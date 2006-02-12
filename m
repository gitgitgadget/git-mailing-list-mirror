From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Add support for explicit type specifiers when calling git-repo-config
Date: Sun, 12 Feb 2006 04:14:48 +0100
Message-ID: <20060212031448.GU31278@pasky.or.cz>
References: <43ED0368.7020204@gmail.com> <7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com> <7vvevmtza4.fsf@assigned-by-dhcp.cox.net> <43ED5F60.1010408@gmail.com> <7v1wyasfam.fsf@assigned-by-dhcp.cox.net> <7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 04:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F87gx-0006AM-9u
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 04:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWBLDOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 22:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWBLDOQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 22:14:16 -0500
Received: from w241.dkm.cz ([62.24.88.241]:30873 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750867AbWBLDOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 22:14:16 -0500
Received: (qmail 11920 invoked by uid 2001); 12 Feb 2006 04:14:48 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15975>

Dear diary, on Sat, Feb 11, 2006 at 05:43:21AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  (3) neither of these commands know list of all the possible
>      configuration items, nor types of them, so core.filename
>      can be spelled as "1" or "true" to mean the same thing to
>      our C code, but repo-config faithfully returns how the
>      value is literally spelled in the configuration file.  The
>      following two means the same thing to the C layer, so the
>      calling script needs to further interpret the output from
>      git-repo-config:
> 
> 	$ git repo-config core.filemode ;# [core] filemode=1
> 	1
> 	$ git repo-config core.filemode ;# [core] filemode=true
> 	true
> 
>  (4) worse, boolean 'true' can be specified by just having the
>      configuration item in the file, but repo-config dumps core
>      on that:
> 
> 	$ git repo-config core.filemode ;# [core] filemode
>         segmentation fault

This patch provides a partial solution - if you query only for variables
of the same type (or just a single variable), this adds type-checking
and transformation to the given type.

It is basically what Cogito would like to see - centralized variables
database in GIT won't help us, but we would like to have custom but
still typed variables in the config file.

---

[PATCH] Add support for explicit type specifiers when calling git-repo-config

Currently, git-repo-config will just return the raw value of option
as specified in the config file; this makes things difficult for scripts
calling it, especially if the value is supposed to be boolean.

This patch makes it possible to ask git-repo-config to check if the option
is of the given type (int or bool) and write out the value in its
canonical form. If you do not pass --int or --bool, the behaviour stays
unchanged and the raw value is emitted.

This also incidentally fixes the segfault when option with no value is
encountered.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit 8dcc626cd144b2c6eae2a299242bbbe905cb0059
tree 0d4dcc3a44eb318ef52c3d64dda11768745f7583
parent 29e55cd5ad9e17d2ff8a1a37b7ee45d18d1e59d6
author Petr Baudis <pasky@suse.cz> Sun, 12 Feb 2006 04:09:01 +0100
committer Petr Baudis <xpasky@machine.or.cz> Sun, 12 Feb 2006 04:09:01 +0100

 Documentation/git-repo-config.txt |   18 ++++++--
 repo-config.c                     |   80 +++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 3069464..33fcde4 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -8,12 +8,12 @@ git-repo-config - Get and set options in
 
 SYNOPSIS
 --------
-'git-repo-config' name [value [value_regex]]
-'git-repo-config' --replace-all name [value [value_regex]]
-'git-repo-config' --get name [value_regex]
-'git-repo-config' --get-all name [value_regex]
-'git-repo-config' --unset name [value_regex]
-'git-repo-config' --unset-all name [value_regex]
+'git-repo-config' [type] name [value [value_regex]]
+'git-repo-config' [type] --replace-all name [value [value_regex]]
+'git-repo-config' [type] --get name [value_regex]
+'git-repo-config' [type] --get-all name [value_regex]
+'git-repo-config' [type] --unset name [value_regex]
+'git-repo-config' [type] --unset-all name [value_regex]
 
 DESCRIPTION
 -----------
@@ -26,6 +26,12 @@ should provide a POSIX regex for the val
 *not* matching the regex, just prepend a single exclamation mark in front
 (see EXAMPLES).
 
+The type specifier can be either '--int' or '--bool', which will make
+'git-repo-config' ensure that the variable(s) are of the given type and
+convert the value to the canonical form (simple decimal number for int,
+a "true" or "false" string for bool). If no type specifier is passed,
+no checks or transformations are performed on the value.
+
 This command will fail if
 
 . .git/config is invalid,
diff --git a/repo-config.c b/repo-config.c
index c31e441..ccdee3c 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -2,7 +2,7 @@
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
+"git-repo-config [ --bool | --int ] [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
 
 static char* key = NULL;
 static char* value = NULL;
@@ -10,6 +10,7 @@ static regex_t* regexp = NULL;
 static int do_all = 0;
 static int do_not_match = 0;
 static int seen = 0;
+static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_config(const char* key_, const char* value_)
 {
@@ -25,7 +26,17 @@ static int show_config(const char* key_,
 			fprintf(stderr, "More than one value: %s\n", value);
 			free(value);
 		}
-		value = strdup(value_);
+
+		if (type == T_INT) {
+			value = malloc(256);
+			sprintf(value, "%d", git_config_int(key_, value_));
+		} else if (type == T_BOOL) {
+			value = malloc(256);
+			sprintf(value, "%s", git_config_bool(key_, value_)
+					     ? "true" : "false");
+		} else {
+			value = strdup(value_ ? : "");
+		}
 		seen++;
 	}
 	return 0;
@@ -72,43 +83,52 @@ static int get_value(const char* key_, c
 
 int main(int argc, const char **argv)
 {
+	int i;
 	setup_git_directory();
-	switch (argc) {
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--int"))
+			type = T_INT;
+		else if (!strcmp(argv[i], "--bool"))
+			type = T_BOOL;
+		else
+			break;
+	}
+	switch (argc-i) {
+	case 1:
+		return get_value(argv[i], NULL);
 	case 2:
-		return get_value(argv[1], NULL);
-	case 3:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set(argv[2], NULL);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, NULL, 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], NULL);
-		else if (!strcmp(argv[1], "--get-all")) {
+		if (!strcmp(argv[i], "--unset"))
+			return git_config_set(argv[i+1], NULL);
+		else if (!strcmp(argv[i], "--unset-all"))
+			return git_config_set_multivar(argv[i+1], NULL, NULL, 1);
+		else if (!strcmp(argv[i], "--get"))
+			return get_value(argv[i+1], NULL);
+		else if (!strcmp(argv[i], "--get-all")) {
 			do_all = 1;
-			return get_value(argv[2], NULL);
+			return get_value(argv[i+1], NULL);
 		} else
 
-			return git_config_set(argv[1], argv[2]);
-	case 4:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], argv[3]);
-		else if (!strcmp(argv[1], "--get-all")) {
+			return git_config_set(argv[i], argv[i+1]);
+	case 3:
+		if (!strcmp(argv[i], "--unset"))
+			return git_config_set_multivar(argv[i+1], NULL, argv[i+2], 0);
+		else if (!strcmp(argv[i], "--unset-all"))
+			return git_config_set_multivar(argv[i+1], NULL, argv[i+2], 1);
+		else if (!strcmp(argv[i], "--get"))
+			return get_value(argv[i+1], argv[i+2]);
+		else if (!strcmp(argv[i], "--get-all")) {
 			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--replace-all"))
+			return get_value(argv[i+1], argv[i+2]);
+		} else if (!strcmp(argv[i], "--replace-all"))
 
-			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
+			return git_config_set_multivar(argv[i+1], argv[i+2], NULL, 1);
 		else
 
-			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
-	case 5:
-		if (!strcmp(argv[1], "--replace-all"))
-			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
-	case 1:
+			return git_config_set_multivar(argv[i], argv[i+1], argv[i+2], 0);
+	case 4:
+		if (!strcmp(argv[i], "--replace-all"))
+			return git_config_set_multivar(argv[i+1], argv[i+2], argv[i+3], 1);
+	case 0:
 	default:
 		usage(git_config_set_usage);
 	}


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
