From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 1/2] git-svn.perl: consider all ranges for a given merge, instead of only tip-by-tip
Date: Wed, 23 May 2012 20:40:44 -0400
Message-ID: <1337820046-4791-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 02:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXM6s-00056G-7v
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 02:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab2EXAkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 20:40:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38489 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab2EXAku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 20:40:50 -0400
Received: by yhmm54 with SMTP id m54so7250733yhm.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oFvtlEjmV7kqzdj8Jn1vUEAYZon6bDLTczLF8dTV4rw=;
        b=zT5rGL1T5UbNduatBu9Jiq0H44pAw8GZiqVBLEPhSbYKzil4+HBk7m4o2FMM3JDYM9
         meZZPH5VW4U67vHhm7Mm+7JStyuSTnWnxxutGuvi4NbQTpJu8PdmbcWbUoybua9XP0gQ
         z21g4OBFKXM4Grlk/y1yzaxXR6Hfkpa0TSelVvcIAagjEMYMkR/eZyYpRBW38krKDD5F
         vEllEjkxINuYmG1EPp1HtNnylduqJDVXYZWzlMplGpf6BWbNE5ipArdA6Iv6nWf4ck3y
         JLSi5FDAXKIqRQ7AN+8S9wbejZkMGyCszN3IeWkRQ6EOTSoCCMEq+HUg7yM4XrJ54v68
         lqOw==
Received: by 10.236.189.9 with SMTP id b9mr32883937yhn.105.1337820049354;
        Wed, 23 May 2012 17:40:49 -0700 (PDT)
Received: from brock (adsl-184-43-63-84.bgk.bellsouth.net. [184.43.63.84])
        by mx.google.com with ESMTPS id s5sm5472464anh.16.2012.05.23.17.40.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 17:40:48 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1SXM6h-0001Fo-0n; Wed, 23 May 2012 20:40:47 -0400
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198337>

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
index 0000000..58c7c56
--- /dev/null
+++ b/t/t9163-git-svn-fetch-merge-branch-of-branch.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Steven Walter
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
+		svn add foo &&
+		svn commit -m "initial commit" &&
+		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+		svn switch "$svnrepo"/branches/branch1 &&
+		touch bar &&
+		svn add bar &&
+		svn commit -m branch1 &&
+		svn cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
+		svn switch "$svnrepo"/branches/branch2 &&
+		touch baz &&
+		svn add baz &&
+		svn commit -m branch2 &&
+		svn switch "$svnrepo"/trunk &&
+		touch bar2 &&
+		svn add bar2 &&
+		svn commit -m trunk &&
+		svn switch "$svnrepo"/branches/branch2 &&
+		svn merge "$svnrepo"/trunk &&
+		svn commit -m "merge trunk"
+		svn switch "$svnrepo"/trunk &&
+		svn merge --reintegrate "$svnrepo"/branches/branch2 &&
+		svn commit -m "merge branch2"
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
+	[ $x == $y ]
+'
+
+test_done
-- 
1.7.9.5
