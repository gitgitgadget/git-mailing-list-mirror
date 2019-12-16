Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70600C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 06:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EB520725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 06:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLPGe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:34:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:47422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726054AbfLPGe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 01:34:27 -0500
Received: (qmail 20904 invoked by uid 109); 16 Dec 2019 06:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Dec 2019 06:34:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10180 invoked by uid 111); 16 Dec 2019 06:39:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2019 01:39:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Dec 2019 01:34:25 -0500
From:   Jeff King <peff@peff.net>
To:     pp yy <yoann.mac.donald@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [bug] Adding -z to git status seems to disable relative path
Message-ID: <20191216063425.GA2127604@coredump.intra.peff.net>
References: <CAK60LiX0g8mNVH5YY0JNOuUNRNYp+URt=2MyH758OAWpX_Phxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK60LiX0g8mNVH5YY0JNOuUNRNYp+URt=2MyH758OAWpX_Phxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 15, 2019 at 09:31:23PM +0100, pp yy wrote:

> Maybe i missed something but i can't get relativepath when adding '-z'
> 
> $ git --version
> git version 2.17.1
> $ git status -s test
> ?? test
> $ git status -s -z test
> ?? plugins/git/test
> $ git -c status.relativePaths=true status -s test
> ?? test
> $ git -c status.relativePaths=true status -s -z test
> ?? plugins/git/test
> 
> Bug or did i missed something ?

I think it's a bug. At first I thought you were running up against the
implied porcelain output:

  -z
      Terminate entries with NUL, instead of LF. This implies the
      --porcelain=v1 output format if no other format is given.

but you are explicitly saying "-s" (and running this in a terminal shows
that the result is colorized, which means we're triggering the short
format and not porcelain).

And indeed, the "-z" code path seems to ignore the prefix entirely.
Something like this would fix it:

diff --git a/wt-status.c b/wt-status.c
index cc6f94504d..3a0e479407 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1837,9 +1837,13 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		putchar(' ');
 	putchar(' ');
 	if (s->null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
+		struct strbuf scratch = STRBUF_INIT;
+		fprintf(stdout, "%s%c",
+			relative_path(it->string, s->prefix, &scratch), 0);
 		if (d->rename_source)
-			fprintf(stdout, "%s%c", d->rename_source, 0);
+			fprintf(stdout, "%s%c",
+				relative_path(d->rename_source, s->prefix, &scratch), 0);
+		strbuf_release(&scratch);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;

Now I do think it's a little weird to use "-z" with "--short" in the
first place, since the whole point of "-z" is make something that can be
parsed. And the whole point of "--short" versus "--porcelain" is that
the latter is stable and predictable (so it doesn't respect config at
all).

But I guess I could imagine a use case where a script is taking in paths
from the "-z" and then showing them to the user without further
processing (and so it's convenient to get the relative path directly
rather than computing them itself). I do wonder if there are any other
surprises in "--short" that might be lurking, though (IIRC, we do not
even promise that the output will stay syntactically the same between
versions; it could change to something completely different, or add new
lines in future versions).

-Peff
