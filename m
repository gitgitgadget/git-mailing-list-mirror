Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E431F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeFYQOx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:14:53 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39948 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752286AbeFYQNX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:23 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PGCct1000752;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01t2c6a-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 91589226FB3E;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7F6172CDE65;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 7/9] git-rebase.txt: document behavioral differences between modes
Date:   Mon, 25 Jun 2018 09:12:58 -0700
Message-Id: <20180625161300.26060-8-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
 <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a variety of aspects that are common to all rebases regardless
of which backend is in use; however, the behavior for these different
aspects varies in ways that could surprise users.  (In fact, it's not
clear -- to me at least -- that these differences were even desirable or
intentional.)  Document these differences.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt                  | 32 +++++++++++++++++++
 .../technical/directory-rename-detection.txt  | 23 +++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2f47495a4d..a67df4caba 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -546,6 +546,38 @@ Other incompatible flag pairs:
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
 
+BEHAVIORAL DIFFERENCES
+-----------------------
+
+ * empty commits:
+
+    am-based rebase will drop any "empty" commits, whether the
+    commit started empty (had no changes relative to its parent to
+    start with) or ended empty (all changes were already applied
+    upstream in other commits).
+
+    merge-based rebase does the same.
+
+    interactive-based rebase will by default drop commits that
+    started empty and halt if it hits a commit that ended up empty.
+    The `--keep-empty` option exists for interactive rebases to allow
+    it to keep commits that started empty.
+
+  * empty commit messages:
+
+    am-based rebase will silently apply commits with empty commit
+    messages.
+
+    merge-based and interactive-based rebases will by default halt
+    on any such commits.  The `--allow-empty-message` option exists to
+    allow interactive-based rebases to apply such commits without
+    halting.
+
+  * directory rename detection:
+
+    merge-based and interactive-based rebases work fine with
+    directory rename detection.  am-based rebases sometimes do not.
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 6e22920a39..1c0086e287 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -90,3 +90,26 @@ directory rename detection support in:
     simply not implemented.  Further, to implement this, directory rename
     detection logic would need to move from merge-recursive to
     diffcore-rename.
+
+  * am
+
+    git-am tries to avoid a full three way merge, instead calling
+    git-apply.  That prevents us from detecting renames at all, which may
+    defeat the directory rename detection.  There is a fallback, though; if
+    the initial git-apply fails and the user has specified the -3 option,
+    git-am will fall back to a three way merge.  However, git-am lacks the
+    necessary information to do a "real" three way merge.  Instead, it has
+    to use build_fake_ancestor() to get a merge base that is missing files
+    whose rename may have been important to detect for directory rename
+    detection to function.
+
+  * rebase
+
+    Since am-based rebases work by first generating a bunch of patches
+    (which no longer record what the original commits were and thus don't
+    have the necessary info from which we can find a real merge-base), and
+    then calling git-am, this implies that am-based rebases will not always
+    successfully detect directory renames either (see the 'am' section
+    above).  merged-based rebases (rebase -m) and cherry-pick-based rebases
+    (rebase -i) are not affected by this shortcoming, and fully support
+    directory rename detection.
-- 
2.18.0.9.g678597d97e

