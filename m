From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] teach the user to be nice to git and let him say please
	sometimes
Date: Sun, 12 May 2013 09:26:18 +0200
Message-ID: <20130512072616.GC23115@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 12 09:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbQg3-0007GR-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 09:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab3ELH0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 03:26:21 -0400
Received: from [46.115.72.172] ([46.115.72.172]:35453 "EHLO book.hvoigt.net"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750894Ab3ELH0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 03:26:20 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 May 2013 03:26:18 EDT
Received: by book.hvoigt.net (Postfix, from userid 501)
	id C1F13D2B928; Sun, 12 May 2013 09:26:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224027>

Since ages we do not care about our program enough. Lets not treat them
as slaves anymore and say please.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Johan Herland <johan@herland.net>
---

I do not know why this very urgent patch did not make it to the
mailinglist yesterday evening. Well here is a resend.

 .gitignore                       |  1 +
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/config.c                 | 23 ++-----------------
 builtin/please.c                 |  9 ++++++++
 cache.h                          |  1 +
 config.c                         | 23 +++++++++++++++++++
 contrib/completion/git-prompt.sh |  5 +++-
 git.c                            | 49 +++++++++++++++++++++++++++++++++++++++-
 9 files changed, 90 insertions(+), 23 deletions(-)
 create mode 100644 builtin/please.c

diff --git a/.gitignore b/.gitignore
index 6669bf0..28dd4cf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,7 @@
 /git-parse-remote
 /git-patch-id
 /git-peek-remote
+/git-please
 /git-prune
 /git-prune-packed
 /git-pull
diff --git a/Makefile b/Makefile
index 0f931a2..7e22cc0 100644
--- a/Makefile
+++ b/Makefile
@@ -943,6 +943,7 @@ BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
+BUILTIN_OBJS += builtin/please.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/push.o
diff --git a/builtin.h b/builtin.h
index faef559..6fe1d5f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -105,6 +105,7 @@ extern int cmd_notes(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
+extern int cmd_please(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..16b5152 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -364,27 +364,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if (use_global_config) {
-		char *user_config = NULL;
-		char *xdg_config = NULL;
-
-		home_config_paths(&user_config, &xdg_config, "config");
-
-		if (!user_config)
-			/*
-			 * It is unknown if HOME/.gitconfig exists, so
-			 * we do not know if we should write to XDG
-			 * location; error out even if XDG_CONFIG_HOME
-			 * is set and points at a sane location.
-			 */
-			die("$HOME not set");
-
-		if (access_or_warn(user_config, R_OK) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK))
-			given_config_file = xdg_config;
-		else
-			given_config_file = user_config;
-	}
+	if (use_global_config)
+		given_config_file = git_user_config();
 	else if (use_system_config)
 		given_config_file = git_etc_gitconfig();
 	else if (use_local_config)
diff --git a/builtin/please.c b/builtin/please.c
new file mode 100644
index 0000000..aea8424
--- /dev/null
+++ b/builtin/please.c
@@ -0,0 +1,9 @@
+#include "builtin.h"
+#include "run-command.h"
+
+int cmd_please(int argc, const char **argv, const char *prefix)
+{
+	if (!strcmp(argv[1], "-h"))
+		usage("Sometimes");
+	return run_command_v_opt(argv+1, RUN_GIT_CMD);
+}
diff --git a/cache.h b/cache.h
index 94ca1ac..73a9caf 100644
--- a/cache.h
+++ b/cache.h
@@ -1164,6 +1164,7 @@ extern int git_config_set_multivar_in_file(const char *, const char *, const cha
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
+extern const char *git_user_config(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
diff --git a/config.c b/config.c
index aefd80b..8b3e473 100644
--- a/config.c
+++ b/config.c
@@ -935,6 +935,29 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
+const char *git_user_config(void)
+{
+	char *user_config = NULL;
+	char *xdg_config = NULL;
+
+	home_config_paths(&user_config, &xdg_config, "config");
+
+	if (!user_config)
+		/*
+		 * It is unknown if HOME/.gitconfig exists, so
+		 * we do not know if we should write to XDG
+		 * location; error out even if XDG_CONFIG_HOME
+		 * is set and points at a sane location.
+		 */
+		die("$HOME not set");
+
+	if (access_or_warn(user_config, R_OK) &&
+			xdg_config && !access_or_warn(xdg_config, R_OK))
+		return xdg_config;
+	else
+		return user_config;
+}
+
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..a455d72 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -241,6 +241,7 @@ __git_ps1 ()
 	local ps1pc_start='\u@\h:\w '
 	local ps1pc_end='\$ '
 	local printf_format=' (%s)'
+	export GIT_POLITENESS_CHECK_PASSED="Yes"
 
 	case "$#" in
 		2|3)	pcmode=yes
@@ -250,7 +251,8 @@ __git_ps1 ()
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
-		*)	return
+		*)      unset GIT_POLITENESS_CHECK_PASSED
+			return
 		;;
 	esac
 
@@ -409,4 +411,5 @@ __git_ps1 ()
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
 		fi
 	fi
+	unset GIT_POLITENESS_CHECK_PASSED
 }
diff --git a/git.c b/git.c
index 1ada169..6c67cef 100644
--- a/git.c
+++ b/git.c
@@ -19,6 +19,8 @@ const char git_more_info_string[] =
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
+static int impolite_counter;
+static int polite_counter;
 
 static void commit_pager_choice(void) {
 	switch (use_pager) {
@@ -302,6 +304,48 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
+static int read_polite_counter(const char *key, const char *value, void *data)
+{
+	if (!strcmp(key, "user.impolite"))
+		impolite_counter = git_config_int(key, value);
+	else if (!strcmp(key, "user.polite"))
+		polite_counter = git_config_int(key, value);
+	return 0;
+}
+
+static void check_politeness(const char *cmd)
+{
+	const char *user_config;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (getenv("GIT_POLITENESS_CHECK_PASSED"))
+		return;
+
+	setenv("GIT_POLITENESS_CHECK_PASSED", "Yes", 1);
+
+	git_config_early(read_polite_counter, NULL, NULL);
+	if (!strcmp(cmd, "please")) {
+		impolite_counter = 0;
+		polite_counter++;
+	} else {
+		impolite_counter++;
+		polite_counter = 0;
+	}
+
+	if (impolite_counter > 10)
+		die("Error: Learn some manners, say please some time!");
+	if (polite_counter > 10)
+		die("Error: Too many please! I don't believe you.");
+
+	user_config = git_user_config();
+	strbuf_addf(&buf, "%d", polite_counter);
+	git_config_set_in_file(user_config, "user.polite", buf.buf);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%d", impolite_counter);
+	git_config_set_in_file(user_config, "user.impolite", buf.buf);
+	strbuf_release(&buf);
+}
+
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
@@ -379,6 +423,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "patch-id", cmd_patch_id },
 		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
+		{ "please", cmd_please, RUN_SETUP_GENTLY },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
@@ -441,8 +486,11 @@ static void handle_internal_command(int argc, const char **argv)
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
+
 		if (strcmp(p->cmd, cmd))
 			continue;
+
+		check_politeness(cmd);
 		exit(run_builtin(p, argc, argv));
 	}
 }
@@ -506,7 +554,6 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
-
 int main(int argc, const char **argv)
 {
 	const char *cmd;
-- 
1.8.3.rc1.44.gb387c77
