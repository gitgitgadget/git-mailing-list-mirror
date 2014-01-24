From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 3/3] merge-recursive.c: Tolerate missing files while refreshing index
Date: Fri, 24 Jan 2014 15:10:49 -0500
Message-ID: <92b0b0310b762276db23161d34ba94a86fd67139.1390592626.git.brad.king@kitware.com>
References: <cover.1390574980.git.brad.king@kitware.com> <cover.1390592626.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 21:10:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6n59-0007A7-I7
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbaAXUKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:10:23 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59747 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbaAXUKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:10:21 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id E54589FBA7; Fri, 24 Jan 2014 15:10:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390592626.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241029>

Teach add_cacheinfo to tell make_cache_entry to skip refreshing stat
information when a file is missing from the work tree.  We do not want
the index to be stat-dirty after the merge but also do not want to fail
when a file happens to be missing.

This fixes the 'merge-recursive w/ empty work tree - ours has rename'
case in t3030-merge-recursive.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Brad King <brad.king@kitware.com>
---
 merge-recursive.c          | 3 ++-
 t/t3030-merge-recursive.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a6fe7f9..35935c5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -201,7 +201,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh, 0);
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
+			      refresh, REFRESH_IGNORE_MISSING);
 	if (!ce)
 		return error(_("addinfo_cache failed for path '%s'"), path);
 	return add_cache_entry(ce, options);
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 3db3bf6..82e1854 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -518,7 +518,7 @@ test_expect_success 'reset and bind merge' '
 
 '
 
-test_expect_failure 'merge-recursive w/ empty work tree - ours has rename' '
+test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 	(
 		GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
 		export GIT_WORK_TREE &&
-- 
1.8.5.2
