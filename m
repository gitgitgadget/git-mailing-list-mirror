From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 27/37] merge-recursive: Move handling of double rename of one file to two
Date: Mon, 20 Sep 2010 02:29:00 -0600
Message-ID: <1284971350-30590-28-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblK-0006R4-4f
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab0ITI22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0ITI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:26 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5sbX/C9lmkkrMvKFVpB5siNc5/96LZZIU1Ppzx3I6ew=;
        b=kxrIBmzbSvPMXHCo+ba2jA4hJ//LBjul3NmW1hKCDb7MdnG8uRljO49vufjaUWrKWc
         pVt88e5G0CKk1jsoYeG4reqkc02WCqrsiK8GeGggmpqoRMfmmprffHtSNgwRcL2rlNhB
         1Xj18kKNQvNg+hY/pXCadhULmWk6pPTEHZo9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r2kAhrEfIBkDJAApy8MOBf4JtQBBRVb5uw7bZ8gNBJzG5hZdZVs0DVZRilFG2VbJeL
         OXw/IHDft7sZ9wz5Lm+YzUn2xKt3vTGMibpPTviF8hvh+Y/7DjmRwGMBWBH2pLw7WoQK
         Bmfmbm1L13DNslbeHIkp35LAEI+uTYHMsetN4=
Received: by 10.142.204.8 with SMTP id b8mr7359725wfg.158.1284971306691;
        Mon, 20 Sep 2010 01:28:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156583>

Move the handling of rename/rename conflicts where one file is renamed to
two different files, from process_renames() to process_df_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |   57 +++++++++++++++++++++++++++++++++-------------
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 178bbd8..e219d62 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -855,8 +855,11 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
 		 */
 	} else {
-		update_stages(dst_name1, NULL, pair1->two, NULL, 1);
-		update_stages(dst_name2, NULL, NULL, pair2->two, 1);
+		update_stages(ren1_dst, NULL, pair1->two, NULL, 1);
+		update_stages(ren2_dst, NULL, NULL, pair2->two, 1);
+
+		update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
+		update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
 	}
 	while (delp--)
 		free(del[delp]);
@@ -958,19 +961,15 @@ static int process_renames(struct merge_options *o,
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
-				clean_merge = 0;
-				output(o, 1, "CONFLICT (rename/rename): "
-				       "Rename \"%s\"->\"%s\" in branch \"%s\" "
-				       "rename \"%s\"->\"%s\" in \"%s\"%s",
-				       src, ren1_dst, branch1,
-				       src, ren2_dst, branch2,
-				       o->call_depth ? " (left unresolved)": "");
-				if (o->call_depth) {
-					remove_file_from_cache(src);
-					update_file(o, 0, ren1->pair->one->sha1,
-						    ren1->pair->one->mode, src);
-				}
-				conflict_rename_rename_1to2(o, ren1->pair, branch1, ren2->pair, branch2);
+				setup_rename_df_conflict_info(RENAME_ONE_FILE_TO_TWO,
+							      ren1->pair,
+							      ren2->pair,
+							      branch1,
+							      branch2,
+							      ren1->dst_entry,
+							      ren2->dst_entry);
+				remove_file(o, 0, ren1_dst, 0);
+				/* ren2_dst not in head, so no need to delete */
 			} else {
 				struct merge_file_info mfi;
 				remove_file(o, 1, ren1_src, 1);
@@ -1364,7 +1363,33 @@ static int process_df_entry(struct merge_options *o,
 
 	entry->processed = 1;
 	if (entry->rename_df_conflict_info) {
-		die ("Not yet implemented.");
+		struct rename_df_conflict_info *conflict_info = entry->rename_df_conflict_info;
+		char *src;
+		switch (conflict_info->rename_type) {
+		case RENAME_ONE_FILE_TO_TWO:
+			src = conflict_info->pair1->one->path;
+			clean_merge = 0;
+			output(o, 1, "CONFLICT (rename/rename): "
+			       "Rename \"%s\"->\"%s\" in branch \"%s\" "
+			       "rename \"%s\"->\"%s\" in \"%s\"%s",
+			       src, conflict_info->pair1->two->path, conflict_info->branch1,
+			       src, conflict_info->pair2->two->path, conflict_info->branch2,
+			       o->call_depth ? " (left unresolved)": "");
+			if (o->call_depth) {
+				remove_file_from_cache(src);
+				update_file(o, 0, conflict_info->pair1->one->sha1,
+					    conflict_info->pair1->one->mode, src);
+			}
+			conflict_rename_rename_1to2(o, conflict_info->pair1,
+						    conflict_info->branch1,
+						    conflict_info->pair2,
+						    conflict_info->branch2);
+			conflict_info->dst_entry2->processed = 1;
+			break;
+		default:
+			entry->processed = 0;
+			break;
+		}
 	} else if (!o_sha && !!a_sha != !!b_sha) {
 		/* directory -> (directory, file) */
 		const char *add_branch;
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 02dea16..1f29c0a 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -652,7 +652,7 @@ test_expect_success 'setup rename of one file to two, with directories in the wa
 	git commit -m "Put one/file in the way, rename to two"
 '
 
-test_expect_failure 'check handling of differently renamed file with D/F conflicts' '
+test_expect_success 'check handling of differently renamed file with D/F conflicts' '
 	git checkout -q first-rename^0 &&
 	test_must_fail git merge --strategy=recursive second-rename &&
 
-- 
1.7.3.271.g16009
