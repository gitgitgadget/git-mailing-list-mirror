Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135541F453
	for <e@80x24.org>; Fri,  2 Nov 2018 18:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeKCECF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:02:05 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35722 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730606AbeKCEBs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 00:01:48 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2InIek009923;
        Fri, 2 Nov 2018 11:53:30 -0700
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ncnvk80vr-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 02 Nov 2018 11:53:30 -0700
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 2 Nov 2018 14:53:25 -0400
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 2 Nov 2018 14:53:25 -0400
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id BDAEF2101970;
        Fri,  2 Nov 2018 11:53:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v4 09/10] fixup! merge-recursive: fix rename/add conflict handling
Date:   Fri, 2 Nov 2018 11:53:17 -0700
Message-ID: <20181102185317.31015-10-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.232.gd14c2061fc
In-Reply-To: <20181102185317.31015-1-newren@gmail.com>
References: <20181019193111.12051-1-newren@gmail.com>
 <20181102185317.31015-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This test added solely to improve code coverage of new code added in
this series.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

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
-- 
2.19.0.232.gd14c2061fc

