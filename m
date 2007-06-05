From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH 1/2] This patch was inspired by ClearCase command 'ct man', which
Date: Tue, 5 Jun 2007 18:28:18 +0000
Message-ID: <20070605182818.GA8420@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 20:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvdlr-0006B9-VR
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 20:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbXFES2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbXFES2b
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 14:28:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:39052 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbXFES23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 14:28:29 -0400
Received: by wr-out-0506.google.com with SMTP id i21so1101761wra
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 11:28:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=TMiLooYC/ktiH9vxgg7pG2VuLBx+yrIl4N+zSVGks3tIYtUmdvZsIs7GoqpLF3AswiVDPwXjU8+KJ+r6rLPnRcG0ZVhrx7601nBi52qXYiFcKyjx76gcezuAAe2xHFCVl4SLIqHUiF3c8a7DnF3hJ6aYQr3/Z9yt8KLYYLLKIj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=s1wREn49i654SPdPIxc5i9XFOMNFnDNBwoNb2nqB7tt3qCUyYiEGHmcZkHKPGkzI3XEmM2mQBd9o6rdhjQ1MdZ4pCIDBiekN/jemqq9lQqdDZa0Lr+kINDLfaUXDPKqYZmODlE8pwZyva6kChl02jDtORT8ibAIzWe/qA4cWZlk=
Received: by 10.90.89.5 with SMTP id m5mr5421832agb.1181068108252;
        Tue, 05 Jun 2007 11:28:28 -0700 (PDT)
Received: from pclouds@gmail.com ( [66.129.232.2])
        by mx.google.com with ESMTP id 5sm2639084agc.2007.06.05.11.28.27;
        Tue, 05 Jun 2007 11:28:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue,  5 Jun 2007 18:28:18 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49215>

opens an html help file on Windows. I at first attempted to
implement it for MinGW port only but found it so useful that I
wanted to have it even in Linux.

A new option '--html' is added to git. When git-help is called
with --html, it will try to open an html file located at
$(docdir)/html using xdg-open. HTML files are not installed
by default so users have to install them manually or have their
distributors to do that.

There are two new config options introduced in this patch. The
first is core.help. It has one of three values: html, auto or
man. 'html' has the same effect as git-help --html. 'auto'
will in addition fall back to man pages if possible. 'man'
is 'I hate html, give me my man pages'.  The second option is
core.htmlprogram, used to specify the program you want to
open html files instead of xdg-open. You can override the default
program by appending HTML_PROGRAM=blah when calling make.
core.htmlprogram can contain %p, %f or %b.  If none is given,
%p will be appended.

Signed-off-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |   16 +++++
 Documentation/git.txt    |    5 +-
 Makefile                 |    5 +-
 cache.h                  |    2 +
 config.c                 |   17 +++++
 config.mak.in            |    3 +-
 environment.c            |    2 +
 git.c                    |    2 +-
 help.c                   |  166 +++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 212 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5868d58..7687750 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -262,6 +262,22 @@ core.excludeFile::
 	of files which are not meant to be tracked.  See
 	gitlink:gitignore[5].
 
+core.help::
+	If 'html', it is equivalent to 'git-help' with option --html.
+	If 'auto', it tries to open html files first. If that attempt fails
+	(the html program does not exist or the program return non-zero
+	value), then it will fall back to man pages. If 'man', always use
+	man pages as usual.
+
+core.htmlprogram::
+	Specify the program used to open html help files when 'git-help'
+	is called with option --html or core.help is other than 'man'.
+	By default, xdg-open will be used.
+	Special strings '%p', '%f' and '%b' will be replaced with html
+	full path, file name and git command (without .html suffix)
+	respectively. If none is given, '%p' will be automatically appended
+	to the command line.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 98860af..589ebea 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
-    [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=GIT_DIR] [--help [--html]] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -87,6 +87,9 @@ OPTIONS
 	commands.  If a git command is named this option will bring up
 	the man-page for that command. If the option '--all' or '-a' is
 	given then all available commands are printed.
+	If option '--html' is given, try opening html files instead of
+	using 'man'. The default program to open html files is xdg-open.
+	See 'git-config' to know how to change html program.
 
 --exec-path::
 	Path to wherever your core git programs are installed.
diff --git a/Makefile b/Makefile
index a11ff60..744a732 100644
--- a/Makefile
+++ b/Makefile
@@ -186,6 +186,7 @@ export TCL_PATH TCLTK_PATH
 # explicitly what architecture to check for. Fix this up for yours..
 SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 
+HTML_PROGRAM=xdg-open
 
 
 ### --- END CONFIGURATION SECTION ---
@@ -693,6 +694,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+html_dir_SQ = $(subst ','\'',$(html_dir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
 
@@ -741,7 +743,8 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+help.o: help.c common-cmds.h
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DHTML_DIR='"$(html_dir_SQ)"' -DHTML_PROGRAM='"$(HTML_PROGRAM)"' $<
 
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
diff --git a/cache.h b/cache.h
index 8a9d1f3..dbaae6a 100644
--- a/cache.h
+++ b/cache.h
@@ -288,6 +288,8 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int show_html_help;
+extern const char *html_help_program;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 0614c2b..d216ab7 100644
--- a/config.c
+++ b/config.c
@@ -382,6 +382,23 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.help")) {
+		if (!strcmp(value, "auto"))
+			show_html_help = 2;
+		else if (!strcmp(value, "html"))
+			show_html_help = 1;
+		else if (!strcmp(value, "man"))
+			show_html_help = 0;
+		else
+			return 1;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.htmlprogram")) {
+		html_help_program = xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/config.mak.in b/config.mak.in
index eb9d7a5..c3e410d 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -8,12 +8,14 @@ TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
 
+PACKAGE_TARNAME=@PACKAGE_TARNAME@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
 #gitexecdir = @libexecdir@/git-core/
 datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates/
+html_dir = @docdir@/html/
 
 mandir=@mandir@
 
@@ -38,4 +40,3 @@ NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRLCPY=@NO_STRLCPY@
 NO_SETENV=@NO_SETENV@
 NO_ICONV=@NO_ICONV@
-
diff --git a/environment.c b/environment.c
index 9d3e5eb..e905972 100644
--- a/environment.c
+++ b/environment.c
@@ -32,6 +32,8 @@ size_t delta_base_cache_limit = 16 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+int show_html_help = 0;
+const char *html_help_program = NULL;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
diff --git a/git.c b/git.c
index 29b55a1..c3c0fe8 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help [--html]] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
diff --git a/help.c b/help.c
index 6a9af4d..78b1023 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,14 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
 
+#ifndef HTML_DIR
+#define HTML_DIR "/usr/share/html/"
+#endif
+
+#ifndef HTML_PROGRAM
+#define HTML_PROGRAM "xdg-open"
+#endif
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -183,6 +191,145 @@ static void show_man_page(const char *git_cmd)
 	execlp("man", "man", page, NULL);
 }
 
+static void show_html_page(const char *git_cmd)
+{
+	const char *html_dir;
+	int len, ret, nr_quotes;
+	char *p, *p2;
+	const char *cp, *cp2;
+	struct stat st;
+	char *quoted_git_cmd;
+	char *default_command = NULL;
+	const char *command;
+
+	html_dir = HTML_DIR;
+	command = html_help_program ? html_help_program : HTML_PROGRAM;
+
+	nr_quotes = 0;
+	for (cp = git_cmd; *cp; cp++)
+		if (*cp == '\'') nr_quotes ++;
+
+	len = strlen(git_cmd) + nr_quotes*2 + 2 + 4; /* two quotes and git- */
+	quoted_git_cmd = p2 = xmalloc(len + 1);
+	*p2++ = '\'';
+	if (prefixcmp(git_cmd, "git")) {
+		strcpy(p2,"git-");
+		p2 += 4;
+	}
+	for (cp = git_cmd; *cp; cp ++) {
+		if (*cp == '\'')
+			*p2++ = '\\';
+		*p2++ = *cp;
+	}
+	*p2++ = '\'';
+	*p2 = 0;
+
+	/* append %p if there is not any %x */
+	if (!strchr(command, '%')) {
+		len = strlen(command);
+		default_command = xmalloc(len + 3 + 1); /* space %p */
+		strcpy(default_command, command);
+		strcat(default_command, " %p");
+		command = default_command;
+	}
+
+	/* first pass, calculate command length */
+	cp = command;
+	len = 0;
+	while (*cp && (cp2 = strchr(cp, '%'))) {
+		len += cp2 - cp;
+
+		if (!cp2[1]) {
+			len ++;
+			break;
+		}
+
+		switch (cp2[1]) {
+			case 'p':
+				len += strlen(html_dir) + strlen(quoted_git_cmd) + 5; /* .html */
+				break;
+
+			case 'f':
+				len += strlen(quoted_git_cmd) + 5; /* .html */
+				break;
+
+			case 'b':
+				len += strlen(quoted_git_cmd);
+				break;
+
+			default:
+				len += 2;
+		}
+		cp = cp2 + 2;
+	}
+
+	/* second pass */
+	cp = command;
+	p = p2 = xmalloc(len + 1);
+	while (*cp && (cp2 = strchr(cp, '%'))) {
+		len = cp2 - cp;
+		memcpy(p2, cp, len);
+		p2 += len;
+
+		if (!cp2[1]) {
+			*p2++ = *cp2;
+			break;
+		}
+
+		switch (cp2[1]) {
+			case 'p':
+				len = strlen(html_dir);
+				memcpy(p2, html_dir, len);
+				p2 += len;
+
+				len = strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 += len;
+
+				memcpy(p2, ".html", 5);
+				p2 += 5;
+				break;
+
+			case 'f':
+				len = strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 += len;
+
+				memcpy(p2, ".html", 5);
+				p2 += 5;
+				break;
+
+			case 'b':
+				len = strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 += len;
+				break;
+
+			default:
+				*p2++ = cp2[0];
+				*p2++ = cp2[1];
+		}
+		cp = cp2+2;
+	}
+	*p2 = 0;
+
+	free(quoted_git_cmd);
+	if (default_command)
+		free(default_command);
+
+	ret = system(p);
+
+	if (ret == -1)
+		error("Failed to run %s", p);
+
+	free(p);
+
+	/* fallback to man pages */
+	if (show_html_help > 1 && (ret == -1 || ret > 0))
+		show_man_page(git_cmd);
+	exit(ret);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	printf("git: '%s' is not a git-command\n\n", cmd);
@@ -214,8 +361,23 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	else
-		show_man_page(help_cmd);
+	else {
+		git_config(git_default_config);
+		if (!strcmp(help_cmd, "--html")) {
+			help_cmd = argc > 2 ? argv[2] : NULL;
+			if (!help_cmd) {
+				printf("usage: %s\n\n", git_usage_string);
+				list_common_cmds_help();
+				exit(1);
+			}
+			show_html_help = 1;
+		}
+
+		if (show_html_help)
+			show_html_page(help_cmd);
+		else
+			show_man_page(help_cmd);
+	}
 
 	return 0;
 }
-- 
1.5.0.7
