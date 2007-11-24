From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] git-help: add new options -w (for web) and -i (for
 info)
Date: Sat, 24 Nov 2007 05:16:50 +0100
Message-ID: <20071124051650.07fd275f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Nov 24 05:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvmLl-0005Gd-FV
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 05:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXKXEKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 23:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXKXEKS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 23:10:18 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58651 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbXKXEKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 23:10:16 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E27DF1AB2AE;
	Sat, 24 Nov 2007 05:10:12 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 856811AB2B2;
	Sat, 24 Nov 2007 05:10:12 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65935>

With option -i or --info "git help" will call "info git-XXX".

With option -w or --web "git help" will call a new shell script
"git-html-help" that will try to show the HTML version of the
man page in your prefered web browser.

This currently works only if the HTML versions of the man page
have been installed in "PREFIX/share/doc/git-doc", so new target
to do that is added to "Documentation/Makefile".

The code in "git-html-help" is heavily stolen from "git-mergetool".
Thanks.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile |    4 ++
 Makefile               |    4 +-
 git-html-help.sh       |  125 ++++++++++++++++++++++++++++++++++++++++++++++++
 help.c                 |   48 +++++++++++++++---
 4 files changed, 172 insertions(+), 9 deletions(-)
 create mode 100755 git-html-help.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d886641..3e01718 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -29,6 +29,7 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
+htmldir?=$(prefix)/share/doc/git-doc
 mandir?=$(prefix)/share/man
 man1dir=$(mandir)/man1
 man5dir=$(mandir)/man5
@@ -95,6 +96,9 @@ install-info: info
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi
 
+install-html: html
+	sh ./install-webdoc.sh $(htmldir)
+
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
 
diff --git a/Makefile b/Makefile
index 313f9a2..6ccf7e7 100644
--- a/Makefile
+++ b/Makefile
@@ -223,7 +223,8 @@ SCRIPT_SH = \
 	git-merge-resolve.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
-	git-stash.sh
+	git-stash.sh \
+	git-html-help.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
@@ -807,6 +808,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's|@@PREFIX@@|$(prefix_SQ)|g' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-html-help.sh b/git-html-help.sh
new file mode 100755
index 0000000..286d3b5
--- /dev/null
+++ b/git-html-help.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+#
+# This program launch a web browser on the html page
+# describing a git command.
+#
+# Copyright (c) 2007 Christian Couder
+# Copyright (c) 2006 Theodore Y. Ts'o
+#
+# This file is heavily stolen from git-mergetool.sh, by
+# Theodore Y. Ts'o (thanks) that is:
+#
+# Copyright (c) 2006 Theodore Y. Ts'o
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Junio C Hamano or any other official
+# git maintainer.
+#
+
+USAGE='[--tool=tool] [cmd to display] ...'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+
+valid_tool() {
+	case "$1" in
+		firefox | iceweasel | konqueror | w3m)
+			;; # happy
+		*)
+			return 1
+			;;
+	esac
+}
+
+init_browser_path() {
+	browser_path=`git config webtool.$1.path`
+	test -z "$browser_path" && browser_path=$1
+}
+
+while test $# != 0
+do
+    case "$1" in
+	-t|--tool*)
+	    case "$#,$1" in
+		*,*=*)
+		    browser=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    ;;
+		1,*)
+		    usage ;;
+		*)
+		    browser="$2"
+		    shift ;;
+	    esac
+	    ;;
+	--)
+	    break
+	    ;;
+	-*)
+	    usage
+	    ;;
+	*)
+	    break
+	    ;;
+    esac
+    shift
+done
+
+if test -z "$browser"; then
+    browser=`git config web.tool`
+    if test -n "$browser" && ! valid_tool "$browser"; then
+	    echo >&2 "git config option web.tool set to unknown tool: $browser"
+	    echo >&2 "Resetting to default..."
+	    unset browser
+    fi
+fi
+
+if test -z "$browser" ; then
+    if test -n "$DISPLAY"; then
+        browser_candidates="firefox iceweasel konqueror w3m"
+        if test "$KDE_FULL_SESSION" = "true"; then
+            browser_candidates="konqueror $browser_candidates"
+        fi
+    else
+        browser_candidates="w3m"
+    fi
+    echo "browser candidates: $browser_candidates"
+    for i in $browser_candidates; do
+        init_browser_path $i
+	echo "browser path: $browser_path"
+        if type "$browser_path" > /dev/null 2>&1; then
+            browser=$i
+            break
+        fi
+    done
+    test -z "$browser" && die "No known browser available."
+else
+    valid_tool "$browser" || die "Unknown browser $browser"
+
+    init_browser_path "$browser"
+
+    if ! type "$browser_path" > /dev/null 2>&1; then
+        die "The browser $browser is not available as '$browser_path'"
+    fi
+fi
+
+html_dir="@@PREFIX@@/share/doc/git-doc"
+pages=$(for p in "$@"; do echo "$html_dir/$p.html" ; done)
+test -z "$pages" && pages="$html_dir/git.html"
+
+case "$browser" in
+    firefox|iceweasel)
+        # TODO check version (firefox < 2.0 does not support -new-tab)
+        nohup "$browser" -new-tab $pages &
+	;;
+    konqueror)
+        # FIXME: we may want to find an existing konqueror and use
+        # dcop to tell it what to do.
+        nohup "$browser" $pages &
+        ;;
+    w3m)
+        eval "$browser" $pages
+        ;;
+esac
+
+
+
diff --git a/help.c b/help.c
index 37a9c25..a5602a2 100644
--- a/help.c
+++ b/help.c
@@ -239,24 +239,38 @@ void list_common_cmds_help(void)
 	}
 }
 
-static void show_man_page(const char *git_cmd)
+static const char *cmd_to_page(const char *git_cmd)
 {
-	const char *page;
-
 	if (!prefixcmp(git_cmd, "git"))
-		page = git_cmd;
+		return git_cmd;
 	else {
 		int page_len = strlen(git_cmd) + 4;
 		char *p = xmalloc(page_len + 1);
 		strcpy(p, "git-");
 		strcpy(p + 4, git_cmd);
 		p[page_len] = 0;
-		page = p;
+		return p;
 	}
+}
 
+static void show_man_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
 	execlp("man", "man", page, NULL);
 }
 
+static void show_info_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	execlp("info", "info", page, NULL);
+}
+
+static void show_html_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	execlp("git-html-help", "git-html-help", page, NULL);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
@@ -269,10 +283,8 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-int cmd_help(int argc, const char **argv, const char *prefix)
+static void check_help_cmd(const char *help_cmd)
 {
-	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
@@ -284,6 +296,26 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands();
 		exit(0);
 	}
+}
+
+int cmd_help(int argc, const char **argv, const char *prefix)
+{
+	const char *help_cmd = argc > 1 ? argv[1] : NULL;
+	check_help_cmd(help_cmd);
+
+	if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
+		help_cmd = argc > 2 ? argv[2] : NULL;
+		check_help_cmd(help_cmd);
+
+		show_html_page(help_cmd);
+	}
+
+	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
+		help_cmd = argc > 2 ? argv[2] : NULL;
+		check_help_cmd(help_cmd);
+
+		show_info_page(help_cmd);
+	}
 
 	else
 		show_man_page(help_cmd);
-- 
1.5.3.5.1730.g6d12d-dirty
