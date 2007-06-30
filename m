From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] contrib/hooks: add post-update hook for updating working copy
Date: Sat, 30 Jun 2007 20:56:20 +1200
Message-ID: <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlN-0006AV-6c
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbXF3I4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbXF3I4k
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:40 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56650 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008UT-Va; Sat, 30 Jun 2007 20:56:23 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id EA7BE5CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51209>

Many users want 'git push' to work like 'git pull'; that is, after the
transfer of the new objects, the working copy is updated, too.  This
hook tries to be paranoid and never lose any information, as well as
being able to be safely just chmod +x'ed without destroying anything
it shouldn't.

Also allude to this potential feature on the man page for git-push.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-push.txt   |    4 ++-
 templates/hooks--post-update |   78 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 665f6dc..9f5fbc7 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -20,7 +20,9 @@ necessary to complete the given refs.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
-documentation for gitlink:git-receive-pack[1].
+documentation for gitlink:git-receive-pack[1].  One commonly
+requested feature, updating the working copy of the target
+repository, must be enabled in this way.
 
 
 OPTIONS
diff --git a/templates/hooks--post-update b/templates/hooks--post-update
index bcba893..b5d490c 100644
--- a/templates/hooks--post-update
+++ b/templates/hooks--post-update
@@ -1,8 +1,78 @@
 #!/bin/sh
 #
-# An example hook script to prepare a packed repository for use over
-# dumb transports.
+# This hook does two things:
 #
-# To enable this hook, make this file executable by "chmod +x post-update".
+#  1. update the "info" files that allow the list of references to be
+#     queries over dumb transports such as http
+#
+#  2. if this repository looks like it is a non-bare repository, and
+#     the checked-out branch is pushed to, then update the working copy.
+#     This makes "push" and "pull" symmetric operations, as in darcs and
+#     bzr.
+
+git-update-server-info
+
+export GIT_DIR=`cd $GIT_DIR; pwd`
+[ `expr "$GIT_DIR" : '.*/\.git'` = 0 ] && exit 0
+
+tree_in_revlog() {
+    ref=$1
+    tree=$2
+    found=$(
+    tail logs/$ref | while read commit rubbish
+    do
+        this_tree=`git-rev-parse commit $commit^{tree}`
+	if [ "$this_tree" = "$tree" ]
+        then
+	    echo $commit
+        fi
+    done
+    )
+    [ -n "$found" ] && true
+}
+
+for ref
+do
+active=`git-symbolic-ref HEAD`
+if [ "$ref" = "$active" ]
+then
+  echo "Pushing to checked out branch - updating working copy" >&2
+  success=
+  if ! (cd ..; git-diff-files) | grep -q .
+  then
+    # save the current index just in case
+    current_tree=`git-write-tree`
+    if tree_in_revlog $ref $current_tree
+    then
+      cd ..
+      if git-diff-index -R --name-status HEAD >&2 &&
+         git-diff-index -z --name-only --diff-filter=A HEAD | xargs -0r rm &&
+         git-reset --hard HEAD
+      then
+         success=1
+      else
+        echo "E:unexpected error during update" >&2
+      fi
+    else
+      echo "E:uncommitted, staged changes found" >&2
+    fi
+  else
+    echo "E:unstaged changes found" >&2
+  fi
 
-exec git-update-server-info
+  if [ -z "$success" ]
+  then
+    (
+    echo "Non-bare repository checkout is not clean - not updating it"
+    echo "However I AM going to update the index.  Any half-staged commit"
+    echo "in that checkout will be thrown away, but on the bright side"
+    echo "this is probably the least confusing thing for us to do and at"
+    echo "least we're not throwing any files somebody has changed away"
+    git-reset --mixed HEAD
+    echo
+    echo "This is the new status of the upstream working copy:"
+    git-status
+    ) >&2
+  fi
+fi
+done
-- 
1.5.2.1.1131.g3b90
