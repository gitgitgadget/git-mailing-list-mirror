Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF0F1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCERMn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:12:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43462 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752017AbeCERMk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Mar 2018 12:12:40 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25H2t89032300;
        Mon, 5 Mar 2018 09:11:27 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gfsfqk1wb-1;
        Mon, 05 Mar 2018 09:11:26 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 629102215E02;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4F41D2CDE69;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Somebody <somebody@ex.com>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/5] merge-recursive: improve handling for add/add conflicts
Date:   Mon,  5 Mar 2018 09:11:25 -0800
Message-Id: <20180305171125.22331-6-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.41.g6a66043158
In-Reply-To: <20180305171125.22331-1-newren@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803050199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes add/add conflicts use the new handle_file_collision()
function.  This leaves the handling of the index the same, but
modifies how the working tree is handled: instead of always doing
a two-way merge of the file contents and recording them at the
collision path name, we instead first estimate the similarity of the
two files involved.  If they are not similar, we instead record the
file contents into two separate files for the user to inspect.

Several testcases had to be modified to either expect files to be
written to different locations, or for the two test colliding files
to be modified so that they were similar.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 25 ++++++++++++++++++++-----
 t/t2023-checkout-m.sh                |  2 +-
 t/t3418-rebase-continue.sh           | 27 +++++++++++++++++++++++----
 t/t3504-cherry-pick-rerere.sh        | 19 ++++++++++++++-----
 t/t4200-rerere.sh                    | 12 ++++++------
 t/t6020-merge-df.sh                  |  4 ++--
 t/t6024-recursive-merge.sh           | 35 +++++++++++++++++++++---------=
-----
 t/t6025-merge-symlinks.sh            |  9 ++++++---
 t/t6031-merge-filemode.sh            |  4 ++--
 t/t6042-merge-rename-corner-cases.sh |  2 +-
 t/t6043-merge-rename-directories.sh  | 15 ++++++++-------
 t/t7060-wtstatus.sh                  |  1 +
 t/t7064-wtstatus-pv2.sh              |  4 ++--
 t/t7506-status-submodule.sh          | 11 +++++++----
 t/t7610-mergetool.sh                 | 28 ++++++++++++++--------------
 15 files changed, 128 insertions(+), 70 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 96f0e9cee2..edba4fb11c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3070,11 +3070,26 @@ static int process_entry(struct merge_options *o,
 				clean_merge =3D -1;
 		}
 	} else if (a_oid && b_oid) {
-		/* Case C: Added in both (check for same permissions) and */
-		/* case D: Modified in both, but differently. */
-		clean_merge =3D merge_content(o, path, 0 /* file_in_way */,
-					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-					    NULL);
+		if (!o_oid) {
+			/* Case C: Added in both (check for same permissions) */
+			output(o, 1,
+			       _("CONFLICT (add/add): Merge conflict in %s"),
+			       path);
+			clean_merge =3D handle_file_collision(o,
+							    path, NULL, NULL,
+							    o->branch1,
+							    o->branch2,
+							    a_oid, a_mode,
+							    b_oid, b_mode,
+							    0);
+		} else
+			/* case D: Modified in both, but differently. */
+			clean_merge =3D merge_content(o, path,
+						    0 /* file_in_way */,
+						    o_oid, o_mode,
+						    a_oid, a_mode,
+						    b_oid, b_mode,
+						    NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
 		/*
 		 * this entry was deleted altogether. a_mode =3D=3D 0 means
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 7e18985134..2f8ea52318 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -27,7 +27,7 @@ clean_branchnames () {
 }
=20
 test_expect_success '-m restores 2-way conflicted+resolved file' '
-	cp each.txt each.txt.conflicted &&
+	test_must_fail git merge-file -p each.txt~HEAD /dev/null each.txt~maste=
r >each.txt.conflicted &&
 	echo resolved >each.txt &&
 	git add each.txt &&
 	git checkout -m -- each.txt &&
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 7c91a85f43..cf3a82d512 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -10,10 +10,17 @@ set_fake_editor
=20
 test_expect_success 'setup' '
 	test_commit "commit-new-file-F1" F1 1 &&
-	test_commit "commit-new-file-F2" F2 2 &&
+	printf "1\n2\n2\n" >F2 &&
+	git add F2 &&
+	test_tick &&
+	git commit -m "commit-new-file-F2" &&
=20
 	git checkout -b topic HEAD^ &&
-	test_commit "commit-new-file-F2-on-topic-branch" F2 22 &&
+	printf "1\n2\n22\n" >F2 &&
+	git add F2 &&
+	test_tick &&
+	git commit -m "commit-new-file-F2-on-topic-branch" &&
+	git tag "commit-new-file-F2-on-topic-branch" &&
=20
 	git checkout master
 '
@@ -48,7 +55,13 @@ test_expect_success 'rebase --continue can not be used=
 with other options' '
 test_expect_success 'rebase --continue remembers merge strategy and opti=
ons' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F2-on-topic-branch &&
-	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
+
+	printf "1\n2\n32\n" >F3 &&
+	git add F3 &&
+	test_tick &&
+	git commit -m "commit-new-file-F3-on-topic-branch" &&
+	git tag "commit-new-file-F3-on-topic-branch" &&
+
 	test_when_finished "rm -fr test-bin funny.was.run" &&
 	mkdir test-bin &&
 	cat >test-bin/git-merge-funny <<-EOF &&
@@ -92,7 +105,13 @@ test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
 	git checkout master &&
-	test_commit "commit-new-file-F3" F3 3 &&
+
+	printf "1\n2\n3\n" >F3 &&
+	git add F3 &&
+	test_tick &&
+	git commit -m "commit-new-file-F3" &&
+	git tag "commit-new-file-F3" &&
+
 	test_config rerere.enabled true &&
 	test_must_fail git rebase -m master topic &&
 	echo "Resolved" >F2 &&
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.s=
h
index a267b2d144..444ab06ad1 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -4,14 +4,23 @@ test_description=3D'cherry-pick should rerere for confl=
icts'
=20
 . ./test-lib.sh
=20
+test_basic_commit () {
+	file=3D$2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n$1" >"$2" &&
+	git add "$file" &&
+	test_tick
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
 test_expect_success setup '
-	test_commit foo &&
-	test_commit foo-master foo &&
-	test_commit bar-master bar &&
+	test_basic_commit foo foo &&
+	test_basic_commit foo-master foo &&
+	test_basic_commit bar-master bar &&
=20
 	git checkout -b dev foo &&
-	test_commit foo-dev foo &&
-	test_commit bar-dev bar &&
+	test_basic_commit foo-dev foo &&
+	test_basic_commit bar-dev bar &&
 	git config rerere.enabled true
 '
=20
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index d97d2bebc9..80451907ce 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -280,36 +280,36 @@ test_expect_success 'setup: file2 added differently=
 in two branches' '
 	git reset --hard &&
=20
 	git checkout -b fourth &&
-	echo Hallo >file2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nHallo" >file2 &&
 	git add file2 &&
 	test_tick &&
 	git commit -m version1 &&
=20
 	git checkout third &&
-	echo Bello >file2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nBello" >file2 &&
 	git add file2 &&
 	test_tick &&
 	git commit -m version2 &&
=20
 	test_must_fail git merge fourth &&
-	echo Cello >file2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nCello" >file2 &&
 	git add file2 &&
 	git commit -m resolution
 '
=20
 test_expect_success 'resolution was recorded properly' '
-	echo Cello >expected &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nCello" >expected &&
=20
 	git reset --hard HEAD~2 &&
 	git checkout -b fifth &&
=20
-	echo Hallo >file3 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nHallo" >file3 &&
 	git add file3 &&
 	test_tick &&
 	git commit -m version1 &&
=20
 	git checkout third &&
-	echo Bello >file3 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nBello" >file3 &&
 	git add file3 &&
 	test_tick &&
 	git commit -m version2 &&
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 2af1beec5f..4ee27d2e20 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup modify/delete + directory/fi=
le conflict' '
 	# Throw in letters.txt for sorting order fun
 	# ("letters.txt" sorts between "letters" and "letters/file")
 	echo i >>letters &&
-	echo "version 2" >letters.txt &&
+	printf "1\n2\n3\n4\n5\nversion 2" >letters.txt &&
 	git add letters letters.txt &&
 	git commit -m modified &&
=20
@@ -70,7 +70,7 @@ test_expect_success 'setup modify/delete + directory/fi=
le conflict' '
 	git rm letters &&
 	mkdir letters &&
 	>letters/file &&
-	echo "version 1" >letters.txt &&
+	printf "1\n2\n3\n4\n5\nversion 1" >letters.txt &&
 	git add letters letters.txt &&
 	git commit -m deleted
 '
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 3f59e58dfb..354f70a66f 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -15,47 +15,47 @@ GIT_COMMITTER_DATE=3D"2006-12-12 23:28:00 +0100"
 export GIT_COMMITTER_DATE
=20
 test_expect_success "setup tests" '
-echo 1 > a1 &&
+printf "1\n2\n3\n4\n1\n" > a1 &&
 git add a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:00" git commit -m 1 a1 &&
=20
 git checkout -b A master &&
-echo A > a1 &&
+printf "1\n2\n3\n4\nA\n" > a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:01" git commit -m A a1 &&
=20
 git checkout -b B master &&
-echo B > a1 &&
+printf "1\n2\n3\n4\nB\n" > a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:02" git commit -m B a1 &&
=20
 git checkout -b D A &&
 git rev-parse B > .git/MERGE_HEAD &&
-echo D > a1 &&
+printf "1\n2\n3\n4\nD\n" > a1 &&
 git update-index a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:03" git commit -m D &&
=20
 git symbolic-ref HEAD refs/heads/other &&
-echo 2 > a1 &&
+printf "1\n2\n3\n4\n2\n" > a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:04" git commit -m 2 a1 &&
=20
 git checkout -b C &&
-echo C > a1 &&
+printf "1\n2\n3\n4\nC\n" > a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:05" git commit -m C a1 &&
=20
 git checkout -b E C &&
 git rev-parse B > .git/MERGE_HEAD &&
-echo E > a1 &&
+printf "1\n2\n3\n4\nE\n" > a1 &&
 git update-index a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:06" git commit -m E &&
=20
 git checkout -b G E &&
 git rev-parse A > .git/MERGE_HEAD &&
-echo G > a1 &&
+printf "1\n2\n3\n4\nG\n" > a1 &&
 git update-index a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:07" git commit -m G &&
=20
 git checkout -b F D &&
 git rev-parse C > .git/MERGE_HEAD &&
-echo F > a1 &&
+printf "1\n2\n3\n4\nF\n" > a1 &&
 git update-index a1 &&
 GIT_AUTHOR_DATE=3D"2006-12-12 23:00:08" git commit -m F
 '
@@ -65,6 +65,10 @@ test_expect_success "combined merge conflicts" "
 "
=20
 cat > expect << EOF
+1
+2
+3
+4
 <<<<<<< HEAD
 F
 =3D=3D=3D=3D=3D=3D=3D
@@ -76,9 +80,9 @@ test_expect_success "result contains a conflict" "test_=
cmp expect a1"
=20
 git ls-files --stage > out
 cat > expect << EOF
-100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
-100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
-100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
+100644 a2849e152d46797b83870a479775e980d9a138b1 1	a1
+100644 b1a886a67c3f471cec4d4112a91dc6caa6e3b709 2	a1
+100644 e9d143c719e446df2bafb4b6aba8ed511ecd63b1 3	a1
 EOF
=20
 test_expect_success "virtual trees were processed" "test_cmp expect out"
@@ -87,10 +91,13 @@ test_expect_success 'refuse to merge binary files' '
 	git reset --hard &&
 	printf "\0" > binary-file &&
 	git add binary-file &&
-	git commit -m binary &&
-	git checkout G &&
+	git commit -m initial-binary &&
 	printf "\0\0" > binary-file &&
 	git add binary-file &&
+	git commit -m binary1 &&
+	git checkout -b H HEAD~1 &&
+	printf "\0\0\0" > binary-file &&
+	git add binary-file &&
 	git commit -m binary2 &&
 	test_must_fail git merge F > merge.out 2> merge.err &&
 	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 433c4de08f..08eb85e703 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -37,7 +37,8 @@ test_must_fail git merge master'
=20
 test_expect_success \
 'the merge result must be a file' '
-test -f symlink'
+test -f symlink~HEAD &&
+test -f symlink~master'
=20
 test_expect_success \
 'merge master into b-file, which has a file instead of a symbolic link' =
'
@@ -46,7 +47,8 @@ test_must_fail git merge master'
=20
 test_expect_success \
 'the merge result must be a file' '
-test -f symlink'
+test -f symlink~HEAD &&
+test -f symlink~master'
=20
 test_expect_success \
 'merge b-file, which has a file instead of a symbolic link, into master'=
 '
@@ -56,6 +58,7 @@ test_must_fail git merge b-file'
=20
 test_expect_success \
 'the merge result must be a file' '
-test -f symlink'
+test -f symlink~HEAD &&
+test -f symlink~master'
=20
 test_done
diff --git a/t/t6031-merge-filemode.sh b/t/t6031-merge-filemode.sh
index 7d06461f13..79e77f391f 100755
--- a/t/t6031-merge-filemode.sh
+++ b/t/t6031-merge-filemode.sh
@@ -40,12 +40,12 @@ do_one_mode resolve b1 a1
 test_expect_success 'set up mode change in both branches' '
 	git reset --hard HEAD &&
 	git checkout -b a2 master &&
-	: >file2 &&
+	echo true >file2 &&
 	H=3D$(git hash-object file2) &&
 	test_chmod +x file2 &&
 	git commit -m a2 &&
 	git checkout -b b2 master &&
-	: >file2 &&
+	echo true >file2 &&
 	git add file2 &&
 	git commit -m b2 &&
 	{
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-=
corner-cases.sh
index cf5ea5a0f9..7bd6d64671 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -731,7 +731,7 @@ test_conflicts_with_adds_and_renames() {
 		)
 	'
=20
-	test_expect_failure "check simple $side1/$side2 conflict" '
+	test_expect_success "check simple $side1/$side2 conflict" '
 		(
 			cd simple_${side1}_${side2} &&
=20
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 2e28f2908d..a5560f7d94 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -996,7 +996,7 @@ test_expect_success '5b-check: Rename/delete in order=
 to get add/add/add conflic
 		git ls-files -u >out &&
 		test_line_count =3D 2 out &&
 		git ls-files -o >out &&
-		test_line_count =3D 1 out &&
+		test_line_count =3D 3 out &&
=20
 		git rev-parse >actual \
 			:0:y/b :0:y/c :0:y/e :2:y/d :3:y/d &&
@@ -1005,7 +1005,9 @@ test_expect_success '5b-check: Rename/delete in ord=
er to get add/add/add conflic
 		test_cmp expect actual &&
=20
 		test_must_fail git rev-parse :1:y/d &&
-		test_path_is_file y/d
+		test_path_is_file y/d~HEAD &&
+		test_path_is_file y/d~B^0 &&
+		test_path_is_missing y/d
 	)
 '
=20
@@ -1077,7 +1079,7 @@ test_expect_success '5c-check: Transitive rename wo=
uld cause rename/rename/renam
 		git ls-files -u >out &&
 		test_line_count =3D 6 out &&
 		git ls-files -o >out &&
-		test_line_count =3D 3 out &&
+		test_line_count =3D 5 out &&
=20
 		git rev-parse >actual \
 			:0:y/b :0:y/c :0:y/e &&
@@ -1093,13 +1095,12 @@ test_expect_success '5c-check: Transitive rename =
would cause rename/rename/renam
 		test_cmp expect actual &&
=20
 		git hash-object >actual \
-			w/d~HEAD w/d~B^0 z/d &&
+			w/d~HEAD w/d~B^0 y/d~HEAD y/d~B^0 z/d &&
 		git rev-parse >expect \
-			O:x/d    B:w/d   O:x/d &&
+			O:x/d    B:w/d   A:y/d    B:y/d   O:x/d &&
 		test_cmp expect actual &&
 		test_path_is_missing x/d &&
-		test_path_is_file y/d &&
-		grep -q "<<<<" y/d  # conflict markers should be present
+		test_path_is_missing y/d
 	)
 '
=20
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 53cf42fac1..a7888f9fc3 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -214,6 +214,7 @@ EOF
 	git status --untracked-files=3Dno >actual &&
 	test_i18ncmp expected actual &&
 	git reset --hard &&
+	git clean -f *~* &&
 	git checkout master
 '
=20
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index e319fa2e84..c4d3b1d7e4 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -259,14 +259,14 @@ test_expect_success 'verify AA (add-add) conflict' =
'
=20
 	git branch AA_A master &&
 	git checkout AA_A &&
-	echo "Branch AA_A" >conflict.txt &&
+	printf "1\n2\n3\n4\n5\n6\nBranch AA_A" >conflict.txt &&
 	OID_AA_A=3D$(git hash-object -t blob -- conflict.txt) &&
 	git add conflict.txt &&
 	git commit -m "branch aa_a" &&
=20
 	git branch AA_B master &&
 	git checkout AA_B &&
-	echo "Branch AA_B" >conflict.txt &&
+	printf "1\n2\n3\n4\n5\n6\nBranch AA_B" >conflict.txt &&
 	OID_AA_B=3D$(git hash-object -t blob -- conflict.txt) &&
 	git add conflict.txt &&
 	git commit -m "branch aa_b" &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 9edf6572ed..0514a019be 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -240,6 +240,8 @@ test_expect_success 'status -a clean (empty submodule=
 dir)' '
 cat >status_expect <<\EOF
 AA .gitmodules
 A  sub1
+?? .gitmodules~HEAD
+?? .gitmodules~add_sub1
 EOF
=20
 test_expect_success 'status with merge conflict in .gitmodules' '
@@ -273,7 +275,7 @@ index badaa4c,44f999a..0000000
 --- a/.gitmodules
 +++ b/.gitmodules
 @@@ -1,3 -1,3 +1,9 @@@
-++<<<<<<< HEAD
+++<<<<<<< ours
  +[submodule "sub2"]
  +	path =3D sub2
  +	url =3D ../sub2
@@ -281,7 +283,7 @@ index badaa4c,44f999a..0000000
 + [submodule "sub1"]
 + 	path =3D sub1
 + 	url =3D ../sub1
-++>>>>>>> add_sub1
+++>>>>>>> theirs
 EOF
=20
 cat >diff_submodule_expect <<\EOF
@@ -290,7 +292,7 @@ index badaa4c,44f999a..0000000
 --- a/.gitmodules
 +++ b/.gitmodules
 @@@ -1,3 -1,3 +1,9 @@@
-++<<<<<<< HEAD
+++<<<<<<< ours
  +[submodule "sub2"]
  +	path =3D sub2
  +	url =3D ../sub2
@@ -298,12 +300,13 @@ index badaa4c,44f999a..0000000
 + [submodule "sub1"]
 + 	path =3D sub1
 + 	url =3D ../sub1
-++>>>>>>> add_sub1
+++>>>>>>> theirs
 EOF
=20
 test_expect_success 'diff with merge conflict in .gitmodules' '
 	(
 		cd super &&
+		git checkout -m .gitmodules &&
 		git diff >../diff_actual 2>&1
 	) &&
 	test_cmp diff_expect diff_actual
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 1a430b9c40..71f41fc9a8 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -37,9 +37,9 @@ test_expect_success 'setup' '
 	git checkout -b branch1 master &&
 	git submodule update -N &&
 	echo branch1 change >file1 &&
-	echo branch1 newfile >file2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nbranch1 newfile\n" >file2 &&
 	echo branch1 spaced >"spaced name" &&
-	echo branch1 both added >both &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\nbranch1 both added\n" >both &&
 	echo branch1 change file11 >file11 &&
 	echo branch1 change file13 >file13 &&
 	echo branch1 sub >subdir/file3 &&
@@ -84,9 +84,9 @@ test_expect_success 'setup' '
 	git checkout master &&
 	git submodule update -N &&
 	echo master updated >file1 &&
-	echo master new >file2 &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nmaster new\n" >file2 &&
 	echo master updated spaced >"spaced name" &&
-	echo master both added >both &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\nmaster both added\n" >both &&
 	echo master updated file12 >file12 &&
 	echo master updated file14 >file14 &&
 	echo master new sub >subdir/file3 &&
@@ -139,7 +139,7 @@ test_expect_success 'custom mergetool' '
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
 	test "$(cat file1)" =3D "master updated" &&
-	test "$(cat file2)" =3D "master new" &&
+	test "$(git hash-object file2)" =3D "$(git rev-parse master:file2)" &&
 	test "$(cat subdir/file3)" =3D "master new sub" &&
 	test "$(cat submod/bar)" =3D "branch1 submodule" &&
 	git commit -m "branch1 resolved with mergetool"
@@ -163,7 +163,7 @@ test_expect_success 'mergetool crlf' '
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod >/dev/null 2>&1 ) &&
 	test "$(printf x | cat file1 -)" =3D "$(printf "master updated\r\nx")" =
&&
-	test "$(printf x | cat file2 -)" =3D "$(printf "master new\r\nx")" &&
+	test "$(printf x | cat file2 -)" =3D "$(printf "1\r\n2\r\n3\r\n4\r\n5\r=
\n6\r\n7\r\n8\r\n9\r\nmaster new\r\nx")" &&
 	test "$(printf x | cat subdir/file3 -)" =3D "$(printf "master new sub\r=
\nx")" &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" =3D "master submodule" &&
@@ -171,7 +171,7 @@ test_expect_success 'mergetool crlf' '
 '
=20
 test_expect_success 'mergetool in subdir' '
-	test_when_finished "git reset --hard" &&
+	test_when_finished "git reset --hard && git clean -f" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -183,7 +183,7 @@ test_expect_success 'mergetool in subdir' '
 '
=20
 test_expect_success 'mergetool on file in parent dir' '
-	test_when_finished "git reset --hard" &&
+	test_when_finished "git reset --hard && git clean -f" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -197,14 +197,14 @@ test_expect_success 'mergetool on file in parent di=
r' '
 		( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 		( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
 		test "$(cat ../file1)" =3D "master updated" &&
-		test "$(cat ../file2)" =3D "master new" &&
+		test "$(git hash-object ../file2)" =3D "$(git rev-parse master:file2)"=
 &&
 		test "$(cat ../submod/bar)" =3D "branch1 submodule" &&
 		git commit -m "branch1 resolved with mergetool - subdir"
 	)
 '
=20
 test_expect_success 'mergetool skips autoresolved' '
-	test_when_finished "git reset --hard" &&
+	test_when_finished "git reset --hard && git clean -f" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
@@ -217,7 +217,7 @@ test_expect_success 'mergetool skips autoresolved' '
 '
=20
 test_expect_success 'mergetool merges all from subdir (rerere disabled)'=
 '
-	test_when_finished "git reset --hard" &&
+	test_when_finished "git reset --hard && git clean -f" &&
 	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled false &&
 	(
@@ -226,7 +226,7 @@ test_expect_success 'mergetool merges all from subdir=
 (rerere disabled)' '
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
 		test "$(cat ../file1)" =3D "master updated" &&
-		test "$(cat ../file2)" =3D "master new" &&
+		test "$(git hash-object ../file2)" =3D "$(git rev-parse master:file2)"=
 &&
 		test "$(cat file3)" =3D "master new sub" &&
 		( cd .. && git submodule update -N ) &&
 		test "$(cat ../submod/bar)" =3D "master submodule" &&
@@ -245,7 +245,7 @@ test_expect_success 'mergetool merges all from subdir=
 (rerere enabled)' '
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
 		test "$(cat ../file1)" =3D "master updated" &&
-		test "$(cat ../file2)" =3D "master new" &&
+		test "$(git hash-object ../file2)" =3D "$(git rev-parse master:file2)"=
 &&
 		test "$(cat file3)" =3D "master new sub" &&
 		( cd .. && git submodule update -N ) &&
 		test "$(cat ../submod/bar)" =3D "master submodule" &&
@@ -631,7 +631,7 @@ test_expect_success 'custom commands override built-i=
ns' '
 	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
-	echo master both added >expected &&
+	git cat-file -p master:both >expected &&
 	test_cmp expected both
 '
=20
--=20
2.16.0.41.g6a66043158

