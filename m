Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6EB1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935862AbdAGBQ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:16:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:36294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbdAGBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:16:26 -0500
Received: (qmail 29525 invoked by uid 109); 7 Jan 2017 01:16:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:16:26 +0000
Received: (qmail 21947 invoked by uid 111); 7 Jan 2017 01:17:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:17:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:16:24 -0500
Date:   Fri, 6 Jan 2017 20:16:24 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 1/3] execv_dashed_external: use child_process struct
Message-ID: <20170107011624.hnvu2m5jaosebadf@sigill.intra.peff.net>
References: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run a dashed external, we use the one-liner
run_command_v_opt() to do so. Let's switch to using a
child_process struct, which has two advantages:

  1. We can drop all of the allocation and cleanup code for
     building our custom argv array, and just rely on the
     builtin argv_array (at the minor cost of doing a few
     extra mallocs).

  2. We have access to the complete range of child_process
     options, not just the ones that the "_opt()" form can
     forward.

Signed-off-by: Jeff King <peff@peff.net>
---

It's possible people may disagree with reason (2), and we should add a
new RUN_WAIT_AFTER_CLEAN flag in the final patch. IMHO the whole
run_command_v_opt() thing is a good sign that you should be switching to
a child_process struct. :)

 git.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/git.c b/git.c
index dce529fcbf..d0e04d5c97 100644
--- a/git.c
+++ b/git.c
@@ -575,8 +575,7 @@ static void handle_builtin(int argc, const char **argv)
 
 static void execv_dashed_external(const char **argv)
 {
-	struct strbuf cmd = STRBUF_INIT;
-	const char *tmp;
+	struct child_process cmd = CHILD_PROCESS_INIT;
 	int status;
 
 	if (get_super_prefix())
@@ -586,30 +585,20 @@ static void execv_dashed_external(const char **argv)
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
-	strbuf_addf(&cmd, "git-%s", argv[0]);
+	argv_array_pushf(&cmd.args, "git-%s", argv[0]);
+	argv_array_pushv(&cmd.args, argv + 1);
+	cmd.clean_on_exit = 1;
+	cmd.silent_exec_failure = 1;
 
-	/*
-	 * argv[0] must be the git command, but the argv array
-	 * belongs to the caller, and may be reused in
-	 * subsequent loop iterations. Save argv[0] and
-	 * restore it on error.
-	 */
-	tmp = argv[0];
-	argv[0] = cmd.buf;
-
-	trace_argv_printf(argv, "trace: exec:");
+	trace_argv_printf(cmd.args.argv, "trace: exec:");
 
 	/*
 	 * if we fail because the command is not found, it is
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
-	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT);
+	status = run_command(&cmd);
 	if (status >= 0 || errno != ENOENT)
 		exit(status);
-
-	argv[0] = tmp;
-
-	strbuf_release(&cmd);
 }
 
 static int run_argv(int *argcp, const char ***argv)
-- 
2.11.0.527.gfef230ca76

