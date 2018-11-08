Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D31F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKHOOM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:12 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44908 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbeKHOOM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:12 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84dbBC024774;
        Wed, 7 Nov 2018 20:40:35 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm96drdsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:35 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 20:40:33 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 20:40:33 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id A5EDC2101E7B;
        Wed,  7 Nov 2018 20:40:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 00/10] Improve path collision conflict resolutions
Date:   Wed, 7 Nov 2018 20:40:21 -0800
Message-ID: <20181108044031.25885-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series applies cleanly on master, since en/merge-cleanup-more has
now merged down.

This series makes all the "file collision" conflict types be handled
consistently; making them all behave like add/add (as suggested by
Jonathan[1] and Junio[2]).  These types are:
  * add/add
  * rename/add
  * rename/rename(2to1)
  * each rename/add piece of a rename/rename(1to2)/add[/add] conflict

[1] https://public-inbox.org/git/20180312213521.GB58506@aiede.svl.corp.google.com/
[2] https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com

Changes since v4:
  * Merged the two RFC patches into a single patch.
  * Added patch submitted by Stolee at the end.
  * (The addition of what are the last two patches are also the only
     difference since v3)


Derrick Stolee (1):
  merge-recursive: combine error handling

Elijah Newren (9):
  Add testcases for consistency in file collision conflict handling
  t6036, t6042: testcases for rename collision of already conflicting
    files
  merge-recursive: increase marker length with depth of recursion
  merge-recursive: new function for better colliding conflict
    resolutions
  merge-recursive: fix rename/add conflict handling
  merge-recursive: improve handling for rename/rename(2to1) conflicts
  merge-recursive: use handle_file_collision for add/add conflicts
  merge-recursive: improve rename/rename(1to2)/add[/add] handling
  t6036, t6043: increase code coverage for file collision handling

 ll-merge.c                           |   4 +-
 ll-merge.h                           |   1 +
 merge-recursive.c                    | 529 ++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh    | 430 +++++++++++++++++++++-
 t/t6042-merge-rename-corner-cases.sh | 333 ++++++++++++++++-
 t/t6043-merge-rename-directories.sh  | 144 +++++---
 6 files changed, 1149 insertions(+), 292 deletions(-)

-- 
2.19.1.858.g526e8fe740.dirty

