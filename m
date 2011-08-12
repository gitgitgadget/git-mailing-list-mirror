From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 56/56] merge-recursive: Fix virtual merge base for rename/rename(1to2)/add-dest
Date: Thu, 11 Aug 2011 23:20:29 -0600
Message-ID: <1313126429-17368-57-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD7-0005ix-LY
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab1HLFWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53872 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab1HLFWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:35 -0400
Received: by yxj19 with SMTP id 19so1756499yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uHdBRqfw0XnV0IVzfN8OqtU+JrG47LVwIvbDTJGFEUQ=;
        b=ugIrZUc8mh2DGf8Pv6e/zOHx6wDEOaS7rITzPWsWO7+5W8SUeogCm/uyuHRAwX9wfA
         HnjFLdGaiq0s3fAYUCByTsFnn7VVUDySAnKXNWdPUCsipYVSItLhsNcuWIfym4quGK6O
         XouK2z6JSbaJRV1I+lvC7xecFLEnAoRql6tRU=
Received: by 10.42.157.5 with SMTP id b5mr494571icx.442.1313126554949;
        Thu, 11 Aug 2011 22:22:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.32
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179205>

Earlier in this series, the patch "merge-recursive: add handling for
rename/rename/add-dest/add-dest" added code to handle the rename on each
side of history also being involved in a rename/add conflict, but only
did so in the non-recursive case.  Add code for the recursive case,
ensuring that the "added" files are not simply deleted.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 merge-recursive.c                 |   23 +++++++++++++++++++++--
 t/t6036-recursive-corner-cases.sh |    2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f088132..05ba41c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1161,6 +1161,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	       o->call_depth ? " (left unresolved)" : "");
 	if (o->call_depth) {
 		struct merge_file_info mfi;
+		struct diff_filespec other;
+		struct diff_filespec *add;
 		mfi = merge_file(o, one->path,
 				 one->sha1, one->mode,
 				 a->sha1, a->mode,
@@ -1173,8 +1175,25 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * unique path, or use that unique path instead of src here.
 		 */
 		update_file(o, 0, mfi.sha, mfi.mode, one->path);
-		remove_file_from_cache(a->path);
-		remove_file_from_cache(b->path);
+
+		/*
+		 * Above, we put the merged content at the merge-base's
+		 * path.  Now we usually need to delete both a->path and
+		 * b->path.  However, the rename on each side of the merge
+		 * could also be involved in a rename/add conflict.  In
+		 * such cases, we should keep the added file around,
+		 * resolving the conflict at that path in its favor.
+		 */
+		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
+		if (add)
+			update_file(o, 0, add->sha1, add->mode, a->path);
+		else
+			remove_file_from_cache(a->path);
+		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
+		if (add)
+			update_file(o, 0, add->sha1, add->mode, b->path);
+		else
+			remove_file_from_cache(b->path);
 	} else {
 		handle_file(o, a, 2, ci);
 		handle_file(o, b, 3, ci);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index e9c7a25..dfee7d1 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -760,7 +760,7 @@ test_expect_success 'setup criss-cross+rename/rename/add-dest + simple modify' '
 	git tag E
 '
 
-test_expect_failure 'virtual merge base handles rename/rename(1to2)/add-dest' '
+test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 	git checkout D^0 &&
 
 	git merge -s recursive E^0 &&
-- 
1.7.6.100.gac5c1
