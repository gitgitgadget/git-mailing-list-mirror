From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add git-clean command
Date: Mon, 03 Apr 2006 18:18:41 -0400
Message-ID: <20060403221841.25097.18242.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Apr 04 00:18:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXNo-0002fH-Mj
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWDCWSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWDCWSo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:18:44 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:35235 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751572AbWDCWSn
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:18:43 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FQXNi-0002ZJ-RP
	for git@vger.kernel.org; Mon, 03 Apr 2006 18:18:42 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FQXNi-0006Wu-44
	for git@vger.kernel.org; Mon, 03 Apr 2006 18:18:42 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.8-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18353>

This command removes untracked files from the working tree.  This
implementation is based on cg-clean with some simplifications.  The
documentation is included.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .gitignore                  |    1 +
 Documentation/git-clean.txt |   50 +++++++++++++++++++++++++++++++
 Makefile                    |    2 +
 git-clean.sh                |   70 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletions(-)

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
index 0000000..0c671e1
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
+-D::
+	Same as above, but use chmod first.  This is useful for
+	read-only directories used in some testsuites.
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
index c79d646..221e59a 100644
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
index 0000000..8470559
--- /dev/null
+++ b/git-clean.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2005-2006 Pavel Roskin
+#
+
+USAGE="[-d | -D] [-n] [-q] [-x]"
+LONG_USAGE='Clean untracked files from the working directory
+	-d	remove directories as well
+	-D	remove directories, try harder (chmod first)
+	-n 	don'\''t remove anything, just show what would be done
+	-q	be quiet, only report errors
+	-x	remove ignored files as well'
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+
+noexclude=
+cleandir=
+cleandirhard=
+quiet=
+rmf="rm -f"
+rmrf="rm -rf"
+rm_refuse="echo Not removing"
+echo1="echo"
+
+for arg in "$@"; do
+	if [ "$arg" = "-d" ]; then
+		cleandir=1
+	elif [ "$arg" = "-D" ]; then
+		cleandir=1
+		cleandirhard=1
+	elif [ "$arg" = "-n" ]; then
+		quiet=1
+		rmf="echo Would remove"
+		rmrf="echo Would remove"
+		rm_refuse="echo Would not remove"
+		echo1=":"
+	elif [ "$arg" = "-q" ]; then
+		quiet=1
+	elif [ "$arg" = "-x" ]; then
+		noexclude=1
+	else
+		echo >&2 "Unknown option: \"$arg\""
+		exit 1
+	fi
+done
+
+excl1=
+excl2=
+if [ -z "$noexclude" ]; then
+	excl1="--exclude-per-directory=.gitignore"
+	if [ -f "$GIT_DIR/info/exclude" ]; then
+		excl2="--exclude-from=$GIT_DIR/info/exclude"
+	fi
+fi
+
+git-ls-files --others --directory "$excl1" "$excl2" |
+while read -r file; do
+	if [ -d "$file" -a ! -L "$file" ]; then
+		if [ -z "$cleandir" ]; then
+			$rm_refuse "$file"
+			continue
+		fi
+		$echo1 "Removing $file"
+		[ "$cleandirhard" ] && chmod -R 700 "$file"
+		$rmrf "$file"
+	else
+		$echo1 "Removing $file"
+		$rmf "$file"
+	fi
+done
