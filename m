Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256D01FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161288AbdAGBRv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:17:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:36303 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbdAGBRu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:17:50 -0500
Received: (qmail 29597 invoked by uid 109); 7 Jan 2017 01:17:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:17:50 +0000
Received: (qmail 21967 invoked by uid 111); 7 Jan 2017 01:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:18:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:17:48 -0500
Date:   Fri, 6 Jan 2017 20:17:48 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 2/3] execv_dashed_external: stop exiting with negative code
Message-ID: <20170107011748.l25a6ofofjiuvpgk@sigill.intra.peff.net>
References: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we try to exec a git sub-command, we pass along the
status code from run_command(). But that may return -1 if we
ran into an error with pipe() or execve(). This tends to
work (and end up as 255 due to twos-complement wraparound
and truncation), but in general it's probably a good idea to
avoid negative exit codes for portability.

We can easily translate to the normal generic "128" code we
get when syscalls cause us to die.

Signed-off-by: Jeff King <peff@peff.net>
---
I know that negative exit codes were a problem once upon a time on
Windows, but I think that is fine since 47e3de0e79 (MinGW: truncate
exit()'s argument to lowest 8 bits, 2009-07-05). Still, I think it's a
weird portability thing that we are better off avoiding (and certainly I
wouldn't be surprised if some callers assume everything >128 is a
signal).

 git.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index d0e04d5c97..bc2f2a7ec9 100644
--- a/git.c
+++ b/git.c
@@ -593,12 +593,16 @@ static void execv_dashed_external(const char **argv)
 	trace_argv_printf(cmd.args.argv, "trace: exec:");
 
 	/*
-	 * if we fail because the command is not found, it is
-	 * OK to return. Otherwise, we just pass along the status code.
+	 * If we fail because the command is not found, it is
+	 * OK to return. Otherwise, we just pass along the status code,
+	 * or our usual generic code if we were not even able to exec
+	 * the program.
 	 */
 	status = run_command(&cmd);
-	if (status >= 0 || errno != ENOENT)
+	if (status >= 0)
 		exit(status);
+	else if (errno != ENOENT)
+		exit(128);
 }
 
 static int run_argv(int *argcp, const char ***argv)
-- 
2.11.0.527.gfef230ca76

