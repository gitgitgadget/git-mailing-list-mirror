From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] git-svn: Correctly handle root commits in mergeinfo ranges
Date: Sat, 18 Jun 2011 08:48:00 +0200
Message-ID: <1308379680-17188-4-git-send-email-mhagger@alum.mit.edu>
References: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, bert.wesarg@googlemail.com,
	normalperson@yhbt.net, git@drmicha.warpmail.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 08:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXpLN-0001oz-Iu
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 08:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1FRGtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 02:49:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37974 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab1FRGtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 02:49:13 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BE9EF0.dip.t-dialin.net [84.190.158.240])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5I6mO8j000405;
	Sat, 18 Jun 2011 08:49:04 +0200
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175967>

If the bottom of a mergeinfo range is a commit that maps to a git root
commit, then it doesn't have a parent.  In such a case, use git commit
range "$top_commit" rather than "$bottom_commit^..$top_commit".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-svn.perl                           |    7 +++++--
 t/t9159-git-svn-no-parent-mergeinfo.sh |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2cc9242..7e121ae 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3111,8 +3111,11 @@ sub lookup_svn_merge {
 			next;
 		}
 
-		push @merged_commit_ranges,
-			"$bottom_commit^..$top_commit";
+		if (scalar(command('rev-parse', "$bottom_commit^@"))) {
+			push @merged_commit_ranges, "$bottom_commit^..$top_commit";
+		} else {
+			push @merged_commit_ranges, "$top_commit";
+		}
 
 		if ( !defined $tip or $top > $tip ) {
 			$tip = $top;
diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
index 9472de3..85120b7 100755
--- a/t/t9159-git-svn-no-parent-mergeinfo.sh
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -2,7 +2,7 @@
 test_description='git svn handling of root commits in merge ranges'
 . ./lib-git-svn.sh
 
-test_expect_failure 'test handling of root commits in merge ranges' '
+test_expect_success 'test handling of root commits in merge ranges' '
 	mkdir -p init/trunk init/branches init/tags &&
 	echo "r1" > init/trunk/file.txt &&
 	svn_cmd import -m "initial import" init "$svnrepo" &&
-- 
1.7.5.4
