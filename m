Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB1E1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbdKJWWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45958 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754500AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAME7hi003355;
        Fri, 10 Nov 2017 14:22:04 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631me2-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id BD14422F94C1;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id B4B602CDE6A;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 6/9] merge-recursive: Improve handling for rename/rename(2to1) conflicts
Date:   Fri, 10 Nov 2017 14:21:53 -0800
Message-Id: <20171110222156.23221-7-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the rename/rename(2to1) conflicts use the new
handle_file_collision() function.  Since that function was based
originally on the rename/rename(2to1) handling code, the main
differences here are in what was added.  In particular:

  * If the two colliding files are similar, instead of being stored
    at collide_path~HEAD and collide_path~MERGE, the files are two-way
    merged and recorded at collide_path.
  * Instead of recording the version of the renamed file that existed
    on the renamed side in the index (thus ignoring any changes that
    were made to the file on the side of history without the rename),
    we do a three-way content merge on the renamed path, then store
    that at either stage 2 or stage 3.
  * Note that if either of the three-way content merges done for each
    rename have conflicts, we do NOT try to estimate the similarity of
    the resulting two files and just automatically consider them to be
    dissimilar.  This is done to avoid foisting conflicts-of-conflicts
    on the user.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Is it too weird to others that I potentially record a merged file with
conflict markers at both stage 2 and stage 3 in the index?  To me, it
seemed less weird than what we previously did, but I am curious what
others think of it. 

 merge-recursive.c                    | 100 +++++------------------------------
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 2 files changed, 14 insertions(+), 88 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f29cbd1240..b8108740c4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -647,26 +647,6 @@ static int update_stages(struct merge_options *opt, const char *path,
 	return 0;
 }
 
-static int update_stages_for_stage_data(struct merge_options *opt,
-					const char *path,
-					const struct stage_data *stage_data)
-{
-	struct diff_filespec o, a, b;
-	o.mode = stage_data->stages[1].mode;
-	oidcpy(&o.oid, &stage_data->stages[1].oid);
-
-	a.mode = stage_data->stages[2].mode;
-	oidcpy(&a.oid, &stage_data->stages[2].oid);
-
-	b.mode = stage_data->stages[3].mode;
-	oidcpy(&b.oid, &stage_data->stages[3].oid);
-
-	return update_stages(opt, path,
-			     is_null_sha1(o.oid.hash) ? NULL : &o,
-			     is_null_sha1(a.oid.hash) ? NULL : &a,
-			     is_null_sha1(b.oid.hash) ? NULL : &b);
-}
-
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1598,7 +1578,6 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	char *path = c1->path; /* == c2->path */
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
-	int ret;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1606,9 +1585,6 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
-
 	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
 				       o->branch1, c1->path,
 				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
@@ -1617,66 +1593,11 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 				       o->branch2, c2->path, &mfi_c2))
 		return -1;
 
-	if (o->call_depth) {
-		/*
-		 * If mfi_c1.clean && mfi_c2.clean, then it might make
-		 * sense to do a two-way merge of those results.  But, I
-		 * think in all cases, it makes sense to have the virtual
-		 * merge base just undo the renames; they can be detected
-		 * again later for the non-recursive merge.
-		 */
-		remove_file(o, 0, path, 0);
-		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
-		if (!ret)
-			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  b->path);
-	} else {
-		char *new_path1 = unique_path(o, path, ci->branch1);
-		char *new_path2 = unique_path(o, path, ci->branch2);
-		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
-		       a->path, new_path1, b->path, new_path2);
-		if (was_dirty(o, path))
-			output(o, 1, _("Refusing to lose dirty file at %s"),
-			       path);
-		else if (would_lose_untracked(path))
-			/*
-			 * Only way we get here is if both renames were from
-			 * a directory rename AND user had an untracked file
-			 * at the location where both files end up after the
-			 * two directory renames.  See testcase 10d of t6043.
-			 */
-			output(o, 1, _("Refusing to lose untracked file at "
-				       "%s, even though it's in the way."),
-			       path);
-		else
-			remove_file(o, 0, path, 0);
-		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
-		if (!ret)
-			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  new_path2);
-		/*
-		 * unpack_trees() actually populates the index for us for
-		 * "normal" rename/rename(2to1) situtations so that the
-		 * correct entries are at the higher stages, which would
-		 * make the call below to update_stages_for_stage_data
-		 * unnecessary.  However, if either of the renames came
-		 * from a directory rename, then unpack_trees() will not
-		 * have gotten the right data loaded into the index, so we
-		 * need to do so now.  (While it'd be tempting to move this
-		 * call to update_stages_for_stage_data() to
-		 * apply_directory_rename_modifications(), that would break
-		 * our intermediate calls to would_lose_untracked() since
-		 * those rely on the current in-memory index.  See also the
-		 * big "NOTE" in update_stages()).
-		 */
-		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
-			ret = -1;
-
-		free(new_path2);
-		free(new_path1);
-	}
-
-	return ret;
+	return handle_file_collision(o, path, a->path, b->path,
+				     ci->branch1, ci->branch2,
+				     &mfi_c1.oid, mfi_c1.mode,
+				     &mfi_c2.oid, mfi_c2.mode,
+				     !mfi_c1.clean || !mfi_c2.clean);
 }
 
 /*
@@ -3034,9 +2955,14 @@ static int process_entry(struct merge_options *o,
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
-			clean_merge = 0;
-			if (conflict_rename_rename_2to1(o, conflict_info))
-				clean_merge = -1;
+			/*
+			 * Probably unclean merge, but if the two renamed
+			 * files merge cleanly and the two resulting files
+			 * can then be two-way merged cleanly, I guess it's
+			 * a clean merge?
+			 */
+			clean_merge = conflict_rename_rename_2to1(o,
+								  conflict_info);
 			break;
 		default:
 			entry->processed = 0;
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index d8fe797f0d..b0b840223b 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -358,7 +358,7 @@ test_expect_success 'setup rename/rename (2to1) + modify/modify' '
 	git init &&
 
 	printf "1\n2\n3\n4\n5\n" >a &&
-	printf "5\n4\n3\n2\n1\n" >b &&
+	printf "9\n8\n7\n6\n5\n" >b &&
 	git add a b &&
 	git commit -m A &&
 	git tag A &&
-- 
2.15.0.46.g41dca04efb

