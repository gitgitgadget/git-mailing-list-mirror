Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57A1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDMT4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:56:18 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59664 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751892AbeDMT4Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:56:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DJsDAC016205;
        Fri, 13 Apr 2018 12:56:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h95bs58tn-1;
        Fri, 13 Apr 2018 12:56:09 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D8AB52215BA4;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id CFC2B2CDE68;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     torvalds@linux-foundation.org, gitster@pobox.com,
        sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v9 0/30] Add directory rename detection to git
Date:   Fri, 13 Apr 2018 12:56:03 -0700
Message-Id: <20180413195607.18091-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.35.g6dd7ede834
In-Reply-To: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=45 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804130184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on commit febb3a86098f ("merge-recursive: avoid
spurious rename/rename conflict from dir renames", 2018-02-14), also known
as patch 29/30 of en/rename-directory-detection.  That patch series has
been reverted from master[1], due to a bug with patch 30/30, so does not
apply to current master.  But I didn't want to resend the whole series for
an RFC.

These four patches replace that patch and:
  - fixes Linus' rewriting-of-unchanged-files bug[1]
  - fixes the problems that broke Junio's merges after my series[2]
  - fixes the problem the original patch 30/30 was intended to solve
  - adds lots of testcases to make sure this doesn't regress.

Linus' alternative of stupid-brute-force[3], would also work here,
though I feel the first three patches are useful even if we take some
form of his patch.  Long term, the most correct solution would involve
a rewrite to merge-recursive that would simplify this code[4], though
I think the changes in this series brings this part of the code closer
to that end state.

The big questions here are:
  1) The last time my rename-directory-detection series was merged into
     master it bit Junio badly.  I'm planning to redo all merges of
     git.git and linux.git and comparing v2.17.0 to what I get after
     my changes.  What else should I test?
  2) What do folks thing about stupid-brute-force vs. the explanation in
     my final patch?


[1] https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/
[2] https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
[3] https://public-inbox.org/git/CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com/
[4] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/


Elijah Newren (4):
  merge-recursive: improve output precision around skipping updates
  t6046: testcases checking whether updates can be skipped in a merge
  merge-recursive: Fix was_tracked() to quit lying with some renamed
    paths
  merge-recursive: fix check for skipability of working tree updates

 merge-recursive.c                      | 109 +++++---
 merge-recursive.h                      |   1 +
 t/t6022-merge-rename.sh                |   2 +-
 t/t6043-merge-rename-directories.sh    |   2 +-
 t/t6046-merge-skip-unneeded-updates.sh | 497 +++++++++++++++++++++++++++++++++
 5 files changed, 575 insertions(+), 36 deletions(-)
 create mode 100755 t/t6046-merge-skip-unneeded-updates.sh

-- 
2.16.0.35.g6dd7ede834

