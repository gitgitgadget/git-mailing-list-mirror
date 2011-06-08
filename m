From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 39/48] merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
Date: Wed,  8 Jun 2011 01:31:09 -0600
Message-ID: <1307518278-23814-40-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEj-0006q0-54
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab1FHHaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1FHHaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:14 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=uK7JiuR32+XuoF66AGh/AEm+EPEHAqkfyMFTjXgfIC4=;
        b=o1k/6/1B54eta2NIPdJy0SF64g4h2fFU8Rl5+Yf3nnxXkgH8v4OVmZfIcSJrFC5Wl9
         jlYmsHT3CYwzPEFdsdqpc0/1C5C7v32UY4yQYaNi1dYObLpMTzLjIdASJiF35ZDCmjPC
         f8Jmki4SmP7c0oOF6e3NpQ1j2FxS/3w8yM+hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JL2mcfkFHusBHvwbp048bPoZwZ9GVuzFC+LMkPfGioDhLfHlPn2evrDxMEGx6Sxrw+
         Wvfr5v4bh8sXR/2h15Ic6H4msCH867GPKcvO8XmRcJsxqemRBHnaN/TZzsBSLAnu2+S7
         x680011surcfKJIt82yJBEjXolxa3xU+qMoMc=
Received: by 10.68.6.5 with SMTP id w5mr688524pbw.15.1307518214144;
        Wed, 08 Jun 2011 00:30:14 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.12
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175318>

When renaming one file to two files, we really should be doing a content
merge.  Also, in the recursive case, undoing the renames and recording the
merged file in the index with the source of the rename (while deleting
both destinations) allows the renames to be re-detected in the
non-recursive merge and will result in fewer spurious conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |   30 +++++++++++++-----------------
 t/t6036-recursive-corner-cases.sh |    2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3a364fa..576e02d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -971,17 +971,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	       src, pair1->two->path, branch1,
 	       src, pair2->two->path, branch2,
 	       o->call_depth ? " (left unresolved)" : "");
-	if (o->call_depth) {
-		/*
-		 * FIXME: Why remove file from cache, and then
-		 * immediately readd it?  Why not just overwrite using
-		 * update_file only?  Also...this is buggy for
-		 * rename/add-source situations...
-		 */
-		remove_file_from_cache(src);
-		update_file(o, 0, pair1->one->sha1, pair1->one->mode, src);
-	}
-
 	if (dir_in_way(ren1_dst, !o->call_depth)) {
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
@@ -993,14 +982,21 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		       ren2_dst, branch1, dst_name2);
 	}
 	if (o->call_depth) {
-		remove_file_from_cache(dst_name1);
-		remove_file_from_cache(dst_name2);
+		struct merge_file_info mfi;
+		mfi = merge_file(o, src,
+				 pair1->one->sha1, pair1->one->mode,
+				 pair1->two->sha1, pair1->two->mode,
+				 pair2->two->sha1, pair2->two->mode,
+				 branch1, branch2);
 		/*
-		 * Uncomment to leave the conflicting names in the resulting tree
-		 *
-		 * update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
-		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
+		 * FIXME: For rename/add-source conflicts (if we could detect
+		 * such), this is wrong.  We should instead find a unique
+		 * pathname and then either rename the add-source file to that
+		 * unique path, or use that unique path instead of src here.
 		 */
+		update_file(o, 0, mfi.sha, mfi.mode, src);
+		remove_file_from_cache(ren1_dst);
+		remove_file_from_cache(ren2_dst);
 	} else {
 		update_stages(ren1_dst, NULL, pair1->two, NULL);
 		update_stages(ren2_dst, NULL, NULL, pair2->two);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index d27477b..a1b609f 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -611,7 +611,7 @@ test_expect_success 'setup rename/rename(1to2)/modify followed by what looks lik
 	git tag E
 '
 
-test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
+test_expect_success 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
 	git checkout D^0 &&
 
 	git merge -s recursive E^0 &&
-- 
1.7.6.rc0.62.g2d69f
