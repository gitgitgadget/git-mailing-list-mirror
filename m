From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH v2] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 22:06:37 -0700
Message-ID: <1455685597-22445-1-git-send-email-ischis2@cox.net>
References: <xmqqr3gcj9i5.fsf@gitster.mtv.corp.google.com>
Cc: Ovidiu Gheorghioiu <ovidiug@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 06:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVuJg-00035K-9c
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 06:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbcBQFGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 00:06:13 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:50673 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbcBQFGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 00:06:12 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160217050611.CSPA5597.fed1rmfepo201.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Wed, 17 Feb 2016 00:06:11 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo210 with cox
	id KH6B1s0022tqoqC01H6BN7; Wed, 17 Feb 2016 00:06:11 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020205.56C3FFC3.0061,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Hq2o7TvS c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=kviXuzpPAAAA:8
 a=QPtQ6CIF9rQtDnzxi3QA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 6555F13F83B;
	Tue, 16 Feb 2016 22:06:46 -0700 (MST)
X-Mailer: git-send-email 2.7.0.GIT
In-Reply-To: <xmqqr3gcj9i5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286483>

The 'commit --dry-run' and 'commit' return values differed if a
conflicted merge had been resolved and the commit would be the same as
the parent.

Update show_merge_in_progress to set the commitable bit if conflicts
have been resolved and a merge is in progress.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Updated the commit message.

 t/t7501-commit.sh | 20 ++++++++++++++++++++
 wt-status.c       |  1 +
 2 files changed, 21 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 63e0427..363abb1 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -587,4 +587,24 @@ test_expect_success '--only works on to-be-born branch' '
 	test_cmp expected actual
 '
 
+test_expect_success '--dry-run with conflicts fixed from a merge' '
+	# setup two branches with conflicting information
+	# in the same file, resolve the conflict,
+	# call commit with --dry-run
+	echo "Initial contents, unimportant" >test-file &&
+	git add test-file &&
+	git commit -m "Initial commit" &&
+	echo "commit-1-state" >test-file &&
+	git commit -m "commit 1" -i test-file &&
+	git tag commit-1 &&
+	git checkout -b branch-2 HEAD^1 &&
+	echo "commit-2-state" >test-file &&
+	git commit -m "commit 2" -i test-file &&
+	! $(git merge --no-commit commit-1) &&
+	echo "commit-2-state" >test-file &&
+	git add test-file &&
+	git commit --dry-run &&
+	git commit -m "conflicts fixed from merge."
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index ab4f80d..1374b48 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -950,6 +950,7 @@ static void show_merge_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git commit\")"));
 	} else {
+		s-> commitable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
-- 
2.7.0.GIT
