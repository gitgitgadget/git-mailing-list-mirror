From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Introduce core.initHook
Date: Mon, 24 Mar 2008 16:12:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241611200.4353@racer.site>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241155300.4353@racer.site>
 <20080324122153.GF25381@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 16:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdoMf-0005N4-OK
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 16:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759660AbYCXPMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759376AbYCXPMv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 11:12:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:44643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759660AbYCXPMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 11:12:50 -0400
Received: (qmail invoked by alias); 24 Mar 2008 15:12:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 24 Mar 2008 16:12:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yEwlVj6Wy27WSP3+SOsaTk89bztlIxTguqZtYkY
	x+fTEbmMrN50fp
X-X-Sender: gene099@racer.site
In-Reply-To: <20080324122153.GF25381@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78051>


This variable, if set, specifies the path of a hook which is executed
after every git-init.

It can be used to override settings in the templates per-user.  For 
example, when the adminstrator set core.autoCRLF=true in the templates, 
but you want to avoid that explicitely.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 24 Mar 2008, Dmitry Potapov wrote:

	> On Mon, Mar 24, 2008 at 11:57:19AM +0100, Johannes Schindelin 
	> wrote:
	> > 
	> > Maybe the best idea would be an "init" hook, settable from the 
	> > config, after all.
	> 
	> I agree that seems to be the best solution as it is more 
	> flexible than having $HOME/.gittemplates/.

 Documentation/config.txt   |    4 ++++
 Documentation/git-init.txt |    3 +++
 builtin-init-db.c          |   26 ++++++++++++++++++++++++++
 t/t0001-init.sh            |   21 +++++++++++++++++++++
 4 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index efde54d..3323724 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,6 +358,10 @@ core.whitespace::
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
 
+core.inithook::
+	The path to a program which is run after each call to
+	linkgit:git-init[1].
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 03a4f0e..e082218 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -60,6 +60,9 @@ If you are initializing a non-bare repository, the config variable
 `receive.guardCurrentBranch` is set to true.  This avoids problems with
 pushing into the current branch, which does not touch the working tree.
 
+If you want to run a specific script everytime git-init was issued, you
+can set the variable `core.initHook`.
+
 --
 
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 36c12a2..1975910 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -310,6 +311,28 @@ static void guess_repository_type(const char *git_dir)
 	return;
 }
 
+static const char *init_hook;
+static int config_init_hook(const char *key, const char *value)
+{
+	if (!strcmp(key, "core.inithook"))
+		init_hook = xstrdup(value);
+	return 0;
+}
+
+static int run_init_hook()
+{
+	const char *argv[2] = { NULL, NULL };
+
+	git_config(config_init_hook);
+	if (!init_hook)
+		return 0;
+	if (access(init_hook, X_OK) < 0)
+		return error("init hook '%s' not found", init_hook);
+
+	argv[0] = init_hook;
+	return run_command_v_opt(argv, 0);
+}
+
 static const char init_db_usage[] =
 "git-init [-q | --quiet] [--template=<template-directory>] [--shared]";
 
@@ -407,6 +430,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	if (run_init_hook())
+		return 1;
+
 	if (!quiet)
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c015405..7c18d24 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -113,4 +113,25 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
 
+cat > init-hook.sh << EOF
+#!$SHELL_PATH
+
+git config test.message success
+EOF
+chmod a+x init-hook.sh
+
+# using reinit because of lacking system/global config in the tests
+
+test_expect_success 'core.initHook' '
+
+	mkdir hook &&
+	(cd hook &&
+	 git init &&
+	 test -z "$(git config test.message)" &&
+	 git config core.initHook "$(pwd)"/../init-hook.sh &&
+	 git init &&
+	 test success = "$(git config test.message)")
+
+'
+
 test_done
-- 
1.5.5.rc1.178.gd799d
