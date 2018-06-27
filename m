Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0FC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932777AbeF0HXy (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:23:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36894 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932509AbeF0HXi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:23:38 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7N5gc023661;
        Wed, 27 Jun 2018 00:23:22 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mtgp4-1;
        Wed, 27 Jun 2018 00:23:21 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C7B9E22FD1A3;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id BC5BE2CDE65;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 6/9] directory-rename-detection.txt: technical docs on abilities and limitations
Date:   Wed, 27 Jun 2018 00:23:16 -0700
Message-Id: <20180627072319.31356-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627072319.31356-1-newren@gmail.com>
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270087
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/directory-rename-detection.txt  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/technical/directory-rename-detection.txt

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
new file mode 100644
index 0000000000..6e22920a39
--- /dev/null
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -0,0 +1,92 @@
+Directory rename detection
+==========================
+
+Rename detection logic in diffcore-rename that checks for renames of
+individual files is aggregated and analyzed in merge-recursive for cases
+where combinations of renames indicate that a full directory has been
+renamed.
+
+Scope of abilities
+------------------
+
+It is perhaps easiest to start with an example:
+
+  * When all of x/a, x/b and x/c have moved to z/a, z/b and z/c, it is
+    likely that x/d added in the meantime would also want to move to z/d by
+    taking the hint that the entire directory 'x' moved to 'z'.
+
+More interesting possibilities exist, though, such as:
+
+  * one side of history renames x -> z, and the other renames some file to
+    x/e, causing the need for the merge to do a transitive rename.
+
+  * one side of history renames x -> z, but also renames all files within
+    x.  For example, x/a -> z/alpha, x/b -> z/bravo, etc.
+
+  * both 'x' and 'y' being merged into a single directory 'z', with a
+    directory rename being detected for both x->z and y->z.
+
+  * not all files in a directory being renamed to the same location;
+    i.e. perhaps most the files in 'x' are now found under 'z', but a few
+    are found under 'w'.
+
+  * a directory being renamed, which also contained a subdirectory that was
+    renamed to some entirely different location.  (And perhaps the inner
+    directory itself contained inner directories that were renamed to yet
+    other locations).
+
+  * combinations of the above; see t/t6043-merge-rename-directories.sh for
+    various interesting cases.
+
+Limitations -- applicability of directory renames
+-------------------------------------------------
+
+In order to prevent edge and corner cases resulting in either conflicts
+that cannot be represented in the index or which might be too complex for
+users to try to understand and resolve, a couple basic rules limit when
+directory rename detection applies:
+
+  1) If a given directory still exists on both sides of a merge, we do
+     not consider it to have been renamed.
+
+  2) If a subset of to-be-renamed files have a file or directory in the
+     way (or would be in the way of each other), "turn off" the directory
+     rename for those specific sub-paths and report the conflict to the
+     user.
+
+  3) If the other side of history did a directory rename to a path that
+     your side of history renamed away, then ignore that particular
+     rename from the other side of history for any implicit directory
+     renames (but warn the user).
+
+Limitations -- detailed rules and testcases
+-------------------------------------------
+
+t/t6043-merge-rename-directories.sh contains extensive tests and commentary
+which generate and explore the rules listed above.  It also lists a few
+additional rules:
+
+  a) If renames split a directory into two or more others, the directory
+     with the most renames, "wins".
+
+  b) Avoid directory-rename-detection for a path, if that path is the
+     source of a rename on either side of a merge.
+
+  c) Only apply implicit directory renames to directories if the other side
+     of history is the one doing the renaming.
+
+Limitations -- support in different commands
+--------------------------------------------
+
+Directory rename detection is supported by 'merge' and 'cherry-pick'.
+Other git commands which users might be surprised to see limited or no
+directory rename detection support in:
+
+  * diff
+
+    Folks have requested in the past that `git diff` detect directory
+    renames and somehow simplify its output.  It is not clear whether this
+    would be desirable or how the output should be simplified, so this was
+    simply not implemented.  Further, to implement this, directory rename
+    detection logic would need to move from merge-recursive to
+    diffcore-rename.
-- 
2.18.0.9.g431b2c36d5

