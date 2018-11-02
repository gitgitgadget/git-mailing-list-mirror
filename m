Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCCD1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeKCENa (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:13:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55164 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725728AbeKCEN3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 00:13:29 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2J3p3s003190;
        Fri, 2 Nov 2018 12:05:08 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ncmwmg782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 02 Nov 2018 12:05:08 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 2 Nov 2018 12:05:18 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 2 Nov 2018 12:04:59 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id E273D20C2004;
        Fri,  2 Nov 2018 12:05:06 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 10/10] fixup! merge-recursive: improve rename/rename(1to2)/add[/add] handling
Date:   Fri, 2 Nov 2018 12:05:00 -0700
Message-ID: <20181102190500.31603-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.232.gd14c2061fc
In-Reply-To: <20181102185317.31015-1-newren@gmail.com>
References: <20181102185317.31015-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020169
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This test added solely to improve code coverage of new code added in
this series.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

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
2.19.0.232.gd14c2061fc

