Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F1E1FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 06:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbcGAGGV (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:06:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:38735 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752023AbcGAGGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:06:18 -0400
Received: (qmail 24160 invoked by uid 102); 1 Jul 2016 06:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:06:07 -0400
Received: (qmail 13607 invoked by uid 107); 1 Jul 2016 06:06:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:06:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:06:02 -0400
Date:	Fri, 1 Jul 2016 02:06:02 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 3/5] common-main: call sanitize_stdfds()
Message-ID: <20160701060602.GC4593@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is setup that should be done in every program for
safety, but we never got around to adding it everywhere (so
builtins benefited from the call in git.c, but any external
commands did not). Putting it in the common main() gives us
this safety everywhere.

Note that the case in daemon.c is a little funny. We wait
until we know whether we want to daemonize, and then either:

 - call daemonize(), which will close stdio and reopen it to
   /dev/null under the hood

 - sanitize_stdfds(), to fix up any odd cases

But that is way too late; the point of sanitizing is to give
us reliable descriptors on 0/1/2, and we will already have
executed code, possibly called die(), etc. The sanitizing
should be the very first thing that happens.

With this patch, git-daemon will sanitize first, and can
remove the call in the non-daemonize case. It does mean that
daemonize() may just end up closing the descriptors we
opened, but that's not a big deal (it's not wrong to do so,
nor is it really less optimal than the case where our parent
process redirected us from /dev/null ahead of time).

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c | 9 ++++++++-
 daemon.c      | 3 +--
 git.c         | 7 -------
 shell.c       | 7 -------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/common-main.c b/common-main.c
index 57c912a..353c6ea 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "exec_cmd.h"
 
 int main(int argc, char **av)
@@ -9,6 +9,13 @@ int main(int argc, char **av)
 	 */
 	const char **argv = (const char **)av;
 
+	/*
+	 * Always open file descriptors 0/1/2 to avoid clobbering files
+	 * in die().  It also avoids messing up when the pipes are dup'ed
+	 * onto stdin/stdout/stderr in the child processes we spawn.
+	 */
+	sanitize_stdfds();
+
 	argv[0] = git_extract_argv0_path(argv[0]);
 
 	return cmd_main(argc, argv);
diff --git a/daemon.c b/daemon.c
index d33ee5a..8646f33 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1378,8 +1378,7 @@ int cmd_main(int argc, const char **argv)
 	if (detach) {
 		if (daemonize())
 			die("--detach not supported on this platform");
-	} else
-		sanitize_stdfds();
+	}
 
 	if (pid_file)
 		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
diff --git a/git.c b/git.c
index 3b4e12d..b65083c 100644
--- a/git.c
+++ b/git.c
@@ -639,13 +639,6 @@ int cmd_main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "git-help";
 
-	/*
-	 * Always open file descriptors 0/1/2 to avoid clobbering files
-	 * in die().  It also avoids messing up when the pipes are dup'ed
-	 * onto stdin/stdout/stderr in the child processes we spawn.
-	 */
-	sanitize_stdfds();
-
 	restore_sigpipe_to_default();
 
 	git_setup_gettext();
diff --git a/shell.c b/shell.c
index ca00807..5e70acb 100644
--- a/shell.c
+++ b/shell.c
@@ -147,13 +147,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	/*
-	 * Always open file descriptors 0/1/2 to avoid clobbering files
-	 * in die().  It also avoids messing up when the pipes are dup'ed
-	 * onto stdin/stdout/stderr in the child processes we spawn.
-	 */
-	sanitize_stdfds();
-
 	/*
 	 * Special hack to pretend to be a CVS server
 	 */
-- 
2.9.0.317.g65b4e7c

