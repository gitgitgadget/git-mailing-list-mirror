From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 2/3] git-svn: Support cherry-pick merges
Date: Thu, 28 Nov 2013 10:52:16 -0500
Message-ID: <1385653937-29595-3-git-send-email-andrew.kw.w@gmail.com>
References: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 16:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm3t8-0004qy-I0
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 16:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758989Ab3K1PwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 10:52:16 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64683 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab3K1PwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 10:52:11 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so14175366iec.21
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EvuSpzmD0K9tTW5JgU9MEm0fxhEtu6FL2uFniYrTCKE=;
        b=EXc1NZi+6M0FsJ74xxn4d8IkKNokm1f754oHyuP89HOtCYTmLCUD74/Azvg9MPvFgA
         6ObE/DyoerfzfUfynVbd3xv7Q8cAqaPU3SEQhF8Xn+SyXfjakDWihitkr97xbPvTyYXN
         7UeVngW46xLVzZyY/CFea5dmJYcz1sHlnUgzlDhVC2vSEON//p8NAgS9+J3wkxV5CLMt
         hLOF8N2cWTAe97yd+Lw04A+OVNdGTDzRak10LM8qVHCsbt/PPjlgPpK0IEeKKbsFJX/B
         OdKOJZEgrRev3qn9xkMIN1RTvgwt/qqxkxiTdrlU1R0+97js1v0AhtfqH1dfDcVhoQEg
         x0fw==
X-Received: by 10.50.39.45 with SMTP id m13mr2690785igk.14.1385653931234;
        Thu, 28 Nov 2013 07:52:11 -0800 (PST)
Received: from zanarkand.local (24-212-191-132.cable.teksavvy.com. [24.212.191.132])
        by mx.google.com with ESMTPSA id qi3sm45309190igc.8.2013.11.28.07.52.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 07:52:10 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238499>

Detect a cherry-pick merge if there's only one parent and the git-svn-id
metadata exists. Then, get the parent's mergeinfo and merge this commit's
mergeinfo.
---
 git-svn.perl                      | 52 +++++++++++++++++++++++++++++++++++++--
 t/t9161-git-svn-mergeinfo-push.sh | 30 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9ddeaf4..b04cac7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -698,12 +698,14 @@ sub populate_merge_info {
 	my %parentshash;
 	read_commit_parents(\%parentshash, $d);
 	my @parents = @{$parentshash{$d}};
+
+        my $rooturl = $gs->repos_root;
+        my ($target_branch) = $gs->full_pushurl =~ /^\Q$rooturl\E(.*)/;
+
 	if ($#parents > 0) {
 		# Merge commit
 		my $all_parents_ok = 1;
 		my $aggregate_mergeinfo = '';
-		my $rooturl = $gs->repos_root;
-		my ($target_branch) = $gs->full_pushurl =~ /^\Q$rooturl\E(.*)/;
 
 		if (defined($rewritten_parent)) {
 			# Replace first parent with newly-rewritten version
@@ -785,6 +787,52 @@ sub populate_merge_info {
 		if ($all_parents_ok and $aggregate_mergeinfo) {
 			return $aggregate_mergeinfo;
 		}
+	} elsif ($#parents == 0) {
+		# cherry-pick merge
+		my ($cherry_branchurl, $cherry_svnrev, $cherry_paruuid) =
+			cmt_metadata($d);
+
+		if(defined $cherry_branchurl && defined $cherry_svnrev && defined $cherry_paruuid)
+		{
+			if (defined($rewritten_parent)) {
+				# Replace first parent with newly-rewritten version
+				shift @parents;
+				unshift @parents, $rewritten_parent;
+			}
+
+			my $aggregate_mergeinfo = '';
+
+			# parent mergeinfo
+			my ($branchurl, $svnrev, $paruuid) =
+				cmt_metadata($parents[0]);
+
+			my $ra = Git::SVN::Ra->new($branchurl);
+			my (undef, undef, $props) =
+				$ra->get_dir(canonicalize_path("."), $svnrev);
+			my $parent_mergeinfo = $props->{'svn:mergeinfo'};
+			unless (defined $parent_mergeinfo) {
+				$parent_mergeinfo = '';
+			}
+
+			$aggregate_mergeinfo = merge_merge_info($aggregate_mergeinfo,
+					$parent_mergeinfo,
+					$target_branch);
+
+			# cherry-pick mergeinfo
+			unless ($cherry_branchurl =~ /^\Q$rooturl\E(.*)/) {
+				fatal "commit $d git-svn metadata changed mid-run!";
+			}
+			my $cherry_branchpath = $1;
+
+			my $cherry_pick_mergeinfo = canonicalize_path("$cherry_branchpath")
+				. ":$cherry_svnrev";
+
+			$aggregate_mergeinfo = merge_merge_info($aggregate_mergeinfo,
+					$cherry_pick_mergeinfo,
+					$target_branch);
+
+			return $aggregate_mergeinfo;
+		}
 	}
 
 	return undef;
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index 1eab701..f348392 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -91,6 +91,36 @@ test_expect_success 'check reintegration mergeinfo' '
 /branches/svnb5:6,11"
 	'
 
+test_expect_success 'make further commits to branch' '
+	git checkout svnb2 &&
+	touch newb2file-3 &&
+	git add newb2file-3 &&
+	git commit -m "later b2 commit 3" &&
+	touch newb2file-4 &&
+	git add newb2file-4 &&
+	git commit -m "later b2 commit 4" &&
+	touch newb2file-5 &&
+	git add newb2file-5 &&
+	git commit -m "later b2 commit 5" &&
+	git svn dcommit
+	'
+
+test_expect_success 'cherry-pick merge' '
+	git checkout svnb1 &&
+	git cherry-pick svnb2 &&
+	git cherry-pick svnb2^ &&
+	git cherry-pick svnb2^^ &&
+	git svn dcommit
+	'
+
+test_expect_success 'check cherry-pick mergeinfo' '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	test "$mergeinfo" = "/branches/svnb2:3,8,16-17,20-22
+/branches/svnb3:4,9
+/branches/svnb4:5-6,10-12
+/branches/svnb5:6,11"
+	'
+
 test_expect_success 'dcommit a merge at the top of a stack' '
 	git checkout svnb1 &&
 	touch anotherfile &&
-- 
1.8.5.rc3.5.g96ccada
