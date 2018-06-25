Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C62E1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFYQOv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:14:51 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39950 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752327AbeFYQNX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:23 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PGCmlh000792;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01t2c68-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6988F226E7FC;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 559252CDE65;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 4/9] git-rebase: error out when incompatible options passed
Date:   Mon, 25 Jun 2018 09:12:55 -0700
Message-Id: <20180625161300.26060-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
 <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase has three different types: am, merge, and interactive, all of
which are implemented in terms of separate scripts.  am builds on git-am,
merge builds on git-merge-recursive, and interactive builds on
git-cherry-pick.  We make use of features in those lower-level commands in
the different rebase types, but those features don't exist in all of the
lower level commands so we have a range of incompatibilities.  Previously,
we just accepted nearly any argument and silently ignored whichever ones
weren't implemented for the type of rebase specified.  Change this so the
incompatibilities are documented, included in the testsuite, and tested
for at runtime with an appropriate error message shown.

Some exceptions I left out:

  * --merge and --interactive are technically incompatible since they are
    supposed to run different underlying scripts, but with a few small
    changes, --interactive can do everything that --merge can.  In fact,
    I'll shortly be sending another patch to remove git-rebase--merge and
    reimplement it on top of git-rebase--interactive.

  * One could argue that --interactive and --quiet are incompatible since
    --interactive doesn't implement a --quiet mode (perhaps since
    cherry-pick itself does not implement one).  However, the interactive
    mode is more quiet than the other modes in general with progress
    messages, so one could argue that it's already quiet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh                          | 35 ++++++++++++++++++++++++++
 t/t3422-rebase-incompatible-options.sh | 16 ++++++------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bf71b7fa20..18ac8226c4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -503,6 +503,24 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$git_am_opt"; then
+	incompatible_opts=$(echo " $git_am_opt " | \
+			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
+	if test -n "$interactive_rebase"
+	then
+		if test -n "$incompatible_opts"
+		then
+			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
+		fi
+	fi
+	if test -n "$do_merge"; then
+		if test -n "$incompatible_opts"
+		then
+			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
+		fi
+	fi
+fi
+
 if test -n "$signoff"
 then
 	test -n "$preserve_merges" &&
@@ -511,6 +529,23 @@ then
 	force_rebase=t
 fi
 
+if test -n "$preserve_merges"
+then
+	# Note: incompatibility with --signoff handled in signoff block above
+	# Note: incompatibility with --interactive is just a strong warning;
+	#       git-rebase.txt caveats with "unless you know what you are doing"
+	test -n "$rebase_merges" &&
+		die "$(gettext "error: cannot combine '--preserve_merges' with '--rebase-merges'")"
+fi
+
+if test -n "$rebase_merges"
+then
+	test -n "$strategy_opts" &&
+		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy-option'")"
+	test -n "$strategy" &&
+		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy'")"
+fi
+
 if test -z "$rebase_root"
 then
 	case "$#" in
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 2687a85254..fc0ce150d1 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -33,27 +33,27 @@ test_expect_success 'setup' '
 test_rebase_am_only () {
 	opt=$1
 	shift
-	test_expect_failure "$opt incompatible with --merge" "
+	test_expect_success "$opt incompatible with --merge" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --merge A
 	"
 
-	test_expect_failure "$opt incompatible with --strategy=ours" "
+	test_expect_success "$opt incompatible with --strategy=ours" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --strategy=ours A
 	"
 
-	test_expect_failure "$opt incompatible with --strategy-option=ours" "
+	test_expect_success "$opt incompatible with --strategy-option=ours" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --strategy=ours A
 	"
 
-	test_expect_failure "$opt incompatible with --interactive" "
+	test_expect_success "$opt incompatible with --interactive" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --interactive A
 	"
 
-	test_expect_failure "$opt incompatible with --exec" "
+	test_expect_success "$opt incompatible with --exec" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --exec 'true' A
 	"
@@ -70,17 +70,17 @@ test_expect_success '--preserve-merges incompatible with --signoff' '
 	test_must_fail git rebase --preserve-merges --signoff A
 '
 
-test_expect_failure '--preserve-merges incompatible with --rebase-merges' '
+test_expect_success '--preserve-merges incompatible with --rebase-merges' '
 	git checkout B^0 &&
 	test_must_fail git rebase --preserve-merges --rebase-merges A
 '
 
-test_expect_failure '--rebase-merges incompatible with --strategy' '
+test_expect_success '--rebase-merges incompatible with --strategy' '
 	git checkout B^0 &&
 	test_must_fail git rebase --rebase-merges -s resolve A
 '
 
-test_expect_failure '--rebase-merges incompatible with --strategy-option' '
+test_expect_success '--rebase-merges incompatible with --strategy-option' '
 	git checkout B^0 &&
 	test_must_fail git rebase --rebase-merges -Xignore-space-change A
 '
-- 
2.18.0.9.g678597d97e

