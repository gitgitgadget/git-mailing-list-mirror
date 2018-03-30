Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CF41F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeC3T0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:26:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752069AbeC3T0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:26:17 -0400
Received: (qmail 26653 invoked by uid 109); 30 Mar 2018 19:26:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 19:26:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32138 invoked by uid 111); 30 Mar 2018 19:27:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 15:27:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 15:26:15 -0400
Date:   Fri, 30 Mar 2018 15:26:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] config: move flockfile() closer to unlocked functions
Message-ID: <20180330192615.GB32338@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 09:04:13PM +0200, Johannes Schindelin wrote:

> > Probably the flockfile should go into do_config_from_file(), where we
> > specify to use the unlocked variants.
> 
> Ah, that makes sense now! I am glad I could also help ;-)

:)

> > Yeah, I'll wait to see how your refactor turns out.
> 
> I don't think I'll touch too much in that part of the code. My changes
> should not cause merge conflicts with a patch moving the
> flockfile()/funlockfile() calls to do_config_from_file().

OK, then let's do this while we're thinking about it:

-- >8 --
Subject: config: move flockfile() closer to unlocked functions

Commit 260d408e32 (config: use getc_unlocked when reading
from file, 2015-04-16) taught git_config_from_file() to lock
the filehandle so that we could safely use the faster
unlocked functions to access the handle.

However, it split the logic into two places:

  1. The master lock/unlock happens in git_config_from_file().

  2. The decision to use the unlocked functions happens in
     do_config_from_file().

That means that if anybody calls the latter function, they
will accidentally use the unlocked functions without holding
the lock. And indeed, git_config_from_stdin() does so.

In practice, this hasn't been a problem since this code
isn't generally multi-threaded (and even if some Git program
happened to have another thread running, it's unlikely to be
reading from stdin). But it's a good practice to make sure
we're always holding the lock before using the unlocked
functions.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I wasn't sure if this was "helped by" or "reported by" or
"stumbled-upon-by". :)

 config.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index b0c20e6cb8..609ef2f58b 100644
--- a/config.c
+++ b/config.c
@@ -1426,6 +1426,7 @@ static int do_config_from_file(config_fn_t fn,
 		void *data)
 {
 	struct config_source top;
+	int ret;
 
 	top.u.file = f;
 	top.origin_type = origin_type;
@@ -1436,7 +1437,10 @@ static int do_config_from_file(config_fn_t fn,
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
 
-	return do_config_from(&top, fn, data);
+	flockfile(f);
+	ret = do_config_from(&top, fn, data);
+	funlockfile(f);
+	return ret;
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
@@ -1451,9 +1455,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	f = fopen_or_warn(filename, "r");
 	if (f) {
-		flockfile(f);
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
-		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
-- 
2.17.0.rc2.594.gdb94a0ce02

