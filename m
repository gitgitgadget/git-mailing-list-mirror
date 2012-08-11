From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH v3 1/2] git-svn.perl: consider all ranges for a given merge, instead of only tip-by-tip
Date: Sat, 11 Aug 2012 13:14:24 -0400
Message-ID: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, avarab@gmail.com, sam@vilain.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 19:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0FHK-0002oE-6l
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 19:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2HKROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 13:14:23 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33232 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab2HKROU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 13:14:20 -0400
Received: by ggdk6 with SMTP id k6so2444477ggd.19
        for <git@vger.kernel.org>; Sat, 11 Aug 2012 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=r+i5F7TZLhAWujROYHzyDdfsFvrzCystEsGJKUZiXJo=;
        b=D/K95qj2GcZZY9vBVyXnKeYaxXKLXvD8ji01xrSJhY+4WJ0m8mmp5rEQY2VRNqVriC
         Pm37JUMOPyOiS0yPtlJBKAk43hbHYEbQaE+ho2XGbYcXof9FbhM8a0hSMqAuR7AUVmO2
         Zz6LqsABSMrHph8Hu/IORNquRaYGCgwNwh1Gedgv+B1NWVKKUhpBJfI96vzcIx7wpVeg
         HLoj2KULUnbs/89xSGSKZvFwjbHYP1iUk5XJl0wJUv0ETzAIqCEsUkLwJThumZpUCM/2
         sLGediyatHbaOEXslPYFYCbt+1Qk/xNY6roOrmhkgdEdxxYAFWVjCpxkGp80Z5EwmEaz
         Iwhw==
Received: by 10.42.97.70 with SMTP id m6mr1322725icn.27.1344705259913;
        Sat, 11 Aug 2012 10:14:19 -0700 (PDT)
Received: from brock (CPE-76-177-45-54.natcky.res.rr.com. [76.177.45.54])
        by mx.google.com with ESMTPS id l19sm2030198iga.10.2012.08.11.10.14.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 10:14:18 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id BD285261E11; Sat, 11 Aug 2012 13:14:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203295>

Consider the case where you have trunk, branchA of trunk, and branchB of
branchA.  trunk is merged back into branchB, and then branchB is
reintegrated into trunk.  The merge of branchB into trunk will have
svn:mergeinfo property references to both branchA and branchB.  When
performing the check_cherry_pick check on branchB, it is necessary to
eliminate the merged contents of branchA as well as branchB, or else the
merge will be incorrectly ignored as a cherry-pick.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl                                    |    8 ++-
 t/t9163-git-svn-fetch-merge-branch-of-branch.sh |   60 +++++++++++++++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100755 t/t9163-git-svn-fetch-merge-branch-of-branch.sh

diff --git a/git-svn.perl b/git-svn.perl
index ca038ec..abcec11 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3657,14 +3657,14 @@ sub find_extra_svn_parents {
 	my @merge_tips;
 	my $url = $self->{url};
 	my $uuid = $self->ra_uuid;
-	my %ranges;
+	my @all_ranges;
 	for my $merge ( @merges ) {
 		my ($tip_commit, @ranges) =
 			lookup_svn_merge( $uuid, $url, $merge );
 		unless (!$tip_commit or
 				grep { $_ eq $tip_commit } @$parents ) {
 			push @merge_tips, $tip_commit;
-			$ranges{$tip_commit} = \@ranges;
+			push @all_ranges, @ranges;
 		} else {
 			push @merge_tips, undef;
 		}
@@ -3679,8 +3679,6 @@ sub find_extra_svn_parents {
 		my $spec = shift @merges;
 		next unless $merge_tip and $excluded{$merge_tip};
 
-		my $ranges = $ranges{$merge_tip};
-
 		# check out 'new' tips
 		my $merge_base;
 		eval {
@@ -3702,7 +3700,7 @@ sub find_extra_svn_parents {
 		my (@incomplete) = check_cherry_pick(
 			$merge_base, $merge_tip,
 			$parents,
-			@$ranges,
+			@all_ranges,
 		       );
 
 		if ( @incomplete ) {
diff --git a/t/t9163-git-svn-fetch-merge-branch-of-branch.sh b/t/t9163-git-svn-fetch-merge-branch-of-branch.sh
new file mode 100755
index 0000000..13ae7e3
--- /dev/null
+++ b/t/t9163-git-svn-fetch-merge-branch-of-branch.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Steven Walter
+#
+
+test_description='git svn merge detection'
+. ./lib-git-svn.sh
+
+svn_ver="$(svn --version --quiet)"
+case $svn_ver in
+0.* | 1.[0-4].*)
+	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
+	test_done
+	;;
+esac
+
+test_expect_success 'initialize source svn repo' '
+	svn_cmd mkdir -m x "$svnrepo"/trunk &&
+	svn_cmd mkdir -m x "$svnrepo"/branches &&
+	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
+		cd "$SVN_TREE" &&
+		touch foo &&
+		svn_cmd add foo &&
+		svn_cmd commit -m "initial commit" &&
+		svn_cmd cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+		svn_cmd switch "$svnrepo"/branches/branch1 &&
+		touch bar &&
+		svn_cmd add bar &&
+		svn_cmd commit -m branch1 &&
+		svn_cmd cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
+		svn_cmd switch "$svnrepo"/branches/branch2 &&
+		touch baz &&
+		svn_cmd add baz &&
+		svn_cmd commit -m branch2 &&
+		svn_cmd switch "$svnrepo"/trunk &&
+		touch bar2 &&
+		svn_cmd add bar2 &&
+		svn_cmd commit -m trunk &&
+		svn_cmd switch "$svnrepo"/branches/branch2 &&
+		svn_cmd merge "$svnrepo"/trunk &&
+		svn_cmd commit -m "merge trunk"
+		svn_cmd switch "$svnrepo"/trunk &&
+		svn_cmd merge --reintegrate "$svnrepo"/branches/branch2 &&
+		svn_cmd commit -m "merge branch2"
+	) &&
+	rm -rf "$SVN_TREE"
+'
+
+test_expect_success 'clone svn repo' '
+	git svn init -s "$svnrepo" &&
+	git svn fetch
+'
+
+test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
+	y=$(git rev-parse branch2) &&
+	test "x$x" = "x$y"
+'
+
+test_done
-- 
1.7.9.5
