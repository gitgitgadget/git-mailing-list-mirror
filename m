Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDFC1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDSR6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:37 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41672 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeDSR6f (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:35 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnDim028655;
        Thu, 19 Apr 2018 10:58:28 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas70-1;
        Thu, 19 Apr 2018 10:58:28 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 40E9122175A1;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 3861C2CDE6F;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 00/36] Add directory rename detection to git
Date:   Thu, 19 Apr 2018 10:57:47 -0700
Message-Id: <20180419175823.7946-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=45 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a reboot of the directory rename detection series that was
merged to master and then reverted due to the final patch having a buggy
can-skip-update check, as noted at
  https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
This series based on top of master.

This updated series fixes the problem found with the previous series, and
also fixes Linus' issue with unnecessary rebuilds noted at
  https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/

For the original details about design considerations surrounding
directory rename detection, see
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/

Patches 1--28 are identical to what was previously merged to master,
modulo trivial compilation fixes due to the fact that I've rebased on
master which now includes commit 916bc35b29af ("tree-walk: convert tree
entry functions to object_id", 2018-03-12).  As such, I've retained the
Reviewed-by and Signed-off-by tags for these first 28 patches.  (The
final patch of the original series, patch 29, has been rewritten and
replaced in this series.)

The remaining eight patches are new; a brief summary:

  merge-recursive: improve add_cacheinfo error handling
  merge-recursive: move more is_dirty handling to merge_content
  merge-recursive: avoid triggering add_cacheinfo error with dirty mod

    When Junio was bit by the previous series, the code reached a
    detected error state that should not ever be hit in production.
    That was bad enough, but the problem compounded because the code
    simply printed a vague not-very-scary-sounding error, and returned
    an error code that the caller ignored (which not only proceeded to
    then handle other paths which might print messages causing the error
    to scroll off the screen, but could result in a "clean" merge).  Fix
    issues with the error handling...and then deal with the breakage of
    one particular test that was triggering this codepath.

  t6046: testcases checking whether updates can be skipped in a merge

    Add a fairly comprehensive set of tests for the skipability of
    working tree updates.

  merge-recursive: fix was_tracked() to quit lying with some renamed
    paths
  merge-recursive: fix remainder of was_dirty() to use original index

    Instead of using the current index as a (rather imperfect) proxy for
    the state of the index just before the merge, keep a copy of the
    original index around so we can get correct answers to whether
    certain paths were tracked or dirty before the merge.

  merge-recursive: make "Auto-merging" comment show for other merges
  merge-recursive: fix check for skipability of working tree updates

    Fix and simplify the skipability check.  Due to some tests being
    picky about output, the first of these two patches exists to avoid
    triggering the "Auto-merging $FILE" message too often with the
    simplified logic; in the process, it fixes a pair of existing issues
    with when those messages are shown, making it more accurate in
    general.

Additional testing:

  * I've re-merged all ~13k merge commits in git.git with both
    git-2.17.0 and this version of git, comparing the results to each
    other in detail.  (Including stdout & stderr, as well as the output
    of subsequent commands like `git status`, `git ls-files -s`, `git
    diff -M`, `git diff -M --staged`).  The only differences were in 23
    merges of either git-gui or gitk which involved directory renames
    (e.g. git-2.17.0's merge would result in files like 'lib/tools.tcl'
    or 'po/ru.po' instead of the expected 'git-gui/lib/tools.tcl' or
    'gitk-git/po/ru.po')

  * I'm trying to do the same with linux.git, but it looks like that will
    take nearly a week to complete...

My biggest question:

  * Is there any other testing others would like to see, in order to avoid
    a repeat of the pain from my previous series and allow us to safely
    merge this newer one?

Elijah Newren (36):
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
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
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
  merge-recursive: improve add_cacheinfo error handling
  merge-recursive: move more is_dirty handling to merge_content
  merge-recursive: avoid triggering add_cacheinfo error with dirty mod
  t6046: testcases checking whether updates can be skipped in a merge
  merge-recursive: fix was_tracked() to quit lying with some renamed
    paths
  merge-recursive: fix remainder of was_dirty() to use original index
  merge-recursive: make "Auto-merging" comment show for other merges
  merge-recursive: fix check for skipability of working tree updates

 merge-recursive.c                      | 1432 ++++++++-
 merge-recursive.h                      |   28 +
 strbuf.c                               |   16 +
 strbuf.h                               |   16 +
 t/t3501-revert-cherry-pick.sh          |    7 +-
 t/t6022-merge-rename.sh                |    2 +-
 t/t6043-merge-rename-directories.sh    | 3998 ++++++++++++++++++++++++
 t/t6046-merge-skip-unneeded-updates.sh |  761 +++++
 t/t7607-merge-overwrite.sh             |    2 +-
 unpack-trees.c                         |    4 +-
 unpack-trees.h                         |    4 +
 11 files changed, 6092 insertions(+), 178 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh
 create mode 100755 t/t6046-merge-skip-unneeded-updates.sh

-- 
2.17.0.290.ge988e9ce2a

