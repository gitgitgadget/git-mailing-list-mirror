From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 48/56] merge-recursive: add handling for rename/rename/add-dest/add-dest
Date: Thu, 11 Aug 2011 23:20:21 -0600
Message-ID: <1313126429-17368-49-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCQ-0005Kt-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1HLFWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:22 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab1HLFWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:19 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r1htMZ8pZecKaGxmYvPlAF0ZqQxgXMti4DwiFJ7QYUk=;
        b=o9finIDzx2p7rG3155+fnA108EUJiEqxGoH4zhYT3I50X8+YF57RQSLUYSupkEdoPv
         6v5q+v1vaN1bCt7s54zIVJdOnj6N+6m5m1F1am1/EPl+PokhPtuyq/r2f2HIvAnsG14d
         6eEBGqz0aT0TggVj+ZtDrbsDwiNccGkpdiyjQ=
Received: by 10.43.46.65 with SMTP id un1mr567605icb.20.1313126539535;
        Thu, 11 Aug 2011 22:22:19 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.17
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179198>

Each side of the rename in rename/rename(1to2) could potentially also be
involved in a rename/add conflict.  Ensure stages for such conflicts are
also recorded.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                    |   21 +++++++++++++++++++--
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c89a5ce..8ddd520 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1073,6 +1073,19 @@ static void conflict_rename_delete(struct merge_options *o,
 			     "rename", "renamed");
 }
 
+static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
+						 struct stage_data *entry,
+						 int stage)
+{
+	unsigned char *sha = entry->stages[stage].sha;
+	unsigned mode = entry->stages[stage].mode;
+	if (mode == 0 || is_null_sha1(sha))
+		return NULL;
+	hashcpy(target->sha1, sha);
+	target->mode = mode;
+	return target;
+}
+
 static void conflict_rename_rename_1to2(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
@@ -1118,8 +1131,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		remove_file_from_cache(a->path);
 		remove_file_from_cache(b->path);
 	} else {
-		update_stages(a->path, NULL, a, NULL);
-		update_stages(b->path, NULL, NULL, b);
+		struct diff_filespec other;
+		update_stages(a->path, NULL,
+			      a, filespec_from_entry(&other, ci->dst_entry1, 3));
+
+		update_stages(b->path, NULL,
+			      filespec_from_entry(&other, ci->dst_entry2, 2), b);
 
 		update_file(o, 0, a->sha1, a->mode, dst_name_a);
 		update_file(o, 0, b->sha1, b->mode, dst_name_b);
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 3be5059..6875919 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -551,7 +551,7 @@ test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
 	git commit -m two
 '
 
-test_expect_failure 'rename/rename/add-dest merge still knows about conflicting file versions' '
+test_expect_success 'rename/rename/add-dest merge still knows about conflicting file versions' '
 	git checkout C^0 &&
 	test_must_fail git merge -s recursive B^0 &&
 
-- 
1.7.6.100.gac5c1
