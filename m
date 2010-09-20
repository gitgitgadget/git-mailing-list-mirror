From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 30/37] merge-recursive: Delay content merging for renames
Date: Mon, 20 Sep 2010 02:29:03 -0600
Message-ID: <1284971350-30590-31-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblL-0006R4-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab0ITI2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0ITI2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:33 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bXtnCvkFpLQ+VB7Z4AGLVwG6bNi5LW7BcY8hu9hn5h0=;
        b=epJmOnBRcjwCnl8VvJyndGgoKeqqpFh/X27WVeE9x1l1hG+ddoI4Cm/9DW7SdwD2jG
         FNYx6SLwTB3/j0Pg2Nn73H7d/YWgyUE3bVA3HhDzXfW5/lS2kApoPDt/+F+djAGLKQOu
         1c3Xd9J8uUrsH00KpuRuKSBWz5MZEAjjnImV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d4S6b1tTmHZupmXWK5vukj6XI+EQhKo2tFW89uNQ3aQ2WRqRwx3LAKJPxZhIztIRVJ
         fIiB2PSZ/Y7CHU4I/hYF9cO90hzDPt7CaGXO0r4HfXNAgBRnC/Qc3GBY4YWObtuaYMBp
         agm6kWur6JN5bwqGAHRB9dhm/g83lh3mBlxWU=
Received: by 10.142.233.4 with SMTP id f4mr6962239wfh.266.1284971312846;
        Mon, 20 Sep 2010 01:28:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156581>

Move the handling of content merging for renames from process_renames() to
process_df_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |   51 +++++++++++++---------------------------------
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 81508b3..008cacb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1073,7 +1073,6 @@ static int process_renames(struct merge_options *o,
 
 			if (try_merge) {
 				struct diff_filespec *one, *a, *b;
-				struct merge_file_info mfi;
 				src_other.path = (char *)ren1_src;
 
 				one = ren1->pair->one;
@@ -1084,41 +1083,16 @@ static int process_renames(struct merge_options *o,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				mfi = merge_file(o, one, a, b,
-						o->branch1, o->branch2);
-
-				if (mfi.clean &&
-				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
-				    mfi.mode == ren1->pair->two->mode) {
-					/*
-					 * This message is part of
-					 * t6022 test. If you change
-					 * it update the test too.
-					 */
-					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
-
-					/* There may be higher stage entries left
-					 * in the index (e.g. due to a D/F
-					 * conflict) that need to be resolved.
-					 */
-					if (!ren1->dst_entry->stages[2].mode !=
-					    !ren1->dst_entry->stages[3].mode)
-						ren1->dst_entry->processed = 0;
-				} else {
-					if (mfi.merge || !mfi.clean)
-						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
-					if (mfi.merge)
-						output(o, 2, "Auto-merging %s", ren1_dst);
-					if (!mfi.clean) {
-						output(o, 1, "CONFLICT (rename/modify): Merge conflict in %s",
-						       ren1_dst);
-						clean_merge = 0;
-
-						if (!o->call_depth)
-							update_stages(ren1_dst,
-								      one, a, b, 1);
-					}
-					update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+				update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
+				if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+					setup_rename_df_conflict_info(RENAME_NORMAL,
+								      ren1->pair,
+								      NULL,
+								      branch1,
+								      NULL,
+								      ren1->dst_entry,
+								      NULL);
+					remove_file(o, 0, ren1_dst, 0);
 				}
 			}
 		}
@@ -1358,6 +1332,11 @@ static int process_df_entry(struct merge_options *o,
 		struct rename_df_conflict_info *conflict_info = entry->rename_df_conflict_info;
 		char *src;
 		switch (conflict_info->rename_type) {
+		case RENAME_NORMAL:
+			clean_merge = merge_content(o, path,
+						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
+						    conflict_info->branch1);
+			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
 			conflict_rename_delete(o, conflict_info->pair1,
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1f29c0a..edbfa47 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -455,7 +455,7 @@ cat >expected <<\EOF &&
 >>>>>>> dir-not-in-way
 EOF
 
-test_expect_failure 'Rename+D/F conflict; renamed file cannot merge, dir not in way' '
+test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in way' '
 	git reset --hard &&
 	rm -rf dir~* &&
 	git checkout -q renamed-file-has-conflicts^0 &&
-- 
1.7.3.271.g16009
