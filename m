From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 3/5] git-svn: fix some mistakes with interpreting SVN mergeinfo commit ranges
Date: Sun, 20 Dec 2009 05:33:53 +1300
Message-ID: <1261240435-8948-4-git-send-email-sam@vilain.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
 <1261240435-8948-2-git-send-email-sam@vilain.net>
 <1261240435-8948-3-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2GH-000123-EA
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbZLSQeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZLSQeU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52456 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbZLSQeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:19 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 706A821C57A; Sun, 20 Dec 2009 05:34:18 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 4131621C50A;
	Sun, 20 Dec 2009 05:34:13 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2Fy-0002Lt-Jo; Sun, 20 Dec 2009 05:34:14 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1261240435-8948-3-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135487>

SVN's list of commit ranges in mergeinfo tickets is inclusive, whereas
git commit ranges are exclusive on the left hand side.  Also, the end
points of the commit ranges may not exist; they simply delineate
ranges of commits which may or may not exist.  Fix these two mistakes.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl             |   12 +++---------
 t/t9151-svn-mergeinfo.sh |    2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3b17a83..9cf4a3e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2988,14 +2988,8 @@ sub lookup_svn_merge {
 	for my $range ( @ranges ) {
 		my ($bottom, $top) = split "-", $range;
 		$top ||= $bottom;
-		my $bottom_commit =
-			$gs->rev_map_get($bottom, $uuid) ||
-			$gs->rev_map_get($bottom+1, $uuid);
-		my $top_commit;
-		for (; !$top_commit && $top >= $bottom; --$top) {
-			$top_commit =
-				$gs->rev_map_get($top, $uuid);
-		}
+		my $bottom_commit = $gs->find_rev_after( $bottom, 1, $top );
+		my $top_commit = $gs->find_rev_before( $top, 1, $bottom );
 
 		unless ($top_commit and $bottom_commit) {
 			warn "W:unknown path/rev in svn:mergeinfo "
@@ -3004,7 +2998,7 @@ sub lookup_svn_merge {
 		}
 
 		push @merged_commit_ranges,
-			"$bottom_commit..$top_commit";
+			"$bottom_commit^..$top_commit";
 
 		if ( !defined $tip or $top > $tip ) {
 			$tip = $top;
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index dc3478f..f6e00ea 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -33,7 +33,7 @@ test_expect_success 'svn non-merge merge commits did not become git merge commit
 	[ -z "$bad_non_merges" ]
 	'
 
-test_expect_failure 'everything got merged in the end' '
+test_expect_success 'everything got merged in the end' '
 	unmerged=$(git rev-list --all --not master)
 	[ -z "$unmerged" ]
 	'
-- 
1.6.3.3
