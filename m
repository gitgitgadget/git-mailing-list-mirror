Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883691F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeFUPAp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:00:45 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:6765 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932963AbeFUPAo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 11:00:44 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LErZED032081;
        Thu, 21 Jun 2018 08:00:28 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jn0dk0uxg-1;
        Thu, 21 Jun 2018 08:00:27 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B5B0722FE3C6;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A2C362CDE86;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v3 7/7] git-rebase: make --allow-empty-message the default
Date:   Thu, 21 Jun 2018 08:00:23 -0700
Message-Id: <20180621150023.23533-8-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.99.g3b7a0dc564
In-Reply-To: <20180621150023.23533-1-newren@gmail.com>
References: <20180617055856.22838-1-newren@gmail.com>
 <20180621150023.23533-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=45 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210165
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All rebase backends should behave the same with empty commit messages, but
currently do not.  am-based rebases already apply commits with an empty
commit message without stopping or requiring the user to specify an extra
flag.  Since am-based rebases are the default rebase type, and since it
appears no one has ever requested a --no-allow-empty-message flag to
change this behavior, make --allow-empty-message the default so that
merge-based and interactive-based rebases will behave the same.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

See also
https://public-inbox.org/git/CABPp-BHrcUHX_zHxpojV5=sxJ1=NoDg9uhxv+NH5BsHsQYavPQ@mail.gmail.com/
for some discussion of this change.

 Documentation/git-rebase.txt  | 10 ----------
 git-rebase.sh                 |  2 +-
 t/t3404-rebase-interactive.sh |  7 ++++---
 t/t3405-rebase-malformed.sh   | 11 +++--------
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1f422cd0a7..3addcf8218 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -563,16 +563,6 @@ BEHAVIORAL INCONSISTENCIES
     The --keep-empty option exists for interactive rebases to allow
     it to keep commits that started empty.
 
-  * empty commit messages:
-
-    am-based rebase will silently apply commits with empty commit
-    messages.
-
-    merge-based and interactive-based rebases will by default halt
-    on any such commits.  The --allow-empty-message option exists to
-    allow interactive-based rebases to apply such commits without
-    halting.
-
   * directory rename detection:
 
     merge-based and interactive-based rebases work fine with
diff --git a/git-rebase.sh b/git-rebase.sh
index 590bdbb12a..a909a2cfb1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -95,7 +95,7 @@ rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
-allow_empty_message=
+allow_empty_message=--allow-empty-message
 signoff=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..81ce9fe7f9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,15 +553,16 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 '
 
 test_expect_success 'aborted --continue does not squash commits after "edit"' '
+	test_when_finished "git rebase --abort" &&
 	old=$(git rev-parse HEAD) &&
 	test_tick &&
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
-	test $old = $(git rev-parse HEAD) &&
-	git rebase --abort
+	echo all the things >>conflict &&
+	test_must_fail git rebase --continue &&
+	test $old = $(git rev-parse HEAD)
 '
 
 test_expect_success 'auto-amend only edited commits after "edit"' '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index cb7c6de84a..da94dddc86 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -77,19 +77,14 @@ test_expect_success 'rebase commit with diff in message' '
 '
 
 test_expect_success 'rebase -m commit with empty message' '
-	test_must_fail git rebase -m master empty-message-merge &&
-	git rebase --abort &&
-	git rebase -m --allow-empty-message master empty-message-merge
+	git rebase -m master empty-message-merge
 '
 
 test_expect_success 'rebase -i commit with empty message' '
 	git checkout diff-in-message &&
 	set_fake_editor &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i HEAD^ &&
-	git rebase --abort &&
-	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i --allow-empty-message HEAD^
+	env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
+		git rebase -i HEAD^
 '
 
 test_done
-- 
2.18.0.rc2.92.g133ed01dde

