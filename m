From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-config: document --rename-section, provide --remove-section
Date: Fri, 2 Mar 2007 21:53:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022152050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es66vt$jej$1@sea.gmane.org>
 <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E7DDB5.9060009@lu.unisi.ch> <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E814D9.7020104@lu.unisi.ch> <Pine.LNX.4.63.0703021640440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E850D8.4040306@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 21:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNEl1-0004TV-Ba
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbXCBUxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 15:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965607AbXCBUxg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 15:53:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:46623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965606AbXCBUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 15:53:34 -0500
Received: (qmail invoked by alias); 02 Mar 2007 20:53:33 -0000
X-Provags-ID: V01U2FsdGVkX19of1dx0KpoFwkMoiaqAlCt0PEBpbWf9oIiG6V1CM
	5MJtEaNthbNyxl
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E850D8.4040306@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41246>


From: Paolo Bonzini <bonzini@gnu.org>

This patch documents the previously undocumented option --rename-section
and adds a new option to zap an entire section.

Hopefully-Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I just made the changes to git_rename_section() myself, and added
	the test case (which I made a little nastier, too), then made sure
	that everything is fine.

	Paolo, do you agree with this patch? I left you as the author, 
	because you did all the hard work.

 Documentation/git-config.txt |    8 +++++
 builtin-config.c             |   15 ++++++++++-
 config.c                     |   60 +++++++++++++++++++++++++----------------
 t/t1300-repo-config.sh       |   16 +++++++++++
 4 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6624484..68de588 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -16,6 +16,8 @@ SYNOPSIS
 'git-config' [--global] [type] --get-all name [value_regex]
 'git-config' [--global] [type] --unset name [value_regex]
 'git-config' [--global] [type] --unset-all name [value_regex]
+'git-config' [--global] [type] --rename-section old_name new_name
+'git-config' [--global] [type] --remove-section name
 'git-config' [--global] -l | --list
 
 DESCRIPTION
@@ -74,6 +76,12 @@ OPTIONS
 --global::
 	Use global ~/.gitconfig file rather than the repository .git/config.
 
+--remove-section::
+	Remove the given section from the configuration file.
+
+--rename-section::
+	Rename the given section to a new name.
+
 --unset::
 	Remove the line matching the key from config file.
 
diff --git a/builtin-config.c b/builtin-config.c
index f1433a4..dfa403b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
+"git-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -168,6 +168,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			}
 			return 0;
 		}
+		else if (!strcmp(argv[1], "--remove-section")) {
+			int ret;
+			if (argc != 3)
+				usage(git_config_set_usage);
+			ret = git_config_rename_section(argv[2], NULL);
+			if (ret < 0)
+				return ret;
+			if (ret == 0) {
+				fprintf(stderr, "No such section!\n");
+				return 1;
+			}
+			return 0;
+		}
 		else
 			break;
 		argc--;
diff --git a/config.c b/config.c
index 0ff413b..5611d7a 100644
--- a/config.c
+++ b/config.c
@@ -854,9 +854,37 @@ write_err_out:
 
 }
 
+static int section_name_match (const char *buf, const char *name)
+{
+	int i = 0, j = 0, dot = 0;
+	for (; buf[i] && buf[i] != ']'; i++) {
+		if (!dot && isspace(buf[i])) {
+			dot = 1;
+			if (name[j++] != '.')
+				break;
+			for (i++; isspace(buf[i]); i++)
+				; /* do nothing */
+			if (buf[i] != '"')
+				break;
+			continue;
+		}
+		if (buf[i] == '\\' && dot)
+			i++;
+		else if (buf[i] == '"' && dot) {
+			for (i++; isspace(buf[i]); i++)
+				; /* do_nothing */
+			break;
+		}
+		if (buf[i] != name[j++])
+			break;
+	}
+	return (buf[i] == ']' && name[j] == 0);
+}
+
+/* if new_name == NULL, the section is removed instead */
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
-	int ret = 0;
+	int ret = 0, remove = 0;
 	char *config_filename;
 	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
 	int out_fd;
@@ -887,31 +915,12 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 			; /* do nothing */
 		if (buf[i] == '[') {
 			/* it's a section */
-			int j = 0, dot = 0;
-			for (i++; buf[i] && buf[i] != ']'; i++) {
-				if (!dot && isspace(buf[i])) {
-					dot = 1;
-					if (old_name[j++] != '.')
-						break;
-					for (i++; isspace(buf[i]); i++)
-						; /* do nothing */
-					if (buf[i] != '"')
-						break;
+			if (section_name_match (&buf[i+1], old_name)) {
+				ret++;
+				if (new_name == NULL) {
+					remove = 1;
 					continue;
 				}
-				if (buf[i] == '\\' && dot)
-					i++;
-				else if (buf[i] == '"' && dot) {
-					for (i++; isspace(buf[i]); i++)
-						; /* do_nothing */
-					break;
-				}
-				if (buf[i] != old_name[j++])
-					break;
-			}
-			if (buf[i] == ']' && old_name[j] == 0) {
-				/* old_name matches */
-				ret++;
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
 					ret = write_error();
@@ -919,7 +928,10 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 				}
 				continue;
 			}
+			remove = 0;
 		}
+		if (remove)
+			continue;
 		length = strlen(buf);
 		if (write_in_full(out_fd, buf, length) != length) {
 			ret = write_error();
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3753e9f..655d1e6 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -391,6 +391,22 @@ EOF
 
 test_expect_success "rename succeeded" "git diff expect .git/config"
 
+cat >> .git/config << EOF
+  [branch "zwei"] a = 1 [branch "vier"]
+EOF
+
+test_expect_success "remove section" "git config --remove-section branch.zwei"
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "drei"]
+weird
+EOF
+
+test_expect_success "section was removed properly" \
+	"diff -u expect .git/config"
+
 test_expect_success numbers '
 
 	git-config kilo.gram 1k &&
-- 
1.5.0.2.2488.gdffb-dirty
