From: Csaba Henk <csaba@gluster.com>
Subject: [PATCH v2] filter-branch: retire --remap-to-ancestor
Date: Fri, 27 Aug 2010 20:44:56 +0000 (UTC)
Message-ID: <i59848$vtg$2@dough.gmane.org>
References: <20100826092233.GA32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 22:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op5nZ-0000aD-NS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab0H0UpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:45:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:51010 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab0H0UpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:45:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Op5nN-0000UU-Jv
	for git@vger.kernel.org; Fri, 27 Aug 2010 22:45:05 +0200
Received: from gluelinux.org ([195.56.45.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 22:45:05 +0200
Received: from csaba by gluelinux.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 22:45:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: gluelinux.org
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154620>

We can be clever and know by ourselves when we need the behavior
implied by "--remap-to-ancestor". No need to encumber users by having
them exposed to it as a tunable. (Option kept for backward compatibility,
but it's now a no-op.)

Signed-off-by: Csaba Henk <csaba@gluster.com>
---
 Documentation/git-filter-branch.txt |   26 +++++++++++++-------------
 git-filter-branch.sh                |   10 +++++++++-
 t/t7003-filter-branch.sh            |   18 ++++++++++++++++++
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..7357c88 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -159,18 +159,7 @@ to other tags will be rewritten to point to the underlying commit.
 --subdirectory-filter <directory>::
 	Only look at the history which touches the given subdirectory.
 	The result will contain that directory (and only that) as its
-	project root.  Implies --remap-to-ancestor.
-
---remap-to-ancestor::
-	Rewrite refs to the nearest rewritten ancestor instead of
-	ignoring them.
-+
-Normally, positive refs on the command line are only changed if the
-commit they point to was rewritten.  However, you can limit the extent
-of this rewriting by using linkgit:rev-list[1] arguments, e.g., path
-limiters.  Refs pointing to such excluded commits would then normally
-be ignored.  With this option, they are instead rewritten to point at
-the nearest ancestor that was not excluded.
+	project root. Implies <<Remap_to_ancestor>>.
 
 --prune-empty::
 	Some kind of filters will generate empty commits, that left the tree
@@ -204,7 +193,18 @@ the nearest ancestor that was not excluded.
 	Arguments for 'git rev-list'.  All positive refs included by
 	these options are rewritten.  You may also specify options
 	such as '--all', but you must use '--' to separate them from
-	the 'git filter-branch' options.
+	the 'git filter-branch' options. Implies <<Remap_to_ancestor>>.
+
+
+[[Remap_to_ancestor]]
+Remap to ancestor
+~~~~~~~~~~~~~~~~~
+
+By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
+set of revisions which get rewritten. However, positive refs on the command
+line are distinguished: we don't let them be excluded by such limiters. For
+this purpose, they are instead rewritten to point at the nearest ancestor that
+was not excluded.
 
 
 Examples
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 88fb0f0..962a93b 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -139,6 +139,7 @@ do
 		continue
 		;;
 	--remap-to-ancestor)
+		# deprecated ($remap_to_ancestor is set now automatically)
 		shift
 		remap_to_ancestor=t
 		continue
@@ -265,7 +266,14 @@ mkdir ../map || die "Could not create map/ directory"
 
 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
-test -z "$nonrevs" && dashdash=-- || dashdash=
+if test -z "$nonrevs"
+then
+	dashdash=--
+else
+	dashdash=
+	remap_to_ancestor=t
+fi
+
 rev_args=$(git rev-parse --revs-only "$@")
 
 case "$filter_subdir" in
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2c55801..12aa63e 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -307,6 +307,24 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
+test_expect_success 'automatic remapping to ancestor with filename filters' '
+	git checkout master &&
+	git reset --hard A &&
+	test_commit add-foo2 foo 1 &&
+	git branch moved-foo2 &&
+	test_commit add-bar2 bar a &&
+	git branch invariant2 &&
+	orig_invariant=$(git rev-parse invariant2) &&
+	git branch moved-bar2 &&
+	test_commit change-foo2 foo 2 &&
+	git filter-branch -f \
+		moved-foo2 moved-bar2 A..master \
+		-- -- foo &&
+	test $(git rev-parse moved-foo2) = $(git rev-parse moved-bar2) &&
+	test $(git rev-parse moved-foo2) = $(git rev-parse master^) &&
+	test $orig_invariant = $(git rev-parse invariant2)
+'
+
 test_expect_success 'setup submodule' '
 	rm -fr ?* .git &&
 	git init &&
-- 
1.7.2.2
