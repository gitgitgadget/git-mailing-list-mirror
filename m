Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036ED1F42D
	for <e@80x24.org>; Fri, 11 May 2018 09:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeEKJZS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 05:25:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:36000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752153AbeEKJZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 05:25:18 -0400
Received: (qmail 22988 invoked by uid 109); 11 May 2018 09:25:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 09:25:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31751 invoked by uid 111); 11 May 2018 09:25:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 05:25:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 05:25:16 -0400
Date:   Fri, 11 May 2018 05:25:16 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] pager: set COLUMNS to term_columns()
Message-ID: <20180511092515.GA9567@sigill.intra.peff.net>
References: <20180511075602.9182-1-pclouds@gmail.com>
 <20180511082840.GA22086@sigill.intra.peff.net>
 <CACsJy8CE2tnhH6eds6ZePyMxFXGnnyHDkWjSBbJz97BmYFr-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CE2tnhH6eds6ZePyMxFXGnnyHDkWjSBbJz97BmYFr-gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 10:43:45AM +0200, Duy Nguyen wrote:

> > As an aside, I was confused while looking into this because I _thought_
> > I had COLUMNS set:
> >
> >   $ echo $COLUMNS
> >   119
> >
> > But it turns out that bash sets that by default (if you have the
> > checkwinsize option on) but does not export it. ;)
> 
> Yep. This confused me too and I was "f*ck it I don't want to deal with
> this tty crap again". I'll leave the term_columns() fix to you then,
> and limit this patch to the "while at there" part which should be
> fixed anyway.

Heh. OK, here it is. I wondered why we didn't notice this earlier and
elsewhere (like in "git -p help -a"). The answer is that git-tag is the
only program that uses the column filter. Everybody else does it
in-process.

-- >8 --
Subject: [PATCH] pager: set COLUMNS to term_columns()

After we invoke the pager, our stdout goes to a pipe, not the
terminal, meaning we can no longer use an ioctl to get the
terminal width. For that reason, ad6c3739a3 (pager: find out
the terminal width before spawning the pager, 2012-02-12)
started caching the terminal width.

But that cache is only an in-process variable. Any programs
we spawn will also not be able to run that ioctl, but won't
have access to our cache. They'll end up falling back to our
80-column default.

You can see the problem with:

  git tag --column=row

Since git-tag spawns a pager these days, its spawned
git-column helper will see neither the terminal on stdout
nor a useful COLUMNS value (assuming you do not export it
from your shell already). And you'll end up with 80-column
output in the pager, regardless of your terminal size.

We can fix this by setting COLUMNS right before spawning the
pager. That fixes this case, as well as any more complicated
ones (e.g., a paged program spawns another script which then
generates columnized output).

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 92b23e6cd1..226828f178 100644
--- a/pager.c
+++ b/pager.c
@@ -109,10 +109,15 @@ void setup_pager(void)
 		return;
 
 	/*
-	 * force computing the width of the terminal before we redirect
-	 * the standard output to the pager.
+	 * After we redirect standard output, we won't be able to use an ioctl
+	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
+	 * to communicate it to any sub-processes.
 	 */
-	(void) term_columns();
+	{
+		char buf[64];
+		xsnprintf(buf, sizeof(buf), "%d", term_columns());
+		setenv("COLUMNS", buf, 0);
+	}
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
-- 
2.17.0.984.g9b00a423a4

