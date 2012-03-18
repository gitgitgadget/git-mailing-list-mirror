From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Sun, 18 Mar 2012 17:37:12 -0400
Message-ID: <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:39:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Okr-0007o9-0O
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 23:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab2CRWih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 18:38:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34206 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab2CRWig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 18:38:36 -0400
Received: by iagz16 with SMTP id z16so8535066iag.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3YDGvdX8xWsbvK/aVi9ITMw7j9Yecx53Zs3A6vB7YwI=;
        b=TZn4+KHdqVlc1ilreHKx0zkfSmD4BbxZ46uklp0Gt2ISq7Yg1RjAq8fkunkliToUxB
         01ArIyCYunhzXfkgDE1Fsh6durvtdQI1/YrBOXXOKd5QZ9hWXYpb/jWwju1vlekqVGdR
         0LHrBAMXyTuT+Qz+qPPYMGk2PldLpPoREo/uUYtK5WBpOl+Vl2geI8c7AR+cOYmrcrD+
         oDWnWR3+ERZCAW/eYEmcQMFD0t4sKZhoFsIs/+M00OLq6szJBnbDVcT68VC94kSTBvzk
         Ua6Vyky61EVsEBF9CQBZyH3wOYkAtykHO6L6fHToUjaPYmnx8S5/ftkOSbHPMqBPo7SZ
         OYHw==
Received: by 10.50.194.193 with SMTP id hy1mr4463262igc.53.1332110315915;
        Sun, 18 Mar 2012 15:38:35 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com. [24.246.58.202])
        by mx.google.com with ESMTPS id dl10sm6881728igb.9.2012.03.18.15.38.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 15:38:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.22.gf5241
In-Reply-To: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193394>

Instead of having the sequencer catch errors and remove CHERRY_PICK_HEAD
for its caller's sake, let its caller do the work. This way, the
sequencer doesn't have to check all points of failures where its caller
doesn't want CHERRY_PICK_HEAD.

For example, the sequencer current doesn't clean up CHERRY_PICK_HEAD if
'commit' failed due to an empty commit. Letting 'rebase -i' deal with
removing CHERRY_PICK_HEAD keeps the sequencer's logic a bit cleaner.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |   10 +++++++++-
 sequencer.c                |    6 ------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..061248c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -196,7 +196,12 @@ pick_one () {
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $ff "$@"
+	output git cherry-pick $ff "$@" ||
+	{
+		status=$?
+		rm -f "$GIT_DIR"/CHERRY_PICK_HEAD
+		return $status
+	}
 }
 
 pick_one_preserving_merges () {
@@ -308,7 +313,10 @@ pick_one_preserving_merges () {
 			;;
 		*)
 			output git cherry-pick "$@" ||
+			{
+				rm -f "$GIT_DIR"/CHERRY_PICK_HEAD
 				die_with_patch $sha1 "Could not pick $sha1"
+			}
 			;;
 		esac
 		;;
diff --git a/sequencer.c b/sequencer.c
index a37846a..c2eceb5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -129,12 +129,6 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
-		/*
-		 * A conflict has occured but the porcelain
-		 * (typically rebase --interactive) wants to take care
-		 * of the commit itself so remove CHERRY_PICK_HEAD
-		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
 		return;
 	}
 
-- 
1.7.10.rc1.22.gf5241
