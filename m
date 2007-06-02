From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Show html help with git-help --html
Date: Fri, 1 Jun 2007 21:53:41 -0400
Message-ID: <20070602015341.GA26520@localhost.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 03:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuIoU-00011w-6o
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 03:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbXFBBxp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 21:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbXFBBxp
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 21:53:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:26176 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbXFBBxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 21:53:44 -0400
Received: by wx-out-0506.google.com with SMTP id t15so673896wxc
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 18:53:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=OBvXzJUHkHJbIBa27ZCbd+lqgOeb/yENfuryte06mPVTlaGAgUeLYKvZMKbLjmhx1Pe/Rzk2en6KR4aQBvx2G4v5WHmALl52iTEaBlR+nyX701YxTVJEwrrCjYBrp28sdbfvFbrSjHfCa9gn27ggZm80Wf5wHJd7niVEbAVjlng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=Vi2V4qULCPbjDwPm0CZUrS0O/6pgkgslc0rvr7C9RtiFzqQqmp8GvcpnXzzMGaa0C9AW5KvUlJruzN5x1ZlCUfYW1itdi8KaT2mwz51/1cWc0jekbTcVHUwEz4lafhazEV0KedWwkTqH7E0bBWTiobyqXA706+j3HA+U1enSPu0=
Received: by 10.70.17.1 with SMTP id 1mr3762932wxq.1180749223509;
        Fri, 01 Jun 2007 18:53:43 -0700 (PDT)
Received: from pclouds@gmail.com ( [71.124.247.246])
        by mx.google.com with ESMTP id g3sm105264wra.2007.06.01.18.53.41;
        Fri, 01 Jun 2007 18:53:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  1 Jun 2007 21:53:41 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48908>

This patch was inspired by ClearCase command 'ct man' which
opens an html help file on Windows. I at first attempted to
implement it for MinGW port only but found it so useful that I
wanted to have it even in Linux.

A new option '--help' is added to git. When git-help is called
with --help, it will try to open html files located at
$(sharedir)/html using xdg-open. HTML files are not installed
by default so users have to install them manually or have their
distributors to do that.

There are two new config options introduced in this patch. The
first is core.help. It has one of three values: html, auto or
man. 'html' has the same effect as git-help --html. 'auto'
will in addition fall back to man pages if possible. 'man'
is 'I hate html, give me my man pages'.  The second option is
core.htmlprogram, used to specify the program you want to
open html files instead of xdg-open.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   12 ++++++++++
 Documentation/git.txt    |    5 +++-
 Makefile                 |    5 +++-
 cache.h                  |    2 +
 config.c                 |   17 ++++++++++++++
 environment.c            |    2 +
 git.c                    |    2 +-
 help.c                   |   53 ++++++++++++++++++++++++++++++++++++++=
++++++-
 8 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d8f03d..2ec8545 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -261,6 +261,18 @@ core.excludeFile::
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.
=20
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
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last =3D cat-file commit HEAD", the invocation
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 98860af..589ebea 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate]
-    [--bare] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=3DGIT_DIR] [--help [--html]] COMMAND [ARGS]
=20
 DESCRIPTION
 -----------
@@ -87,6 +87,9 @@ OPTIONS
 	commands.  If a git command is named this option will bring up
 	the man-page for that command. If the option '--all' or '-a' is
 	given then all available commands are printed.
+	If option '--html' is given, try opening html files instead of
+	using 'man'. The default program to open html files is xdg-open.
+	See 'git-config' to know how to change html program.
=20
 --exec-path::
 	Path to wherever your core git programs are installed.
diff --git a/Makefile b/Makefile
index cac0a4a..43e0d15 100644
--- a/Makefile
+++ b/Makefile
@@ -145,6 +145,7 @@ prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
 gitexecdir =3D $(bindir)
 sharedir =3D $(prefix)/share/
+htmldir =3D $(sharedir)/html/
 template_dir =3D $(sharedir)/git-core/templates/
 ifeq ($(prefix),/usr)
 sysconfdir =3D /etc
@@ -693,6 +694,7 @@ ETC_GITCONFIG_SQ =3D $(subst ','\'',$(ETC_GITCONFIG=
))
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
 bindir_SQ =3D $(subst ','\'',$(bindir))
 gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
+htmldir_SQ =3D $(subst ','\'',$(htmldir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
=20
@@ -741,7 +743,8 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIB=
S) GIT-CFLAGS
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
=20
-help.o: common-cmds.h
+help.o: help.c common-cmds.h
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DHTML_DIR=3D'"$(htmldir_SQ=
)"' $<
=20
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
diff --git a/cache.h b/cache.h
index 0da7070..7a438ed 100644
--- a/cache.h
+++ b/cache.h
@@ -288,6 +288,8 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int show_html_help;
+extern const char *html_help_program;
=20
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 0614c2b..d216ab7 100644
--- a/config.c
+++ b/config.c
@@ -382,6 +382,23 @@ int git_default_config(const char *var, const char=
 *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.help")) {
+		if (!strcmp(value, "auto"))
+			show_html_help =3D 2;
+		else if (!strcmp(value, "html"))
+			show_html_help =3D 1;
+		else if (!strcmp(value, "man"))
+			show_html_help =3D 0;
+		else
+			return 1;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.htmlprogram")) {
+		html_help_program =3D xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 9d3e5eb..e905972 100644
--- a/environment.c
+++ b/environment.c
@@ -32,6 +32,8 @@ size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color =3D 1;
 int auto_crlf =3D 0;	/* 1: both ways, -1: only when adding git objects=
 */
+int show_html_help =3D 0;
+const char *html_help_program =3D NULL;
=20
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graf=
t_file;
diff --git a/git.c b/git.c
index 29b55a1..c3c0fe8 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
=20
 const char git_usage_string[] =3D
-	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--b=
are] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--b=
are] [--git-dir=3DGIT_DIR] [--help [--html]] COMMAND [ARGS]";
=20
 static void prepend_to_path(const char *dir, int len)
 {
diff --git a/help.c b/help.c
index 6a9af4d..e3e705b 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,10 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
=20
+#ifndef HTML_DIR
+#define HTML_DIR "/usr/share/html/"
+#endif
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -183,6 +187,36 @@ static void show_man_page(const char *git_cmd)
 	execlp("man", "man", page, NULL);
 }
=20
+static void show_html_page(const char *git_cmd)
+{
+	const char *html_dir;
+	int i,len,ret;
+	char *p;
+
+	html_dir =3D HTML_DIR;
+	if (!html_help_program)
+		html_help_program =3D "xdg-open";
+
+	/* html_help_program space html_dir git- git_cmd .html */
+	len =3D strlen(html_help_program) + 1 + strlen(html_dir) + 4 + strlen=
(git_cmd) + 5;
+	p =3D xmalloc(len + 1);
+
+	strcpy(p, html_help_program);
+	strcat(p," ");
+	strcat(p,html_dir);
+	if (prefixcmp(git_cmd, "git"))
+		strcat(p,"git-");
+	strcat(p,git_cmd);
+	strcat(p,".html");
+
+	ret =3D system(p);
+
+	/* fallback to man pages */
+	if (show_html_help > 1 && (ret =3D=3D -1 || ret > 0))
+		show_man_page(git_cmd);
+	exit(0);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	printf("git: '%s' is not a git-command\n\n", cmd);
@@ -214,8 +248,23 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
 		exit(1);
 	}
=20
-	else
-		show_man_page(help_cmd);
+	else {
+		git_config(git_default_config);
+		if (!strcmp(help_cmd, "--html")) {
+			help_cmd =3D argc > 2 ? argv[2] : NULL;
+			if (!help_cmd) {
+				printf("usage: %s\n\n", git_usage_string);
+				list_common_cmds_help();
+				exit(1);
+			}
+			show_html_help =3D 1;
+		}
+
+		if (show_html_help)
+			show_html_page(help_cmd);
+		else
+			show_man_page(help_cmd);
+	}
=20
 	return 0;
 }
--=20
1.5.2
