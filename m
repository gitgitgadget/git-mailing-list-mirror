Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C108E202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdKTWEe (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:04:34 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58144 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbdKTWCN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:13 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLw7d0028727;
        Mon, 20 Nov 2017 14:02:09 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr3cp6-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 70BC022F41A0;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 68C1F2CDE75;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 00/33] Add directory rename detection to git
Date:   Mon, 20 Nov 2017 14:01:36 -0800
Message-Id: <20171120220209.15111-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=45 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.
See https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the previous series, design considerations, etc.

Changes since the first series include:

  * Rebased on latest master (addressing a couple minor conflicts)

  * Fixed numerous checkstyle.pl issues (except a few line-too-long and
    string-split ones, in order to match the style of the surrounding code;
    also, added two BUG() calls as suggested by Stefan)

  * Various code cleanups and commit message improvements suggested by
    reviewers

  * Testcase cleanups suggested by reviewers:
    * Use test_create_repo for different tests instead of heavy-handed
      cleaning
    * O-A-B instead of A-B-C for labelling original commit and sides of
      merge
    * reduced the number of git-rev-parse invocations
    * various wording fixes, clarifications, and typo eradication in
      comments

  * New testcases (see patch 31/33):
    * Added a pair of testcases suggested by Stefan Boller and a third that
      was a slight modification of one of those two.  The second testcase
      Stefan suggested has a fairly weird resolution that folks may want to
      double check, although to be fair, the input is fairly weird so some
      kind of weirdness in the output is to be expected.
    * Added a new testcase 9h based on a separate bug I found

  * Fixed two bugs:
    * ensure we write updates for directory-renamed file (bug triggered by
      testcase suggested by Stefan Boller; see patch 33/33)
    * avoid spurious rename/rename(1to2) conflicts from dir renames (found
      while I was digging around more; see patch 32/33)

Both Junio and Stefan made numerous suggestions that were very helpful.  I
believe this second series incorporates all suggestions made by Junio, all
but one of the non-tentative suggestions from Stefan (namely, the git
ls-files exit code checking), and several of the tentative suggestions from
Stefan as well.  If folks feel strongly about the ls-files exit code
checking or can spot anything I missed that looks important, let me know
and I'll get it fixed up.

Elijah Newren (33):
  Tighten and correct a few testcases for merging and cherry-picking
  merge-recursive: fix logic ordering issue
  merge-recursive: add explanation for src_entry and dst_entry
  directory rename detection: basic testcases
  directory rename detection: directory splitting testcases
  directory rename detection: testcases to avoid taking detection too
    far
  directory rename detection: partially renamed directory
    testcase/discussion
  directory rename detection: files/directories in the way of some
    renames
  directory rename detection: testcases checking which side did the
    rename
  directory rename detection: more involved edge/corner testcases
  directory rename detection: testcases exploring possibly suboptimal
    merges
  directory rename detection: miscellaneous testcases to complete
    coverage
  directory rename detection: tests for handling overwriting untracked
    files
  directory rename detection: tests for handling overwriting dirty files
  merge-recursive: move the get_renames() function
  merge-recursive: introduce new functions to handle rename logic
  merge-recursive: fix leaks of allocated renames and diff_filepairs
  merge-recursive: make !o->detect_rename codepath more obvious
  merge-recursive: split out code for determining diff_filepairs
  merge-recursive: add a new hashmap for storing directory renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add a new hashmap for storing file collisions
  merge-recursive: add computation of collisions due to dir rename &
    merging
  merge-recursive: check for file level conflicts then get new name
  merge-recursive: when comparing files, don't include trees
  merge-recursive: apply necessary modifications for directory renames
  merge-recursive: avoid clobbering untracked files with directory
    renames
  merge-recursive: fix overwriting dirty files involved in renames
  merge-recursive: fix remaining directory rename + dirty overwrite
    cases
  directory rename detection: new testcases showcasing a pair of bugs
  merge-recursive: avoid spurious rename/rename conflict from dir
    renames
  merge-recursive: ensure we write updates for directory-renamed file

 merge-recursive.c                   | 1239 +++++++++++-
 merge-recursive.h                   |   17 +
 t/t3501-revert-cherry-pick.sh       |    5 +-
 t/t6043-merge-rename-directories.sh | 3821 +++++++++++++++++++++++++++++++++++
 t/t7607-merge-overwrite.sh          |    7 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 7 files changed, 4981 insertions(+), 116 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

-- 
2.15.0.309.g00c152f825

