Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A9C1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFUPBD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:01:03 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58691 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932948AbeFUPAo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 11:00:44 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LEqUDK017560;
        Thu, 21 Jun 2018 08:00:26 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jmyevrwuy-1;
        Thu, 21 Jun 2018 08:00:26 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4024622FE3BF;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 332BA2CDE76;
        Thu, 21 Jun 2018 08:00:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/7] Document/fix/warn about rebase incompatibilities and inconsistencies
Date:   Thu, 21 Jun 2018 08:00:16 -0700
Message-Id: <20180621150023.23533-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.99.g3b7a0dc564
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180617055856.22838-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210165
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase has lots of options that are mutually incompatible.  Even among
aspects of its behavior that is common to all rebase types, it has a number
of inconsistencies.  This series tries to document, fix, and/or warn users
about many of these.

I have left patch 7 in RFC state.  We probably need more opinions
about it, and whether cherry-pick should also be changed to match.

Changes since v2 (full branch-diff below):
  - Slight changes to documentation wording
  - Add incompatibilitiy of --rebase-merges and --strategy-option
  - Add tests and code for incompatibilities involving either
    --preserve-merges or --rebase-merges
  - Slightly more detail in the commit message for making -m and -i behave
    the same with empty commit messages as am-based rebases.

Many thanks to Phillip for reviewing the last series, and Eric who pointed
out the wording improvements.

Elijah Newren (7):
  git-rebase.txt: document incompatible options
  git-rebase.sh: update help messages a bit
  t3422: new testcases for checking when incompatible options passed
  git-rebase: error out when incompatible options passed
  git-rebase.txt: document behavioral inconsistencies between modes
  git-rebase.txt: address confusion between --no-ff vs --force-rebase
  git-rebase: make --allow-empty-message the default

 Documentation/git-rebase.txt           | 155 ++++++++++++++++++++-----
 git-rebase.sh                          |  42 ++++++-
 t/t3404-rebase-interactive.sh          |   7 +-
 t/t3405-rebase-malformed.sh            |  11 +-
 t/t3422-rebase-incompatible-options.sh |  89 ++++++++++++++
 5 files changed, 262 insertions(+), 42 deletions(-)
 create mode 100755 t/t3422-rebase-incompatible-options.sh

 1: d184d5bd3f !  1: 4cdf9130cc git-rebase.txt: document incompatible options
    @@ -191,14 +191,15 @@
     + * --keep-empty
     + * --autosquash
     + * --edit-todo
    -+ * --root + --onto
    ++ * --root when used in combination with --onto
     +
     +Other incompatible flag pairs:
     +
    -+ * --preserve-merges && --interactive
    -+ * --preserve-merges && --signoff
    -+ * --preserve-merges && --rebase-merges
    -+ * --rebase-merges && --strategy
    ++ * --preserve-merges and --interactive
    ++ * --preserve-merges and --signoff
    ++ * --preserve-merges and --rebase-merges
    ++ * --rebase-merges and --strategy
    ++ * --rebase-merges and --strategy-option
     +
      include::merge-strategies.txt[]
      
 2: 788df9fa43 =  2: e336f76c5e git-rebase.sh: update help messages a bit
 3: d3d124795a !  3: 4ab38d8a5f t3422: new testcases for checking when incompatible options passed
    @@ -83,4 +83,24 @@
     +test_run_rebase --committer-date-is-author-date
     +test_run_rebase -C4
     +
    ++test_expect_success '--preserve-merges incompatible with --signoff' '
    ++	git checkout B^0 &&
    ++	test_must_fail git rebase --preserve-merges --signoff A
    ++'
    ++
    ++test_expect_failure '--preserve-merges incompatible with --rebase-merges' '
    ++	git checkout B^0 &&
    ++	test_must_fail git rebase --preserve-merges --rebase-merges A
    ++'
    ++
    ++test_expect_failure '--rebase-merges incompatible with --strategy' '
    ++	git checkout B^0 &&
    ++	test_must_fail git rebase --rebase-merges -s resolve A
    ++'
    ++
    ++test_expect_failure '--rebase-merges incompatible with --strategy-option' '
    ++	git checkout B^0 &&
    ++	test_must_fail git rebase --rebase-merges -Xignore-space-change A
    ++'
    ++
     +test_done
 4: 28d2dfd49a !  4: 5223954caf git-rebase: error out when incompatible options passed
    @@ -56,6 +56,30 @@
      if test -n "$signoff"
      then
      	test -n "$preserve_merges" &&
    +@@
    + 	force_rebase=t
    + fi
    + 
    ++if test -n "$preserve_merges"
    ++then
    ++	# Note: incompatibility with --signoff handled in signoff block above
    ++	# Note: incompatibility with --interactive is just a strong warning;
    ++	#       git-rebase.txt caveats with "unless you know what you are doing"
    ++	test -n "$rebase_merges" &&
    ++		die "$(gettext "error: cannot combine '--preserve_merges' with '--rebase-merges'")"
    ++fi
    ++
    ++if test -n "$rebase_merges"
    ++then
    ++	test -n "$strategy_opts" &&
    ++		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy-option'")"
    ++	test -n "$strategy" &&
    ++		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy'")"
    ++fi
    ++
    + if test -z "$rebase_root"
    + then
    + 	case "$#" in
     
     diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
     --- a/t/t3422-rebase-incompatible-options.sh
    @@ -93,3 +117,24 @@
      		git checkout B^0 &&
      		test_must_fail git rebase $opt --exec 'true' A
      	"
    +@@
    + 	test_must_fail git rebase --preserve-merges --signoff A
    + '
    + 
    +-test_expect_failure '--preserve-merges incompatible with --rebase-merges' '
    ++test_expect_success '--preserve-merges incompatible with --rebase-merges' '
    + 	git checkout B^0 &&
    + 	test_must_fail git rebase --preserve-merges --rebase-merges A
    + '
    + 
    +-test_expect_failure '--rebase-merges incompatible with --strategy' '
    ++test_expect_success '--rebase-merges incompatible with --strategy' '
    + 	git checkout B^0 &&
    + 	test_must_fail git rebase --rebase-merges -s resolve A
    + '
    + 
    +-test_expect_failure '--rebase-merges incompatible with --strategy-option' '
    ++test_expect_success '--rebase-merges incompatible with --strategy-option' '
    + 	git checkout B^0 &&
    + 	test_must_fail git rebase --rebase-merges -Xignore-space-change A
    + '
 5: b2eec2cc5a !  5: 96f7ba98bc git-rebase.txt: document behavioral inconsistencies between modes
    @@ -14,8 +14,8 @@
     --- a/Documentation/git-rebase.txt
     +++ b/Documentation/git-rebase.txt
     @@
    -  * --preserve-merges && --rebase-merges
    -  * --rebase-merges && --strategy
    +  * --rebase-merges and --strategy
    +  * --rebase-merges and --strategy-option
      
     +BEHAVIORAL INCONSISTENCIES
     +--------------------------
 6: cea18d7e60 =  6: 7bb7b380ac git-rebase.txt: address confusion between --no-ff vs --force-rebase
 7: ab8805c40a !  7: 3ed07548a6 git-rebase: make --allow-empty-message the default
    @@ -2,9 +2,13 @@
     
         git-rebase: make --allow-empty-message the default
     
    -    am-based rebases already apply commits with an empty commit message
    -    without requiring the user to specify an extra flag.  Make merge-based and
    -    interactive-based rebases behave the same.
    +    All rebase backends should behave the same with empty commit messages, but
    +    currently do not.  am-based rebases already apply commits with an empty
    +    commit message without stopping or requiring the user to specify an extra
    +    flag.  Since am-based rebases are the default rebase type, and since it
    +    appears no one has ever requested a --no-allow-empty-message flag to
    +    change this behavior, make --allow-empty-message the default so that
    +    merge-based and interactive-based rebases will behave the same.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
-- 
2.18.0.rc2.92.g133ed01dde
