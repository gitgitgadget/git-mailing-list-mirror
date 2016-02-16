From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Mon, 15 Feb 2016 19:38:25 -0700
Message-ID: <1455590305-30923-1-git-send-email-ischis2@cox.net>
References: <72756249.nAoBccgOj7@thunderbird>
Cc: Ovidiu Gheorghioiu <ovidiug@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:39:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVVXb-0004S6-H6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 03:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbcBPCip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 21:38:45 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:40202 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbcBPCi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 21:38:29 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160216023828.FUWS7752.fed1rmfepo102.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Mon, 15 Feb 2016 21:38:28 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo210 with cox
	id JqeU1s0022tqoqC01qeUpd; Mon, 15 Feb 2016 21:38:28 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.56C28BA4.00A1,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Hq2o7TvS c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=kviXuzpPAAAA:8
 a=3j0OYUYmodt_BhDjIi8A:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 0E8C113F629;
	Mon, 15 Feb 2016 19:38:57 -0700 (MST)
X-Mailer: git-send-email 2.7.0.GIT
In-Reply-To: <72756249.nAoBccgOj7@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286306>

The 'commit --dry-run' and commit return values differed if a
conflicted merge had been resolved and the commit would be the same as
the parent.

Update show_merge_in_progress to set the commitable bit if conflicts
have been resolved and a merge is in progress.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    In the original report when the dry run switch was passed and after
    the merge commit was resolved head and index matched leading to a
    returned value of 1. [1]
    
    If the dry run switch was not passed, the commit would succeed to
    correctly record the resolution.
    
    The result was that a dry run would report that there would be a
    failure, but there really isn't a failure if the commit is actually
    attemped.
    
    [1] $gmane/276591
    
    It appeared that the conditional for 'Reject an attempt to record a
    non-merge empty commit without * explicit --allow-empty.' could be
    simplified after adding this patch.
    
    This change can't be propagated to the conditional because it allows
    a commit that was previously disallowed.

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
