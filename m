Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666641F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeF0Hgh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:36:37 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38192 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752997AbeF0Hgg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:36:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7WQAd031166;
        Wed, 27 Jun 2018 00:36:25 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mth2s-1;
        Wed, 27 Jun 2018 00:36:25 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 913112230EC8;
        Wed, 27 Jun 2018 00:36:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 854EA2CDE65;
        Wed, 27 Jun 2018 00:36:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] Fix use of strategy options with interactive rebases
Date:   Wed, 27 Jun 2018 00:36:21 -0700
Message-Id: <20180627073623.31725-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180607050845.19779-1-newren@gmail.com>
References: <20180607050845.19779-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270089
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive machinery for git rebase can accept special merge
strategies or strategy options, but has a bug in its handling of
strategy options.  This short series patches that.

Changes since v1:
  - Small change to the second commit message
  - Addition of a cover letter.  :-)

Elijah Newren (2):
  t3418: add testcase showing problems with rebase -i and strategy
    options
  Fix use of strategy options with interactive rebases

 git-rebase.sh              |  2 +-
 sequencer.c                |  7 ++++++-
 t/t3418-rebase-continue.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

 1: 68cad084cf =  1: 43b9ac5a63 t3418: add testcase showing problems with rebase -i and strategy options
 2: 8eda0e7c1e !  2: d345eb96d5 Fix use of strategy options with interactive rebases
    @@ -2,9 +2,10 @@
     
         Fix use of strategy options with interactive rebases
     
    -    git-rebase.sh wrote stuff like
    +    git-rebase.sh wrote strategy options to .git/rebase/merge/strategy_opts
    +    in the following format:
           '--ours'  '--renormalize'
    -    to .git/rebase-merge/strategy_opts.  Note the double spaces.
    +    Note the double spaces.
     
         git-rebase--interactive uses sequencer.c to parse that file, and
         sequencer.c used split_cmdline() to get the individual strategy options.
    @@ -15,10 +16,11 @@
         So, when it ended up calling try_merge_strategy(), that in turn would run
           git merge-$strategy -- --ours -- --renormalize $merge_base -- $head $remote
     
    -    instead of the expected
    +    instead of the expected/desired
           git merge-$strategy --ours --renormalize $merge_base -- $head $remote
     
    -    Remove the extra spaces so that split_cmdline() will work as expected.
    +    Remove the extra spaces so that when it goes through split_cmdline() we end
    +    up with the desired command line.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
-- 
2.18.0.9.g431b2c36d5
