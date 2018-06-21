Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457661F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933288AbeFUPAs (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:00:48 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42748 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933285AbeFUPAq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 11:00:46 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LEqUKq017557;
        Thu, 21 Jun 2018 08:00:27 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jmyevrwv3-1;
        Thu, 21 Jun 2018 08:00:27 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8EA3E22FE3C4;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 82E442CDE86;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 5/7] git-rebase.txt: document behavioral inconsistencies between modes
Date:   Thu, 21 Jun 2018 08:00:21 -0700
Message-Id: <20180621150023.23533-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.99.g3b7a0dc564
In-Reply-To: <20180621150023.23533-1-newren@gmail.com>
References: <20180617055856.22838-1-newren@gmail.com>
 <20180621150023.23533-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=653 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210165
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
 Documentation/git-rebase.txt | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7de6523931..340137e2cf 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -556,6 +556,63 @@ Other incompatible flag pairs:
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
 
+BEHAVIORAL INCONSISTENCIES
+--------------------------
+
+  * --no-ff vs. --force-rebase
+
+    These options are actually identical, though their description
+    leads people to believe they might not be.
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
+    The --keep-empty option exists for interactive rebases to allow
+    it to keep commits that started empty.
+
+  * empty commit messages:
+
+    am-based rebase will silently apply commits with empty commit
+    messages.
+
+    merge-based and interactive-based rebases will by default halt
+    on any such commits.  The --allow-empty-message option exists to
+    allow interactive-based rebases to apply such commits without
+    halting.
+
+  * directory rename detection:
+
+    merge-based and interactive-based rebases work fine with
+    directory rename detection.  am-based rebases sometimes do not.
+
+    git-am tries to avoid a full three way merge, instead calling
+    git-apply.  That prevents us from detecting renames at all,
+    which may defeat the directory rename detection.  There is a
+    fallback, though; if the initial git-apply fails and the user
+    has specified the -3 option, git-am will fall back to a three
+    way merge.  However, git-am lacks the necessary information to
+    do a "real" three way merge.  Instead, it has to use
+    build_fake_ancestor() to get a merge base that is missing files
+    whose rename may have been important to detect for directory
+    rename detection to function.
+
+    Since am-based rebases work by first generating a bunch of
+    patches (which no longer record what the original commits were
+    and thus don't have the necessary info from which we can find a
+    real merge-base), and then calling git-am, this implies that
+    am-based rebases will not always successfully detect directory
+    renames either.  merged-based rebases (rebase -m) and
+    cherry-pick-based rebases (rebase -i) are not affected by this
+    shortcoming.
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
2.18.0.rc2.92.g133ed01dde

