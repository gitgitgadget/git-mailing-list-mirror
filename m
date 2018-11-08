Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E2A1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeKHOOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47302 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbeKHOOO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:14 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84bwu8026337;
        Wed, 7 Nov 2018 20:40:38 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm9610eb8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:37 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 23:40:35 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 23:40:34 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 2A30B2101E98;
        Wed,  7 Nov 2018 20:40:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 09/10] t6036, t6043: increase code coverage for file collision handling
Date:   Wed, 7 Nov 2018 20:40:30 -0800
Message-ID: <20181108044031.25885-10-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108044031.25885-1-newren@gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
 <20181108044031.25885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stolee's coverage reports found a few code blocks for file collision
conflicts that had not previously been covered by testcases; add a few
more testcases to cover those too.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh   | 51 +++++++++++++++++++++++++++++
 t/t6043-merge-rename-directories.sh | 37 +++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 99cddb05af..b7488b00c0 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -240,6 +240,57 @@ test_expect_success 'git detects differently handled merges conflict' '
 	)
 '
 
+# Repeat the above testcase with precisely the same setup, other than with
+# the two merge bases having different orderings of commit timestamps so
+# that they are reversed in the order they are provided to merge-recursive,
+# so that we can improve code coverage.
+test_expect_success 'git detects differently handled merges conflict, swapped' '
+	(
+		cd rename-add &&
+
+		# Difference #1: Do cleanup from previous testrun
+		git reset --hard &&
+		git clean -fdqx &&
+
+		# Difference #2: Change commit timestamps
+		btime=$(git log --no-walk --date=raw --format=%cd B | awk "{print \$1}") &&
+		ctime=$(git log --no-walk --date=raw --format=%cd C | awk "{print \$1}") &&
+		newctime=$(($btime+1)) &&
+		git fast-export --no-data --all | sed -e s/$ctime/$newctime/ | git fast-import --force --quiet &&
+		# End of differences; rest is copy-paste of last test
+
+		git checkout D^0 &&
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect       \
+			C:new_a  D:new_a  E:new_a &&
+		git rev-parse   >actual     \
+			:1:new_a :2:new_a :3:new_a &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in new_a is as expected
+		git cat-file -p D:new_a >ours &&
+		git cat-file -p E:new_a >theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "E^0" \
+			ours empty theirs &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" ours >expect &&
+		git hash-object new_a >actual &&
+		git hash-object ours  >expect &&
+		test_cmp expect actual
+	)
+'
+
 #
 # criss-cross + modify/delete:
 #
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 5c01a0c14a..62c564707b 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3163,6 +3163,43 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 	)
 '
 
+test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2), other direction' '
+	(
+		cd 10c &&
+
+		git reset --hard &&
+		git clean -fdqx &&
+
+		git checkout B^0 &&
+		mkdir y &&
+		echo important >y/c &&
+
+		test_must_fail git merge -s recursive A^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c~HEAD >actual &&
+		git rev-parse O:x/c >expect &&
+		test_cmp expect actual &&
+
+		echo important >expect &&
+		test_cmp expect y/c
+	)
+'
+
 # Testcase 10d, Delete untracked w/ dir rename/rename(2to1)
 #   Commit O: z/{a,b,c_1},        x/{d,e,f_2}
 #   Commit A: y/{a,b},            x/{d,e,f_2,wham_1} + untracked y/wham
-- 
2.19.1.858.g526e8fe740.dirty

