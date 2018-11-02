Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCCA1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbeKCEBs (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:01:48 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35706 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731091AbeKCEBq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 00:01:46 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2InIei009923;
        Fri, 2 Nov 2018 11:53:29 -0700
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ncnvk80vr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 02 Nov 2018 11:53:29 -0700
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 2 Nov 2018 14:53:24 -0400
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 2 Nov 2018 14:53:24 -0400
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 751412101960;
        Fri,  2 Nov 2018 11:53:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 00/10] Improve path collision conflict resolutions
Date:   Fri, 2 Nov 2018 11:53:08 -0700
Message-ID: <20181102185317.31015-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.232.gd14c2061fc
In-Reply-To: <20181019193111.12051-1-newren@gmail.com>
References: <20181019193111.12051-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-cleanup-more and is built on that
series.  (It merges cleanly to master, next, and pu -- well, as long
as v3 of this series is excluded from pu, that is).

This series makes all the "file collision" conflict types be handled
consistently; making them all behave like add/add (as suggested by
Jonathan[1] and Junio[2]).  These types are:
  * add/add
  * rename/add
  * rename/rename(2to1)
  * each rename/add piece of a rename/rename(1to2)/add[/add] conflict

[1] https://public-inbox.org/git/20180312213521.GB58506@aiede.svl.corp.google.com/
[2] https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com

Changes since v3:
  * Fixed test names to be surrounded by single quotes instead of double
    quotes, as suggested by Derrick.
  * Two more (RFC) patches add a couple testcases to cover previously
    uncovered code, as pointed out by Derrick and his test coverage report.
  * Full range-diff below.

Major question:
  * You'll note that I edited the last two patches to mark them as RFC.
    To be honest, I'm not sure what to do with these.  They improve code
    coverage of new code, but the same gaps existed in the old code;
    they only show up in the coverage-diff because I essentially moved
    code around to a new improved function.  Since the new code doesn't
    really add new abilities but rather just shifts the handling of
    these conflicts to a common function, they shouldn't need any more
    testcases than previously and modifying the existing patches thus
    feels slightly misleading.  That line of thought leads me to believe
    that perhaps putting them in a separate combined patch of their own
    with a decent commit message is the right way to go.  On the other
    hand, squashing them to the commits they're marked as fixups for
    shows which logical part of the code the tests are related to, which
    seems like a good thing.  So what's the right way to handle these?


 1:  1be9e213db !  1:  0fa67d6109 t6036, t6042: testcases for rename collision of already conflicting files
    @@ -51,7 +51,7 @@
     +#   conflict markers.  This is a pretty weird corner case, but we just want
     +#   to ensure that we handle it as well as practical.
     +
    -+test_expect_success "setup nested conflicts" '
    ++test_expect_success 'setup nested conflicts' '
     +	test_create_repo nested_conflicts &&
     +	(
     +		cd nested_conflicts &&
    @@ -130,7 +130,7 @@
     +	)
     +'
     +
    -+test_expect_failure "check nested conflicts" '
    ++test_expect_failure 'check nested conflicts' '
     +	(
     +		cd nested_conflicts &&
     +
    @@ -241,7 +241,7 @@
     +#
     +#   So, we have four different conflicting files that all end up at path
     +#   'three'.
    -+test_expect_success "setup nested conflicts from rename/rename(2to1)" '
    ++test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
     +	test_create_repo nested_conflicts_from_rename_rename &&
     +	(
     +		cd nested_conflicts_from_rename_rename &&
    @@ -294,7 +294,7 @@
     +	)
     +'
     +
    -+test_expect_failure "check nested conflicts from rename/rename(2to1)" '
    ++test_expect_failure 'check nested conflicts from rename/rename(2to1)' '
     +	(
     +		cd nested_conflicts_from_rename_rename &&
     +
 2:  d3356ff525 !  2:  9f5f0105d0 merge-recursive: increase marker length with depth of recursion
    @@ -179,7 +179,7 @@
     +#   nested conflict markers from X2 in the base version -- that means we
     +#   have three levels of conflict markers.  Can we distinguish all three?
     +
    -+test_expect_success "setup virtual merge base with nested conflicts" '
    ++test_expect_success 'setup virtual merge base with nested conflicts' '
     +	test_create_repo virtual_merge_base_has_nested_conflicts &&
     +	(
     +		cd virtual_merge_base_has_nested_conflicts &&
    @@ -241,7 +241,7 @@
     +	)
     +'
     +
    -+test_expect_success "check virtual merge base with nested conflicts" '
    ++test_expect_success 'check virtual merge base with nested conflicts' '
     +	(
     +		cd virtual_merge_base_has_nested_conflicts &&
     +
 3:  aa68e3d675 =  3:  5922c40fa7 merge-recursive: new function for better colliding conflict resolutions
 4:  f046ba6362 =  4:  dcf88dd363 merge-recursive: fix rename/add conflict handling
 5:  37742bdefd !  5:  1d11288be4 merge-recursive: improve handling for rename/rename(2to1) conflicts
    @@ -209,8 +209,8 @@
      	)
      '
      
    --test_expect_failure "check nested conflicts" '
    -+test_expect_success "check nested conflicts" '
    +-test_expect_failure 'check nested conflicts' '
    ++test_expect_success 'check nested conflicts' '
      	(
      		cd nested_conflicts &&
      
    @@ -290,8 +290,8 @@
      	)
      '
      
    --test_expect_failure "check nested conflicts from rename/rename(2to1)" '
    -+test_expect_success "check nested conflicts from rename/rename(2to1)" '
    +-test_expect_failure 'check nested conflicts from rename/rename(2to1)' '
    ++test_expect_success 'check nested conflicts from rename/rename(2to1)' '
      	(
      		cd nested_conflicts_from_rename_rename &&
      
 6:  776dff8bc4 =  6:  1fad3428a4 merge-recursive: use handle_file_collision for add/add conflicts
 7:  45940724d5 =  7:  e7ac0d894e merge-recursive: improve rename/rename(1to2)/add[/add] handling
 -:  ---------- >  8:  9328f66ed1 fixup! merge-recursive: fix rename/add conflict handling
 -:  ---------- >  9:  d061509573 fixup! merge-recursive: improve rename/rename(1to2)/add[/add] handling
  
Elijah Newren (10):
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
  fixup! merge-recursive: fix rename/add conflict handling
  fixup! merge-recursive: improve rename/rename(1to2)/add[/add] handling

 ll-merge.c                           |   4 +-
 ll-merge.h                           |   1 +
 merge-recursive.c                    | 528 ++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh    | 430 +++++++++++++++++++++-
 t/t6042-merge-rename-corner-cases.sh | 333 ++++++++++++++++-
 t/t6043-merge-rename-directories.sh  | 144 +++++---
 6 files changed, 1148 insertions(+), 292 deletions(-)

-- 
2.19.0.232.gd14c2061fc

