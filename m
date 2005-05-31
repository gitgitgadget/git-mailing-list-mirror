From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-format-patch-script.
Date: Tue, 31 May 2005 14:50:26 -0700
Message-ID: <7vpsv7vzdp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 23:54:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdEg0-00011z-IS
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVEaVyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEaVxk
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 17:53:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14011 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261604AbVEaVub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 17:50:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531215026.GHHZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 17:50:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The script takes two HEADs and optionally one directory name,
and prepares a patch file for each commit between the named
HEADS in a separate file in the named directory.  The directory
defaults to the $cwd.

This is in the same spirit as the recent additions of helper
scripts to make core GIT plumbing more comfortable to use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile                |    3 +-
 git-format-patch-script |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,8 @@ INSTALL=install
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
-	git-deltafy-script git-fetch-script git-status-script git-commit-script
+	git-deltafy-script git-fetch-script git-status-script \
+	git-commit-script git-format-patch-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-format-patch-script b/git-format-patch-script
new file mode 100755
--- /dev/null
+++ b/git-format-patch-script
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+junio="$1"
+linus="$2"
+outdir="${3:-./}"
+
+tmp=.tmp-series$$
+trap 'rm -f $tmp-*' 0 1 2 3 15
+
+series=$tmp-series
+
+titleScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	s/[^-a-z.A-Z_0-9]/-/g
+	s/^--*//g
+	s/--*$//g
+	s/---*/-/g
+	s/$/.txt/
+        s/\.\.\.*/\./g
+	q
+'
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'
+
+O=
+if test -f .git/patch-order
+then
+    O=-O.git/patch-order
+fi
+git-rev-list "$junio" "$linus" >$series
+total=`wc -l <$series`
+i=$total
+while read commit
+do
+    title=`git-cat-file commit "$commit" | sed -e "$titleScript"`
+    num=`printf "%d/%d" $i $total`
+    file=`printf '%04d-%s' $i "$title"`
+    i=`expr "$i" - 1`
+    echo "$file"
+    {
+	mailScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	s|^|[PATCH '"$num"'] |
+	: body
+	p
+	n
+	b body'
+
+	git-cat-file commit "$commit" | sed -ne "$mailScript"
+	echo '---'
+	echo
+	git-diff-tree -p $O "$commit" | git-apply --stat
+	echo
+	git-diff-tree -p $O "$commit" | sed -e "$stripCommitHead"
+	echo '------------'
+    } >"$outdir$file"
+done <$series
+
------------

