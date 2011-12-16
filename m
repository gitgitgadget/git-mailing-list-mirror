From: Christopher Dale <chrelad@gmail.com>
Subject: [PATCH] Adding hooks.directory config option; wiring into run_hook
Date: Fri, 16 Dec 2011 12:00:58 -0600
Message-ID: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 19:01:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbc5h-00088c-EC
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760315Ab1LPSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:01:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab1LPSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:00:59 -0500
Received: by wgbdr13 with SMTP id dr13so6613307wgb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Xufqbg+X3vbCMKrMNpCoo3EDt0ZCsqoT0se/+OalTEg=;
        b=IFwRFR3AhhfbvgYbsWblowQE3nsQAfXZa6pYHl6gTzyVesHrMBnTkU6+/BTFscAkHl
         +imUgHBropbrjK5ZhOmaF4X2UfeakdI+E0jWb47p3jp19zm3jKHaEq1T58vR3kFEFosg
         5Snhfpj9A3lXnCUKSkrXDkYokePiPuERLirvY=
Received: by 10.216.137.28 with SMTP id x28mr3664546wei.0.1324058458214; Fri,
 16 Dec 2011 10:00:58 -0800 (PST)
Received: by 10.216.155.148 with HTTP; Fri, 16 Dec 2011 10:00:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187292>

>From 92a34696bb4e76ae7a967666234f13d04858bb68 Mon Sep 17 00:00:00 2001
From: Christopher Dale <chrelad@gmail.com>
Date: Fri, 16 Dec 2011 10:55:26 -0600
Subject: [PATCH] Adding hooks.directory config option; wiring into run_hook

The new hooks.directory config option allows each git repository to
specify the location of the hooks for that repository. The default
remains $GIT_DIR/hooks. The ability to change the hooks directory is
necessary when stuck in an environment with enhanced security and
trusted path execution policies. These systems require that any file
that can be executed exhibit at least the following characteristics:

  * The executable, it's directory, and each directory above it are
    not writable.

Since the hooks directory is within a directory that by it's very nature
requires write permissions, hooks are a non-starter in git's current
state. This patch aims to allow a (most likely bare) repo to have it's
hooks directory customized to a location that meets the above
requirements.

I'm not terribly good at C++, so please let me know if I need to fix
anything. I saw that there were a bunch of scripts that have
GIT_DIR/hooks hard-coded in them. Since I'm not familiar with those
scripts, I will leave them alone for now. Maybe someone that is familiar
with the scripts can integrate the new configuration option into them?
---
 Documentation/config.txt               |    5 +++++
 contrib/completion/git-completion.bash |    1 +
 run-command.c                          |   25 +++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8a7d2d4..c23417c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1226,6 +1226,11 @@ help.autocorrect::
        value is 0 - the command will be just shown but not executed.
        This is the default.

+hooks.directory::
+       Override the default hook directory location GIT_DIR/hooks. This can be
+       usefull if you are in an environment that has trusted path execution for
+       example.
+
 http.proxy::
        Override the HTTP proxy, normally configured using the 'http_proxy'
        environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index cc1bdf9..066948e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2177,6 +2177,7 @@ _git_config ()
                help.autocorrect
                help.browser
                help.format
+               hooks.directory
                http.lowSpeedLimit
                http.lowSpeedTime
                http.maxRequests
diff --git a/run-command.c b/run-command.c
index 1c51043..2e5fa16 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "diff.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "argv-array.h"
@@ -65,6 +66,7 @@ static int execv_shell_cmd(const char **argv)
 #ifndef WIN32
 static int child_err = 2;
 static int child_notifier = -1;
+static const char *hook_directory = NULL;

 static void notify_parent(void)
 {
@@ -603,6 +605,14 @@ int finish_async(struct async *async)
 #endif
 }

+static int git_hook_config(const char *var, const char *value, void *cb)
+{
+       if (!strcmp(var, "hooks.directory"))
+               return git_config_pathname(&hook_directory, var, value);
+
+       return git_diff_ui_config(var, value, cb);
+}
+
 int run_hook(const char *index_file, const char *name, ...)
 {
        struct child_process hook;
@@ -612,11 +622,22 @@ int run_hook(const char *index_file, const char
*name, ...)
        va_list args;
        int ret;

-       if (access(git_path("hooks/%s", name), X_OK) < 0)
+       // If this is not reset to NULL, then strange stuff happens
+       hook_directory = NULL;
+
+       // Load the configuration for hooks.directory
+       git_config(git_hook_config, NULL);
+
+       // If the configuration is not set for hooks directory, set it to the
+       // default GIT_PATH/hooks directory that we all know and love.
+       if(hook_directory == NULL)
+               hook_directory = git_path("hooks");
+
+       if (access(mkpath("%s/%s", hook_directory, name), X_OK) < 0)
                return 0;

        va_start(args, name);
-       argv_array_push(&argv, git_path("hooks/%s", name));
+       argv_array_push(&argv, mkpath("%s/%s", hook_directory, name));
        while ((p = va_arg(args, const char *)))
                argv_array_push(&argv, p);
        va_end(args);
-- 
1.7.5.2.353.g5df3e
