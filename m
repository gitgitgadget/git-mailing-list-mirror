Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986AF202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdKTWTs (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:19:48 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41126 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751154AbdKTWTq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:19:46 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKMJG7G001667;
        Mon, 20 Nov 2017 14:19:44 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb9q3-1;
        Mon, 20 Nov 2017 14:19:44 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6ECE122F4648;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 65E672CDE75;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 0/9] Improve merge recursive performance
Date:   Mon, 20 Nov 2017 14:19:35 -0800
Message-Id: <20171120221944.15431-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200300
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You probably want to wait to review this series until my rename detection
series lands so that I can clean up any more conflicts, but I'm posting
this new series in case anyone wants to take an early look.  It includes
fixes identified by the reviews of my other patch series, and has been
rebased on top of newer versions with conflicts resolved.

For the adventerous, though...

This patch series improves merge recursive performance, particularly when
one side of history only makes a small number of changes, and the other has
lots of renames (or lots of adds and deletes); I saw a speedup factor of
over 30 on one particular real world repository.

Still RFC for the same reasons that the first series was (see
https://public-inbox.org/git/20171110222156.23221-1-newren@gmail.com/), I
haven't yet had time to push this further other than rebasing and cleaning
up issues shared with my other series.

If you just want to test it out, it's available as the
'big-repo-small-cherry-pick' branch of https://github.com/newren/git .

Elijah Newren (9):
  diffcore-rename: no point trying to find a match better than exact
  merge-recursive: avoid unnecessary string list lookups
  merge-recursive: new function for better colliding conflict
    resolutions
  Add testcases for improved file collision conflict handling
  merge-recursive: fix rename/add conflict handling
  merge-recursive: improve handling for rename/rename(2to1) conflicts
  merge-recursive: improve handling for add/add conflicts
  merge-recursive: accelerate rename detection
  diffcore-rename: filter rename_src list when possible

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
 t/t6043-merge-rename-directories.sh  |  15 +-
 t/t7060-wtstatus.sh                  |   1 +
 t/t7064-wtstatus-pv2.sh              |   4 +-
 t/t7506-status-submodule.sh          |  11 +-
 t/t7610-mergetool.sh                 |  28 +--
 19 files changed, 723 insertions(+), 224 deletions(-)

-- 
2.15.0.323.g31fe956618

