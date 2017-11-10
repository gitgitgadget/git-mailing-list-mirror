Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C1A1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753810AbdKJTGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:03 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48712 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753665AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4Gr3002777;
        Fri, 10 Nov 2017 11:05:59 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgp-1;
        Fri, 10 Nov 2017 11:05:59 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id AAFAC22F6280;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A25782CDE6A;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/30] Add directory rename detection to git
Date:   Fri, 10 Nov 2017 11:05:20 -0800
Message-Id: <20171110190550.27059-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=79 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This series is entirely independent of my rename detection limits series.
However, I have a separate rename detection performance series that depends
on both this series and the rename detection limits series.]

In this patchset, I introduce directory rename detection to merge-recursive,
predominantly so that when files are added to directories on one side of
history and those directories are renamed on the other side of history, the
files will end up in the proper location after a merge or cherry-pick.

However, this isn't limited to that simplistic case.  More interesting
possibilities exist, such as:

  * a file being renamed into a directory which is renamed on the other
    side of history, causing the need for a transitive rename.

  * two (or three or N) directories being merged (with no conflicts so
    long as files/directories within the merged directory have different
    names), and the "merging" being detected as a directory rename for
    each original directory.

  * not all files in a directory being renamed to the same location;
    i.e. perhaps the directory was renamed, but some files within it were
    renamed to a different location

  * a directory being renamed, which also contained a subdirectory that
    was renamed to some entirely different location.  (And perhaps the
    inner directory itself contained inner directories that were renamed
    to yet other locations).

Also, I found it useful to allow all files within the directory being
renamed to themselves be renamed and still detect the directory rename.
For example, if goal/a and goal/b are renamed to priority/alpha and
priority/bravo, we can detect that goal/ was renamed to priority/, so that
if someone adds goal/c on the other side of history, after the merge we'll
end up with priority/c.  (In the absence of a readily available
libmindread.so library that I can link to, we can't rename directly from
goal/c to priority/charlie automatically, and will need to have priority/c
suffice.)

Naturally, an attempt to do all of the above brings up all kinds of
interesting edge and corner cases, some of which result in conflicts
that cannot be represented in the index, and others of which might be
considered too complex for users to understand and resolve.  For
example:

  * An add/add/add/.../add conflict, all on one side of history (see
    testcase 9e in the new t6043, or any of the testcases in section 5)

  * Doubly, triply, or N-fold transitive renames (testcases 9c & 9d)

In order to prevent such problems, I introduce a couple basic rules that
limit when directory rename detection applies:

  1) If a subset of to-be-renamed files have a file or directory in the
     way (or would be in the way of each other), "turn off" the directory
     rename for those specific sub-paths and report the conflict to the
     user.

  2) If the other side of history did a directory rename to a path that
     your side of history renamed away, then ignore that particular
     rename from the other side of history for any implicit directory
     renames (but warn the user).

Further, there's a basic question about when directory rename detection
should be applied at all.  I have a simple rule:

  3) If a given directory still exists on both sides of a merge, we do
     not consider it to have been renamed.

Rule 3 may sound obvious at first, but it will probably arise as a
question for some users -- what if someone "mostly" moved a directory but
still left some files around, or, equivalently (from the perspective of the
three-way merge that merge-recursive performs), fully renamed a directory
in one commmit and then recreated that directory in a later commit adding
some new files and then tried to merge?  See the big comment in section 4
of the new t6043 for further discussion of this rule.

This set of rules seems to be reasonably easy to explain, is
self-consistent, allows all conflict cases to be represented without
changing any on-disk data structures or introducing new terminology or
commands for users, prevents excessively complex conflicts that users
might struggle to understand, and brings peace to the middle east.
Actually, maybe not that last one.

While I feel that this directory rename detection reduces the number of
suboptimal merges and cherry-picks that git performs, there are sadly
still a number of cases that remain suboptimal, or that even newly appear
to be not-quite-consistent with other cases.  The fact that one file
layout might trigger some of the rules above while another "slightly"
different file layout doesn't might occasionally cause some user
grumblings.  I've tried to explore and document these cases in section 8
of the new t6043-merge-rename-directories.sh

Finally, from an implementation perspective, there's another strong
advantage to the ruleset above: it means that any path to which we want
to apply an implicit directory rename will have a free and open spot
for us to move it into.  Thus, we can just adjust the diff_filepair
from an add or modify into a rename (or adjust a rename diff_filepair
to change the target a little more), and then let process_renames and
process_entry do all their magic.  That allows us to rely on all the
heavy testing already done for those code paths to handle a large
variety of edge and corner cases (e.g. D/F, rename/rename, criss-cross
merges, etc.)  The big trick is just making sure to do all the
necessary checks that we can apply directory rename detection, and then
fixing things up to put it in the expected format, with enough test
cases to make sure we actually got it into the right format.

Okay, the last paragraph had a small lie (though I didn't know that when
I originally wrote it): the fact that unpack_trees() aborts early if it
detects an untracked or dirty file would be overwritten by a merge, and
if not it immediately proceeds to start modifying the working tree before
passing control back to merge-recursive, causes some problems.  Not only
has it always made the code more complex, but the fact that
unpack_trees() doesn't understand renames means that it can't
appropriately abort early if a path involved in a rename has untracked
or dirty contents in the way of the merge.  But by the time we detect
renames, it's too late to abort early.  So we have to instead figure out
ways of emitting warnings messages and writing something sensible to the
working copy without overwriting any of their data.  This was a problem
before directory rename detection, but directory rename detection
increases the number of places where we have to worry about this.

Elijah Newren (30):
  Tighten and correct a few testcases for merging and cherry-picking
  merge-recursive: Fix logic ordering issue
  merge-recursive: Add explanation for src_entry and dst_entry

These three patches provide a few miscellaneous fixups that could be
submitted independent of this series, though the series partially
depends on the fixes in the first one, and the second fix becomes more
important with the rest of the changes in this series.

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

These patches add testcases for directory rename detection, trying to
cover the space of possibilities as exhaustively as I can while trying
to avoid excessive overlap in testcases

  merge-recursive: Move the get_renames() function
  merge-recursive: Introduce new functions to handle rename logic
  merge-recursive: Fix leaks of allocated renames and diff_filepairs
  merge-recursive: Make !o->detect_rename codepath more obvious
  merge-recursive: Split out code for determining diff_filepairs

These four patches make small code reorganizations in preparation for
further changes, though they include some memory leak fixes.

  merge-recursive: Add a new hashmap for storing directory renames
  merge-recursive: Add get_directory_renames()
  merge-recursive: Check for directory level conflicts
  merge-recursive: Add a new hashmap for storing file collisions
  merge-recursive: Add computation of collisions due to dir rename &
    merging
  merge-recursive: Check for file level conflicts then get new name
  merge-recursive: When comparing files, don't include trees
  merge-recursive: Apply necessary modifications for directory renames

These eight patches implement the directory rename detection logic.
  
  merge-recursive: Avoid clobbering untracked files with directory
    renames
  merge-recursive: Fix overwriting dirty files involved in renames
  merge-recursive: Fix remaining directory rename + dirty overwrite
    cases

These last three deal with untracked and dirty file overwriting
headaches.  The middle patch in particular, isn't just a fix for
directory rename detection but fixes a bug in current versions of git
in overwriting dirty files that are involved in a rename.  That patch
could be backported and submitted independent of this series, but the
final patch depends heavily on it.

 merge-recursive.c                   | 1212 +++++++++++--
 merge-recursive.h                   |   17 +
 t/t3501-revert-cherry-pick.sh       |    5 +-
 t/t6043-merge-rename-directories.sh | 3277 +++++++++++++++++++++++++++++++++++
 t/t7607-merge-overwrite.sh          |    7 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 7 files changed, 4413 insertions(+), 113 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

-- 
2.15.0.5.g9567be9905
