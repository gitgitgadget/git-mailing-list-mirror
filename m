Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604FA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeGaSxa (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:53:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50402 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729662AbeGaSxa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jul 2018 14:53:30 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VH3bJi026217;
        Tue, 31 Jul 2018 10:12:11 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kgpbn7e6s-1;
        Tue, 31 Jul 2018 10:12:11 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 9798F226E7FA;
        Tue, 31 Jul 2018 10:12:08 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 82C552CDE5F;
        Tue, 31 Jul 2018 10:12:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/2] Address recovery failures with directory/file conflicts
Date:   Tue, 31 Jul 2018 10:12:03 -0700
Message-Id: <20180731171205.4794-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.2.gf4c50c7885
In-Reply-To: <20180713163331.22446-1-newren@gmail.com>
References: <20180713163331.22446-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes several "recovery" commands that outright fail
or do not fully recover when directory-file conflicts are present.
This includes:
   * git read-tree --reset HEAD
   * git am --skip
   * git am --abort
   * git merge --abort (or git reset --merge)
   * git reset --hard

Changes since v2 (full range-diff below):
  - Backported to maint (there were some textual conflicts in t6042
    due to the merging of en/merge-recursive-tests to master), because
    of this comment from Junio's what's cooking email:

    "This may have to be rebased on an older maintenance track before
     moving forward."

Elijah Newren (2):
  t1015: demonstrate directory/file conflict recovery failures
  read-cache: fix directory/file conflict handling in
    read_index_unmerged()

 read-cache.c                         |  13 +--
 t/t1015-read-index-unmerged.sh       | 123 +++++++++++++++++++++++++++
 t/t6020-merge-df.sh                  |   3 -
 t/t6042-merge-rename-corner-cases.sh |   2 -
 4 files changed, 131 insertions(+), 10 deletions(-)
 create mode 100755 t/t1015-read-index-unmerged.sh

1:  4a1c9c3368 ! 1:  00f94a8b41 t1015: demonstrate directory/file conflict recovery failures
    @@ -14,7 +14,6 @@
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Message-Id: <20180713163331.22446-2-newren@gmail.com>
     
     diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
     new file mode 100755
2:  e105e8bfbd ! 2:  d3b8d7edb6 read-cache: fix directory/file conflict handling in read_index_unmerged()
    @@ -59,7 +59,6 @@
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Message-Id: <20180713163331.22446-3-newren@gmail.com>
     
     diff --git a/read-cache.c b/read-cache.c
     --- a/read-cache.c
    @@ -150,10 +149,18 @@
     --- a/t/t6042-merge-rename-corner-cases.sh
     +++ b/t/t6042-merge-rename-corner-cases.sh
     @@
    - 	(
    - 		cd rename-directory-1 &&
    + '
    +
    + test_expect_success 'rename/directory conflict + clean content merge' '
    +-	git reset --hard &&
    +	git reset --hard &&
    +	git clean -fdqx &&
      
    --		git reset --hard &&
    - 		git reset --hard &&
    - 		git clean -fdqx &&
    +@@
    + '
    +
    + test_expect_success 'rename/directory conflict + content merge conflict' '
    +-	git reset --hard &&
    +	git reset --hard &&
    +	git clean -fdqx &&
      
-- 
2.18.0.2.gf4c50c7885
