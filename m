From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add script for patch submission via e-mail.
Date: Fri, 10 Jun 2005 18:32:30 -0700
Message-ID: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:28:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgunO-0003s9-Kp
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFKBcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFKBcm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:32:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9892 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261158AbVFKBcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:32:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611013232.IUAY7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:32:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This git-format-patch-script is what I use to prepare patches
for e-mail submission.

Typical usage is:

$ git-format-patch-script -B -C --find-copies-harder HEAD linus

to prepare each commit with its patch since "HEAD" forked from
"linus", one file per patch for e-mail submission.  Each output
file is numbered sequentially from 1, and uses the first line of
the commit message (massaged for pathname safety) as the
filename.

$ git-format-patch-script -B -C --find-copies-harder HEAD linus .patch/

creates output files in .patch/ directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** Linus I am submitting this one because some patches on
*** read-tree I am going to send you will need this for
*** formatting into a form that is easier to review.  And this
*** in turn can use diff-tree --find-copies-harder, which I
*** indeed used to generate the patches that follow.

 Makefile                |    3 +-
 git-format-patch-script |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,8 @@ INSTALL=install
 SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
-	git-log-script git-shortlog git-cvsimport-script
+	git-log-script git-shortlog git-cvsimport-script \
+	git-format-patch-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-format-patch-script b/git-format-patch-script
new file mode 100755
--- /dev/null
+++ b/git-format-patch-script
@@ -0,0 +1,93 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Typical usage is:
+#
+# $ git-format-patch-script -B -C --find-copies-harder HEAD linus
+#
+# to prepare each commit with its patch since "HEAD" forked from
+# "linus", one file per patch for e-mail submission.  Each output file is
+# numbered sequentially from 1, and uses the first line of the commit
+# message (massaged for pathname safety) as the filename.
+#
+# $ git-format-patch-script -B -C --find-copies-harder HEAD linus .patch/
+#
+# creates output files in .patch/ directory.
+
+diff_opts=
+IFS='
+'
+LF='
+'
+while case "$#" in 0) break;; esac
+do
+    case "$1" in
+    -*)	diff_opts="$diff_opts$LF$1" ;;
+    *) break ;;
+    esac
+    shift
+done
+
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
+git-rev-list "$junio" "^$linus" >$series
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
+	git-diff-tree -p $diff_opts $O "$commit" | git-apply --stat
+	echo
+	git-diff-tree -p $diff_opts $O "$commit" | sed -e "$stripCommitHead"
+	echo '------------'
+    } >"$outdir$file"
+done <$series
+
------------

