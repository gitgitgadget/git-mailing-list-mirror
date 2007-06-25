From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/7] stg-cvs: update doc,
	and use correct setting for parent branch.
Date: Mon, 25 Jun 2007 23:24:31 +0200
Message-ID: <20070625212431.17189.38788.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3E-0004lQ-Jl
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXFYVYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXFYVYn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:24:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51160 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbXFYVYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:24:42 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5547C5A19A;
	Mon, 25 Jun 2007 23:24:41 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 498671F150;
	Mon, 25 Jun 2007 23:24:31 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50923>

This script had not been updated when we moved away from my wrong
interpretation of branch.*.merge.

At the same time, this includes some doc to set up a branch for use
with this command, and propotes design flaws to such, instead of
leaving them hidden among mere limitation of the implementation.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-cvs |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/contrib/stg-cvs b/contrib/stg-cvs
index 7b968d6..582f4f2 100755
--- a/contrib/stg-cvs
+++ b/contrib/stg-cvs
@@ -14,15 +14,35 @@ set -e
 # - you want to add a "CVS" line to .git/info/exclude
 # - you may want to add a ".git" line to the top .cvsignore
 
+# BRANCH INIT
+# - ensure the cvs wc is clean (eg. with "cvsco")
+# $ git init
+# $ echo CVS >> .git/info/exclude
+# $ git add .
+# $ git commit -m "Initial import."
+# $ git branch -m master cvs
+# $ stg branch -c master cvs
+# $ git config branch.master.stgit.parentbranch cvs (0.12.1 and earlier only)
+# $ git config branch.cvs.description "CVS $(cat CVS/Root) $(cat CVS/Repository) $(cat CVS/Tag 2>/dev/null | echo HEAD)"
+# $ git config branch.master.description "Changes for $(cat CVS/Repository) $(cat CVS/Tag 2>/dev/null | echo HEAD)"
+
 # LIMITATIONS
 # - this is only a proof-of-concept prototype
-# - lacks an "init" command
+# - lacks an "init" command (see above)
 # - "commit" does not ensure the base is uptodate before trying to
-#   commit (but hey, it's CVS ;)
+#   commit (but hey, it's CVS ;): better "stg-cvs pull" first
 # - "commit" can only commit a single patch
 # - not much robustness here
-# - still bad support for files removed in cvs (should catch "no
+# - still no support for files removed in cvs (should catch "no
 #   longer in the repository" message)
+# - this only deals with CVS but could surely be extended to any other
+#   VCS
+# - lacks synchronisation of .cvsignore <-> .gitignore
+# - no support for filenames with spaces (stg lacks --zero output format)
+# - git-commit is too chatty when it finds nothing to commit
+# - lacks a "quick cvs commit" feature
+
+# DESIGN FLAWS
 # - while fetching, if a file change was not git-update-index'd when
 #   cvs-update'd (eg. because of a stg-cvs bug), it is not seen on further
 #   fetches until it changes again, since we scan "cvs update" output.
@@ -32,17 +52,11 @@ set -e
 #   already-existing in working copy, or to directory moves inside the
 #   cvs repository, or <fill here>) has to be dealt with by hand (although
 #   the situation is better here: cvs sees the conflict on subsequent tries)
-# - this only deals with CVS but could surely be extended to any other
-#   VCS
 # - bad/no support for cvsutils:
 #   - stg push/pop operations confuse cvsu because of timestamp changes
 #   - cvspurge/cvsco would nuke .git => does not make it easy to ensure
 #     synchronisation
 # - should use a separate workspace for cvs branch like tailor does
-# - lacks synchronisation of .cvsignore <-> .gitignore
-# - no support for filenames with spaces (stg lacks --zero output format)
-# - git-commit is too chatty when it finds nothing to commit
-# - lacks a "quick cvs commit" feature
 # - confused by cvs keyword substitution
 
 usage()
@@ -102,8 +116,8 @@ cvs_add_dir()
 
 # get context
 branch=$(stg branch)
-parent=$(git-repo-config "branch.${branch}.merge") || 
-    usage "no declared parent for '$branch' - set branch.${branch}.merge"
+parent=$(git-config "branch.${branch}.stgit.parentbranch") || 
+    usage "no declared parent for '$branch' - set branch.${branch}.stgit.parentbranch"
 
 # extract command
 
