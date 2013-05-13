From: Tobias Schulte <tobias.schulte@gliderpilot.de>
Subject: [PATCH] git-svn: introduce --parents parameter for commands branch and tag
Date: Mon, 13 May 2013 22:22:29 +0200
Message-ID: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
Cc: Eric Wong <normalperson@yhbt.net>,
	Tobias Schulte <tobias.schulte@gliderpilot.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 13 22:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbzGb-0002zf-Su
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 22:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab3EMUWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 16:22:37 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57746 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab3EMUWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 16:22:36 -0400
Received: from tobias-desktop.localdomain (pD9FB63A9.dip0.t-ipconnect.de [217.251.99.169])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Mf6s9-1Ur3B33ZvN-00OXjx; Mon, 13 May 2013 22:22:33 +0200
X-Mailer: git-send-email 1.7.9.5
X-Provags-ID: V02:K0:1MU35cjDdCNBWpCqfZcTw1pxRgy7rRJ9ibUAG1FcspP
 qWFMBCAoG1UPX79QIc6oJjiJG9SgWkSfe/TbiZ6U4epbWylNr/
 yRSh+tWkJqV+XkxCTnsqGuBGzlnPe03iFSkiwBM/X+wo/Mg6ff
 EvSYzwxb/RH32WvMU4sKS4tenxR4LPuGxYETsdkiKcNNSuoAU7
 wTpGOoUOEQItq8RTphAnJDXnwjJgeNmFFfvC1+TYeqnHa09RTu
 gs3Q8/U5XfM7cyzZhe7OMtjnHtaLGdEPu5aVgnGKnAw9YlWmoj
 pypwLMeS7+gPgL8X2dYUYUymM5hgD/SIR7kHu1vHNC5Gs7Dv/b
 St5xoZtZRoDKSWY3Ygteqo/H0LqES7xrhv7YUi34LN0tlyWVcg
 3/o0ZFxwqx0AAHYkYl5/zO74bPiDB4a/gbb8cf2lAdFp1/lsYS
 uZFIX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224199>

This parameter is equivalent to the parameter --parents on svn cp commands
and is useful for non-standard repository layouts.

Signed-off-by: Tobias Schulte <tobias.schulte@gliderpilot.de>
---
 Documentation/git-svn.txt                |    5 ++++
 git-svn.perl                             |   22 +++++++++++++-
 t/t9167-git-svn-cmd-branch-subproject.sh |   46 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100755 t/t9167-git-svn-cmd-branch-subproject.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 58b6d54..4f2141d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -298,6 +298,11 @@ where <name> is the name of the SVN repository as specified by the -R option to
 	git config --get-all svn-remote.<name>.commiturl
 +
 
+--parents;;
+	Create parent folders. This parameter is equivalent to the parameter 
+	--parents on svn cp commands and is useful for non-standard repository 
+	layouts.
+
 'tag'::
 	Create a tag in the SVN repository. This is a shorthand for
 	'branch -t'.
diff --git a/git-svn.perl b/git-svn.perl
index ccabe06..204313d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -113,7 +113,7 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_before, $_after,
-	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
+	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_parents, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_commit_url, $_tag, $_merge_info, $_interactive);
 
@@ -203,6 +203,7 @@ my %cmd = (
 	            { 'message|m=s' => \$_message,
 	              'destination|d=s' => \$_branch_dest,
 	              'dry-run|n' => \$_dry_run,
+	              'parents' => \$_parents,
 	              'tag|t' => \$_tag,
 	              'username=s' => \$Git::SVN::Prompt::_username,
 	              'commit-url=s' => \$_commit_url } ],
@@ -211,6 +212,7 @@ my %cmd = (
 	         { 'message|m=s' => \$_message,
 	           'destination|d=s' => \$_branch_dest,
 	           'dry-run|n' => \$_dry_run,
+	           'parents' => \$_parents,
 	           'username=s' => \$Git::SVN::Prompt::_username,
 	           'commit-url=s' => \$_commit_url } ],
 	'set-tree' => [ \&cmd_set_tree,
@@ -1172,6 +1174,10 @@ sub cmd_branch {
 		$ctx->ls($dst, 'HEAD', 0);
 	} and die "branch ${branch_name} already exists\n";
 
+	if ($_parents) {
+		mk_parent_dirs($ctx, $dst);
+	}
+
 	print "Copying ${src} at r${rev} to ${dst}...\n";
 	$ctx->copy($src, $rev, $dst)
 		unless $_dry_run;
@@ -1179,6 +1185,20 @@ sub cmd_branch {
 	$gs->fetch_all;
 }
 
+sub mk_parent_dirs {
+	my $ctx = shift;
+	my $parent = shift;
+	$parent =~ s/\/[^\/]*$//;
+
+	if (!eval{$ctx->ls($parent, 'HEAD', 0)}) {
+		mk_parent_dirs($ctx, $parent);
+		print "Creating parent folder ${parent} ...\n";
+		$ctx->mkdir($parent)
+			unless $_dry_run;
+	}
+
+}
+
 sub cmd_find_rev {
 	my $revision_or_hash = shift or die "SVN or git revision required ",
 	                                    "as a command-line argument\n";
diff --git a/t/t9167-git-svn-cmd-branch-subproject.sh b/t/t9167-git-svn-cmd-branch-subproject.sh
new file mode 100755
index 0000000..9cb891b
--- /dev/null
+++ b/t/t9167-git-svn-cmd-branch-subproject.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Tobias Schulte
+#
+
+test_description='git svn branch for subproject clones'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize svnrepo' '
+    mkdir import &&
+    (
+        (cd import &&
+        mkdir -p trunk/project branches tags &&
+        (cd trunk/project &&
+        echo foo > foo
+        ) &&
+        svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null
+        ) &&
+        rm -rf import &&
+        svn_cmd co "$svnrepo"/trunk/project trunk/project &&
+        (cd trunk/project &&
+        echo bar >> foo &&
+        svn_cmd ci -m "updated trunk"
+        ) &&
+        rm -rf trunk
+    )
+'
+
+test_expect_success 'import into git' '
+    git svn init --trunk=trunk/project --branches=branches/*/project --tags=tags/*/project "$svnrepo" &&
+    git svn fetch &&
+    git checkout remotes/trunk
+'
+
+test_expect_success 'git svn branch tests' '
+    test_must_fail git svn branch a &&
+    git svn branch --parents a &&
+    test_must_fail git svn branch -t tag1 &&
+    git svn branch --parents -t tag1 &&
+    test_must_fail git svn branch --tag tag2 &&
+    git svn branch --parents --tag tag2 &&
+    test_must_fail git svn tag tag3 &&
+    git svn tag --parents tag3
+'
+
+test_done
-- 
1.7.9.5
