Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A9F1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 02:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeJNJpG (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 05:45:06 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44890 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725734AbeJNJpG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Oct 2018 05:45:06 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9E23Lhm018130;
        Sat, 13 Oct 2018 19:05:47 -0700
Received: from mail.palantir.com (mxw2.palantir.com [66.70.54.22] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2n3ejh0q95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 13 Oct 2018 19:05:47 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 13 Oct 2018 19:05:46 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Sat, 13 Oct 2018 19:05:46 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Sat, 13 Oct 2018 19:05:45 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 D8E672101E7B;  Sat, 13 Oct 2018 19:05:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 0/7] Improve path collision conflict resolutions
Date:   Sat, 13 Oct 2018 19:05:30 -0700
Message-ID: <20181014020537.17991-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.3.g98f21ceff2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810140017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC series depends on this series submitted yesterday:
  https://public-inbox.org/git/20181012212551.7689-1-newren@gmail.com/
(which in turn depends on en/merge-cleanup in next).

Although this is an "update" to my previous RFC series from six months
ago:
  https://public-inbox.org/git/20180305171125.22331-1-newren@gmail.com/
It's essentially a complete rewrite to instead use the strategy proposed
by Jonathan and Junio (from a separate thread discussing that RFC series):
  https://public-inbox.org/git/20180312213521.GB58506@aiede.svl.corp.google.com/
  https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com

The basic idea is to make the "file collision" conflict types all behave
like add/add.  These types are:
  * add/add
  * rename/add
  * rename/rename(2to1)
  * each rename/add piece of a rename/rename(1to2)/add[/add] conflict

Specific bits that make this RFC:
  * Depends on another series not even in pu yet.
  * In order to simplify review, I add a new common function for all
    these conflict types to call in one commit, and since the function
    is not yet used at that point, I wrap the function in an #ifdef 0.
    In later patches, I remove the #ifdef.  Is that...okay?
  * There are a few FIXMEs in the code.  I'm okay leaving them there,
    but are others upset by them?
  * Every time I attempt to complete this series, I spot more problems;
    many of the merge-recursive series I've submitted since March were
    issues I discovered while trying to complete this series -- or
    secondary tangents discovered while working on the side-issues to
    this one.  I've gotten to the point of automatically second-guessing
    myself on whether I could have actually completed the necessary
    fixes.

Elijah Newren (7):
  Add testcases for consistency in file collision conflict handling
  t6036, t6042: testcases for rename collision of already conflicting
    files
  merge-recursive: new function for better colliding conflict
    resolutions
  merge-recursive: fix rename/add conflict handling
  merge-recursive: improve handling for rename/rename(2to1) conflicts
  merge-recursive: use handle_file_collision for add/add conflicts
  merge-recursive: improve rename/rename(1to2)/add[/add] handling

 merge-recursive.c                    | 513 ++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh    | 228 +++++++++++-
 t/t6042-merge-rename-corner-cases.sh | 333 ++++++++++++++++-
 t/t6043-merge-rename-directories.sh  | 107 +++---
 4 files changed, 893 insertions(+), 288 deletions(-)

-- 
2.19.0.3.g98f21ceff2.dirty

