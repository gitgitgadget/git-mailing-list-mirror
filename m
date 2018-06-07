Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65AA1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeFGRN4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:13:56 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44638 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932881AbeFGRNx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jun 2018 13:13:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57H95of032540;
        Thu, 7 Jun 2018 10:13:47 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3ghekt-1;
        Thu, 07 Jun 2018 10:13:47 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 2762D22BCF80;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 1C9882CDE86;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        alban.gruin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/3] Send more rebases through interactive machinery
Date:   Thu,  7 Jun 2018 10:13:41 -0700
Message-Id: <20180607171344.23331-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.13.ge6eabe3ad6
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

  * deletes git-rebase--merge, making git-rebase--interactive handle
    those cases instead
  * adds an --am option to git rebase, and changes the rebase default
    from using git-rebase--am to git-rebase--interactive, fixing
    directory rename detection for default rebases.

However:

  * this series has several minor conflicts with ag/rebase-p in pu.
    But it's just an RFC for now; I can re-roll on top of that after
    getting some feedback.

  * this series depends on the other preparatory fixups under
      https://public-inbox.org/git/CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com/
    To get this series with the preparatory fixups:

Fetch-It-Via: git fetch https://github.com/newren/git rebase-new-default

Elijah Newren (3):
  git-rebase, sequencer: add a --quiet option for the interactive
    machinery
  rebase: Implement --merge via git-rebase--interactive
  git-rebase.sh: make git-rebase--interactive the default

 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  24 +++--
 Makefile                          |   1 -
 git-rebase--interactive.sh        |  14 ++-
 git-rebase--merge.sh              | 164 ------------------------------
 git-rebase.sh                     |  75 ++++++++------
 sequencer.c                       |  19 ++--
 sequencer.h                       |   1 +

Yes, there are a significant number of testcase changes below.  See
the relevant commit messages where I explain why each was changed.

 t/t3400-rebase.sh                 |   7 +-
 t/t3401-rebase-and-am-rename.sh   |  18 +++-
 t/t3404-rebase-interactive.sh     |   2 +-
 t/t3406-rebase-message.sh         |   7 +-
 t/t3407-rebase-abort.sh           |  28 ++++-
 t/t3420-rebase-autostash.sh       |  89 +++-------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |  15 +--
 t/t5407-post-rewrite-hook.sh      |   5 +-
 t/t5520-pull.sh                   |   9 +-
 t/t9903-bash-prompt.sh            |  12 ++-
 19 files changed, 180 insertions(+), 321 deletions(-)
 delete mode 100644 git-rebase--merge.sh

-- 
2.18.0.rc1.12.g2996b9442d
