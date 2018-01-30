Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202BD1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeA3XqS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Jan 2018 18:46:18 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36748 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932200AbeA3XpS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:18 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNOKDr009751;
        Tue, 30 Jan 2018 15:25:34 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frr5qd2d3-1;
        Tue, 30 Jan 2018 15:25:34 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 17385221A562;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 0A9472CDE88;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 00/31] Add directory rename detection to git
Date:   Tue, 30 Jan 2018 15:25:02 -0800
Message-Id: <20180130232533.25846-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.106.gf69932adfe
MIME-Version: 1.0
Content-Type: text/plain; charset=bogus too
Content-Transfer-Encoding: 8BIT
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.  See
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the first series (including design considerations, etc.), and follow-up
series can be found at
  https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
  https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
  https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
  https://public-inbox.org/git/20171228041352.27880-1-newren@gmail.com/
  https://public-inbox.org/git/20180105202711.24311-1-newren@gmail.com/

Changes since v6 (full tbdiff follows below):
  * Fix missing file argument in a testcase, pointed out by SZEDER Gábor.
  * Add whitespace in some testcases in separate git-rev-parse invocations
    to make it easier to visually see what is being compared.
  * Rebased on latest origin/master (not that there were any conflicts)

Note: This series continues to depend upon en/merge-recursive-fixes, at
  least contextually.

Elijah Newren (31):
  directory rename detection: basic testcases
  directory rename detection: directory splitting testcases
  directory rename detection: testcases to avoid taking detection too
    far
  directory rename detection: partially renamed directory
    testcase/discussion
  directory rename detection: files/directories in the way of some
    renames
  directory rename detection: testcases checking which side did the
    rename
  directory rename detection: more involved edge/corner testcases
  directory rename detection: testcases exploring possibly suboptimal
    merges
  directory rename detection: miscellaneous testcases to complete
    coverage
  directory rename detection: tests for handling overwriting untracked
    files
  directory rename detection: tests for handling overwriting dirty files
  merge-recursive: move the get_renames() function
  merge-recursive: introduce new functions to handle rename logic
  merge-recursive: fix leaks of allocated renames and diff_filepairs
  merge-recursive: make !o->detect_rename codepath more obvious
  merge-recursive: split out code for determining diff_filepairs
  merge-recursive: add a new hashmap for storing directory renames
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add a new hashmap for storing file collisions
  merge-recursive: add computation of collisions due to dir rename &
    merging
  merge-recursive: check for file level conflicts then get new name
  merge-recursive: when comparing files, don't include trees
  merge-recursive: apply necessary modifications for directory renames
  merge-recursive: avoid clobbering untracked files with directory
    renames
  merge-recursive: fix overwriting dirty files involved in renames
  merge-recursive: fix remaining directory rename + dirty overwrite
    cases
  directory rename detection: new testcases showcasing a pair of bugs
  merge-recursive: avoid spurious rename/rename conflict from dir
    renames
  merge-recursive: ensure we write updates for directory-renamed file

 merge-recursive.c                   | 1212 ++++++++++-
 merge-recursive.h                   |   17 +
 strbuf.c                            |   16 +
 strbuf.h                            |   16 +
 t/t3501-revert-cherry-pick.sh       |    2 +-
 t/t6043-merge-rename-directories.sh | 3990 +++++++++++++++++++++++++++++++++++
 t/t7607-merge-overwrite.sh          |    2 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 9 files changed, 5148 insertions(+), 115 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

 1: 2fd0812b7a !  1: 5ba69c9c7b directory rename detection: basic testcases
    @@ -94,7 +94,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e/f &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/d B:z/e/f &&
    ++			O:z/b    O:z/c    B:z/d    B:z/e/f &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/d >actual &&
    @@ -161,7 +161,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:y/d A:z/e &&
    ++			O:z/b    O:z/c    O:y/d    A:z/e &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:z/e
     +	)
    @@ -219,7 +219,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:x/d &&
    ++			O:z/b    O:z/c    O:x/d &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:x/d &&
     +		test_must_fail git rev-parse HEAD:z/d &&
    @@ -293,14 +293,14 @@
     +		git rev-parse >actual \
     +			:0:x/b :0:x/c :0:x/d :0:x/e :0:x/m :0:x/n &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:y/d O:y/e A:y/m B:z/n &&
    ++			 O:z/b  O:z/c  O:y/d  O:y/e  A:y/m  B:z/n &&
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :0:x/wham &&
     +		git rev-parse >actual \
     +			:2:x/wham :3:x/wham &&
     +		git rev-parse >expect \
    -+			A:y/wham B:z/wham &&
    ++			 A:y/wham  B:z/wham &&
     +		test_cmp expect actual &&
     +
     +		test_path_is_missing x/wham &&
    @@ -310,7 +310,7 @@
     +		git hash-object >actual \
     +			x/wham~HEAD x/wham~B^0 &&
     +		git rev-parse >expect \
    -+			A:y/wham B:z/wham &&
    ++			A:y/wham    B:z/wham &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -366,7 +366,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/newb HEAD:y/newc HEAD:y/d &&
     +		git rev-parse >expect \
    -+			O:z/oldb O:z/oldc B:z/d &&
    ++			O:z/oldb    O:z/oldc    B:z/d &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:z/d
     +	)
    @@ -432,7 +432,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d HEAD:x/e HEAD:x/f HEAD:x/g &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:z/d O:z/e O:z/f A:z/g &&
    ++			O:z/b    O:z/c    O:z/d    O:z/e    O:z/f    A:z/g &&
     +		test_cmp expect actual &&
     +		test_path_is_missing z/g &&
     +		test_must_fail git rev-parse HEAD:z/g
 2: 5c697afd4b !  2: e1d23f7f95 directory rename detection: directory splitting testcases
    @@ -79,7 +79,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:w/c :0:z/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/d &&
    ++			 O:z/b  O:z/c  B:z/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -140,7 +140,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:w/c :0:x/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:x/d &&
    ++			 O:z/b  O:z/c  B:x/d &&
     +		test_cmp expect actual &&
     +		test_i18ngrep ! "CONFLICT.*directory rename split" out
     +	)
 3: 2b9346df1b !  3: b10cb49cf9 directory rename detection: testcases to avoid taking detection too far
    @@ -74,7 +74,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:z/d &&
    ++			O:z/b    O:z/c    O:z/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -133,7 +133,7 @@
     +
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
    -+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d &&
    ++		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
     +
     +		git ls-files -s >out &&
     +		test_line_count = 5 out &&
    @@ -145,12 +145,12 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:z/d O:z/d O:z/d &&
    ++			 O:z/b  O:z/c  O:z/d  O:z/d  O:z/d &&
     +		test_cmp expect actual &&
     +
     +		test_path_is_missing z/d &&
     +		git hash-object >actual \
    -+			x/d w/d &&
    ++			x/d   w/d &&
     +		git rev-parse >expect \
     +			O:z/d O:z/d &&
     +		test_cmp expect actual
 4: 791201822d !  4: ec3ccf0a95 directory rename detection: partially renamed directory testcase/discussion
    @@ -103,7 +103,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/e HEAD:z/f &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:z/d O:z/e B:z/f &&
    ++			O:z/b    O:z/c    O:z/d    O:z/e    B:z/f &&
     +		test_cmp expect actual
     +	)
     +'
 5: 6fc6028a78 !  5: da018f1adb directory rename detection: files/directories in the way of some renames
    @@ -86,7 +86,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/d :0:y/e :0:z/e :0:y/f &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:y/d A:y/e A:z/e A:z/f &&
    ++			 O:z/b  O:z/c  O:y/d  A:y/e  A:z/e  A:z/f &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -160,7 +160,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e :2:y/d :3:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/e A:y/d B:y/d &&
    ++			 O:z/b  O:z/c  B:z/e  A:y/d  B:y/d &&
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :1:y/d &&
    @@ -241,20 +241,20 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/e &&
    ++			 O:z/b  O:z/c  B:z/e &&
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :1:y/d &&
     +		git rev-parse >actual \
     +			:2:w/d :3:w/d :1:x/d :2:y/d :3:y/d :3:z/d &&
     +		git rev-parse >expect \
    -+			O:x/d B:w/d O:x/d A:y/d B:y/d O:x/d &&
    ++			 O:x/d  B:w/d  O:x/d  A:y/d  B:y/d  O:x/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
     +			w/d~HEAD w/d~B^0 z/d &&
     +		git rev-parse >expect \
    -+			O:x/d B:w/d O:x/d &&
    ++			O:x/d    B:w/d   O:x/d &&
     +		test_cmp expect actual &&
     +		test_path_is_missing x/d &&
     +		test_path_is_file y/d &&
    @@ -324,7 +324,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/d B:z/f A:y/d B:y/d/e &&
    ++			 O:z/b  O:z/c  B:z/d  B:z/f  A:y/d  B:y/d/e &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/d~HEAD >actual &&
 6: 317d54cfc0 !  6: f7ca54e7f2 directory rename detection: testcases checking which side did the rename
    @@ -84,7 +84,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :3:y/c &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c &&
    ++			 O:z/b  O:z/c &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -148,7 +148,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/d &&
    ++			O:z/b    O:z/c    B:z/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -210,7 +210,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/d &&
    ++			O:z/b    O:z/c    B:z/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -272,7 +272,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:x/d &&
    ++			O:z/b    O:z/c    O:x/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -335,7 +335,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:y/d B:z/d &&
    ++			O:z/b    O:z/c    B:y/d    B:z/d &&
     +		test_cmp expect actual
     +	)
     +'
 7: afb942c5d7 !  7: 8ae28f45fe directory rename detection: more involved edge/corner testcases
    @@ -97,11 +97,11 @@
     +		git rev-parse >actual \
     +			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:x/c :0:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c B:z/d &&
    ++			 O:z/b  O:z/b  O:z/b  O:z/c  O:z/c  O:z/c  B:z/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
    -+			y/b w/b y/c x/c &&
    ++			y/b   w/b   y/c   x/c &&
     +		git rev-parse >expect \
     +			O:z/b O:z/b O:z/c O:z/c &&
     +		test_cmp expect actual
    @@ -168,7 +168,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :2:y/d :3:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:w/d O:x/d &&
    ++			 O:z/b  O:z/c  O:w/d  O:x/d &&
     +		test_cmp expect actual &&
     +
     +		test_path_is_missing y/d &&
    @@ -178,7 +178,7 @@
     +		git hash-object >actual \
     +			y/d~HEAD y/d~B^0 &&
     +		git rev-parse >expect \
    -+			O:w/d O:x/d &&
    ++			O:w/d    O:x/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -244,7 +244,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :1:x/d :2:w/d :3:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:x/d O:x/d O:x/d &&
    ++			 O:z/b  O:z/c  O:x/d  O:x/d  O:x/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -308,7 +308,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :3:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:x/d &&
    ++			 O:z/b  O:z/c  O:x/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -398,7 +398,7 @@
     +		git rev-parse >actual \
     +			:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
     +		git rev-parse >expect \
    -+			A:x/d/f A:y/d/g O:z/b O:z/c O:x/d &&
    ++			 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/d~B^0 >actual &&
 8: 157559ceac !  8: 8d05b8dc10 directory rename detection: testcases exploring possibly suboptimal merges
    @@ -92,7 +92,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/a HEAD:y/b HEAD:y/e HEAD:y/f HEAD:z/c HEAD:z/d &&
     +		git rev-parse >expect \
    -+			O:x/a O:x/b A:x/e A:y/f O:y/c O:y/d &&
    ++			O:x/a    O:x/b    A:x/e    A:y/f    O:y/c    O:y/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -170,7 +170,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/a HEAD:y/b HEAD:z/a HEAD:z/b HEAD:x/e HEAD:y/e &&
     +		git rev-parse >expect \
    -+			O:x/a O:x/b O:y/a O:y/b A:x/e A:y/e &&
    ++			O:x/a    O:x/b    O:y/a    O:y/b    A:x/e    A:y/e &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -238,7 +238,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e :3:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/e B:z/d &&
    ++			 O:z/b  O:z/c  B:z/e  B:z/d &&
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :1:y/d &&
    @@ -320,7 +320,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/e &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/e &&
    ++			O:z/b    O:z/c    B:z/e &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -401,11 +401,11 @@
     +		git rev-parse >actual \
     +			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:w/c :0:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c B:z/d &&
    ++			 O:z/b  O:z/b  O:z/b  O:z/c  O:z/c  O:z/c  B:z/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
    -+			y/b w/b y/c w/c &&
    ++			y/b   w/b   y/c   w/c &&
     +		git rev-parse >expect \
     +			O:z/b O:z/b O:z/c O:z/c &&
     +		test_cmp expect actual &&
 9: e9f563a34e !  9: 47ffccc86d directory rename detection: miscellaneous testcases to complete coverage
    @@ -105,13 +105,13 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/i &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/i &&
    ++			O:z/b    O:z/c    B:z/i &&
     +		test_cmp expect actual &&
     +
     +		git rev-parse >actual \
     +			HEAD:x/w/e HEAD:x/w/f HEAD:x/w/g HEAD:x/w/h &&
     +		git rev-parse >expect \
    -+			O:z/d/e O:z/d/f O:z/d/g B:z/d/h &&
    ++			O:z/d/e    O:z/d/f    O:z/d/g    B:z/d/h &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -174,7 +174,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c :0:expected &&
    ++			O:z/b    O:z/c    :0:expected &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:x/d &&
     +		test_must_fail git rev-parse HEAD:z/d &&
    @@ -264,7 +264,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e HEAD:x/f HEAD:x/g &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c O:x/d O:x/e O:w/f A:x/g &&
    ++			O:z/b    O:z/c    O:x/d    O:x/e    O:w/f    A:x/g &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -353,9 +353,13 @@
     +		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
    -+			HEAD:z/t HEAD:y/a HEAD:x/b HEAD:w/c HEAD:u/d HEAD:u/e HEAD:u/f &&
    -+		git rev-parse >expect \
    -+			B:z/t O:z/a O:y/b O:x/c O:w/d O:v/e A:u/f &&
    ++			HEAD:z/t \
    ++			HEAD:y/a HEAD:x/b HEAD:w/c \
    ++			HEAD:u/d HEAD:u/e HEAD:u/f &&
    ++		git rev-parse >expect \
    ++			B:z/t    \
    ++			O:z/a    O:y/b    O:x/c    \
    ++			O:w/d    O:v/e    A:u/f &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -439,16 +443,16 @@
     +			:0:combined/g :0:combined/h :0:combined/i \
     +			:0:combined/j :0:combined/k :0:combined/l &&
     +		git rev-parse >expect \
    -+			O:dir1/a O:dir1/b A:dir1/c \
    -+			O:dir2/d O:dir2/e A:dir2/f \
    -+			O:dir3/g O:dir3/h A:dir3/i \
    -+			O:dirN/j O:dirN/k A:dirN/l &&
    ++			 O:dir1/a      O:dir1/b      A:dir1/c \
    ++			 O:dir2/d      O:dir2/e      A:dir2/f \
    ++			 O:dir3/g      O:dir3/h      A:dir3/i \
    ++			 O:dirN/j      O:dirN/k      A:dirN/l &&
     +		test_cmp expect actual &&
     +
     +		git rev-parse >actual \
     +			:0:dir1/yo :0:dir2/yo :0:dir3/yo :0:dirN/yo &&
     +		git rev-parse >expect \
    -+			A:dir1/yo A:dir2/yo A:dir3/yo A:dirN/yo &&
    ++			 A:dir1/yo  A:dir2/yo  A:dir3/yo  A:dirN/yo &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -503,9 +507,15 @@
     +		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
    -+			HEAD:priority/a/foo HEAD:priority/b/bar HEAD:priority/b/baz HEAD:priority/c &&
    -+		git rev-parse >expect \
    -+			O:goal/a/foo O:goal/b/bar O:goal/b/baz B:goal/c &&
    ++			HEAD:priority/a/foo \
    ++			HEAD:priority/b/bar \
    ++			HEAD:priority/b/baz \
    ++			HEAD:priority/c &&
    ++		git rev-parse >expect \
    ++			O:goal/a/foo \
    ++			O:goal/b/bar \
    ++			O:goal/b/baz \
    ++			B:goal/c &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:goal/c
     +	)
    @@ -564,9 +574,15 @@
     +		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
    -+			HEAD:priority/alpha/foo HEAD:priority/beta/bar HEAD:priority/beta/baz HEAD:priority/c &&
    -+		git rev-parse >expect \
    -+			O:goal/a/foo O:goal/b/bar O:goal/b/baz B:goal/c &&
    ++			HEAD:priority/alpha/foo \
    ++			HEAD:priority/beta/bar  \
    ++			HEAD:priority/beta/baz  \
    ++			HEAD:priority/c &&
    ++		git rev-parse >expect \
    ++			O:goal/a/foo \
    ++			O:goal/b/bar \
    ++			O:goal/b/baz \
    ++			B:goal/c &&
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:goal/c
     +	)
10: 0c6630551e ! 10: db7d9850c2 directory rename detection: tests for handling overwriting untracked files
    @@ -147,7 +147,7 @@
     +		git rev-parse >actual \
     +			:0:y/b :3:y/d :3:y/e &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c B:z/e &&
    ++			O:z/b  O:z/c  B:z/e &&
     +		test_cmp expect actual &&
     +
     +		echo very >expect &&
    @@ -223,7 +223,7 @@
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
     +		git rev-parse >expect \
    -+			O:z/a O:z/b O:x/d O:x/c O:x/c O:x/c &&
    ++			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/c~B^0 >actual &&
    @@ -298,7 +298,7 @@
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
     +		git rev-parse >expect \
    -+			O:z/a O:z/b O:x/d O:x/e O:z/c O:x/f &&
    ++			 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :1:y/wham &&
    @@ -309,7 +309,7 @@
     +		git hash-object >actual \
     +			y/wham~B^0 y/wham~HEAD &&
     +		git rev-parse >expect \
    -+			O:x/f O:z/c &&
    ++			O:x/f      O:z/c &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -370,7 +370,7 @@
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:y/c &&
     +		git rev-parse >expect \
    -+			O:z/a O:z/b B:z/c &&
    ++			 O:z/a  O:z/b  B:z/c &&
     +		test_cmp expect actual &&
     +
     +		echo random >expect &&
11: 16cd375e15 ! 11: 0de0a9dfa0 directory rename detection: tests for handling overwriting dirty files
    @@ -87,7 +87,7 @@
     +		git rev-parse >actual \
     +			:0:z/a :2:z/c &&
     +		git rev-parse >expect \
    -+			O:z/a B:z/b &&
    ++			 O:z/a  B:z/b &&
     +		test_cmp expect actual &&
     +
     +		git hash-object z/c~HEAD >actual &&
    @@ -162,7 +162,7 @@
     +		git rev-parse >actual \
     +			:0:x/b :0:y/a :0:y/c &&
     +		git rev-parse >expect \
    -+			O:x/b O:z/a B:x/c &&
    ++			 O:x/b  O:z/a  B:x/c &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/c >actual &&
    @@ -302,7 +302,7 @@
     +		git rev-parse >actual \
     +			:0:x/b :0:y/a :0:y/c/d :3:y/c &&
     +		git rev-parse >expect \
    -+			O:x/b O:z/a B:y/c/d B:x/c &&
    ++			 O:x/b  O:z/a  B:y/c/d  B:x/c &&
     +		test_cmp expect actual &&
     +
     +		git hash-object y/c~HEAD >actual &&
    @@ -381,13 +381,13 @@
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
     +		git rev-parse >expect \
    -+			O:z/a O:z/b O:x/d O:x/c O:x/c A:y/c O:x/c &&
    ++			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
     +			y/c~B^0 y/c~HEAD &&
     +		git rev-parse >expect \
    -+			O:x/c A:y/c &&
    ++			O:x/c   A:y/c &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -458,13 +458,13 @@
     +		git hash-object >actual \
     +			y/wham~B^0 y/wham~HEAD &&
     +		git rev-parse >expect \
    -+			O:x/d O:x/c &&
    ++			O:x/d      O:x/c &&
     +		test_cmp expect actual &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
     +		git rev-parse >expect \
    -+			O:z/a O:z/b O:x/c O:x/d &&
    ++			 O:z/a  O:z/b  O:x/c     O:x/d &&
     +		test_cmp expect actual
     +	)
     +'
12: b7f4530bcd = 12: 9a6777f577 merge-recursive: move the get_renames() function
13: 45c39bb872 = 13: ac6a95c7b8 merge-recursive: introduce new functions to handle rename logic
14: 21b30fe2da = 14: 76b09d49cd merge-recursive: fix leaks of allocated renames and diff_filepairs
15: bad89d2178 = 15: e4189f3da2 merge-recursive: make !o->detect_rename codepath more obvious
16: 67eec195a4 = 16: 6bc800e369 merge-recursive: split out code for determining diff_filepairs
17: 288e3987a7 = 17: 0757c92ca1 merge-recursive: add a new hashmap for storing directory renames
18: c2d58b3a29 = 18: f17343fc2c merge-recursive: make a helper function for cleanup for handle_renames
19: 1dcf482278 = 19: 9b63e257c8 merge-recursive: add get_directory_renames()
20: 968effeaf3 = 20: 6730d8e7b7 merge-recursive: check for directory level conflicts
21: 865b98f6b4 = 21: 178ec9e079 merge-recursive: add a new hashmap for storing file collisions
22: f74e41c564 = 22: 1f3ff65e82 merge-recursive: add computation of collisions due to dir rename & merging
23: 6678bf2ca4 = 23: d28651aeb0 merge-recursive: check for file level conflicts then get new name
24: 8dd2a045c8 = 24: d6f3d47304 merge-recursive: when comparing files, don't include trees
25: 30341f6551 = 25: f91509f9df merge-recursive: apply necessary modifications for directory renames
26: 498cb775f7 = 26: 9d903c98de merge-recursive: avoid clobbering untracked files with directory renames
27: 81d5073abc = 27: 2ab61d26a3 merge-recursive: fix overwriting dirty files involved in renames
28: 3a2e99fe75 = 28: d510c260b7 merge-recursive: fix remaining directory rename + dirty overwrite cases
29: e93a1b89e3 ! 29: b59a612e68 directory rename detection: new testcases showcasing a pair of bugs
    @@ -86,7 +86,7 @@
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d &&
     +		git rev-parse >expect \
    -+			O:z/b O:z/c A:z/d &&
    ++			O:z/b    O:z/c    A:z/d &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -156,9 +156,15 @@
     +		test_line_count = 6 out &&
     +
     +		git rev-parse >actual \
    -+			HEAD:node1/leaf1 HEAD:node1/leaf2 HEAD:node1/leaf5 HEAD:node1/node2/leaf3 HEAD:node1/node2/leaf4 HEAD:node1/node2/leaf6 &&
    ++			HEAD:node1/leaf1 HEAD:node1/leaf2 HEAD:node1/leaf5 \
    ++			HEAD:node1/node2/leaf3 \
    ++			HEAD:node1/node2/leaf4 \
    ++			HEAD:node1/node2/leaf6 &&
     +		git rev-parse >expect \
    -+			O:node1/leaf1 O:node1/leaf2 B:node1/leaf5 O:node2/leaf3 O:node2/leaf4 B:node2/leaf6 &&
    ++			O:node1/leaf1    O:node1/leaf2    B:node1/leaf5 \
    ++			O:node2/leaf3 \
    ++			O:node2/leaf4 \
    ++			B:node2/leaf6 &&
     +		test_cmp expect actual
     +	)
     +'
    @@ -231,8 +237,10 @@
     +			HEAD:node2/node1/node2/leaf3 \
     +			HEAD:node2/node1/node2/leaf4 &&
     +		git rev-parse >expect \
    -+			O:node1/leaf1 O:node1/leaf2 \
    -+			O:node2/leaf3 O:node2/leaf4 &&
    ++			O:node1/leaf1 \
    ++			O:node1/leaf2 \
    ++			O:node2/leaf3 \
    ++			O:node2/leaf4 &&
     +		test_cmp expect actual
     +	)
     +'
30: d77d0d85b0 ! 30: d20b759b63 merge-recursive: avoid spurious rename/rename conflict from dir renames
    @@ -98,8 +98,8 @@
     -			:0:y/b :0:y/c :0:y/e :3:y/d &&
     +			:0:y/b :0:y/c :0:y/e :1:z/d :3:z/d &&
      		git rev-parse >expect \
    --			O:z/b O:z/c B:z/e B:z/d &&
    -+			O:z/b O:z/c B:z/e O:z/d B:z/d &&
    +-			 O:z/b  O:z/c  B:z/e  B:z/d &&
    ++			 O:z/b  O:z/c  B:z/e  O:z/d  B:z/d &&
      		test_cmp expect actual &&
      
     -		test_must_fail git rev-parse :1:y/d &&
31: c7ed5a2134 = 31: f69932adfe merge-recursive: ensure we write updates for directory-renamed file

-- 
2.16.1.106.gf69932adfe
