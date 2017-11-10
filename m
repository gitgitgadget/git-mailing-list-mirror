Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099891F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbdKJTG1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:27 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48726 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753701AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4Gr4002777;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgs-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 078FF22F6288;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id F28D92CDEC3;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/30] directory rename detection: partially renamed directory testcase/discussion
Date:   Fri, 10 Nov 2017 11:05:27 -0800
Message-Id: <20171110190550.27059-8-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 021513ec00..ec054b210a 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -650,4 +650,104 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
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
+# This section contains a test for this partially-renamed-directory case.
+###########################################################################
+
+# Testcase 4a, Directory split, with original directory still present
+#   (Related to testcase 1f)
+#   Commit A: z/{b,c,d,e}
+#   Commit B: y/{b,c,d}, z/e
+#   Commit C: z/{b,c,d,e,f}
+#   Expected: y/{b,c,d}, z/{e,f}
+#   NOTE: Even though most files from z moved to y, we don't want f to follow.
+
+test_expect_success '4a-setup: Directory split, with original directory still present' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo d >z/d &&
+	echo e >z/e &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	mkdir y &&
+	git mv z/b y/ &&
+	git mv z/c y/ &&
+	git mv z/d y/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo f >z/f &&
+	git add z/f &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_success '4a-check: Directory split, with original directory still present' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse HEAD:y/d) = $(git rev-parse A:z/d) &&
+	test $(git rev-parse HEAD:z/e) = $(git rev-parse A:z/e) &&
+	test $(git rev-parse HEAD:z/f) = $(git rev-parse C:z/f)
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
2.15.0.5.g9567be9905

