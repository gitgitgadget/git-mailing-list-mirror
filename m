Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB19D20248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfDEPBJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:09 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40226 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbfDEPBH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:01:07 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwSo0001751;
        Fri, 5 Apr 2019 08:00:49 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg324g4c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:48 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 5 Apr 2019 08:00:40 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 5 Apr 2019 08:00:40 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id BCB81220CB33;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 15/15] merge-recursive: switch directory rename detection default
Date:   Fri, 5 Apr 2019 08:00:26 -0700
Message-ID: <20190405150026.5260-16-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When all of x/a, x/b, and x/c have moved to z/a, z/b, and z/c on one
branch, there is a question about whether x/d added on a different
branch should remain at x/d or appear at z/d when the two branches are
merged.  There are different possible viewpoints here:

  A) The file was placed at x/d; it's unrelated to the other files in
     x/ so it doesn't matter that all the files from x/ moved to z/ on
     one branch; x/d should still remain at x/d.

  B) x/d is related to the other files in x/, and x/ was renamed to z/;
     therefore x/d should be moved to z/d.

Since there was no ability to detect directory renames prior to
git-2.18, users experienced (A) regardless of context.  Choice (B) was
implemented in git-2.18, with no option to go back to (A), and has been
in use since.  However, one user reported that the merge results did not
match their expectations, making the change of default problematic,
especially since there was no notice printed when directory rename
detection moved files.

Note that there is also a third possibility here:

  C) There are different answers depending on the context and content
     that cannot be determined by git, so this is a conflict.  Use a
     higher stage in the index to record the conflict and notify the
     user of the potential issue instead of silently selecting a
     resolution for them.

Add an option for users to specify their preference for whether to use
directory rename detection, and default to (C).  Even when directory
rename detection is on, add notice messages about files moved into new
directories.

As a sidenote, x/d did not have to be a new file here; it could have
already existed at some other path and been renamed to x/d, with
directory rename detection just renaming it again to z/d.  Thus, it's
not just new files, but also a modification to all rename types (normal
renames, rename/add, rename/delete, rename/rename(1to1),
rename/rename(1to2), and rename/rename(2to1)).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/merge.txt         |  19 +-
 merge-recursive.c                      | 146 ++++++--
 t/t3401-rebase-and-am-rename.sh        |   8 +-
 t/t6043-merge-rename-directories.sh    | 458 ++++++++++++++++++++++---
 t/t6046-merge-skip-unneeded-updates.sh |   8 +-
 5 files changed, 552 insertions(+), 87 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index d389c73929..6a313937f8 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -39,9 +39,22 @@ merge.renameLimit::
 	is turned off.
 
 merge.renames::
-	Whether and how Git detects renames.  If set to "false",
-	rename detection is disabled. If set to "true", basic rename
-	detection is enabled.  Defaults to the value of diff.renames.
+	Whether Git detects renames.  If set to "false", rename detection
+	is disabled. If set to "true", basic rename detection is enabled.
+	Defaults to the value of diff.renames.
+
+merge.directoryRenames::
+	Whether Git detects directory renames, affecting what happens at
+	merge time to new files added to a directory on one side of
+	history when that directory was renamed on the other side of
+	history.  If merge.directoryRenames is set to "false", directory
+	rename detection is disabled, meaning that such new files will be
+	left behind in the old directory.  If set to "true", directory
+	rename detection is enabled, meaning that such new files will be
+	moved into the new directory.  If set to "conflict", a conflict
+	will be reported for such paths.  If merge.renames is false,
+	merge.directoryRenames is ignored and treated as false.  Defaults
+	to "conflict".
 
 merge.renormalize::
 	Tell Git that canonical representation of files in the
diff --git a/merge-recursive.c b/merge-recursive.c
index 2edfa01e43..36af441faa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1370,30 +1370,39 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	 */
 	const struct rename *ren = ci->ren1;
 	const struct diff_filespec *dest = ren->pair->two;
+	char *file_path = dest->path;
+	int mark_conflicted = (opt->detect_directory_renames == 1);
+	assert(ren->dir_rename_original_dest);
 
 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
-		char *alt_path = unique_path(opt, dest->path, ren->branch);
-
+		mark_conflicted = 1;
+		file_path = unique_path(opt, dest->path, ren->branch);
 		output(opt, 1, _("Error: Refusing to lose untracked file at %s; "
-			       "writing to %s instead."),
-		       dest->path, alt_path);
+				 "writing to %s instead."),
+		       dest->path, file_path);
+	}
+
+	if (mark_conflicted) {
 		/*
-		 * Write the file in worktree at alt_path, but not in the
-		 * index.  Instead, write to dest->path for the index but
-		 * only at the higher appropriate stage.
+		 * Write the file in worktree at file_path.  In the index,
+		 * only record the file at dest->path in the appropriate
+		 * higher stage.
 		 */
-		if (update_file(opt, 0, dest, alt_path))
+		if (update_file(opt, 0, dest, file_path))
 			return -1;
-		free(alt_path);
-		return update_stages(opt, dest->path, NULL,
-				     ren->branch == opt->branch1 ? dest : NULL,
-				     ren->branch == opt->branch1 ? NULL : dest);
+		if (file_path != dest->path)
+			free(file_path);
+		if (update_stages(opt, dest->path, NULL,
+				  ren->branch == opt->branch1 ? dest : NULL,
+				  ren->branch == opt->branch1 ? NULL : dest))
+			return -1;
+		return 0; /* not clean, but conflicted */
+	} else {
+		/* Update dest->path both in index and in worktree */
+		if (update_file(opt, 1, dest, dest->path))
+			return -1;
+		return 1; /* clean */
 	}
-
-	/* Update dest->path both in index and in worktree */
-	if (update_file(opt, 1, dest, dest->path))
-		return -1;
-	return 0;
 }
 
 static int handle_change_delete(struct merge_options *opt,
@@ -3090,10 +3099,88 @@ static int handle_rename_normal(struct merge_options *opt,
 				const struct diff_filespec *b,
 				struct rename_conflict_info *ci)
 {
-	/* Merge the content and write it out */
+	struct rename *ren = ci->ren1;
 	struct merge_file_info mfi;
-	return handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
-				    o, a, b, ci);
+	int clean;
+	int side = (ren->branch == opt->branch1 ? 2 : 3);
+
+	/* Merge the content and write it out */
+	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
+				     o, a, b, ci);
+
+	if (clean && opt->detect_directory_renames == 1 &&
+	    ren->dir_rename_original_dest) {
+		if (update_stages(opt, path,
+				  NULL,
+				  side == 2 ? &mfi.blob : NULL,
+				  side == 2 ? NULL : &mfi.blob))
+			return -1;
+		clean = 0; /* not clean, but conflicted */
+	}
+	return clean;
+}
+
+static void dir_rename_warning(const char *msg,
+			       int is_add,
+			       int clean,
+			       struct merge_options *opt,
+			       struct rename *ren)
+{
+	const char *other_branch;
+	other_branch = (ren->branch == opt->branch1 ?
+			opt->branch2 : opt->branch1);
+	if (is_add) {
+		output(opt, clean ? 2 : 1, msg,
+		       ren->pair->one->path, ren->branch,
+		       other_branch, ren->pair->two->path);
+		return;
+	}
+	output(opt, clean ? 2 : 1, msg,
+	       ren->pair->one->path, ren->dir_rename_original_dest, ren->branch,
+	       other_branch, ren->pair->two->path);
+}
+static int warn_about_dir_renamed_entries(struct merge_options *opt,
+					  struct rename *ren)
+{
+	const char *msg;
+	int clean = 1, is_add;
+
+	if (!ren)
+		return clean;
+
+	/* Return early if ren was not affected/created by a directory rename */
+	if (!ren->dir_rename_original_dest)
+		return clean;
+
+	/* Sanity checks */
+	assert(opt->detect_directory_renames > 0);
+	assert(ren->dir_rename_original_type == 'A' ||
+	       ren->dir_rename_original_type == 'R');
+
+	/* Check whether to treat directory renames as a conflict */
+	clean = (opt->detect_directory_renames == 2);
+
+	is_add = (ren->dir_rename_original_type == 'A');
+	if (ren->dir_rename_original_type == 'A' && clean) {
+		msg = _("Path updated: %s added in %s inside a "
+			"directory that was renamed in %s; moving it to %s.");
+	} else if (ren->dir_rename_original_type == 'A' && !clean) {
+		msg = _("CONFLICT (file location): %s added in %s "
+			"inside a directory that was renamed in %s, "
+			"suggesting it should perhaps be moved to %s.");
+	} else if (ren->dir_rename_original_type == 'R' && clean) {
+		msg = _("Path updated: %s renamed to %s in %s, inside a "
+			"directory that was renamed in %s; moving it to %s.");
+	} else if (ren->dir_rename_original_type == 'R' && !clean) {
+		msg = _("CONFLICT (file location): %s renamed to %s in %s, "
+			"inside a directory that was renamed in %s, "
+			"suggesting it should perhaps be moved to %s.");
+	} else {
+		BUG("Impossible dir_rename_original_type/clean combination");
+	}
+	dir_rename_warning(msg, is_add, clean, opt, ren);
+
+	return clean;
 }
 
 /* Per entry merge function */
@@ -3115,6 +3202,10 @@ static int process_entry(struct merge_options *opt,
 	if (entry->rename_conflict_info) {
 		struct rename_conflict_info *ci = entry->rename_conflict_info;
 		struct diff_filespec *temp;
+		int path_clean;
+
+		path_clean = warn_about_dir_renamed_entries(opt, ci->ren1);
+		path_clean &= warn_about_dir_renamed_entries(opt, ci->ren2);
 
 		/*
 		 * For cases with a single rename, {o,a,b}->path have all been
@@ -3135,9 +3226,7 @@ static int process_entry(struct merge_options *opt,
 							   ci);
 			break;
 		case RENAME_VIA_DIR:
-			clean_merge = 1;
-			if (handle_rename_via_dir(opt, ci))
-				clean_merge = -1;
+			clean_merge = handle_rename_via_dir(opt, ci);
 			break;
 		case RENAME_ADD:
 			/*
@@ -3187,6 +3276,8 @@ static int process_entry(struct merge_options *opt,
 			entry->processed = 0;
 			break;
 		}
+		if (path_clean < clean_merge)
+			clean_merge = path_clean;
 	} else if (o_valid && (!a_valid || !b_valid)) {
 		/* Case A: Deleted in one */
 		if ((!a_valid && !b_valid) ||
@@ -3558,6 +3649,15 @@ static void merge_recursive_config(struct merge_options *opt)
 		opt->merge_detect_rename = git_config_rename("merge.renames", value);
 		free(value);
 	}
+	if (!git_config_get_string("merge.directoryrenames", &value)) {
+		int boolval = git_parse_maybe_bool(value);
+		if (0 <= boolval) {
+			opt->detect_directory_renames = boolval ? 2 : 0;
+		} else if (!strcasecmp(value, "conflict")) {
+			opt->detect_directory_renames = 1;
+		} /* avoid erroring on values from future versions of git */
+		free(value);
+	}
 	git_config(git_xmerge_config, NULL);
 }
 
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index e0b5111993..a0b9438b22 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -42,7 +42,7 @@ test_expect_success 'rebase --interactive: directory rename detected' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" git rebase --interactive A &&
+		FAKE_LINES="1" git -c merge.directoryRenames=true rebase --interactive A &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -58,7 +58,7 @@ test_expect_failure 'rebase (am): directory rename detected' '
 
 		git checkout B^0 &&
 
-		git rebase A &&
+		git -c merge.directoryRenames=true rebase A &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -74,7 +74,7 @@ test_expect_success 'rebase --merge: directory rename detected' '
 
 		git checkout B^0 &&
 
-		git rebase --merge A &&
+		git -c merge.directoryRenames=true rebase --merge A &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -92,7 +92,7 @@ test_expect_failure 'am: directory rename detected' '
 
 		git format-patch -1 B &&
 
-		git am --3way 0001*.patch &&
+		git -c merge.directoryRenames=true am --3way 0001*.patch &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index fe205be607..50b7543483 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -75,7 +75,7 @@ test_expect_success '1a-check: Simple directory rename detection' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -142,7 +142,7 @@ test_expect_success '1b-check: Merge a directory with another' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -201,7 +201,7 @@ test_expect_success '1c-check: Transitive renaming' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -270,7 +270,7 @@ test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) con
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 
 		git ls-files -s >out &&
@@ -350,7 +350,7 @@ test_expect_success '1e-check: Renamed directory, with all files being renamed t
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -416,7 +416,7 @@ test_expect_success '1f-check: Split a directory into two other directories' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -497,7 +497,7 @@ test_expect_success '2a-check: Directory split into two on one side, with equal
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT.*directory rename split" out &&
 
 		git ls-files -s >out &&
@@ -559,7 +559,7 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 >out &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -640,7 +640,7 @@ test_expect_success '3a-check: Avoid implicit rename if involved as source on ot
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -705,7 +705,7 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
 		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
 
@@ -826,7 +826,7 @@ test_expect_success '4a-check: Directory split, with original directory still pr
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -915,7 +915,7 @@ test_expect_success '5a-check: Merge directories, other side adds files to origi
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT.*implicit dir rename" out &&
 
 		git ls-files -s >out &&
@@ -989,7 +989,7 @@ test_expect_success '5b-check: Rename/delete in order to get add/add/add conflic
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
 
 		git ls-files -s >out &&
@@ -1069,7 +1069,7 @@ test_expect_success '5c-check: Transitive rename would cause rename/rename/renam
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
 		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
 
@@ -1153,7 +1153,7 @@ test_expect_success '5d-check: Directory/file/file conflict due to directory ren
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
 
 		git ls-files -s >out &&
@@ -1243,7 +1243,7 @@ test_expect_success '6a-check: Tricky rename/delete' '
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
 
 		git ls-files -s >out &&
@@ -1308,7 +1308,7 @@ test_expect_success '6b-check: Same rename done on both sides' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -1370,7 +1370,7 @@ test_expect_success '6c-check: Rename only done on same side' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -1432,7 +1432,7 @@ test_expect_success '6d-check: We do not always want transitive renaming' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -1495,7 +1495,7 @@ test_expect_success '6e-check: Add/add from one side' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -1591,7 +1591,7 @@ test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
 		test_i18ngrep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
 
@@ -1663,7 +1663,7 @@ test_expect_success '7b-check: rename/rename(2to1), but only due to transitive r
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 
 		git ls-files -s >out &&
@@ -1740,7 +1740,7 @@ test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
 
 		git ls-files -s >out &&
@@ -1804,7 +1804,7 @@ test_expect_success '7d-check: transitive rename involved in rename/delete; how
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
 		git ls-files -s >out &&
@@ -1894,7 +1894,7 @@ test_expect_success '7e-check: transitive rename in rename/delete AND dirs in th
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
 		git ls-files -s >out &&
@@ -1985,7 +1985,7 @@ test_expect_success '8a-check: Dual-directory rename, one into the others way' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -2063,7 +2063,7 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -2135,7 +2135,7 @@ test_expect_success '8c-check: modify/delete or rename+modify/delete' '
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
 
 		git ls-files -s >out &&
@@ -2212,7 +2212,7 @@ test_expect_success '8d-check: rename/delete...or not?' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -2287,7 +2287,7 @@ test_expect_success '8e-check: Both sides rename, one side adds to original dire
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
 		test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out &&
 
@@ -2374,7 +2374,7 @@ test_expect_success '9a-check: Inner renamed directory within outer renamed dire
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 7 out &&
@@ -2444,7 +2444,7 @@ test_expect_success '9b-check: Transitive rename with content merge' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -2534,7 +2534,7 @@ test_expect_success '9c-check: Doubly transitive rename?' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 >out &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "WARNING: Avoiding applying x -> z rename to x/f" out &&
 
 		git ls-files -s >out &&
@@ -2622,7 +2622,7 @@ test_expect_success '9d-check: N-way transitive rename?' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 >out &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep "WARNING: Avoiding applying z -> y rename to z/t" out &&
 		test_i18ngrep "WARNING: Avoiding applying y -> x rename to y/a" out &&
 		test_i18ngrep "WARNING: Avoiding applying x -> w rename to x/b" out &&
@@ -2704,7 +2704,7 @@ test_expect_success C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 >out &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		grep "CONFLICT (implicit dir rename): Cannot map more than one path to combined/yo" out >error_line &&
 		grep -q dir1/yo error_line &&
 		grep -q dir2/yo error_line &&
@@ -2782,7 +2782,7 @@ test_expect_success '9f-check: Renamed directory that only contained immediate s
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -2849,7 +2849,7 @@ test_expect_failure '9g-check: Renamed directory that only contained immediate s
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -2918,7 +2918,7 @@ test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -2993,7 +2993,7 @@ test_expect_success '10a-check: Overwrite untracked with normal rename/delete' '
 		echo very >z/c &&
 		echo important >z/d &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "The following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
@@ -3061,7 +3061,7 @@ test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 		echo important >y/d &&
 		echo contents >y/e &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
 		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
 
@@ -3137,7 +3137,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 		git checkout A^0 &&
 		echo important >y/c &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
 
@@ -3174,7 +3174,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 		mkdir y &&
 		echo important >y/c &&
 
-		test_must_fail git merge -s recursive A^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
 
@@ -3249,7 +3249,7 @@ test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 		git checkout A^0 &&
 		echo important >y/wham &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
 
@@ -3327,7 +3327,7 @@ test_expect_failure '10e-check: Does git complain about untracked file that is n
 		mkdir z &&
 		echo random >z/c &&
 
-		git merge -s recursive B^0 >out 2>err &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
@@ -3407,7 +3407,7 @@ test_expect_success '11a-check: Avoid losing dirty contents with simple rename'
 		git checkout A^0 &&
 		echo stuff >>z/c &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
 		test_seq 1 10 >expected &&
@@ -3479,7 +3479,7 @@ test_expect_success '11b-check: Avoid losing dirty file involved in directory re
 		git checkout A^0 &&
 		echo stuff >>z/c &&
 
-		git merge -s recursive B^0 >out 2>err &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
 		grep -q stuff z/c &&
@@ -3554,7 +3554,7 @@ test_expect_success '11c-check: Avoid losing not-uptodate with rename + D/F conf
 		git checkout A^0 &&
 		echo stuff >>y/c &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "following files would be overwritten by merge" err &&
 
 		grep -q stuff y/c &&
@@ -3621,7 +3621,7 @@ test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conf
 		git checkout A^0 &&
 		echo stuff >>z/c &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
 
 		grep -q stuff z/c &&
@@ -3700,7 +3700,7 @@ test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rena
 		git checkout A^0 &&
 		echo mods >>y/c &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 		test_i18ngrep "Refusing to lose dirty file at y/c" out &&
 
@@ -3782,7 +3782,7 @@ test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rena
 		git checkout A^0 &&
 		echo important >>y/wham &&
 
-		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 		test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
 
@@ -3870,7 +3870,7 @@ test_expect_success '12a-check: Moving one directory hierarchy into another' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -3946,7 +3946,7 @@ test_expect_success '12b-check: Moving two directory hierarchies into each other
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -4016,7 +4016,7 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 
 		git checkout A^0 &&
 
-		test_must_fail git merge -s recursive B^0 &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
 		git ls-files -u >out &&
 		test_line_count = 12 out &&
@@ -4051,4 +4051,356 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 	)
 '
 
+###########################################################################
+# SECTION 13: Checking informational and conflict messages
+#
+# A year after directory rename detection became the default, it was
+# instead decided to report conflicts on the pathname on the basis that
+# some users may expect the new files added or moved into a directory to
+# be unrelated to all the other files in that directory, and thus that
+# directory rename detection is unexpected.  Test that the messages printed
+# match our expectation.
+###########################################################################
+
+# Testcase 13a, Basic directory rename with newly added files
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d,e/f}
+#   Expected: y/{b,c,d,e/f}, with notices/conflicts for both y/d and y/e/f
+
+test_expect_success '13a-setup: messages for newly added files' '
+	test_create_repo 13a &&
+	(
+		cd 13a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo d >z/d &&
+		mkdir z/e &&
+		echo f >z/e/f &&
+		git add z/d z/e/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '13a-check(conflict): messages for newly added files' '
+	(
+		cd 13a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep CONFLICT..file.location.*z/e/f.added.in.B^0.*y/e/f out &&
+		test_i18ngrep CONFLICT..file.location.*z/d.added.in.B^0.*y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/[de]" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d &&
+		test_path_is_missing z/e/f &&
+		test_path_is_file    y/e/f
+	)
+'
+
+test_expect_success '13a-check(info): messages for newly added files' '
+	(
+		cd 13a &&
+
+		git reset --hard &&
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep Path.updated:.*z/e/f.added.in.B^0.*y/e/f out &&
+		test_i18ngrep Path.updated:.*z/d.added.in.B^0.*y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/[de]" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d &&
+		test_path_is_missing z/e/f &&
+		test_path_is_file    y/e/f
+	)
+'
+
+# Testcase 13b, Transitive rename with conflicted content merge and default
+#               "conflict" setting
+#   (Related to testcase 1c, 9b)
+#   Commit O: z/{b,c},   x/d_1
+#   Commit A: y/{b,c},   x/d_2
+#   Commit B: z/{b,c,d_3}
+#   Expected: y/{b,c,d_merged}, with two conflict messages for y/d,
+#             one about content, and one about file location
+
+test_expect_success '13b-setup: messages for transitive rename with conflicted content' '
+	test_create_repo 13b &&
+	(
+		cd 13b &&
+
+		mkdir x &&
+		mkdir z &&
+		test_seq 1 10 >x/d &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add x z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		echo 11 >>x/d &&
+		git add x/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo eleven >>x/d &&
+		git mv x/d z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '13b-check(conflict): messages for transitive rename with conflicted content' '
+	(
+		cd 13b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep CONFLICT.*content.*Merge.conflict.in.y/d out &&
+		test_i18ngrep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/d" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d
+	)
+'
+
+test_expect_success '13b-check(info): messages for transitive rename with conflicted content' '
+	(
+		cd 13b &&
+
+		git reset --hard &&
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep CONFLICT.*content.*Merge.conflict.in.y/d out &&
+		test_i18ngrep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/d" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d
+	)
+'
+
+# Testcase 13c, Rename/rename(1to1) due to directory rename
+#   Commit O: z/{b,c},   x/{d,e}
+#   Commit A: y/{b,c,d}, x/e
+#   Commit B: z/{b,c,d}, x/e
+#   Expected: y/{b,c,d}, with info or conflict messages for d (
+#             A: renamed x/d -> z/d; B: renamed z/ -> y/ AND renamed x/d to y/d
+#             One could argue A had partial knowledge of what was done with
+#             d and B had full knowledge, but that's a slippery slope as
+#             shown in testcase 13d.
+
+test_expect_success '13c-setup: messages for rename/rename(1to1) via transitive rename' '
+	test_create_repo 13c &&
+	(
+		cd 13c &&
+
+		mkdir x &&
+		mkdir z &&
+		test_seq 1 10 >x/d &&
+		echo e >x/e &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add x z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		git mv x/d y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '13c-check(conflict): messages for rename/rename(1to1) via transitive rename' '
+	(
+		cd 13c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/d" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d
+	)
+'
+
+test_expect_success '13c-check(info): messages for rename/rename(1to1) via transitive rename' '
+	(
+		cd 13c &&
+
+		git reset --hard &&
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d out &&
+
+		git ls-files >paths &&
+		! grep z/ paths &&
+		grep "y/d" paths &&
+
+		test_path_is_missing z/d &&
+		test_path_is_file    y/d
+	)
+'
+
+# Testcase 13d, Rename/rename(1to1) due to directory rename on both sides
+#   Commit O: a/{z,y}, b/x,     c/w
+#   Commit A: a/z,     b/{y,x}, d/w
+#   Commit B: a/z,     d/x,     c/{y,w}
+#   Expected: a/z, d/{y,x,w} with no file location conflict for x
+#             Easy cases:
+#               * z is always in a; so it stays in a.
+#               * x starts in b, only modified on one side to move into d/
+#               * w starts in c, only modified on one side to move into d/
+#             Hard case:
+#               * A renames a/y to b/y, and B renames b/->d/ => a/y -> d/y
+#               * B renames a/y to c/y, and A renames c/->d/ => a/y -> d/y
+#               No conflict in where a/y ends up, so put it in d/y.
+
+test_expect_success '13d-setup: messages for rename/rename(1to1) via dual transitive rename' '
+	test_create_repo 13d &&
+	(
+		cd 13d &&
+
+		mkdir a &&
+		mkdir b &&
+		mkdir c &&
+		echo z >a/z &&
+		echo y >a/y &&
+		echo x >b/x &&
+		echo w >c/w &&
+		git add a b c &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv a/y b/ &&
+		git mv c/ d/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv a/y c/ &&
+		git mv b/ d/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '13d-check(conflict): messages for rename/rename(1to1) via dual transitive rename' '
+	(
+		cd 13d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep CONFLICT..file.location.*a/y.renamed.to.b/y.*moved.to.d/y out &&
+		test_i18ngrep CONFLICT..file.location.*a/y.renamed.to.c/y.*moved.to.d/y out &&
+
+		git ls-files >paths &&
+		! grep b/ paths &&
+		! grep c/ paths &&
+		grep "d/y" paths &&
+
+		test_path_is_missing b/y &&
+		test_path_is_missing c/y &&
+		test_path_is_file    d/y
+	)
+'
+
+test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual transitive rename' '
+	(
+		cd 13d &&
+
+		git reset --hard &&
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep Path.updated.*a/y.renamed.to.b/y.*moving.it.to.d/y out &&
+		test_i18ngrep Path.updated.*a/y.renamed.to.c/y.*moving.it.to.d/y out &&
+
+		git ls-files >paths &&
+		! grep b/ paths &&
+		! grep c/ paths &&
+		grep "d/y" paths &&
+
+		test_path_is_missing b/y &&
+		test_path_is_missing c/y &&
+		test_path_is_file    d/y
+	)
+'
+
 test_done
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 38e24f787c..3a47623ed3 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -466,7 +466,7 @@ test_expect_success '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout A^0 &&
 
-		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 
 		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
@@ -495,7 +495,7 @@ test_expect_success '3a-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout B^0 &&
 
-		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
 
 		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
@@ -560,7 +560,7 @@ test_expect_success '3b-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout A^0 &&
 
-		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 
 		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
@@ -589,7 +589,7 @@ test_expect_success '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout B^0 &&
 
-		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
 
 		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
-- 
2.21.0.211.g719c25afaf.dirty

