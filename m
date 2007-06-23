From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] transplant: move a series of commits to a different parent
Date: Sat, 23 Jun 2007 21:27:57 +0200
Message-ID: <11826268772950-git-send-email-prohaska@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 21:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2BH6-0002Ng-Ry
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 21:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbXFWT17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 15:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbXFWT17
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 15:27:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:50765 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbXFWT16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 15:27:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5NJRv5k026151
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 21:27:57 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5NJRve4007320;
	Sat, 23 Jun 2007 21:27:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50746>

git-transplant.sh <onto> <from> <to>

transplant starts with the contents of <onto> and puts on top of
it the contents of files if they are touched by the series of
commits <from>..<to>.  If a commit touches a file the content of
this file is taken as it is in the commit. No merging is
performed. Original authors, commiters, and commit messages are
preserved.

Warning: this is just a quick hack to solve _my_ problem.
- No error checking is performed.
- Removal of files is not handled.
- Whitespace in filename is not handled.
- The index is left in dirty state.
- No branch is created for the result.
- The script is not integrated with git's shell utilities.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-transplant.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100755 git-transplant.sh

This script seems to solved the problem for me. I can place
the topic branch imported from cvs to the right place.

What do you think? Is this a sane way to handle the situation?

    Steffen

diff --git a/git-transplant.sh b/git-transplant.sh
new file mode 100755
index 0000000..3320071
--- /dev/null
+++ b/git-transplant.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+[[ $# == 3 ]] || { echo "$0 <onto> <from> <to>"; exit 1; }
+onto=$(git-rev-parse $1)
+from=$(git-rev-parse $2)
+to=$(git-rev-parse $3)
+
+# copied from git-filter-branch.sh 
+set_ident () {
+    lid="$(echo "$1" | tr "A-Z" "a-z")"
+    uid="$(echo "$1" | tr "a-z" "A-Z")"
+    pick_id_script='
+        /^'$lid' /{
+            s/'\''/'\''\\'\'\''/g
+            h
+            s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
+            s/'\''/'\''\'\'\''/g
+            s/.*/export GIT_'$uid'_NAME='\''&'\''/p
+
+            g
+            s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
+            s/'\''/'\''\'\'\''/g
+            s/.*/export GIT_'$uid'_EMAIL='\''&'\''/p
+
+            g
+            s/^'$lid' [^<]* <[^>]*> \(.*\)$/\1/
+            s/'\''/'\''\'\'\''/g
+            s/.*/export GIT_'$uid'_DATE='\''&'\''/p
+
+            q
+        }
+    '
+
+    LANG=C LC_ALL=C sed -ne "$pick_id_script"
+    # Ensure non-empty id name.
+    echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
+}
+
+parent=$onto
+git-read-tree --reset $parent
+
+for commit in $(git-rev-list --reverse $from..$to)
+do
+    echo "rewriting commit $commit..."
+    git-diff-tree -r $commit | grep ^: | cut -b 9-15,57-97,100- |
+    while read mode sha path 
+    do
+        echo " $mode $sha $path"
+        git-update-index --add --cacheinfo $mode $sha $path
+    done
+
+    eval "$(git-cat-file commit $commit |set_ident AUTHOR)"
+    eval "$(git-cat-file commit $commit |set_ident COMMITTER)"
+
+    parent=$(git-cat-file commit $commit |  sed -e '1,/^$/d' | git-commit-tree $(git-write-tree) -p $parent)
+    echo "... new commit $parent"
+done
+
+echo ""
+echo "new head is $parent"
-- 
1.5.2.2.315.gc649a
