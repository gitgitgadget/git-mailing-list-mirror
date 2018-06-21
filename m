Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848861F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeFUPA6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:00:58 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42744 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933186AbeFUPAp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 11:00:45 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LEqUKp017557;
        Thu, 21 Jun 2018 08:00:26 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jmyevrwv2-1;
        Thu, 21 Jun 2018 08:00:26 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 82A0722FE3C3;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 78CE82CDE76;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 4/7] git-rebase: error out when incompatible options passed
Date:   Thu, 21 Jun 2018 08:00:20 -0700
Message-Id: <20180621150023.23533-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.99.g3b7a0dc564
In-Reply-To: <20180621150023.23533-1-newren@gmail.com>
References: <20180617055856.22838-1-newren@gmail.com>
 <20180621150023.23533-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210165
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
 git-rebase.sh                          | 34 ++++++++++++++++++++++++++
 t/t3422-rebase-incompatible-options.sh | 16 ++++++------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bf71b7fa20..590bdbb12a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -503,6 +503,23 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$git_am_opt"; then
+	incompatible_opts=$(echo "$git_am_opt" | sed -e 's/ -q//')
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
@@ -511,6 +528,23 @@ then
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
index 157374143f..415d5226bf 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -34,27 +34,27 @@ test_expect_success 'setup' '
 test_run_rebase () {
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
@@ -71,17 +71,17 @@ test_expect_success '--preserve-merges incompatible with --signoff' '
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
2.18.0.rc2.92.g133ed01dde

