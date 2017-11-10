Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3803A1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754640AbdKJWWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:16 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50370 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754478AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMD9eq030648;
        Fri, 10 Nov 2017 14:22:03 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1nd5-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8034822F94C1;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 75F612CDE6A;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/9] Improve rename detection performance in merge recursive
Date:   Fri, 10 Nov 2017 14:21:47 -0800
Message-Id: <20171110222156.23221-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on BOTH my rename-limits and directory-detection
series
(https://public-inbox.org/git/20171110173956.25105-1-newren@gmail.com/
and
https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/).
This series could be modified to be submitted with no dependencies on
those series, but it'd end up causing lots of merging conflicts, and
having this series depend on the other two seemed most logical to me.

This patch series tries to improve performance rename detection
performance in merge recursive where possible.  In particular, I was
guided by a specific usecase of cherry-picking a small change (by
which I mean 7 files with small modifications and one new file) in a
repo that has thousands of renames, due to some high-level directories
having been renamed.  Some of the changes should help rename detection
performance in general, but the greatest benefit will be found when
one side of history only makes a small number of changes.  For my
usecase, I dropped the time needed for the cherry-pick from over 9
minutes, down to about 16 seconds.

RFC because:

  * I believe the patch with the biggest performance improvement will
    break directory rename detection in specific, limited cases (which
    are not yet represented in the testsuite).  Should be fixable; I
    just need to implement the fix.  (The fix may reduce the
    performance improvement slightly).
    
  * This series includes changes to conflict handling for conflict
    types that involve two colliding files.  I think the new behavior
    is strictly better, but this is the kind of thing I really need to
    make sure others agree with; comments very welcome.  (Patches 2--6)

  * 16 seconds is still annoyingly slow; we should be able to do better.
    I have one or two ideas.  But since others are asking about the
    performance of small cherry-picks in large repos with lots of renames,
    I figure it's worth posting what I have so far.

Elijah Newren (9):
  diffcore-rename: No point trying to find a match better than exact
  merge-recursive: Avoid unnecessary string list lookups
  merge-recursive: New function for better colliding conflict
    resolutions
  Add testcases for improved file collision conflict handling
  merge-recursive: Fix rename/add conflict handling
  merge-recursive: Improve handling for rename/rename(2to1) conflicts
  merge-recursive: Improve handling for add/add conflicts
  merge-recursive: Accelerate rename detection
  diffcore-rename: Filter rename_src list when possible

 diff.c                               |   1 +
 diff.h                               |   7 +
 diffcore-rename.c                    |  85 ++++++-
 merge-recursive.c                    | 452 ++++++++++++++++++++++++-----------
 t/t2023-checkout-m.sh                |   2 +-
 t/t3418-rebase-continue.sh           |  27 ++-
 t/t3504-cherry-pick-rerere.sh        |  19 +-
 t/t4200-rerere.sh                    |  12 +-
 t/t6020-merge-df.sh                  |   4 +-
 t/t6024-recursive-merge.sh           |  35 +--
 t/t6025-merge-symlinks.sh            |   9 +-
 t/t6031-merge-filemode.sh            |   4 +-
 t/t6036-recursive-corner-cases.sh    |  19 +-
 t/t6042-merge-rename-corner-cases.sh | 212 +++++++++++++++-
 t/t6043-merge-rename-directories.sh  |  13 +-
 t/t7060-wtstatus.sh                  |   1 +
 t/t7064-wtstatus-pv2.sh              |   4 +-
 t/t7506-status-submodule.sh          |  11 +-
 t/t7610-mergetool.sh                 |  28 +--
 19 files changed, 722 insertions(+), 223 deletions(-)

-- 
2.15.0.46.g41dca04efb

