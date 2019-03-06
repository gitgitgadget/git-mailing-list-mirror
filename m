Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92348202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 00:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfCFA2Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 19:28:16 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50694 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfCFA2Q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Mar 2019 19:28:16 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x260RWGc021469;
        Tue, 5 Mar 2019 16:27:52 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qyqkr4e3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 05 Mar 2019 16:27:52 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Mar 2019 19:27:49 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 5 Mar 2019 19:27:49 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 36AA5221624D;
        Tue,  5 Mar 2019 16:27:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit that moves fewer files
Date:   Tue, 5 Mar 2019 16:27:44 -0800
Message-ID: <20190306002744.14418-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.19.g5671d8e416
In-Reply-To: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 2, 2019 at 5:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Whatever we choose for the default could be tweaked by some new option
> > (e.g. make it less noisy or don't mark such paths as conflicted if the
> > user has explicitly stated their preference for or against directory
> > rename detection).  I'm struggling to see directory rename detection
> > as "risky" (though I certainly feel that lack of it is and thus do not
> > like the opt-in option), but if others feel there is risk here,
>
> I do not think it matters what "others feel" at all.
>
> The simple fact that we are seeing a bug report that started this
> thread is enough to say that the heuristics kick in when the end
> users do not expect to and when it happens it is harder to explain
> than other kinds of rename detection heuristics.
>

Alright, here is a patch to change the default, explaining the history
and updating t6043 (directory rename tests) accordingly.

The following patch does not apply to master, due to building on
jk/unused-params; let me know if you want to see a backport.  I built
on jk/unused-params and partially reverted one of its patches (because
now there is a use for one of the parameters it removed), so that it
could apply cleanly to next and pu.


-- 8< --
Subject: [PATCH] merge-recursive: switch directory rename detection default

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
directory rename detection, and default to (C).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/merge.txt      |  19 +++-
 merge-recursive.c                   |  83 +++++++++-----
 t/t3401-rebase-and-am-rename.sh     |   8 +-
 t/t6043-merge-rename-directories.sh | 171 +++++++++++++++++++---------
 4 files changed, 195 insertions(+), 86 deletions(-)

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
index f270fa66f3..042548eeec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1402,39 +1402,62 @@ static int merge_mode_and_contents(struct merge_options *o,
 
 static int handle_rename_via_dir(struct merge_options *o,
 				 struct diff_filepair *pair,
-				 const char *rename_branch)
+				 const char *rename_branch,
+				 const char *other_branch)
 {
 	/*
 	 * Handle file adds that need to be renamed due to directory rename
-	 * detection.  This differs from handle_rename_normal, because
-	 * there is no content merge to do; just move the file into the
-	 * desired final location.
+	 * detection, based on the setting of o->detect_directory_renames:
+	 *   o->detect_directory_renames == 0: never use directory renames
+	 *   o->detect_directory_renames == 1: report directory conflict
+	 *   o->detect_directory_renames == 2: always use directory renames
+	 * However, this function will not even be called when the value is
+	 * 0, so we only have to worry about values of 1 and 2.
+	 *
+	 * This function differs from handle_rename_normal, because there
+	 * is no content merge to do; we can just mark the file as
+	 * conflicted and/or move the file into the desired final location.
 	 */
 	const struct diff_filespec *dest = pair->two;
-
+	char *file_path = dest->path;
+	int mark_conflicted = (o->detect_directory_renames == 1);
+
+	if (mark_conflicted)
+		output(o, 1, _("CONFLICT (directory possibly renamed): %s "
+			       "added in %s, but that directory was renamed "
+			       "in %s suggesting it should perhaps be moved "
+			       "to %s."),
+		       pair->one->path, other_branch, rename_branch,
+		       dest->path);
 	if (!o->call_depth && would_lose_untracked(o, dest->path)) {
-		char *alt_path = unique_path(o, dest->path, rename_branch);
-
+		mark_conflicted = 1;
+		file_path = unique_path(o, dest->path, rename_branch);
 		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
 			       "writing to %s instead."),
-		       dest->path, alt_path);
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
-		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+		if (update_file(o, 0, &dest->oid, dest->mode, file_path))
 			return -1;
-		free(alt_path);
-		return update_stages(o, dest->path, NULL,
-				     rename_branch == o->branch1 ? dest : NULL,
-				     rename_branch == o->branch1 ? NULL : dest);
+		if (update_stages(o, dest->path, NULL,
+				  rename_branch == o->branch1 ? dest : NULL,
+				  rename_branch == o->branch1 ? NULL : dest))
+			return -1;
+		if (file_path != dest->path)
+			free(file_path);
+		return 0; /* not clean, but conflicted */
+	} else {
+		/* Update dest->path both in index and in worktree */
+		if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
+			return -1;
+		return 1; /* clean */
 	}
-
-	/* Update dest->path both in index and in worktree */
-	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
-		return -1;
-	return 0;
 }
 
 static int handle_change_delete(struct merge_options *o,
@@ -3261,11 +3284,10 @@ static int process_entry(struct merge_options *o,
 							   conflict_info);
 			break;
 		case RENAME_VIA_DIR:
-			clean_merge = 1;
-			if (handle_rename_via_dir(o,
-						  conflict_info->pair1,
-						  conflict_info->branch1))
-				clean_merge = -1;
+			clean_merge = handle_rename_via_dir(o,
+							    conflict_info->pair1,
+							    conflict_info->branch1,
+							    conflict_info->branch2);
 			break;
 		case RENAME_ADD:
 			/*
@@ -3681,6 +3703,15 @@ static void merge_recursive_config(struct merge_options *o)
 		o->merge_detect_rename = git_config_rename("merge.renames", value);
 		free(value);
 	}
+	if (!git_config_get_string("merge.directoryrenames", &value)) {
+		if (!strcasecmp(value, "true"))
+			o->detect_directory_renames = 2;
+		if (!strcasecmp(value, "false"))
+			o->detect_directory_renames = 0;
+		if (!strcasecmp(value, "conflict"))
+			o->detect_directory_renames = 1;
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
index 62c564707b..1048ec2cac 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -75,7 +75,7 @@ test_expect_success '1a-check: Simple directory rename detection' '
 
 		git checkout A^0 &&
 
-		git merge -s recursive B^0 &&
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
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
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
 
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
@@ -3946,7 +3946,7 @@ test_expect_success '12b-check: Moving one directory hierarchy into another' '
 
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
@@ -4051,4 +4051,69 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 	)
 '
 
+# Testcase 12d, Basic directory rename with default "conflict" setting
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d,e/f}
+#   Expected: y/{b,c,d,e/f}, with both y/d and y/e/f marked as conflicted
+
+test_expect_success '12d-setup: Conflict handling for default setting' '
+	test_create_repo 12d &&
+	(
+		cd 12d &&
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
+test_expect_success '12d-check: Conflict handling for default setting' '
+	(
+		cd 12d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c :3:y/d :3:y/e/f &&
+		git rev-parse >expect \
+			O:z/b    O:z/c    B:z/d    B:z/e/f &&
+		test_cmp expect actual &&
+
+		git hash-object y/d >actual &&
+		git rev-parse B:z/d >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:z/d &&
+		test_must_fail git rev-parse HEAD:z/e/f &&
+		test_path_is_missing z/d &&
+		test_path_is_missing z/e/f
+	)
+'
+
 test_done
-- 
2.21.0.rc1.19.g5671d8e416

