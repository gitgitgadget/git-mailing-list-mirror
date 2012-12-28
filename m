From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 2/4] hooks: support variable number of parameters
Date: Fri, 28 Dec 2012 17:57:30 -0500
Message-ID: <1356735452-21667-3-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToisO-000114-57
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 23:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2L1W5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 17:57:45 -0500
Received: from pug.qqx.org ([50.116.43.67]:57402 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173Ab2L1W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 17:57:43 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id E4E4C1D0A4
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 17:57:41 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 480a6
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 17:57:41 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212271>

Define the run_hook_argv() function to allow hooks to be created where
the number of parameters to be passed is variable.  The existing
run_hook() function uses stdarg to allow it to receive a variable number
of arguments, but the number of arguments that a given caller is passing
is fixed at compile time.  This function will allow the caller of a hook
to determine the number of arguments to pass when preparing to call the
hook.

The first use of this function will be for a pre-push hook which will
add an argument for every reference which is to be pushed.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 run-command.c |   20 +++++++++++++-------
 run-command.h |    2 ++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 49c8fa0..e07202b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,7 +2,6 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "sigchain.h"
-#include "argv-array.h"
 
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
@@ -746,10 +745,8 @@ char *find_hook(const char *name)
 
 int run_hook(const char *index_file, const char *name, ...)
 {
-	struct child_process hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *p, *env[2];
-	char index[PATH_MAX];
+	const char *p;
 	va_list args;
 	int ret;
 
@@ -764,6 +761,17 @@ int run_hook(const char *index_file, const char *name, ...)
 		argv_array_push(&argv, p);
 	va_end(args);
 
+	ret = run_hook_argv(index_file, argv);
+	argv_array_clear(&argv);
+	return ret;
+}
+
+int run_hook_argv(const char *index_file, struct argv_array argv)
+{
+	struct child_process hook;
+	char index[PATH_MAX];
+	const char *env[2];
+
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv.argv;
 	hook.no_stdin = 1;
@@ -775,7 +783,5 @@ int run_hook(const char *index_file, const char *name, ...)
 		hook.env = env;
 	}
 
-	ret = run_command(&hook);
-	argv_array_clear(&argv);
-	return ret;
+	return run_command(&hook);
 }
diff --git a/run-command.h b/run-command.h
index 221ce33..12faa5b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,6 +1,7 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
+#include "argv-array.h"
 #ifndef NO_PTHREADS
 #include <pthread.h>
 #endif
@@ -47,6 +48,7 @@ int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
 extern int run_hook(const char *index_file, const char *name, ...);
+extern int run_hook_argv(const char *index_file, struct argv_array);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-- 
1.7.10.4
