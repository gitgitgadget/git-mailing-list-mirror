From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] git-help: add -w|--web option to display html man page
 in a browser.
Date: Sun, 2 Dec 2007 06:07:55 +0100
Message-ID: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iygxf-0003DW-Aq
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbXLBFBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXLBFBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:01:25 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35086 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbXLBFBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:01:24 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0E2531AB2B5;
	Sun,  2 Dec 2007 06:01:23 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 9885E1AB2AD;
	Sun,  2 Dec 2007 06:01:22 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66756>

Now when using "git help -w XXX", we will try to show the HTML man
page "git-XXX.html" in your prefered web browser.

To do that "help.c" code will call a new shell script
"git-browse-help".

This currently works only if the HTML versions of the man page
have been installed in "PREFIX/share/doc/git-doc", so new target
to do that is added to "Documentation/Makefile".

The browser to use can be configured using the "web.browser"
config variable.

We try to open a new tab in an existing web browser, if possible.

The code in "git-browse-help" is heavily stolen from "git-mergetool"
by Theodore Y. Ts'o. Thanks.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile |    4 +
 Makefile               |    4 +-
 git-browse-help.sh     |  154 ++++++++++++++++++++++++++++++++++++++++++++++++
 help.c                 |   15 ++++-
 4 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100755 git-browse-help.sh

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
index a5a40ce..9204bfe 100644
--- a/Makefile
+++ b/Makefile
@@ -223,7 +223,8 @@ SCRIPT_SH = \
 	git-merge-resolve.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
-	git-stash.sh
+	git-stash.sh \
+	git-browse-help.sh
 
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
diff --git a/git-browse-help.sh b/git-browse-help.sh
new file mode 100755
index 0000000..11f8bfa
--- /dev/null
+++ b/git-browse-help.sh
@@ -0,0 +1,154 @@
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
+USAGE='[--browser=browser|--tool=browser] [cmd to display] ...'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+
+PREFIX="@@PREFIX@@"
+GIT_VERSION="@@GIT_VERSION@@"
+
+# Directories that may contain html documentation:
+install_html_dir="$PREFIX/share/doc/git-doc"
+rpm_dir="$PREFIX/share/doc/git-core-$GIT_VERSION"
+
+# Look for the directory that really contains html documentation.
+html_dir=''
+for dir in "$install_html_dir" "$rpm_dir"
+do
+	test -d "$dir" && { html_dir="$dir" ; break ; }
+done
+test -n "$html_dir" || die "No documentation directory found."
+
+valid_tool() {
+	case "$1" in
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo)
+			;; # happy
+		*)
+			return 1
+			;;
+	esac
+}
+
+init_browser_path() {
+	browser_path=`git config browser.$1.path`
+	test -z "$browser_path" && browser_path=$1
+}
+
+while test $# != 0
+do
+    case "$1" in
+	-b|--browser*|-t|--tool*)
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
+    browser=`git config web.browser`
+    if test -n "$browser" && ! valid_tool "$browser"; then
+	    echo >&2 "git config option web.browser set to unknown browser: $browser"
+	    echo >&2 "Resetting to default..."
+	    unset browser
+    fi
+fi
+
+if test -z "$browser" ; then
+    if test -n "$DISPLAY"; then
+        browser_candidates="firefox iceweasel konqueror w3m links lynx dillo"
+        if test "$KDE_FULL_SESSION" = "true"; then
+            browser_candidates="konqueror $browser_candidates"
+        fi
+    else
+        browser_candidates="w3m links lynx"
+    fi
+    echo "browser candidates: $browser_candidates"
+    for i in $browser_candidates; do
+        init_browser_path $i
+        if type "$browser_path" > /dev/null 2>&1; then
+            browser=$i
+            break
+        fi
+    done
+    test -z "$browser" && die "No known browser available."
+else
+    valid_tool "$browser" || die "Unknown browser '$browser'."
+
+    init_browser_path "$browser"
+
+    if ! type "$browser_path" > /dev/null 2>&1; then
+        die "The browser $browser is not available as '$browser_path'."
+    fi
+fi
+
+pages=$(for p in "$@"; do echo "$html_dir/$p.html" ; done)
+test -z "$pages" && pages="$html_dir/git.html"
+
+case "$browser" in
+    firefox|iceweasel)
+        # Check version because firefox < 2.0 does not support "-new-tab".
+	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
+	NEWTAB='-new-tab'
+	test "$vers" -lt 2 && NEWTAB=''
+        nohup "$browser_path" $NEWTAB $pages &
+	;;
+    konqueror)
+	case "$(basename "$browser_path")" in
+	    konqueror)
+		# It's simpler to use kfmclient to open a new tab in konqueror.
+		browser_path="$(echo "$browser_path" | sed -e 's/konqueror$/kfmclient/')"
+		type "$browser_path" > /dev/null 2>&1 || die "No '$browser_path' found."
+		eval "$browser_path" newTab $pages
+		;;
+	    kfmclient)
+		eval "$browser_path" newTab $pages
+		;;
+	    *)
+	        nohup "$browser_path" $pages &
+		;;
+	esac
+        ;;
+    w3m|links|lynx)
+        eval "$browser_path" $pages
+        ;;
+    dillo)
+        nohup "$browser_path" $pages &
+        ;;
+esac
+
+
diff --git a/help.c b/help.c
index 0f1cb71..ecc8c66 100644
--- a/help.c
+++ b/help.c
@@ -265,6 +265,12 @@ static void show_info_page(const char *git_cmd)
 	execlp("info", "info", page, NULL);
 }
 
+static void show_html_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	execlp("git-browse-help", "git-browse-help", page, NULL);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
@@ -297,7 +303,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	const char *help_cmd = argc > 1 ? argv[1] : NULL;
 	check_help_cmd(help_cmd);
 
-	if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
+	if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
+		help_cmd = argc > 2 ? argv[2] : NULL;
+		check_help_cmd(help_cmd);
+
+		show_html_page(help_cmd);
+	}
+
+	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
 		help_cmd = argc > 2 ? argv[2] : NULL;
 		check_help_cmd(help_cmd);
 
-- 
1.5.3.6.1993.g154f-dirty
