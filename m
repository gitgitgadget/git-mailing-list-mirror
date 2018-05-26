Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D491F42D
	for <e@80x24.org>; Sat, 26 May 2018 01:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030865AbeEZBJw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 25 May 2018 21:09:52 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37112 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030816AbeEZBJv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 May 2018 21:09:51 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4Q137C9024406;
        Fri, 25 May 2018 18:09:47 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j2gtktjcb-1;
        Fri, 25 May 2018 18:09:47 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0DF4022F7B04;
        Fri, 25 May 2018 18:09:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id EE9252CDE7B;
        Fri, 25 May 2018 18:09:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
Date:   Fri, 25 May 2018 18:09:44 -0700
Message-Id: <20180526010944.9975-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.844.g1ca50c8745.dirty
In-Reply-To: <CABPp-BEcTKaPPUOVqTRUAW+LBBySCK0dgx1J66hYB30yMasK_Q@mail.gmail.com/>
References: <CABPp-BEcTKaPPUOVqTRUAW+LBBySCK0dgx1J66hYB30yMasK_Q@mail.gmail.com/>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805260008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>>> -            test 2 = $(git ls-files -s | wc -l) &&
>>> -            test 2 = $(git ls-files -u | wc -l) &&
>>> -            test 2 = $(git ls-files -o | wc -l) &&
>>
>> Here 'git ls-files -o' should have listed two untracked files ...
>>
>>> +            git ls-files -s >out &&
>>> +            test_line_count = 2 out &&
>>> +            git ls-files -u >out &&
>>> +            test_line_count = 2 out &&
>>> +            git ls-files -o >out &&
>>> +            test_line_count = 3 out &&
>>
>> ... but now you expect it to list three.  I was about to point out the
>> typo, but then noticed that you expect it to list one more untracked
>> file than before in all subsequent tests...  now that can't be just a
>> typo, can it?
>>
>> Please mention in the commit message that when using an intermediate
>> file to store the output, 'git ls-files -o' will list that file, too,
>> that's why the number of expected untracked files had to be adjusted;
>> so future readers won't have to figure this out themselves.
>
> I'd expect that a reader of the commit who cares enough to bother to
> wonder by looking at the patch and seeing that 2 became 3 would know
> why already.  And a reader of the resulting file would not know that
> the 3 used to be 2, and won't be helped by "we used to count to 2,
> now we have 'out' also counted" that much, especially in the commit
> log message.  What would help the latter would be to name which
> three paths we expect to see in the comment (or test against the
> exact list of paths, instead of using test_line_count).
>
>> An alternative to consider would be to add a .gitignore file in the
>> initial commit to ignore 'out', then the number of untracked files
>> don't have to be adjusted.
>
> I think that is a preferred solution that we've used in ls-files and
> status tests successfully.

...except that if we add a .gitignore to each initial commit (we use
test_create_repo for nearly every test to keep them separable meaning
we'd have to do this many times), then four lines above we have to
adjust the number of expected tracked files.  And, for it to work,
we'd have to add an --exclude-standard flag to ls-files -o.

I can make that change if you both want it, but it seems like it's
actually making it harder to follow the changes rather than easier.

-- >8 --
Subject: [PATCH] fixup! t6036, t6042: use test_line_count instead of wc -l

---

and here's what it looks like which you can apply as a fixup.  I think it makes things worse, though.

 t/t6036-recursive-corner-cases.sh    | 81 +++++++++++++-----------
 t/t6042-merge-rename-corner-cases.sh | 93 +++++++++++++++-------------
 2 files changed, 95 insertions(+), 79 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 3e659cff28..06944a8c0a 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -25,6 +25,7 @@ test_expect_success 'setup basic criss-cross + rename with no modifications' '
 	(
 		cd basic-rename &&
 
+		echo out >.gitignore &&
 		ten="0 1 2 3 4 5 6 7 8 9" &&
 		for i in $ten
 		do
@@ -34,7 +35,7 @@ test_expect_success 'setup basic criss-cross + rename with no modifications' '
 		do
 			echo line $i in another sample file
 		done >two &&
-		git add one two &&
+		git add .gitignore one two &&
 		test_tick && git commit -m initial &&
 
 		git branch L1 &&
@@ -66,11 +67,11 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 		test_must_fail git merge -s recursive R2^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
@@ -97,6 +98,7 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
 	(
 		cd rename-modify &&
 
+		echo out >.gitignore &&
 		ten="0 1 2 3 4 5 6 7 8 9" &&
 		for i in $ten
 		do
@@ -106,7 +108,7 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
 		do
 			echo line $i in another sample file
 		done >two &&
-		git add one two &&
+		git add .gitignore one two &&
 		test_tick && git commit -m initial &&
 
 		git branch L1 &&
@@ -139,11 +141,11 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 		test_must_fail git merge -s recursive R2^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
@@ -178,8 +180,9 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 	(
 		cd rename-add &&
 
+		echo out >.gitignore &&
 		printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n" >a &&
-		git add a &&
+		git add .gitignore a &&
 		test_tick && git commit -m A &&
 
 		git branch B &&
@@ -218,11 +221,11 @@ test_expect_success 'git detects differently handled merges conflict' '
 		test_must_fail git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
 		test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
@@ -376,8 +379,9 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 	(
 		cd directory-file &&
 
+		echo out >.gitignore &&
 		>ignore-me &&
-		git add ignore-me &&
+		git add .gitignore ignore-me &&
 		test_tick &&
 		git commit -m A &&
 		git tag A &&
@@ -437,11 +441,11 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 		test_must_fail git merge -s recursive E1^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 		test $(git rev-parse :2:a) = $(git rev-parse B:a)
@@ -457,11 +461,11 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 		test_must_fail git merge -s recursive D^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 		test $(git rev-parse :3:a) = $(git rev-parse B:a)
@@ -477,11 +481,11 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 		test_must_fail git merge -s recursive E2^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
 		test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
@@ -501,11 +505,11 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 		test_must_fail git merge -s recursive D^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
 		test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
@@ -560,8 +564,9 @@ test_expect_success 'setup rename/rename(1to2)/modify followed by what looks lik
 	(
 		cd rename-squared-squared &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n6\n" >a &&
-		git add a &&
+		git add .gitignore a &&
 		git commit -m A &&
 		git tag A &&
 
@@ -600,11 +605,11 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
 		git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 1 out &&
+		test_line_count = 2 out &&
 		git ls-files -u >out &&
 		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
 	)
@@ -637,8 +642,9 @@ test_expect_success 'setup criss-cross + rename/rename/add-source + modify/modif
 	(
 		cd rename-rename-add-source &&
 
+		echo out >.gitignore &&
 		printf "lots\nof\nwords\nand\ncontent\n" >a &&
-		git add a &&
+		git add .gitignore a &&
 		git commit -m A &&
 		git tag A &&
 
@@ -682,11 +688,11 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 		git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
@@ -719,8 +725,9 @@ test_expect_success 'setup criss-cross+rename/rename/add-dest + simple modify' '
 	(
 		cd rename-rename-add-dest &&
 
+		echo out >.gitignore &&
 		>a &&
-		git add a &&
+		git add .gitignore a &&
 		git commit -m A &&
 		git tag A &&
 
@@ -759,11 +766,11 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 		git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b76da8fcdf..a330ced7da 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -90,9 +90,10 @@ test_expect_success 'setup resolvable conflict missed if rename missed' '
 	(
 		cd break-detection-1 &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n" >a &&
 		echo foo >b &&
-		git add a b &&
+		git add .gitignore a b &&
 		git commit -m A &&
 		git tag A &&
 
@@ -117,11 +118,11 @@ test_expect_failure 'conflict caused if rename not detected' '
 		git merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test_line_count = 6 c &&
 		test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
@@ -181,8 +182,9 @@ test_expect_success 'setup undetected rename/add-source causes data loss' '
 	(
 		cd break-detection-3 &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n" >a &&
-		git add a &&
+		git add .gitignore a &&
 		git commit -m A &&
 		git tag A &&
 
@@ -207,11 +209,11 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
 		git merge -s recursive C^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test -f a &&
 		test -f b &&
@@ -230,11 +232,11 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 		git merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test -f a &&
 		test -f b &&
@@ -249,8 +251,9 @@ test_expect_success 'setup content merge + rename/directory conflict' '
 	(
 		cd rename-directory-1 &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n6\n" >file &&
-		git add file &&
+		git add .gitignore file &&
 		test_tick &&
 		git commit -m base &&
 		git tag base &&
@@ -289,11 +292,11 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 		test_must_fail git merge -s recursive right^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 1 out &&
 
 		echo 0 >expect &&
 		git cat-file -p base:file >>expect &&
@@ -320,11 +323,11 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 		test_must_fail git merge -s recursive right^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 2 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 1 out &&
 
 		git cat-file -p left-conflict:newfile >left &&
 		git cat-file -p base:file    >base &&
@@ -350,9 +353,10 @@ test_expect_success 'setup content merge + rename/directory conflict w/ disappea
 	(
 		cd rename-directory-2 &&
 
+		echo out >.gitignore &&
 		mkdir sub &&
 		printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
-		git add sub/file &&
+		git add .gitignore sub/file &&
 		test_tick &&
 		git commit -m base &&
 		git tag base &&
@@ -383,11 +387,11 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 		git merge -s recursive right^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 1 out &&
+		test_line_count = 2 out &&
 		git ls-files -u >out &&
 		test_line_count = 0 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		echo 0 >expect &&
 		git cat-file -p base:sub/file >>expect &&
@@ -415,9 +419,10 @@ test_expect_success 'setup rename/rename (2to1) + modify/modify' '
 	(
 		cd rename-rename-2to1 &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n" >a &&
 		printf "5\n4\n3\n2\n1\n" >b &&
-		git add a b &&
+		git add .gitignore a b &&
 		git commit -m A &&
 		git tag A &&
 
@@ -445,13 +450,13 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -u c >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 2 out &&
 
 		test ! -f a &&
 		test ! -f b &&
@@ -472,8 +477,9 @@ test_expect_success 'setup simple rename/rename (1to2) conflict' '
 	(
 		cd rename-rename-1to2 &&
 
+		echo out >.gitignore &&
 		echo stuff >a &&
-		git add a &&
+		git add .gitignore a &&
 		test_tick &&
 		git commit -m A &&
 		git tag A &&
@@ -499,11 +505,11 @@ test_expect_success 'merge has correct working tree contents' '
 		test_must_fail git merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
@@ -527,8 +533,9 @@ test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
 	(
 		cd rename-rename-1to2-add-source-1 &&
 
+		echo out >.gitignore &&
 		printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
-		git add a &&
+		git add .gitignore a &&
 		git commit -m A &&
 		git tag A &&
 
@@ -553,9 +560,9 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 		test_must_fail git merge -s recursive C^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		test_line_count = 5 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
 		test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
@@ -573,8 +580,9 @@ test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
 	(
 		cd rename-rename-1to2-add-source-2 &&
 
+		echo out >.gitignore &&
 		>a &&
-		git add a &&
+		git add .gitignore a &&
 		test_tick &&
 		git commit -m base &&
 		git tag A &&
@@ -601,9 +609,9 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
 		git merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 1 out &&
+		test_line_count = 3 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 0 out &&
 
 		test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
@@ -615,8 +623,9 @@ test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
 	(
 		cd rename-rename-1to2-add-dest &&
 
+		echo out >.gitignore &&
 		echo stuff >a &&
-		git add a &&
+		git add .gitignore a &&
 		test_tick &&
 		git commit -m base &&
 		git tag A &&
@@ -645,13 +654,13 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 		test_must_fail git merge -s recursive B^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 5 out &&
+		test_line_count = 6 out &&
 		git ls-files -u b >out &&
 		test_line_count = 2 out &&
 		git ls-files -u c >out &&
 		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 5 out &&
+		git ls-files -o --exclude-standard >out &&
+		test_line_count = 4 out &&
 
 		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
-- 
2.17.0.844.g1ca50c8745.dirty

