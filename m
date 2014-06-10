From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/15] use get_commit_buffer everywhere
Date: Mon, 9 Jun 2014 20:02:24 -0400
Message-ID: <20140610000223.GA20644@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181323.GL20315@sigill.intra.peff.net>
 <xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu9WI-0008Tc-A9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 02:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbaFJAC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 20:02:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:40621 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751615AbaFJACZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 20:02:25 -0400
Received: (qmail 18682 invoked by uid 102); 10 Jun 2014 00:02:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 19:02:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 20:02:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251146>

On Mon, Jun 09, 2014 at 03:40:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/notes-merge.c b/notes-merge.c
> > index 94a1a8a..7885ab2 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -671,7 +671,8 @@ int notes_merge_commit(struct notes_merge_options *o,
> >  	DIR *dir;
> >  	struct dirent *e;
> >  	struct strbuf path = STRBUF_INIT;
> > -	char *msg = strstr(partial_commit->buffer, "\n\n");
> > +	const char *buffer = get_commit_buffer(partial_commit);
> > +	const char *msg = strstr(buffer, "\n\n");
> 
> This tightening causes...
> 
> >  	struct strbuf sb_msg = STRBUF_INIT;
> >  	int baselen;
> >  
> > @@ -720,6 +721,7 @@ int notes_merge_commit(struct notes_merge_options *o,
> >  	}
> >  
> >  	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
> 
> ...a new error here:
> 
> notes-merge.c:723:2: error: passing argument 2 of 'strbuf_attach'
> discards 'const' qualifier from pointer target type [-Werror]
> strbuf.h:19:13: note: expected 'void *' but argument is of type
> 'const char *'

That's weird. I compile with -Wall -Werror, and my gcc doesn't complain.
Hmph.

I agree it's not right, though. I think the original is questionable,
too. It takes a pointer into the middle of partial_commit->buffer and
attaches it to a strbuf. That's wrong because:

  1. It's pointing into the middle of an allocated buffer, not the
     beginning.

  2. We do not own partial_commit->buffer in the first place.

So any call to strbuf_detach on the result would be disastrous. The
compiler doesn't notice because of the const leak in strstr, and it
doesn't cause a bug in practice because the only use of the strbuf is to
pass it as a const to create_notes_commit.

I feel like the most elegant solution is for create_notes_commit to take
a buf/len pair rather than a strbuf, but it unfortunately is just
feeding that to commit_tree. Adjusting that code path would affect quite
a few other spots.

The other obvious option is actually populating the strbuf, but it feels
ugly to have to make a copy just to satisfy the function interface.

Maybe a cast and a warning comment are the least evil thing, as below? I
dunno, it feels pretty wrong.

diff --git a/notes-merge.c b/notes-merge.c
index 94a1a8a..1f3b309 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -671,7 +671,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	DIR *dir;
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
-	char *msg = strstr(partial_commit->buffer, "\n\n");
+	const char *msg = strstr(partial_commit->buffer, "\n\n");
 	struct strbuf sb_msg = STRBUF_INIT;
 	int baselen;
 
@@ -719,7 +719,15 @@ int notes_merge_commit(struct notes_merge_options *o,
 		strbuf_setlen(&path, baselen);
 	}
 
-	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
+	/*
+	 * This is a bit tricky. We should not be attaching msg, which
+	 * is not owned by us and is not even the start of a heap buffer, to a
+	 * strbuf. But the create_notes_commit interface really wants
+	 * a strbuf, even though it will only ever use it as a buf/len pair and
+	 * never modify it. So this is tentatively safe as long as nobody ever
+	 * modifies, detaches, or releases the strbuf.
+	 */
+	strbuf_attach(&sb_msg, (char *)msg, strlen(msg), strlen(msg) + 1);
 	create_notes_commit(partial_tree, partial_commit->parents, &sb_msg,
 			    result_sha1);
 	if (o->verbosity >= 4)

I'm still confused and disturbed that my gcc is not noticing this
obvious const violation. Hmm, shutting off ccache seems to make it work.
Doubly disturbing.

-Peff
