Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146221F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeJMFAZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:00:25 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39116 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbeJMFAZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Oct 2018 01:00:25 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CLNeXX011256;
        Fri, 12 Oct 2018 14:25:59 -0700
Received: from mail.palantir.com (mxw2.palantir.com [66.70.54.22] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mxtwhajtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 Oct 2018 14:25:59 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 12 Oct 2018 14:25:57 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 12 Oct 2018 14:25:57 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 12 Oct 2018 14:25:53 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 6FBA7209F066;  Fri, 12 Oct 2018 14:25:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/4] t6036: add testcase where virtual merge base contains nested conflicts
Date:   Fri, 12 Oct 2018 14:25:48 -0700
Message-ID: <20181012212551.7689-2-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.235.g7c386e1068
In-Reply-To: <20181012212551.7689-1-newren@gmail.com>
References: <20181012212551.7689-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merges involve content conflicts, merge.conflictstyle=diff3 can be
used to also show the content for the file from the base version.  If
there was more than one merge base, then the "base version" is
determined by merging the merge bases to create a virtual merge base.
This means that the "base version" of the file can itself already have
conflict markers.  In the past, this could have created a situation
where users have difficulty distinguishing between the inner and outer
conflict markers.  However, commit d694a17986a2 ("ll-merge: use a longer
conflict marker for internal merge", 2016-04-14) addressed this issue by
making conflict markers two characters longer for a virtual merge base.

Unfortunately, this solution was incomplete.  The recursive merge
algorithm is, as you'd expect from it's name, recursive in nature.  In
particular, this means that the virtual merge base itself could have had
a virtual merge base of its own that contained conflict markers.  In
other words, we can have three (or more) levels of conflict markers when
using merge.conflictstyle=diff3.  Thus, what we need is for conflict
marker length to increase with the depth of recursion.  Add a testcase
demonstrating the problem and testing for marker length increasing with
increasing recursion depth.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 151 ++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 59e52c5a09..1d1135082c 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1402,4 +1402,155 @@ test_expect_failure 'check conflicting modes for regular file' '
 	)
 '
 
+# Setup:
+#          L1---L2---L3
+#         /  \ /  \ /  \
+#   master    X1   X2   ?
+#         \  / \  / \  /
+#          R1---R2---R3
+#
+# Where:
+#   master has one file named 'content'
+#   branches L1 and R1 both modify each of the two files in conflicting ways
+#
+#   L<n> (n>1) is a merge of R<n-1> into L<n-1>
+#   R<n> (n>1) is a merge of L<n-1> into R<n-1>
+#   L<n> and R<n> resolve the conflicts differently.
+#
+#   X<n> is an auto-generated merge-base used when merging L<n+1> and R<n+1>.
+#   By construction, X1 has conflict markers due to conflicting versions.
+#   X2, due to using merge.conflictstyle=3, has nested conflict markers.
+#
+#   So, merging R3 into L3 using merge.conflictstyle=3 should show the
+#   nested conflict markers from X2 in the base version -- that means we
+#   have three levels of conflict markers.  Can we distinguish all three?
+
+test_expect_success "setup virtual merge base with nested conflicts" '
+	test_create_repo virtual_merge_base_has_nested_conflicts &&
+	(
+		cd virtual_merge_base_has_nested_conflicts &&
+
+		# Create some related files now
+		for i in $(test_seq 1 10)
+		do
+			echo Random base content line $i
+		done >content &&
+
+		# Setup original commit
+		git add content &&
+		test_tick && git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Create L1
+		git checkout L &&
+		echo left >>content &&
+		git add content &&
+		test_tick && git commit -m "version L1 of content" &&
+		git tag L1 &&
+
+		# Create R1
+		git checkout R &&
+		echo right >>content &&
+		git add content &&
+		test_tick && git commit -m "verson R1 of content" &&
+		git tag R1 &&
+
+		# Create L2
+		git checkout L &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge R1 &&
+		git checkout L1 content &&
+		test_tick && git commit -m "version L2 of content" &&
+		git tag L2 &&
+
+		# Create R2
+		git checkout R &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge L1 &&
+		git checkout R1 content &&
+		test_tick && git commit -m "version R2 of content" &&
+		git tag R2 &&
+
+		# Create L3
+		git checkout L &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge R2 &&
+		git checkout L1 content &&
+		test_tick && git commit -m "version L3 of content" &&
+		git tag L3 &&
+
+		# Create R3
+		git checkout R &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge L2 &&
+		git checkout R1 content &&
+		test_tick && git commit -m "version R3 of content" &&
+		git tag R3
+	)
+'
+
+test_expect_failure "check virtual merge base with nested conflicts" '
+	(
+		cd virtual_merge_base_has_nested_conflicts &&
+
+		git checkout L3^0 &&
+
+		# Merge must fail; there is a conflict
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R3^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		# Ensure we have the correct number of untracked files
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		# Compare :[23]:content to expected values
+		git rev-parse L1:content R1:content >expect &&
+		git rev-parse :2:content :3:content >actual &&
+		test_cmp expect actual &&
+
+		# Imitate X1 merge base, except without long enough conflict
+		# markers because a subsequent sed will modify them.  Put
+		# result into vmb.
+		git cat-file -p master:content >base &&
+		git cat-file -p L:content >left &&
+		git cat-file -p R:content >right &&
+		cp left merged-once &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			merged-once \
+			base        \
+			right       &&
+		sed -e "s/^\([<|=>]\)/\1\1\1/" merged-once >vmb &&
+
+		# Imitate X2 merge base, overwriting vmb.  Note that we
+		# extend both sets of conflict markers to make them longer
+		# with the sed command.
+		cp left merged-twice &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			merged-twice \
+			vmb          \
+			right        &&
+		sed -e "s/^\([<|=>]\)/\1\1\1/" merged-twice >vmb &&
+
+		# Compare :1:content to expected value
+		git cat-file -p :1:content >actual &&
+		test_cmp vmb actual &&
+
+		# Determine expected content in final outer merge, compare to
+		# what the merge generated.
+		cp -f left expect &&
+		test_must_fail git merge-file --diff3                      \
+			-L "HEAD"  -L "merged common ancestors"  -L "R3^0" \
+			expect     vmb                           right     &&
+		test_cmp expect content
+	)
+'
+
 test_done
-- 
2.19.0.235.g7c386e1068

