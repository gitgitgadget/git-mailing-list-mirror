From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] Add git-config --remove-section, document --rename-section
Date: Thu, 01 Mar 2007 10:39:09 +0100
Message-ID: <es66vt$jej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080109050306050904020707"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhl1-000695-TV
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXCAJj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbXCAJj0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:39:26 -0500
Received: from main.gmane.org ([80.91.229.2]:55253 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbXCAJj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:39:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMhks-0008Qn-Jr
	for git@vger.kernel.org; Thu, 01 Mar 2007 10:39:18 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 10:39:18 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 10:39:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41068>

This is a multi-part message in MIME format.
--------------080109050306050904020707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As per the subject.  The existing --rename-section option is 
undocumented, while --remove-section is added by this patch based on the 
code I had written for the "git branch" patch.

Paolo

--------------080109050306050904020707
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="git-builtin-config-removesec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-builtin-config-removesec.patch"

* git-config: document --rename-section, provide --remove-section

This patch documents the previously undocumented option --rename-section
and adds a new option to zap an entire section.


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
index f1433a4..6b12fa1 100644
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
+			ret = git_config_remove_section(argv[2]);
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
index 0ff413b..49df7bd 100644
--- a/config.c
+++ b/config.c
@@ -854,6 +859,33 @@ write_err_out:
 
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
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
 	int ret = 0;
@@ -885,40 +917,15 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 		int length;
 		for (i = 0; buf[i] && isspace(buf[i]); i++)
 			; /* do nothing */
-		if (buf[i] == '[') {
+		if (buf[i] == '[' && section_name_match (&buf[i+1], old_name)) {
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
-					continue;
-				}
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
-				store.baselen = strlen(new_name);
-				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error();
-					goto out;
-				}
-				continue;
+			ret++;
+			store.baselen = strlen(new_name);
+			if (!store_write_section(out_fd, new_name)) {
+				ret = write_error();
+				goto out;
 			}
+			continue;
 		}
 		length = strlen(buf);
 		if (write_in_full(out_fd, buf, length) != length) {
@@ -934,3 +941,58 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	return ret;
 }
 
+int git_config_remove_section(const char *name)
+{
+	int ret = 0;
+	char *config_filename;
+	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
+	int out_fd;
+	int removing = 0;
+	char buf[1024];
+
+	config_filename = getenv(CONFIG_ENVIRONMENT);
+	if (!config_filename) {
+		config_filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
+		if (!config_filename)
+			config_filename  = git_path("config");
+	}
+	config_filename = xstrdup(config_filename);
+	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
+	if (out_fd < 0) {
+		ret = error("Could not lock config file!");
+		goto out;
+	}
+
+	if (!(config_file = fopen(config_filename, "rb"))) {
+		ret = error("Could not open config file!");
+		goto out;
+	}
+
+	while (fgets(buf, sizeof(buf), config_file)) {
+		int i;
+		int length;
+		for (i = 0; buf[i] && isspace(buf[i]); i++)
+			; /* do nothing */
+		if (buf[i] == '[') {
+			if (section_name_match (&buf[i + 1], name)) {
+				/* name matches */
+				ret++;
+				removing = 1;
+			} else
+				removing = 0;
+		}
+		if (removing)
+			continue;
+		length = strlen(buf);
+		if (write_in_full(out_fd, buf, length) != length) {
+			ret = write_error();
+			goto out;
+		}
+	}
+	fclose(config_file);
+	if (close(out_fd) || commit_lock_file(lock) < 0)
+			ret = error("Cannot commit config file!");
+ out:
+	free(config_filename);
+	return ret;
+}
diff --git a/cache.h b/cache.h
index 8bbc142..585a9b4 100644
--- a/cache.h
+++ b/cache.h
@@ -438,6 +439,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
+extern int git_config_remove_section(const char *);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)

--------------080109050306050904020707--
