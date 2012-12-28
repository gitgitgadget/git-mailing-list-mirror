From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 1/4] hooks: Add function to check if a hook exists
Date: Fri, 28 Dec 2012 17:57:29 -0500
Message-ID: <1356735452-21667-2-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToisN-000114-M6
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 23:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab2L1W5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 17:57:44 -0500
Received: from pug.qqx.org ([50.116.43.67]:57404 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab2L1W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 17:57:43 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 913611D0BE
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 17:57:41 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 4807d
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 17:57:40 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212269>

Create find_hook() function to determine if a given hook exists and is
executable.  If it is the path to the script will be returned, otherwise
NULL is returned.

This is in support for an upcoming run_hook_argv() function which will
expect the full path to the hook script as the first element in the
argv_array.  This also makes it simple for places that can use a hook to
check if a hook exists before doing, possibly lengthy, setup work which
would be pointless if no such hook is present.

The returned value is left as a static value from get_pathname() rather
than a duplicate because it is anticipated that the return value will
either be used as a boolean, or immediately added to an argv_array list
which would result in it being duplicated at that point.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 run-command.c |   15 +++++++++++++--
 run-command.h |    1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3b982e4..49c8fa0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -735,6 +735,15 @@ int finish_async(struct async *async)
 #endif
 }
 
+char *find_hook(const char *name)
+{
+	char *path = git_path("hooks/%s", name);
+	if (access(path, X_OK) < 0)
+		path = NULL;
+
+	return path;
+}
+
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
@@ -744,11 +753,13 @@ int run_hook(const char *index_file, const char *name, ...)
 	va_list args;
 	int ret;
 
-	if (access(git_path("hooks/%s", name), X_OK) < 0)
+	p = find_hook(name);
+	if (!p)
 		return 0;
 
+	argv_array_push(&argv, p);
+
 	va_start(args, name);
-	argv_array_push(&argv, git_path("hooks/%s", name));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
 	va_end(args);
diff --git a/run-command.h b/run-command.h
index 850c638..221ce33 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,6 +45,7 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
+extern char *find_hook(const char *name);
 extern int run_hook(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.7.10.4
