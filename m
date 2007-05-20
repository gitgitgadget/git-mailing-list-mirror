From: skimo@liacs.nl
Subject: [PATCH 02/15] git-config: add --remote option for reading config from remote repo
Date: Sun, 20 May 2007 20:04:35 +0200
Message-ID: <11796842881646-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppmK-0007La-7I
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528AbXETSE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbXETSE6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:04:58 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37195 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528AbXETSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:04:57 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4m9A007799;
	Sun, 20 May 2007 20:04:53 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id BA0677DDA1; Sun, 20 May 2007 20:04:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47864>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/git-config.txt |   33 +++++++++++++++++++++---------
 builtin-config.c             |   44 ++++++++++++++++++++++++++++++++---------
 cache.h                      |    1 +
 config.c                     |   26 ++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 280ef20..76398ab 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,16 +9,25 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global] [type] name [value [value_regex]]
-'git-config' [--system | --global] [type] --add name value
-'git-config' [--system | --global] [type] --replace-all name [value [value_regex]]
-'git-config' [--system | --global] [type] --get name [value_regex]
-'git-config' [--system | --global] [type] --get-all name [value_regex]
-'git-config' [--system | --global] [type] --unset name [value_regex]
-'git-config' [--system | --global] [type] --unset-all name [value_regex]
-'git-config' [--system | --global] [type] --rename-section old_name new_name
-'git-config' [--system | --global] [type] --remove-section name
-'git-config' [--system | --global] -l | --list
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] name [value [value_regex]]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --add name value
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --replace-all name [value [value_regex]]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --get name [value_regex]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --get-all name [value_regex]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --unset name [value_regex]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --unset-all name [value_regex]
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --rename-section old_name new_name
+'git-config' [--system | --global | --remote=[<host>:]<directory ]
+	     [type] --remove-section name
+'git-config' [--system | --global | --remote=[<host>:]<directory ] -l | --list
 
 DESCRIPTION
 -----------
@@ -80,6 +89,10 @@ OPTIONS
 	Use system-wide $(prefix)/etc/gitconfig rather than the repository
 	.git/config.
 
+--remote=[<host>:]<directory
+	Use remote config instead of the repository .git/config.
+	Only available for reading options.
+
 --remove-section::
 	Remove the given section from the configuration file.
 
diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..3a1e86c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,8 +2,10 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system | --remote=[<host>:]<directory ] "
+"[ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
+static char *dest;
 static char *key;
 static regex_t *key_regexp;
 static regex_t *regexp;
@@ -104,15 +106,19 @@ static int get_value(const char* key_, const char* regex_)
 		}
 	}
 
-	if (do_all && system_wide)
-		git_config_from_file(show_config, system_wide);
-	if (do_all && global)
-		git_config_from_file(show_config, global);
-	git_config_from_file(show_config, local);
-	if (!do_all && !seen && global)
-		git_config_from_file(show_config, global);
-	if (!do_all && !seen && system_wide)
-		git_config_from_file(show_config, system_wide);
+	if (dest)
+		git_config_from_remote(show_config, dest);
+	else {
+		if (do_all && system_wide)
+			git_config_from_file(show_config, system_wide);
+		if (do_all && global)
+			git_config_from_file(show_config, global);
+		git_config_from_file(show_config, local);
+		if (!do_all && !seen && global)
+			git_config_from_file(show_config, global);
+		if (!do_all && !seen && system_wide)
+			git_config_from_file(show_config, system_wide);
+	}
 
 	free(key);
 	if (regexp) {
@@ -155,8 +161,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[1], "--system"))
 			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
+		else if (!prefixcmp(argv[1], "--remote="))
+			dest = xstrdup(argv[1]+9);
 		else if (!strcmp(argv[1], "--rename-section")) {
 			int ret;
+			if (dest) {
+				fprintf(stderr, "Cannot rename on remote\n");
+				return 1;
+			}
 			if (argc != 4)
 				usage(git_config_set_usage);
 			ret = git_config_rename_section(argv[2], argv[3]);
@@ -170,6 +182,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[1], "--remove-section")) {
 			int ret;
+			if (dest) {
+				fprintf(stderr, "Cannot remove on remote\n");
+				return 1;
+			}
 			if (argc != 3)
 				usage(git_config_set_usage);
 			ret = git_config_rename_section(argv[2], NULL);
@@ -191,6 +207,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	case 2:
 		return get_value(argv[1], NULL);
 	case 3:
+		if (dest && prefixcmp(argv[1], "--get")) {
+			fprintf(stderr, "Cannot (un)set on remote\n");
+			return 1;
+		}
 		if (!strcmp(argv[1], "--unset"))
 			return git_config_set(argv[2], NULL);
 		else if (!strcmp(argv[1], "--unset-all"))
@@ -209,6 +229,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 			return git_config_set(argv[1], argv[2]);
 	case 4:
+		if (dest && prefixcmp(argv[1], "--get")) {
+			fprintf(stderr, "Cannot (un)set on remote\n");
+			return 1;
+		}
 		if (!strcmp(argv[1], "--unset"))
 			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
 		else if (!strcmp(argv[1], "--unset-all"))
diff --git a/cache.h b/cache.h
index 65b4685..452aa89 100644
--- a/cache.h
+++ b/cache.h
@@ -501,6 +501,7 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
 extern int git_config_from_file(config_fn_t fn, const char *);
+extern int git_config_from_remote(config_fn_t fn, char *dest);
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 0614c2b..dbfae3f 100644
--- a/config.c
+++ b/config.c
@@ -6,9 +6,12 @@
  *
  */
 #include "cache.h"
+#include "pkt-line.h"
 
 #define MAXNAME (256)
 
+static const char *dumpconfig = "git-dump-config";
+
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
@@ -403,6 +406,29 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 	return ret;
 }
 
+int git_config_from_remote(config_fn_t fn, char *dest)
+{
+	int ret;
+	int fd[2];
+	pid_t pid;
+	static char var[MAXNAME];
+	static char value[1024];
+
+	pid = git_connect(fd, dest, dumpconfig);
+	if (pid < 0)
+		return 1;
+	ret = 0;
+	while (packet_read_line(fd[0], var, sizeof(var))) {
+		if (!packet_read_line(fd[0], value, sizeof(value)))
+			die("Missing value");
+		fn(var, value);
+	}
+	close(fd[0]);
+	close(fd[1]);
+	ret |= finish_connect(pid);
+	return !!ret;
+}
+
 int git_config(config_fn_t fn)
 {
 	int ret = 0;
-- 
1.5.2.rc3.815.g8fc2
