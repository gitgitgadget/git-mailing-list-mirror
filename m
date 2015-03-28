From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH V2 6/6] WIP/RFC/entry.c: fix a memleak
Date: Sat, 28 Mar 2015 11:09:57 +0000
Message-ID: <20150328110957.GB1097@serenity.lan>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
 <1427495569-10863-7-git-send-email-sbeller@google.com>
 <CAPig+cSHntg6KwZr3h6nhO7AK0v+FcbVAA4b_kvHdEg_=9o_eg@mail.gmail.com>
 <CAPig+cR8zA_FLhhnUgKZPdUFpCM3yNKNfbEBH+yoY=G44xGk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 12:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybolh-00038Z-J1
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 12:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbC1LTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 07:19:04 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:42791 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbC1LTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 07:19:02 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2015 07:19:02 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4A4CD22B50;
	Sat, 28 Mar 2015 11:10:07 +0000 (GMT)
X-Quarantine-ID: <9GMg1DEz9vgr>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9GMg1DEz9vgr; Sat, 28 Mar 2015 11:10:06 +0000 (GMT)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id D43E322EBF;
	Sat, 28 Mar 2015 11:09:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPig+cR8zA_FLhhnUgKZPdUFpCM3yNKNfbEBH+yoY=G44xGk8w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266412>

On Fri, Mar 27, 2015 at 08:14:28PM -0400, Eric Sunshine wrote:
> On Friday, March 27, 2015, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> > > I  observe that filter is going out of scope, but the
> > > implementation proposed in this patch produces just a
> > > crash instead of any helpful fix.
> > >
> > > Signed-off-by: Stefan Beller <sbeller@google.com>
> > > ---
> > > diff --git a/entry.c b/entry.c
> > > index 1eda8e9..5383001 100644
> > > --- a/entry.c
> > > +++ b/entry.c
> > > @@ -152,8 +152,10 @@ static int write_entry(struct cache_entry *ce,
> > >                 if (filter &&
> > >                     !streaming_write_entry(ce, path, filter,
> > >                                            state, to_tempfile,
> > > -                                          &fstat_done, &st))
> > > +                                          &fstat_done, &st)) {
> > > +                       free_stream_filter(filter);
> >
> > Aside from the crash you are seeing, this is a bogus fix anyway.
> > You're only freeing 'filter' if it was allocated _and_ if
> > streaming_write_entry() returned 0. I would guess your intention was
> > to free 'filter' regardless of the result of streaming_write_entry().
> 
> Unless streaming_write_entry() is freeing the filter for you -- there
> is a free_stream_filter() call in close_method_decl() in streaming.c
> -- in which case your new free_stream_filter() call would attempt to
> free the already-freed filter.

Yes, I think the correct fix for this leak is to make
stream_blob_to_fd() always free the filter, since there's only one path
out that doesn't at the moment and there's no way for the caller to
figure out whether or not the filter has been freed:

-- >8 --
diff --git a/streaming.c b/streaming.c
index 2ff036a..811fcc2 100644
--- a/streaming.c
+++ b/streaming.c
@@ -507,8 +507,11 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 	int result = -1;
 
 	st = open_istream(sha1, &type, &sz, filter);
-	if (!st)
+	if (!st) {
+		if (filter)
+			free_stream_filter(filter);
 		return result;
+	}
 	if (type != OBJ_BLOB)
 		goto close_and_exit;
 	for (;;) {
