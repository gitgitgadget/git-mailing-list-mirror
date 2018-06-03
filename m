Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF5F1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeFCG6R (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:17 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48614 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750981AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536s26L018495;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3g93kf-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5C866228A260;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5378B2CDE66;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/7] merge requirement: index matches head
Date:   Sat,  2 Jun 2018 23:58:03 -0700
Message-Id: <20180603065810.23841-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.49.g3c08dc0fef
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Between working on some other things, I happened to be reading
Documentation/git-merge.txt and ran across the part that says:

    ...[merge will] abort if there are any changes registered in the
    index relative to the `HEAD` commit.  (One exception is when the
    changed index entries are in the state that would result from the
    merge already.)

I was pretty sure this statement was wrong, but did some digging to
uncover the details and the history.  What I thought would turn into a
simple three-line documentation fix, ballooned into this patch series.

This series might be best read in a different order; I'm not yet sure
the right way to structure it.  But:

  * Patch 5 demonstrates one of the ways that the parenthetical
    sentence is wrong (desirable perhaps, but not what is implemented)

  * Patch 7 explains the history, the trade-offs, the three ways the
    parenthetical sentence is wrong, and the many pitfalls we've run
    into trying to allow for such an exception.  Very small
    documentation fix with a huge commit message.

  * Patch 6 fixes the breakage demonstrated in patch 5, but if I only
    submitted patches 5-7, then the testsuite wouldn't pass because
    this fix uncovered multiple other bugs.  That's where patches 1-4
    came in.  This fix is also kind of opinionated; it takes the stance
    that allowing the exceptions isn't worth it.

Elijah Newren (7):
  t6044: verify that merges expected to abort actually abort
  t6044: add a testcase for index matching head, when head doesn't match HEAD
  merge-recursive: make sure when we say we abort that we actually abort
  merge-recursive: fix assumption that head tree being merged is HEAD
  t6044: add more testcases with staged changes before a merge is invoked
  merge-recursive: enforce rule that index matches head before merging
  merge: fix misleading pre-merge check documentation

 Documentation/git-merge.txt              |   6 +-
 builtin/am.c                             |   6 +-
 cache.h                                  |   8 --
 merge-recursive.c                        |  14 +--
 merge.c                                  |  10 +-
 t/t6044-merge-unrelated-index-changes.sh |  67 +++++++++++--
 t/t7504-commit-msg-hook.sh               |   4 +-
 t/t7611-merge-abort.sh                   | 118 -----------------------
 tree.h                                   |   8 ++
 9 files changed, 87 insertions(+), 154 deletions(-)

-- 
2.18.0.rc0.49.g3c08dc0fef

