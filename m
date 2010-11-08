From: Brian Collins <bricollins@gmail.com>
Subject: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon,  8 Nov 2010 04:32:00 -0800
Message-ID: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
Cc: s-beyer@gmx.net, Brian Collins <bricollins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 13:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFQtZ-00066V-4u
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 13:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab0KHMcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 07:32:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38528 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0KHMcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 07:32:13 -0500
Received: by pwj7 with SMTP id 7so821225pwj.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 04:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3pWBcAgCmY+FELvnfmw8N4all2q0LGKCQamhSOJ03o8=;
        b=shsjHDkiCNJ83aq3XXvkfWeyGkOpHiI263nIk9zg/oBhPq8Uyj4LRXhvk1QMWKimmX
         jAmHXGRyPfWXmziE11PgmuLM+xsguAwGRpiRYcbD+1Vo45Ob9gnUhYcViptLdxE2Vl5n
         ojiA8jJOmnHuybEOyD9xZE1yTiNBk11H+19IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XXphZoTn3g3fgGAUBF+rqyVjCCXfoGoGIe8JuWL11isdFZ4Rstv4aocV6Y4rArR8++
         ACMY5bossnxitJ6TxJASfO6KJN6uc3PoKzOKboiXIWYu/88PtIIfn3KtuSi9KGl9ryVk
         XTHo9A7w1dhtOQbcs0eOM3zaCJ7mrHwFHjzck=
Received: by 10.142.238.15 with SMTP id l15mr4934215wfh.7.1289219532150;
        Mon, 08 Nov 2010 04:32:12 -0800 (PST)
Received: from localhost.localdomain ([207.81.88.166])
        by mx.google.com with ESMTPS id x35sm8024625wfd.1.2010.11.08.04.32.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 04:32:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.162.g4671
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160932>

Run global hooks in the directory specified by the config variable
hooks.dir before every attempt at running a local hook. If the
global hook fails, the local hook will not run. If the global hook is
absent, the local hook runs normally. This is useful because it means
you can have scripts that run as hooks for multiple repositories, for
example coding style enforcement for an entire organization, or
system-wide commit analytics.

Signed-off-by: Brian Collins <bricollins@gmail.com>
---

The possibility of adding this feature was previously discussed here:
http://marc.info/?l=git&m=127808782807807&w=2

Fixed some bad whitespace in contrib/completion/git-completion.bash

Cheers,
Brian

 Documentation/config.txt               |    5 ++
 cache.h                                |    2 +
 config.c                               |   12 ++++
 contrib/completion/git-completion.bash |    1 +
 run-command.c                          |   51 +++++++++++++-----
 t/t7510-global-hooks.sh                |   88 ++++++++++++++++++++++++++++++++
 6 files changed, 144 insertions(+), 15 deletions(-)
 create mode 100755 t/t7510-global-hooks.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 538ebb5..3f18208 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1199,6 +1199,11 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
 
+hooks.dir::
+	Directory containing executable hooks. Usage is identical to
+	.git/hooks except they are triggered for any repository used
+	while this configuration is set.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/cache.h b/cache.h
index 33decd9..c75a444 100644
--- a/cache.h
+++ b/cache.h
@@ -1018,6 +1018,8 @@ extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
 
+extern const char *git_hooks_dir;
+
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
diff --git a/config.c b/config.c
index 4b0a820..1a9d5ee 100644
--- a/config.c
+++ b/config.c
@@ -745,6 +745,15 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_hooks_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "hooks.dir"))
+		return git_config_pathname(&git_hooks_dir, var, value);
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value, void *dummy)
 {
 	if (!prefixcmp(var, "core."))
@@ -768,6 +777,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "advice."))
 		return git_default_advice_config(var, value);
 
+	if (!prefixcmp(var, "hooks."))
+		return git_default_hooks_config(var, value);
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 168669b..b266f83 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1913,6 +1913,7 @@ _git_config ()
 		help.autocorrect
 		help.browser
 		help.format
+		hooks.dir
 		http.lowSpeedLimit
 		http.lowSpeedTime
 		http.maxRequests
diff --git a/run-command.c b/run-command.c
index 2a1041e..8e33b80 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,8 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
+const char *git_hooks_dir;
+
 static inline void close_pair(int fd[2])
 {
 	close(fd[0]);
@@ -603,26 +605,16 @@ int finish_async(struct async *async)
 #endif
 }
 
-int run_hook(const char *index_file, const char *name, ...)
+int run_hook_file(const char *path, const char *index_file, const char **argv)
 {
 	struct child_process hook;
-	const char **argv = NULL, *env[2];
 	char index[PATH_MAX];
-	va_list args;
-	int ret;
-	size_t i = 0, alloc = 0;
+	const char *env[2];
 
-	if (access(git_path("hooks/%s", name), X_OK) < 0)
+	if (access(path, X_OK) < 0)
 		return 0;
 
-	va_start(args, name);
-	ALLOC_GROW(argv, i + 1, alloc);
-	argv[i++] = git_path("hooks/%s", name);
-	while (argv[i-1]) {
-		ALLOC_GROW(argv, i + 1, alloc);
-		argv[i++] = va_arg(args, const char *);
-	}
-	va_end(args);
+	argv[0] = path;
 
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv;
@@ -635,7 +627,36 @@ int run_hook(const char *index_file, const char *name, ...)
 		hook.env = env;
 	}
 
-	ret = run_command(&hook);
+	return run_command(&hook);
+}
+
+int run_hook(const char *index_file, const char *name, ...)
+{
+	const char **argv = NULL;
+	va_list args;
+	int ret;
+	size_t i = 1, alloc = 0;
+	const char *local_path = git_path("hooks/%s", name);
+	const char *global_path = NULL;
+	if (git_hooks_dir != NULL)
+		global_path = mkpath("%s/%s", git_hooks_dir, name);
+
+	if ((global_path == NULL || access(global_path, X_OK) > 0) &&
+			access(local_path, X_OK) > 0)
+		return 0;
+
+	va_start(args, name);
+	do {
+		ALLOC_GROW(argv, i + 1, alloc);
+		argv[i++] = va_arg(args, const char *);
+	} while (argv[i-1]);
+	va_end(args);
+
+	if (global_path != NULL)
+		ret = run_hook_file(global_path, index_file, argv) ||
+			run_hook_file(local_path, index_file, argv);
+	else
+		ret = run_hook_file(local_path, index_file, argv);
 	free(argv);
 	return ret;
 }
diff --git a/t/t7510-global-hooks.sh b/t/t7510-global-hooks.sh
new file mode 100755
index 0000000..d2481ea
--- /dev/null
+++ b/t/t7510-global-hooks.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='global hooks'
+
+. ./test-lib.sh
+
+test_expect_success 'with no hooks' '
+	echo "foo" > file &&
+	git add file &&
+	git commit -m "first"
+'
+
+GIT_DIR="$(git rev-parse --git-dir)"
+
+# now install global hook that always succeeds
+GLOBALHOOKDIR="global-hooks"
+GLOBALHOOK="$GLOBALHOOKDIR/pre-commit"
+mkdir -p "$GLOBALHOOKDIR"
+cat > $GLOBALHOOK <<EOF
+#!/bin/sh
+touch $GIT_DIR/global-hook-fired
+exit 0
+EOF
+
+chmod +x "$GLOBALHOOK"
+
+# and a local hook that always succeeds
+HOOKDIR="$GIT_DIR/hooks"
+HOOK="$HOOKDIR/pre-commit"
+mkdir -p "$HOOKDIR"
+cat > $HOOK <<EOF
+#!/bin/sh
+touch $GIT_DIR/local-hook-fired
+exit 0
+EOF
+
+chmod +x "$HOOK"
+
+
+test_expect_success 'configure global hooks directory' '
+	git config hooks.dir ${GLOBALHOOKDIR}
+'
+
+test_expect_success 'with succeeding hook' '
+	echo "more" >> file &&
+	git add file &&
+	git commit -m "more" &&
+	test -e ${GIT_DIR}/global-hook-fired &&
+	test -e ${GIT_DIR}/local-hook-fired
+'
+
+rm $GIT_DIR/global-hook-fired
+rm $GIT_DIR/local-hook-fired
+
+# now a local hook that fails, both hooks should fire
+cat > $HOOK <<EOF
+#!/bin/sh
+touch $GIT_DIR/local-hook-fired
+exit 1
+EOF
+
+test_expect_success 'with failing global hook' '
+	echo "another" >> file &&
+	git add file &&
+	test_must_fail git commit -m "another" &&
+	test -e ${GIT_DIR}/global-hook-fired &&
+	test -e ${GIT_DIR}/local-hook-fired
+'
+
+rm $GIT_DIR/global-hook-fired
+rm $GIT_DIR/local-hook-fired
+
+# now a global hook that fails, the local hook shouldn't fire
+cat > "$GLOBALHOOK" <<EOF
+#!/bin/sh
+touch $GIT_DIR/global-hook-fired
+exit 1
+EOF
+
+test_expect_success 'with failing global hook' '
+	echo "another" >> file &&
+	git add file &&
+	test_must_fail git commit -m "another" &&
+	test -e ${GIT_DIR}/global-hook-fired &&
+	test_must_fail test -e ${GIT_DIR}/local-hook-fired
+'
+
+test_done
-- 
1.7.3.2.162.g4671
