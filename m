From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 1/2] git-svn.perl: consider all ranges for a given merge, instead of only tip-by-tip
Date: Sun, 19 Aug 2012 21:39:40 -0400
Message-ID: <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
References: <20120819193356.GA6203@dcvr.yhbt.net>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, sam@vilain.net, avarab@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 03:38:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Gwn-0006Hd-G2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 03:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab2HTBhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 21:37:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64634 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2HTBhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 21:37:41 -0400
Received: by yhmm54 with SMTP id m54so4799462yhm.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 18:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qRccxftvXOaLysDs1M4RqIuRBoS75CH2AbsBxa6HLC0=;
        b=g/MypJoM+t2KtKKROjImbAkOi0zXbhT7Y5/gh5SfIWWZXG3WQUm6qlzc27m0o8elEd
         JiPOILDKI6nJqKf/dWsieY8mQ7zIwANUe0E7IsHIQbQwyt8Y6dCf57N8rwi6T8MZ4QSC
         5t/FsMxVRngdvinQmjo/1BbkoUiWq0F3NRq8s3ciupW1b6w068m1JbzJ5qyQ9splu/OV
         j9Xyq+kKV6T1JrYdwhPEZta3qCnOViG25TnK7DAfXbClF5qE8CFv1J1bTUZ8uUS/n1wO
         BsXZ73XGG+mooF7/dv9OK+Fe8fXvkCMIM+QjXjj8bdg9oIICW65NhpXOnz/2SxvTlHdU
         89Yw==
Received: by 10.50.191.227 with SMTP id hb3mr8437972igc.45.1345426660373;
        Sun, 19 Aug 2012 18:37:40 -0700 (PDT)
Received: from brock (CPE-76-177-45-54.natcky.res.rr.com. [76.177.45.54])
        by mx.google.com with ESMTPS id fu4sm11528246igc.4.2012.08.19.18.37.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 18:37:39 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id B7D8E26048C; Sun, 19 Aug 2012 21:39:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20120819193356.GA6203@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203750>

Consider the case where you have trunk, branch1 of trunk, and branch2 of
branch1.  trunk is merged back into branch2, and then branch2 is
reintegrated into trunk.  The merge of branch2 into trunk will have
svn:mergeinfo property references to both branch1 and branch2.  When
git-svn fetches the commit that merges branch2 (check_cherry_pick),
it is necessary to eliminate the merged contents of branch1 as well as
branch2, or else the merge will be incorrectly ignored as a cherry-pick.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 perl/Git/SVN.pm                                 |    8 ++-
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh |   60 +++++++++++++++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100755 t/t9165-git-svn-fetch-merge-branch-of-branch.sh

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 8478d0c..2707003 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1695,14 +1695,14 @@ sub find_extra_svn_parents {
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
@@ -1717,8 +1717,6 @@ sub find_extra_svn_parents {
 		my $spec = shift @merges;
 		next unless $merge_tip and $excluded{$merge_tip};
 
-		my $ranges = $ranges{$merge_tip};
-
 		# check out 'new' tips
 		my $merge_base;
 		eval {
@@ -1740,7 +1738,7 @@ sub find_extra_svn_parents {
 		my (@incomplete) = check_cherry_pick(
 			$merge_base, $merge_tip,
 			$parents,
-			@$ranges,
+			@all_ranges,
 		       );
 
 		if ( @incomplete ) {
diff --git a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
new file mode 100755
index 0000000..13ae7e3
--- /dev/null
+++ b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
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
