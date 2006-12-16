X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] add a function to rename sections in the config
Date: Sat, 16 Dec 2006 15:14:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161513480.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 14:14:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34618>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvaJ6-0007r1-Dw for gcvg-git@gmane.org; Sat, 16 Dec
 2006 15:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932386AbWLPOOR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 09:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWLPOOR
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 09:14:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:53642 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932386AbWLPOOQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 09:14:16 -0500
Received: (qmail invoked by alias); 16 Dec 2006 14:14:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 16 Dec 2006 15:14:14 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Given a config like this:

	# A config
	[very.interesting.section]
		not

The command

	$ git repo-config --rename-section very.interesting.section bla.1

will lead to this config:

	# A config
	[bla "1"]
		not

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-repo-config.c  |   14 +++++++++-
 cache.h                |    1 +
 config.c               |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1300-repo-config.sh |   48 ++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 1 deletions(-)

diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index 7b6e572..a6b99ed 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -3,7 +3,7 @@
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
+"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -148,6 +148,18 @@ int cmd_repo_config(int argc, const char **argv, const char *prefix)
 			} else {
 				die("$HOME not set");
 			}
+		} else if (!strcmp(argv[1], "--rename-section")) {
+			int ret;
+			if (argc != 4)
+				usage(git_config_set_usage);
+			ret = git_config_rename_section(argv[2], argv[3]);
+			if (ret < 0)
+				return ret;
+			if (ret == 0) {
+				fprintf(stderr, "No such section!\n");
+				return 1;
+			}
+			return 0;
 		} else
 			break;
 		argc--;
diff --git a/cache.h b/cache.h
index 40afee3..a2ffa23 100644
--- a/cache.h
+++ b/cache.h
@@ -403,6 +403,7 @@ extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_rename_section(const char *, const char *);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index 1bdef44..663993f 100644
--- a/config.c
+++ b/config.c
@@ -746,4 +746,68 @@ out_free:
 	return ret;
 }
 
+int git_config_rename_section(const char *old_name, const char *new_name)
+{
+	int ret = 0;
+	const char *config_filename;
+	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
+	int out_fd;
+	char buf[1024];
+
+	config_filename = getenv("GIT_CONFIG");
+	if (!config_filename) {
+		config_filename = getenv("GIT_CONFIG_LOCAL");
+		if (!config_filename)
+			config_filename  = git_path("config");
+	}
+	config_filename = xstrdup(config_filename);
+	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
+	if (out_fd < 0)
+		return error("Could not lock config file!");
+
+	if (!(config_file = fopen(config_filename, "rb")))
+		return error("Could not open config file!");
+
+	while (fgets(buf, sizeof(buf), config_file)) {
+		int i;
+		for (i = 0; buf[i] && isspace(buf[i]); i++)
+			; /* do nothing */
+		if (buf[i] == '[') {
+			/* it's a section */
+			int j = 0, dot = 0;
+			for (i++; buf[i] && buf[i] != ']'; i++) {
+				if (!dot && isspace(buf[i])) {
+					dot = 1;
+					if (old_name[j++] != '.')
+						break;
+					for (i++; isspace(buf[i]); i++)
+						; /* do nothing */
+					if (buf[i] != '"')
+						break;
+					continue;
+				}
+				if (buf[i] == '\\' && dot)
+					i++;
+				else if (buf[i] == '"' && dot) {
+					for (i++; isspace(buf[i]); i++)
+						; /* do_nothing */
+					break;
+				}
+				if (buf[i] != old_name[j++])
+					break;
+			}
+			if (buf[i] == ']') {
+				/* old_name matches */
+				ret++;
+				store.baselen = strlen(new_name);
+				store_write_section(out_fd, new_name);
+				continue;
+			}
+		}
+		write(out_fd, buf, strlen(buf));
+	}
+	if (close(out_fd) || commit_lock_file(lock) < 0)
+		return error("Cannot commit config file!");
+	return ret;
+}
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0de2497..b643cad 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -333,5 +333,53 @@ EOF
 
 test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-config expect'
 
+cat > .git/config << EOF
+# Hallo
+	#Bello
+[branch "eins"]
+	x = 1
+[branch.eins]
+	y = 1
+	[branch "1 234 blabl/a"]
+weird
+EOF
+
+test_expect_success "rename section" \
+	"git-repo-config --rename-section branch.eins branch.zwei"
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "zwei"]
+	x = 1
+[branch "zwei"]
+	y = 1
+	[branch "1 234 blabl/a"]
+weird
+EOF
+
+test_expect_success "rename succeeded" "diff -u expect .git/config"
+
+test_expect_failure "rename non-existing section" \
+	'git-repo-config --rename-section branch."world domination" branch.drei'
+
+test_expect_success "rename succeeded" "diff -u expect .git/config"
+
+test_expect_success "rename another section" \
+	'git-repo-config --rename-section branch."1 234 blabl/a" branch.drei'
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "zwei"]
+	x = 1
+[branch "zwei"]
+	y = 1
+[branch "drei"]
+weird
+EOF
+
+test_expect_success "rename succeeded" "diff -u expect .git/config"
+
 test_done
 
-- 
1.4.4.1.g0604-dirty
