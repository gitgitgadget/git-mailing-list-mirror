Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FA01F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfA2Bj6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:39:58 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50466 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726865AbfA2Bj4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 20:39:56 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T1dFWG008899;
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q8p9rjrj8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 28 Jan 2019 17:39:32 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 28 Jan 2019 17:39:32 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id C53382098559;
        Mon, 28 Jan 2019 17:39:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 0/8] Reimplement rebase --merge via interactive machinery
Date:   Mon, 28 Jan 2019 17:39:37 -0800
Message-ID: <20190129013945.17336-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.310.g17ca096f17
In-Reply-To: <20181211161139.31686-1-newren@gmail.com>
References: <20181211161139.31686-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series continues the work of making rebase more self-consistent
by removing inconsistencies between different backends.  In
particular, this series focuses on making the merge machinery behave
like the interactive machinery (though a few differences between the am
and interactive backends are also fixed along the way), and ultimately
removes the merge backend in favor of reimplementing the relevant
options on top of the interactive machinery.

Differences since v4:
  - Included Dscho's Acked-by (from
    https://public-inbox.org/git/nycvar.QRO.7.76.6.1901212200400.41@tvgsbejvaqbjf.bet/)

Elijah Newren (8):
  rebase: make builtin and legacy script error messages the same
  rebase: fix incompatible options error message
  t5407: add a test demonstrating how interactive handles --skip
    differently
  am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
  git-rebase, sequencer: extend --quiet option for the interactive
    machinery
  git-legacy-rebase: simplify unnecessary triply-nested if
  rebase: define linearization ordering and enforce it
  rebase: implement --merge via the interactive machinery

 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  17 +---
 Makefile                          |   1 -
 builtin/am.c                      |   9 ++
 builtin/rebase.c                  |  30 ++----
 git-legacy-rebase.sh              |  65 ++++++------
 git-rebase--am.sh                 |   2 +-
 git-rebase--common.sh             |   2 +-
 git-rebase--merge.sh              | 164 ------------------------------
 sequencer.c                       |  23 +++--
 sequencer.h                       |   1 +
 t/t3406-rebase-message.sh         |   7 +-
 t/t3420-rebase-autostash.sh       |  78 ++------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |  15 ++-
 t/t5407-post-rewrite-hook.sh      |  34 +++++++
 t/t9903-bash-prompt.sh            |   2 +-
 17 files changed, 121 insertions(+), 340 deletions(-)
 delete mode 100644 git-rebase--merge.sh

-- 
2.20.1.310.g17ca096f17

