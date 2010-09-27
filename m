From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin/revert.c: don't dereference a NULL pointer
Date: Mon, 27 Sep 2010 12:29:45 -0500
Message-ID: <op5xt5mU5aQhqmO9a_49Hhsxhtg2iW_beFHkzibXMWI534-yRKsOVCvL_25O3xS3R6hTEbD06Kc@cipher.nrlssc.navy.mil>
References: <E2A2pg3JJJ3HO95lSjieK3cGmuaKW6JyYGAV6A_XDmFJCJGyAYa00A@cipher.nrlssc.navy.mil>
Cc: zbyszek@in.waw.pl, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 27 19:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Hai-0004ex-Oe
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 19:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759218Ab0I0ReK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 13:34:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41457 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0I0ReJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 13:34:09 -0400
Received: by mail.nrlssc.navy.mil id o8RHU3bw026603; Mon, 27 Sep 2010 12:30:04 -0500
In-Reply-To: <E2A2pg3JJJ3HO95lSjieK3cGmuaKW6JyYGAV6A_XDmFJCJGyAYa00A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Sep 2010 17:30:04.0265 (UTC) FILETIME=[9F04A590:01CB5E69]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157357>

From: Brandon Casey <drafnel@gmail.com>

cherry-pick will segfault when transplanting a root commit if the --ff
option is used.  This happens because the "parent" pointer is set to NULL
when the commit being cherry-picked has no parents.  Later, when "parent"
is dereferenced, the cherry-pick segfaults.

Fix this by checking whether "parent" is NULL before dereferencing it and
add a test for this case of cherry-picking a root commit with --ff.

Reported-by: Zbyszek Szmek <zbyszek@in.waw.pl>
Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin/revert.c          |    2 +-
 t/t3506-cherry-pick-ff.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4b47ace..57b51e4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -442,7 +442,7 @@ static int do_pick_commit(void)
 	else
 		parent = commit->parents->item;
 
-	if (allow_ff && !hashcmp(parent->object.sha1, head))
+	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index e17ae71..51ca391 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -95,4 +95,14 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent with --f
 	test_must_fail git cherry-pick --ff -m 3 C
 '
 
+test_expect_success 'cherry pick a root commit with --ff' '
+	git reset --hard first -- &&
+	git rm file1 &&
+	echo first >file2 &&
+	git add file2 &&
+	git commit --amend -m "file2" &&
+	git cherry-pick --ff first &&
+	test "$(git rev-parse --verify HEAD)" = "1df192cd8bc58a2b275d842cede4d221ad9000d1"
+'
+
 test_done
-- 
1.7.3
