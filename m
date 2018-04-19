Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387B61F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeDSSBD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 14:01:03 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42094 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751386AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4Ox014666;
        Thu, 19 Apr 2018 10:58:28 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au82-1;
        Thu, 19 Apr 2018 10:58:28 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 689DF22175B8;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5FB752CDEF0;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 04/36] directory rename detection: partially renamed directory testcase/discussion
Date:   Thu, 19 Apr 2018 10:57:51 -0700
Message-Id: <20180419175823.7946-5-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a long note about why we are not considering "partial directory
renames" for the current directory rename detection implementation.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6043-merge-rename-directories.sh | 115 ++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 8049ed5fc9..713ad2b75e 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -735,4 +735,119 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 #   of a rename on either side of a merge.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 4: Partially renamed directory; still exists on both sides of merge
+#
+# What if we were to attempt to do directory rename detection when someone
+# "mostly" moved a directory but still left some files around, or,
+# equivalently, fully renamed a directory in one commmit and then recreated
+# that directory in a later commit adding some new files and then tried to
+# merge?
+#
+# It's hard to divine user intent in these cases, because you can make an
+# argument that, depending on the intermediate history of the side being
+# merged, that some users will want files in that directory to
+# automatically be detected and renamed, while users with a different
+# intermediate history wouldn't want that rename to happen.
+#
+# I think that it is best to simply not have directory rename detection
+# apply to such cases.  My reasoning for this is four-fold: (1) it's
+# easiest for users in general to figure out what happened if we don't
+# apply directory rename detection in any such case, (2) it's an easy rule
+# to explain ["We don't do directory rename detection if the directory
+# still exists on both sides of the merge"], (3) we can get some hairy
+# edge/corner cases that would be really confusing and possibly not even
+# representable in the index if we were to even try, and [related to 3] (4)
+# attempting to resolve this issue of divining user intent by examining
+# intermediate history goes against the spirit of three-way merges and is a
+# path towards crazy corner cases that are far more complex than what we're
+# already dealing with.
+#
+# Note that the wording of the rule ("We don't do directory rename
+# detection if the directory still exists on both sides of the merge.")
+# also excludes "renaming" of a directory into a subdirectory of itself
+# (e.g. /some/dir/* -> /some/dir/subdir/*).  It may be possible to carve
+# out an exception for "renaming"-beneath-itself cases without opening
+# weird edge/corner cases for other partial directory renames, but for now
+# we are keeping the rule simple.
+#
+# This section contains a test for a partially-renamed-directory case.
+###########################################################################
+
+# Testcase 4a, Directory split, with original directory still present
+#   (Related to testcase 1f)
+#   Commit O: z/{b,c,d,e}
+#   Commit A: y/{b,c,d}, z/e
+#   Commit B: z/{b,c,d,e,f}
+#   Expected: y/{b,c,d}, z/{e,f}
+#   NOTE: Even though most files from z moved to y, we don't want f to follow.
+
+test_expect_success '4a-setup: Directory split, with original directory still present' '
+	test_create_repo 4a &&
+	(
+		cd 4a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		echo e >z/e &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo f >z/f &&
+		git add z/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '4a-check: Directory split, with original directory still present' '
+	(
+		cd 4a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/e HEAD:z/f &&
+		git rev-parse >expect \
+			O:z/b    O:z/c    O:z/d    O:z/e    B:z/f &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 4:
+#
+#   Directory-rename-detection should be turned off for any directories (as
+#   a source for renames) that exist on both sides of the merge.  (The "as
+#   a source for renames" clarification is due to cases like 1c where
+#   the target directory exists on both sides and we do want the rename
+#   detection.)  But, sadly, see testcase 8b.
+###########################################################################
+
 test_done
-- 
2.17.0.290.ge988e9ce2a

