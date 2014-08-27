From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a
 buffer
Date: Wed, 27 Aug 2014 15:38:57 -0400
Message-ID: <20140827193857.GD7561@peff.net>
References: <20140827075503.GA19521@peff.net>
 <20140827075600.GA26384@peff.net>
 <xmqqioldet75.fsf@gitster.dls.corp.google.com>
 <20140827180016.GA6269@peff.net>
 <xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
 <20140827191414.GA7561@peff.net>
 <xmqqsikhd98f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:39:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMj3g-0000GZ-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935636AbaH0TjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:39:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60293 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935467AbaH0Ti7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:38:59 -0400
Received: (qmail 19082 invoked by uid 102); 27 Aug 2014 19:38:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 14:38:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 15:38:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsikhd98f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256030>

On Wed, Aug 27, 2014 at 12:26:56PM -0700, Junio C Hamano wrote:

> I don't mind returning -1 in out_len and have the callers check.
> That way will allow callers to easily diagnose this
> 
> 	tree $T
>         author $GIT_AUTHOR_IDENT
> 	committer $GIT_COMMITTER_IDENT
> 	encoding encoding
>          unexpected continuation line
> 
> 	log message
> 
> as an error; they would just make sure that out_len is not the "this
> is continued; you need to parse the rest yourself" value.

Hmph. I was hoping that callers could just ignore this and fallback to
the "it's supposed to be one line, so assume that it is, and ignore
other lines" behavior. I guess that is the flip side of the "just use
the whole broken value" alternative that I mentioned earlier.

What I didn't want to do is deal with it in each callsite, like:

diff --git a/builtin/commit.c b/builtin/commit.c
index 7f9f071..10417bb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -564,6 +564,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		a = find_commit_header(author_message_buffer, "author", &len);
 		if (!a)
 			die(_("commit '%s' lacks author header"), author_message);
+		if (len == -1)
+			die(_("commit '%s' has a multi-line author"), author_message);
 		if (split_ident_line(&ident, a, len) < 0)
 			die(_("commit '%s' has malformed author line"), author_message);
 
diff --git a/commit.c b/commit.c
index 9416d84..6fec0c2 100644
--- a/commit.c
+++ b/commit.c
@@ -594,6 +594,8 @@ static void record_author_date(struct author_date_slab *author_date,
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
 		goto fail_exit; /* no author line */
+	if (ident_len == -1)
+		goto fail_exit; /* multi-line author line */
 	if (split_ident_line(&ident, ident_line, ident_len) ||
 	    !ident.date_begin || !ident.date_end)
 		goto fail_exit; /* malformed "author" line */
@@ -1669,7 +1671,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 		if (eol - line > key_len &&
 		    !strncmp(line, key, key_len) &&
 		    line[key_len] == ' ') {
-			*out_len = eol - line - key_len - 1;
+			if (eol[0] && eol[1] == ' ')
+				*out_len = -1;
+			else
+				*out_len = eol - line - key_len - 1;
 			return line + key_len + 1;
 		}
 		line = *eol ? eol + 1 : NULL;
diff --git a/pretty.c b/pretty.c
index 3a70557..ff2bf4a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -551,7 +551,7 @@ static char *get_header(const char *msg, const char *key)
 {
 	size_t len;
 	const char *v = find_commit_header(msg, key, &len);
-	return v ? xmemdupz(v, len) : NULL;
+	return v && len != -1 ? xmemdupz(v, len) : NULL;
 }
 
 static char *replace_encoding_header(char *buf, const char *encoding)


which does not really add any value, IMHO.

-Peff
