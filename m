From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Fix 3-way merge with file move when diff.renames = copies
Date: Mon, 10 Nov 2008 15:53:27 -0800
Message-ID: <1226361207-7491-1-git-send-email-ddkilzer@kilzer.net>
References: <alpine.DEB.1.00.0811110039280.30769@pacific.mpi-cbg.de>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgbF-0003WU-EI
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbYKJXx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbYKJXx2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:53:28 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:52508 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYKJXx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:53:28 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 8573C463CEAF;
	Mon, 10 Nov 2008 15:53:27 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 68B2C280BF;
	Mon, 10 Nov 2008 15:53:27 -0800 (PST)
X-AuditID: 11807130-ab9afbb000000ea6-23-4918c977a794
Received: from localhost.localdomain (ddkilzer.apple.com [17.202.20.50])
	by relay11.apple.com (Apple SCV relay) with ESMTP id 5314C280AD;
	Mon, 10 Nov 2008 15:53:27 -0800 (PST)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <alpine.DEB.1.00.0811110039280.30769@pacific.mpi-cbg.de>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100596>

With diff.renames = copies, a 3-way merge (e.g. "git rebase") with a
file move would fail with the following error:

    fatal: mode change for <file>, which is not in current HEAD
    Repository lacks necessary blobs to fall back on 3-way merge.
    Cannot fall back to three-way merge.
    Patch failed at 0001.

The bug is a logic error added in ece7b749, which attempts to find
an sha1 for a patch with no index line in build_fake_ancestor().
Instead of failing unless an sha1 is found for both the old file and
the new file, a failure should only be reported if neither the old
file nor the new file is found.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
Same as "[PATCH] 3-way merge with file move fails when diff.renames = copies"
but with an updated subject and initial sentence (added "with a file move").

 builtin-apply.c   |    2 +-
 t/t3400-rebase.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4c4d1e1..cfeb6cc 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2573,7 +2573,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
 			/* git diff has no index line for mode/type changes */
 			if (!patch->lines_added && !patch->lines_deleted) {
-				if (get_current_sha1(patch->new_name, sha1) ||
+				if (get_current_sha1(patch->new_name, sha1) &&
 				    get_current_sha1(patch->old_name, sha1))
 					die("mode change for %s, which is not "
 						"in current HEAD", name);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b7a670e..a156850 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -84,4 +84,21 @@ test_expect_success 'rebase a single mode change' '
      GIT_TRACE=1 git rebase master
 '
 
+test_expect_success 'rebase a single file move with diff.renames = copies' '
+     git config diff.renames copies &&
+     git checkout master &&
+     echo 1 > Y &&
+     git add Y &&
+     test_tick &&
+     git commit -m "prepare file move" &&
+     git checkout -b filemove HEAD^ &&
+     echo 1 > Y &&
+     git add Y &&
+     mkdir D &&
+     git mv A D/A &&
+     test_tick &&
+     git commit -m filemove &&
+     GIT_TRACE=1 git rebase master
+'
+
 test_done
-- 
1.6.0
