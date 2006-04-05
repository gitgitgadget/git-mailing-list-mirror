From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add git-clean command
Date: Wed, 05 Apr 2006 02:00:48 -0400
Message-ID: <20060405060048.6694.65940.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Apr 05 08:00:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR14X-0006dW-I5
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWDEGAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWDEGAw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:00:52 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62622 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751106AbWDEGAv
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:00:51 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FR14U-00066a-9p
	for git@vger.kernel.org; Wed, 05 Apr 2006 02:00:50 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FR14S-0001k5-Mf
	for git@vger.kernel.org; Wed, 05 Apr 2006 02:00:48 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.8-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18413>

This command removes untracked files from the working tree.  This
implementation is based on cg-clean with some simplifications.  The
documentation is included.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .gitignore                  |    1 +
 Documentation/git-clean.txt |   50 +++++++++++++++++++++++++++
 Makefile                    |    2 +
 git-clean.sh                |   80 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 75891c3..b5959d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@ git-checkout
 git-checkout-index
 git-cherry
 git-cherry-pick
+git-clean
 git-clone
 git-clone-pack
 git-commit
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
new file mode 100644
index 0000000..e91b2ed
--- /dev/null
+++ b/Documentation/git-clean.txt
@@ -0,0 +1,50 @@
+git-clean(1)
+============
+
+NAME
+----
+git-clean - Remove untracked files from the working tree
+
+SYNOPSIS
+--------
+[verse]
+'git-clean' [-d | -D] [-n] [-q] [-x]
+
+DESCRIPTION
+-----------
+Removes files unknown to git.  This allows to clean the working tree
+from files that are not under version control.  If the '-x' option is
+specified, ignored files are also removed, allowing to remove all
+build products.
+
+OPTIONS
+-------
+-d::
+	Remove untracked directories in addition to untracked files.
+
+-n::
+	Don't actually remove anything, just show what would be done.
+
+-q::
+	Be quiet, only report errors, but not the files that are
+	successfully removed.
+
+-x::
+	Don't use the ignore rules.  This allows removing all untracked
+	files, including build products.  This can be used (possibly in
+	conjunction with gitlink:git-reset[1]) to create a pristine
+	working directory to test a clean build.
+
+-X::
+	Remove only files ignored by git.  This may be useful to rebuild
+	everything from scratch, but keep manually created files.
+
+
+Author
+------
+Written by Pavel Roskin <proski@gnu.org>
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 145099a..3367b8c 100644
--- a/Makefile
+++ b/Makefile
@@ -114,7 +114,7 @@ ### --- END CONFIGURATION SECTION ---
 
 SCRIPT_SH = \
 	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
-	git-cherry.sh git-clone.sh git-commit.sh \
+	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-count-objects.sh git-diff.sh git-fetch.sh \
 	git-format-patch.sh git-log.sh git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
diff --git a/git-clean.sh b/git-clean.sh
new file mode 100755
index 0000000..b200868
--- /dev/null
+++ b/git-clean.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2005-2006 Pavel Roskin
+#
+
+USAGE="[-d] [-n] [-q] [-x | -X]"
+LONG_USAGE='Clean untracked files from the working directory
+	-d	remove directories as well
+	-n 	don'\''t remove anything, just show what would be done
+	-q	be quiet, only report errors
+	-x	remove ignored files as well
+	-X	remove only ignored files as well'
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+
+ignored=
+ignoredonly=
+cleandir=
+quiet=
+rmf="rm -f"
+rmrf="rm -rf"
+rm_refuse="echo Not removing"
+echo1="echo"
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-d)
+		cleandir=1
+		;;
+	-n)
+		quiet=1
+		rmf="echo Would remove"
+		rmrf="echo Would remove"
+		rm_refuse="echo Would not remove"
+		echo1=":"
+		;;
+	-q)
+		quiet=1
+		;;
+	-x)
+		ignored=1
+		;;
+	-X)
+		ignoredonly=1
+		;;
+	*)
+		usage
+	esac
+	shift
+done
+
+case "$ignored,$ignoredonly" in
+	1,1) usage;;
+esac
+
+if [ -z "$ignored" ]; then
+	excl="--exclude-per-directory=.gitignore"
+	if [ -f "$GIT_DIR/info/exclude" ]; then
+		excl_info="--exclude-from=$GIT_DIR/info/exclude"
+	fi
+	if [ "$ignoredonly" ]; then
+		excl="$excl --ignored"
+	fi
+fi
+
+git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} |
+while read -r file; do
+	if [ -d "$file" -a ! -L "$file" ]; then
+		if [ -z "$cleandir" ]; then
+			$rm_refuse "$file"
+			continue
+		fi
+		$echo1 "Removing $file"
+		$rmrf "$file"
+	else
+		$echo1 "Removing $file"
+		$rmf "$file"
+	fi
+done
