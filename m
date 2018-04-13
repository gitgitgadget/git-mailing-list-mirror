Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E961F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeDMT41 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:56:27 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57978 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751940AbeDMT4R (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:56:17 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DJs5Of031039;
        Fri, 13 Apr 2018 12:56:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h96v3w6yt-1;
        Fri, 13 Apr 2018 12:56:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id F0FA52215BAF;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id E3B7E2CDE68;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     torvalds@linux-foundation.org, gitster@pobox.com,
        sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 29.50/30] t6046: testcases checking whether updates can be skipped in a merge
Date:   Fri, 13 Apr 2018 12:56:05 -0700
Message-Id: <20180413195607.18091-3-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.35.g6dd7ede834
In-Reply-To: <20180413195607.18091-1-newren@gmail.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
 <20180413195607.18091-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804130184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add several tests checking whether updates can be skipped in a merge.
Also add several similar testcases for where updates cannot be skipped in
a merge to make sure that we skip if and only if we should.

In particular:

  * Testcase 1a (particularly 1a-check-L) would have pointed out the
    problem Linus has been dealing with for year with his merges[1].

  * Testcase 2a (particularly 2a-check-L) would have pointed out the
    problem with my directory-rename-series before it broke master[2].

  * Testcases 3[ab] (particularly 3a-check-L) provide a simpler testcase
    than 12b of t6043 making that one easier to understand.

  * There are several complementary testcases to make sure we're not just
    fixing those particular issues while regressing in the opposite
    direction.

[1] https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/
[2] https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6046-merge-skip-unneeded-updates.sh | 497 +++++++++++++++++++++++++++++++++
 1 file changed, 497 insertions(+)
 create mode 100755 t/t6046-merge-skip-unneeded-updates.sh

diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
new file mode 100755
index 0000000000..89c3a953ae
--- /dev/null
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -0,0 +1,497 @@
+#!/bin/sh
+
+test_description="merge cases"
+
+# The setup for all of them, pictorially, is:
+#
+#      A
+#      o
+#     / \
+#  O o   ?
+#     \ /
+#      o
+#      B
+#
+# To help make it easier to follow the flow of tests, they have been
+# divided into sections and each test will start with a quick explanation
+# of what commits O, A, and B contain.
+#
+# Notation:
+#    z/{b,c}   means  files z/b and z/c both exist
+#    x/d_1     means  file x/d exists with content d1.  (Purpose of the
+#                     underscore notation is to differentiate different
+#                     files that might be renamed into each other's paths.)
+
+. ./test-lib.sh
+
+
+###########################################################################
+# SECTION 1: Cases involving no renames (one side has subset of changes of
+#            the other side)
+###########################################################################
+
+# Testcase 1a, Changes on A, subset of changes on B
+#   Commit O: b_1
+#   Commit A: b_2
+#   Commit B: b_3
+#   Expected: b_2
+
+test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
+	test_create_repo 1a &&
+	(
+		cd 1a &&
+
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		git add b &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 5.5 6 7 8 9 10 10.5 >b &&
+		git add b &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_write_lines 1 2 3 4 5 5.5 6 7 8 9 10 >b &&
+		git add b &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
+	test_when_finished "git -C 1a reset --hard" &&
+	(
+		cd 1a &&
+
+		git checkout A^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "Skipped" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:b &&
+		git rev-parse >expect A:b &&
+		test_cmp expect actual &&
+
+		git hash-object b   >actual &&
+		git rev-parse   A:b >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '1a-check-R: Modify(A)/Modify(B), change on B subset of A' '
+	test_when_finished "git -C 1a reset --hard" &&
+	(
+		cd 1a &&
+
+		git checkout B^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+
+		test_i18ngrep "Auto-merging" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:b &&
+		git rev-parse >expect A:b &&
+		test_cmp expect actual &&
+
+		git hash-object b   >actual &&
+		git rev-parse   A:b >expect &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# SECTION 2: Cases involving basic renames
+###########################################################################
+
+# Testcase 2a, Changes on A, rename on B
+#   Commit O: b_1
+#   Commit A: b_2
+#   Commit B: c_1
+#   Expected: c_2
+
+test_expect_success '2a-setup: Modify(A)/rename(B)' '
+	test_create_repo 2a &&
+	(
+		cd 2a &&
+
+		test_seq 1 10 >b
+		git add b &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_seq 1 11 > b &&
+		git add b &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv b c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '2a-check-L: Modify/rename, merge into modify side' '
+	test_when_finished "git -C 2a reset --hard" &&
+	(
+		cd 2a &&
+
+		git checkout A^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "Had correct contents" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:c &&
+		git rev-parse >expect A:b &&
+		test_cmp expect actual &&
+
+		git hash-object c   >actual &&
+		git rev-parse   A:b >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:b &&
+		test_path_is_missing b
+	)
+'
+
+test_expect_success '2a-check-R: Modify/rename, merge into rename side' '
+	test_when_finished "git -C 2a reset --hard" &&
+	(
+		cd 2a &&
+
+		git checkout B^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+
+		test_i18ngrep "Auto-merging" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:c &&
+		git rev-parse >expect A:b &&
+		test_cmp expect actual &&
+
+		git hash-object c   >actual &&
+		git rev-parse   A:b >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:b &&
+		test_path_is_missing b
+	)
+'
+
+# Testcase 2b, Changed and renamed on A, subset of changes on B
+#   Commit O: b_1
+#   Commit A: c_2
+#   Commit B: b_3
+#   Expected: c_2
+
+test_expect_success '2b-setup: Modify(A)/Modify(B), change on B subset of A' '
+	test_create_repo 2b &&
+	(
+		cd 2b &&
+
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		git add b &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 5.5 6 7 8 9 10 10.5 >b &&
+		git add b &&
+		git mv b c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_write_lines 1 2 3 4 5 5.5 6 7 8 9 10 >b &&
+		git add b &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '2b-check-L: Modify(A)/Modify(B), change on B subset of A' '
+	test_when_finished "git -C 2b reset --hard" &&
+	(
+		cd 2b &&
+
+		git checkout A^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "Skipped" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:c &&
+		git rev-parse >expect A:c &&
+		test_cmp expect actual &&
+
+		git hash-object c   >actual &&
+		git rev-parse   A:c >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:b &&
+		test_path_is_missing b
+	)
+'
+
+test_expect_success '2b-check-R: Modify(A)/Modify(B), change on B subset of A' '
+	test_when_finished "git -C 2b reset --hard" &&
+	(
+		cd 2b &&
+
+		git checkout B^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+
+		test_i18ngrep "Auto-merging" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 1 index_files &&
+
+		git rev-parse >actual HEAD:c &&
+		git rev-parse >expect A:c &&
+		test_cmp expect actual &&
+
+		git hash-object c   >actual &&
+		git rev-parse   A:c >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:b &&
+		test_path_is_missing b
+	)
+'
+
+###########################################################################
+# SECTION 3: Cases involving directory renames
+#
+# NOTE:
+#   Directory renames only apply when one side renames a directory, and the
+#   other side adds or renames a path into that directory.  Applying the
+#   directory rename to that new path creates a new pathname that didn't
+#   exist on either side of history.  Thus, it is impossible for the
+#   merge contents to already be at the right path, so all of these checks
+#   exist just to make sure that updates are not skipped.
+###########################################################################
+
+# Testcase 3a, Change + rename into dir foo on A, dir rename foo->bar on B
+#   Commit O: bq_1, foo/whatever
+#   Commit A: foo/{bq_2, whatever}
+#   Commit B: bq_1, bar/whatever
+#   Expected: bar/{bq_2, whatever}
+
+test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_create_repo 3a &&
+	(
+		cd 3a &&
+
+		mkdir foo &&
+		test_seq 1 10 >bq &&
+		test_write_lines a b c d e f g h i j k >foo/whatever &&
+		git add bq foo/whatever &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_seq 1 11 > bq &&
+		git add bq &&
+		git mv bq foo/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv foo/ bar/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_when_finished "git -C 3a reset --hard" &&
+	(
+		cd 3a &&
+
+		git checkout A^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "Had correct contents for bar/bq" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		git rev-parse >actual HEAD:bar/bq HEAD:bar/whatever &&
+		git rev-parse >expect A:foo/bq    A:foo/whatever &&
+		test_cmp expect actual &&
+
+		git hash-object bar/bq   bar/whatever   >actual &&
+		git rev-parse   A:foo/bq A:foo/whatever >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
+		test_path_is_missing bq foo/bq foo/whatever
+	)
+'
+
+test_expect_success '3a-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_when_finished "git -C 3a reset --hard" &&
+	(
+		cd 3a &&
+
+		git checkout B^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+
+		test_i18ngrep "Auto-merging bar/bq" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		git rev-parse >actual HEAD:bar/bq HEAD:bar/whatever &&
+		git rev-parse >expect A:foo/bq    A:foo/whatever &&
+		test_cmp expect actual &&
+
+		git hash-object bar/bq   bar/whatever   >actual &&
+		git rev-parse   A:foo/bq A:foo/whatever >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
+		test_path_is_missing bq foo/bq foo/whatever
+	)
+'
+
+# Testcase 3b, rename into dir foo on A, dir rename foo->bar + change on B
+#   Commit O: bq_1, foo/whatever
+#   Commit A: foo/{bq_1, whatever}
+#   Commit B: bq_2, bar/whatever
+#   Expected: bar/{bq_2, whatever}
+
+test_expect_success '3b-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_create_repo 3b &&
+	(
+		cd 3b &&
+
+		mkdir foo &&
+		test_seq 1 10 >bq &&
+		test_write_lines a b c d e f g h i j k >foo/whatever &&
+		git add bq foo/whatever &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv bq foo/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_seq 1 11 > bq &&
+		git add bq &&
+		git mv foo/ bar/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3b-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_when_finished "git -C 3b reset --hard" &&
+	(
+		cd 3b &&
+
+		git checkout A^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "Auto-merging bar/bq" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		git rev-parse >actual HEAD:bar/bq HEAD:bar/whatever &&
+		git rev-parse >expect B:bq        A:foo/whatever &&
+		test_cmp expect actual &&
+
+		git hash-object bar/bq bar/whatever   >actual &&
+		git rev-parse   B:bq   A:foo/whatever >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
+		test_path_is_missing bq foo/bq foo/whatever
+	)
+'
+
+test_expect_success '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_when_finished "git -C 3b reset --hard" &&
+	(
+		cd 3b &&
+
+		git checkout B^0 &&
+
+		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
+
+		test_i18ngrep "Had correct contents for bar/bq" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		git rev-parse >actual HEAD:bar/bq HEAD:bar/whatever &&
+		git rev-parse >expect B:bq        A:foo/whatever &&
+		test_cmp expect actual &&
+
+		git hash-object bar/bq bar/whatever   >actual &&
+		git rev-parse   B:bq   A:foo/whatever >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
+		test_path_is_missing bq foo/bq foo/whatever
+	)
+'
+
+test_done
-- 
2.16.0.35.g6dd7ede834

