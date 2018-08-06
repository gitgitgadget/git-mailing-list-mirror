Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA98C208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeHGA5H (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:57:07 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43810 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732090AbeHGA5G (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:57:06 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76Mggk8031788;
        Mon, 6 Aug 2018 15:45:50 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kn91kc2cd-1;
        Mon, 06 Aug 2018 15:45:50 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E09C9226E7F3;
        Mon,  6 Aug 2018 15:45:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D6F032CDE73;
        Mon,  6 Aug 2018 15:45:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 1/1] merge-recursive: make file/directory conflicts easier to resolve
Date:   Mon,  6 Aug 2018 15:45:47 -0700
Message-Id: <20180806224547.8619-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g44d6daf40a.dirty
In-Reply-To: <20180806224547.8619-1-newren@gmail.com>
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224547.8619-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

File/directory conflicts are somewhat difficult to resolve; by way of
contrast, renames are much easier to handle.  For file/directory
conflicts, we already have to record the file under a different name in
the working copy due to the directory being in the way; if we also record
the file under a different name in the index then it simplifies matters
for the user, and ensures that 'git reset --hard' and 'git merge --abort'
will clean up files created by the merge operation.

Note that there are multiple ways to get a file/directory conflict:
  * add/add (one side adds a file, the other a directory)
  * modify/delete (the side that deletes puts a directory in the way)
  * rename vs add-directory (directory added on one side in way of rename=
)
As such, there are multiple code paths that need updating.

FIXME: Several testcases were updated to show how this affected the
  testsuite in general, but there are still 11 more tests across five
  testfiles that need fixing.  As I said, this is just WIP/RFC.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 38 ++++++++++++++++++++++------
 t/t3030-merge-recursive.sh           | 16 ++++++------
 t/t6020-merge-df.sh                  |  4 +--
 t/t6022-merge-rename.sh              |  4 +--
 t/t6036-recursive-corner-cases.sh    |  5 ++--
 t/t6042-merge-rename-corner-cases.sh |  4 +--
 t/t6043-merge-rename-directories.sh  |  4 +--
 7 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1446e92bea..34906b0f90 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1527,6 +1527,20 @@ static int handle_change_delete(struct merge_optio=
ns *o,
 		 * path.  We could call update_file_flags() with update_cache=3D0
 		 * and update_wd=3D0, but that's a no-op.
 		 */
+		if (!o->call_depth && alt_path) {
+			struct diff_filespec orig, new;
+			int stage =3D (change_branch =3D=3D o->branch1) ? 2 : 3;
+
+			remove_file_from_cache(path);
+			orig.mode =3D o_mode;
+			oidcpy(&orig.oid, o_oid);
+			new.mode =3D changed_mode;
+			oidcpy(&new.oid, changed_oid);
+			if (update_stages(o, alt_path, &orig,
+					  stage =3D=3D 2 ? &new : NULL,
+					  stage =3D=3D 3 ? &new : NULL))
+				ret =3D -1;
+		}
 		if (change_branch !=3D o->branch1 || alt_path)
 			ret =3D update_file(o, 0, changed_oid, changed_mode, update_path);
 	}
@@ -3089,11 +3103,11 @@ static int merge_content(struct merge_options *o,
=20
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
-		if (o->call_depth) {
-			remove_file_from_cache(path);
-		} else {
+		new_path =3D unique_path(o, path, rename_conflict_info->branch1);
+		remove_file_from_cache(path);
+		if (!o->call_depth) {
 			if (!mfi.clean) {
-				if (update_stages(o, path, &one, &a, &b))
+				if (update_stages(o, new_path, &one, &a, &b))
 					return -1;
 			} else {
 				int file_from_stage2 =3D was_tracked(o, path);
@@ -3101,14 +3115,13 @@ static int merge_content(struct merge_options *o,
 				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode =3D mfi.mode;
=20
-				if (update_stages(o, path, NULL,
+				if (update_stages(o, new_path, NULL,
 						  file_from_stage2 ? &merged : NULL,
 						  file_from_stage2 ? NULL : &merged))
 					return -1;
 			}
=20
 		}
-		new_path =3D unique_path(o, path, rename_conflict_info->branch1);
 		if (is_dirty) {
 			output(o, 1, _("Refusing to lose dirty file at %s"),
 			       path);
@@ -3244,10 +3257,19 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %=
s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
+			remove_file_from_cache(path);
+			if (!o->call_depth) {
+				struct diff_filespec dfs;
+
+				dfs.mode =3D mode;
+				oidcpy(&dfs.oid, oid);
+				if (update_stages(o, new_path, NULL,
+						  a_oid ? &dfs : NULL,
+						  a_oid ? NULL : &dfs))
+					clean_merge =3D -1;
+			}
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge =3D -1;
-			else if (o->call_depth)
-				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..6d456da001 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -369,9 +369,9 @@ test_expect_success 'merge-recursive d/f conflict res=
ult' '
=20
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a" &&
-		echo "100644 $o1 2	a" &&
 		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 1	a~$c1" &&
+		echo "100644 $o1 2	a~$c1" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
@@ -393,9 +393,9 @@ test_expect_success 'merge-recursive d/f conflict res=
ult the other way' '
=20
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a" &&
-		echo "100644 $o1 3	a" &&
 		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 1	a~$c1" &&
+		echo "100644 $o1 3	a~$c1" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
@@ -420,9 +420,9 @@ test_expect_success 'merge-recursive d/f conflict res=
ult' '
 		echo "100644 $o1 0	a" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
-		echo "100644 $o6 3	d" &&
 		echo "100644 $o0 1	d/e" &&
-		echo "100644 $o1 2	d/e"
+		echo "100644 $o1 2	d/e" &&
+		echo "100644 $o6 3	d~$c6"
 	) >expected &&
 	test_cmp expected actual
=20
@@ -444,9 +444,9 @@ test_expect_success 'merge-recursive d/f conflict res=
ult' '
 		echo "100644 $o1 0	a" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
-		echo "100644 $o6 2	d" &&
 		echo "100644 $o0 1	d/e" &&
-		echo "100644 $o1 3	d/e"
+		echo "100644 $o1 3	d/e" &&
+		echo "100644 $o6 2	d~$c6"
 	) >expected &&
 	test_cmp expected actual
=20
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 2af1beec5f..f4ea318ec8 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -81,7 +81,7 @@ test_expect_success 'modify/delete + directory/file con=
flict' '
=20
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 4 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
=20
 	test -f letters/file &&
 	test -f letters.txt &&
@@ -100,7 +100,7 @@ test_expect_success 'modify/delete + directory/file c=
onflict; other way' '
=20
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 4 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
=20
 	test -f letters/file &&
 	test -f letters.txt &&
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b760c223c6..0ea3760265 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -385,7 +385,7 @@ test_expect_success 'Rename+D/F conflict; renamed fil=
e cannot merge and dir in t
 	test_must_fail git merge --strategy=3Drecursive dir-in-way &&
=20
 	test 5 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &=
&
+	test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
=20
 	test_must_fail git diff --quiet &&
@@ -421,7 +421,7 @@ test_expect_success 'Same as previous, but merged oth=
er way' '
 	test_must_fail git merge --strategy=3Drecursive renamed-file-has-confli=
cts &&
=20
 	test 5 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &=
&
+	test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)" =
&&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
=20
 	test_must_fail git diff --quiet &&
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner=
-cases.sh
index 59e52c5a09..f8790e6975 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -471,7 +471,7 @@ test_expect_success 'setup differently handled merges=
 of directory/file conflict
 		test_must_fail git merge C^0 &&
 		git clean -fd &&
 		git rm -rf a/ &&
-		git rm a &&
+		git rm a~HEAD &&
 		git cat-file -p B:a >a2 &&
 		git add a2 &&
 		git commit -m D2 &&
@@ -492,6 +492,7 @@ test_expect_success 'setup differently handled merges=
 of directory/file conflict
 		test_must_fail git merge B^0 &&
 		git clean -fd &&
 		git rm -rf a/ &&
+		git rm a~B^0 &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a &&
 		git add a &&
 		git commit -m E3 &&
@@ -501,7 +502,7 @@ test_expect_success 'setup differently handled merges=
 of directory/file conflict
 		test_must_fail git merge B^0 &&
 		git clean -fd &&
 		git rm -rf a/ &&
-		git rm a &&
+		git rm a~B^0 &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a2 &&
 		git add a2 &&
 		git commit -m E4 &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-=
corner-cases.sh
index 07dd09d985..25cb50478c 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -305,14 +305,14 @@ test_expect_success 'rename/directory conflict + cl=
ean content merge' '
 		git ls-files -u >out &&
 		test_line_count =3D 1 out &&
 		git ls-files -o >out &&
-		test_line_count =3D 2 out &&
+		test_line_count =3D 1 out &&
=20
 		echo 0 >expect &&
 		git cat-file -p base:file >>expect &&
 		echo 7 >>expect &&
 		test_cmp expect newfile~HEAD &&
=20
-		test $(git rev-parse :2:newfile) =3D $(git hash-object expect) &&
+		test $(git rev-parse :2:newfile~HEAD) =3D $(git hash-object expect) &&
=20
 		test_path_is_file newfile/realfile &&
 		test_path_is_file newfile~HEAD
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 4a71f17edd..12047a3309 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1160,10 +1160,10 @@ test_expect_success '5d-check: Directory/file/fil=
e conflict due to directory ren
 		git ls-files -u >out &&
 		test_line_count =3D 1 out &&
 		git ls-files -o >out &&
-		test_line_count =3D 2 out &&
+		test_line_count =3D 1 out &&
=20
 		git rev-parse >actual \
-			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
+			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d~HEAD :0:y/d/e &&
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:z/d  B:z/f  A:y/d  B:y/d/e &&
 		test_cmp expect actual &&
--=20
2.18.0.550.g44d6daf40a.dirty

