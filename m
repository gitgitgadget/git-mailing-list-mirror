Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3528E20179
	for <e@80x24.org>; Fri,  1 Jul 2016 06:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbcGAGGn (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:06:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:38740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752299AbcGAGGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:06:39 -0400
Received: (qmail 24168 invoked by uid 102); 1 Jul 2016 06:06:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:06:40 -0400
Received: (qmail 13625 invoked by uid 107); 1 Jul 2016 06:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:06:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:06:35 -0400
Date:	Fri, 1 Jul 2016 02:06:35 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 4/5] common-main: call restore_sigpipe_to_default()
Message-ID: <20160701060635.GD4593@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is another safety/sanity setup that should be in force
everywhere, but which we only applied in git.c. This did
catch most cases, since even external commands are typically
run via "git ..." (and the restoration applies to
sub-processes, too). But there were cases we missed, such as
somebody calling git-upload-pack directly via ssh, or
scripts which use dashed external commands directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c | 23 +++++++++++++++++++++++
 git.c         | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/common-main.c b/common-main.c
index 353c6ea..20e55ef 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,27 @@
 #include "cache.h"
 #include "exec_cmd.h"
 
+/*
+ * Many parts of Git have subprograms communicate via pipe, expect the
+ * upstream of a pipe to die with SIGPIPE when the downstream of a
+ * pipe does not need to read all that is written.  Some third-party
+ * programs that ignore or block SIGPIPE for their own reason forget
+ * to restore SIGPIPE handling to the default before spawning Git and
+ * break this carefully orchestrated machinery.
+ *
+ * Restore the way SIGPIPE is handled to default, which is what we
+ * expect.
+ */
+static void restore_sigpipe_to_default(void)
+{
+	sigset_t unblock;
+
+	sigemptyset(&unblock);
+	sigaddset(&unblock, SIGPIPE);
+	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
+	signal(SIGPIPE, SIG_DFL);
+}
+
 int main(int argc, char **av)
 {
 	/*
@@ -18,5 +39,7 @@ int main(int argc, char **av)
 
 	argv[0] = git_extract_argv0_path(argv[0]);
 
+	restore_sigpipe_to_default();
+
 	return cmd_main(argc, argv);
 }
diff --git a/git.c b/git.c
index b65083c..ccb24fd 100644
--- a/git.c
+++ b/git.c
@@ -609,27 +609,6 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
-/*
- * Many parts of Git have subprograms communicate via pipe, expect the
- * upstream of a pipe to die with SIGPIPE when the downstream of a
- * pipe does not need to read all that is written.  Some third-party
- * programs that ignore or block SIGPIPE for their own reason forget
- * to restore SIGPIPE handling to the default before spawning Git and
- * break this carefully orchestrated machinery.
- *
- * Restore the way SIGPIPE is handled to default, which is what we
- * expect.
- */
-static void restore_sigpipe_to_default(void)
-{
-	sigset_t unblock;
-
-	sigemptyset(&unblock);
-	sigaddset(&unblock, SIGPIPE);
-	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
-	signal(SIGPIPE, SIG_DFL);
-}
-
 int cmd_main(int argc, const char **argv)
 {
 	const char *cmd;
@@ -639,8 +618,6 @@ int cmd_main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "git-help";
 
-	restore_sigpipe_to_default();
-
 	git_setup_gettext();
 
 	trace_command_performance(argv);
-- 
2.9.0.317.g65b4e7c

