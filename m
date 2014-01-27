From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 4/4] merge-recursive.c: Tolerate missing files while refreshing index
Date: Mon, 27 Jan 2014 09:45:09 -0500
Message-ID: <8438a8b04676baa25e39bed68c553ecb9f4dfec5.1390833624.git.brad.king@kitware.com>
References: <cover.1390592626.git.brad.king@kitware.com> <cover.1390833624.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 15:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7nR4-0008Dn-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 15:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbaA0Ool (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 09:44:41 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:35752 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753329AbaA0Ooj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 09:44:39 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 4AC1B9FBA8; Mon, 27 Jan 2014 09:45:09 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390833624.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241137>

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
index c3753c8..b8ea172 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -202,7 +202,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 {
 	struct cache_entry *ce;
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
-			      (refresh ? CE_MATCH_REFRESH : 0 ));
+			      (refresh ? (CE_MATCH_REFRESH |
+					  CE_MATCH_IGNORE_MISSING) : 0 ));
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
