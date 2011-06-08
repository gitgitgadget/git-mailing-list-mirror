From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Wed,  8 Jun 2011 01:30:30 -0600
Message-ID: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDCC-0005Hn-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413Ab1FHH2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:28:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58761 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab1FHH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:28:50 -0400
Received: by pvg12 with SMTP id 12so118557pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=6wyHTOLAROqfduIzs7EVfX1YmvSjgNtUnqFhaRg91WA=;
        b=sJ3mmP8T8aPOGnInM9m5bgLKl4M6YRI6ngan9xFNxQvEP/Twc8vUsxNwf69VkUqspo
         NqQ5DDDOtaYp5Dt9tsm7K/FeViXKVroLdjVTAAL46ios7mAf5HWtHiKgIpSCWRdqYskT
         XhKTBdn4ztkiyRMeFOD+jsu99Yb6z0x8mkgYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=W7Z+X2bVov81TeJySpsC9yrV2wsbRSMIho2Z4MpiBxL3PhCrnyDasMg+kcNiyyy5ZG
         M7o4XGp558ykZXLIpE234boWYn+ggh67VwAMkjwkohbykiXvjzacaIqblxIVu6SaGmK7
         su9maz4uV6IyTSC1jzIJT5Msn/GIUhxOoUXQY=
Received: by 10.68.28.133 with SMTP id b5mr545597pbh.264.1307518129533;
        Wed, 08 Jun 2011 00:28:49 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.46
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175296>

Well, this took me a LOT longer than I expected, but I now have a
(monster) patch series designed to fix various corner cases in
merge-recursive.c.  For those waiting for the 1.7.6 freeze to end,
reading this patch series makes for some great mental gymnastics.  :-)

You might be surprised by just how corner cases we have and the types of
bugs that can be triggered (including deleting untracked files).  This
series includes testcases for the unnecessary file update issues[1]
triggered by my series from last fall[2] and also a testcase that had
been regressed by my earlier (and now reverted) bandaids designed to fix
the unnecessary file update issue[3] (to make sure we fix both those
issues).  The current series aims to fix these problems using the
strategy Junio outlined[4].  However, this series is about a lot more
than just those issues.

[1] http://thread.gmane.org/gmane.comp.version-control.git/167800
[2] http://thread.gmane.org/gmane.comp.version-control.git/156559
[3] http://thread.gmane.org/gmane.comp.version-control.git/172617
[4] http://thread.gmane.org/gmane.comp.version-control.git/169209

You can note that I did not fix all the testcases I added.  I consider
some cases either unfixable or not worth fixing (see [5] for mailing
list discussion about the main such case).

[5] http://thread.gmane.org/gmane.comp.version-control.git/157591

However, there is one large class of problems that I think is fixable,
I'm just not sure whether it is worth fixing.  git's rename detection
optimization of only considering files that exist on one side of the
diff but not the other causes issues with merges (undetected conflicts,
spurious conflicts, or merged cleanly but wrongly due to deleting files
that should be present).  To fix these cases, we would need some way of
including rewritten files as potential rename candidates, meaning we
would also need to somehow check for rewritten files.  (I refer to these
as rename/add-source situations).  The potential problem with applying
such a fix is that it could make merges significantly more costly in the
common case, in order to fix some relatively rare problems that might
occur.  I don't know whether it is justified, especially since git's
merging can't be expected to know how to merge everything; at some point
the user is responsible for checking the result.  Patch 32 does add some
comments to the code if anyone does decide they want to look into this,
though.

Please test!  I apologize for the earlier regressions I caused in
merge-recursive.  I've tried to be MUCH more careful this time, but the
changes are numerous and much more invasive too.  I'm trying to put this
series through the testing wringer and will continue to do so, but extra
testing from others would be great.

Anyway, if you've read this far...thanks!  



Elijah Newren (48):

In patches 1-12, I add a bunch of corner case tests.  Since there are so
many I want to add and I think putting them all in t6036 would be a bit
unwieldy, I split the tests.  Since t6036 currently only contains
testcases that involve criss-cross merges, I mark it for such usage, and
create t6039 for dealing with corner cases involving renames without
criss-cross merges.

  [01] t6039: Add a testcase where git deletes an untracked file
  [02] t6039: Add failing testcase for rename/modify/add-source conflict
  [03] t6039: Add a pair of cases where undetected renames cause issues
  [04] t6039: Add a testcase where undetected rename causes silent file deletion
  [05] t6039: Add tests for content issues with modify/rename/directory conflicts
  [06] t6039: Add failing testcases for rename/rename/add-{source,dest} conflicts
  [07] t6039: Ensure rename/rename conflicts leave index and workdir in sane state
  [08] t6036: Add differently resolved modify/delete conflict in criss-cross test
  [09] t6036: criss-cross with weird content can fool git into clean merge
  [10] t6036: tests for criss-cross merges with various directory/file conflicts
  [11] t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
  [12] t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify

In patches 13-14, I add two tests that Junio reverted from master
(6db41050) which we would still like fixed, and a test that my previous
band-aids had broken to make sure we don't break it again.

  [13] t6022: Remove unnecessary untracked files to make test cleaner
  [14] t6022: New tests checking for unnecessary updates of files
  [15] t6022: Add testcase for merging a renamed file with a simple change

In patches 16-19, I'm just doing minor cleanups.  None of these are
critical; I'll be happy to drop any of them.

  [16] merge-recursive: Make BUG message more legible by adding a newline
  [17] merge-recursive: Correct a comment
  [18] merge-recursive: Mark some diff_filespec struct arguments const
  [19] merge-recursive: Remember to free generated unique path names

Patches 20-22 are small but important bug fixes.  Some of these might
make sense to be pulled to maint independent of the other changes.

  [20] merge-recursive: Avoid working directory changes during recursive case
  [21] merge-recursive: Fix recursive case with D/F conflict via add/add conflict
  [22] merge-recursive: Fix sorting order and directory change assumptions

Patches 23-29 are where I try to implement what I understood Junio
wanted merge-recursive to do to avoid so many lstat() and other
unnecessary working directory changes (see link [4] above).

  [23] merge-recursive: Fix code checking for D/F conflicts still being present
  [24] merge-recursive: Save D/F conflict filenames instead of unlinking them
  [25] merge-recursive: Split was_tracked() out of would_lose_untracked()
  [26] merge-recursive: Allow make_room_for_path() to remove D/F entries
  [27] merge-recursive: Consolidate different update_stages functions
  [28] merge-recursive: Split update_stages_and_entry; only update stages at end
  [29] merge-recursive: When we detect we can skip an update, actually skip it

Patch 30 fixes the deletion of an untracked file; I believe it has the
highest ratio of commit message length to patch size, since it has to
explain why we have modified a certain line of code several times and
still didn't have it quite right.

  [30] merge-recursive: Fix deletion of untracked file in rename/delete conflicts

The commit message for patch 31 seems like there's some good zombie joke
in there that someone cleverer than myself ought to be able to come up
with.  Interestingly, our code for rename/rename (2to1) conflicts was
never executed, and would trigger segfaults had there been a way to
execute it.

  [31] merge-recursive: Make dead code for rename/rename(2to1) conflicts undead

There are a few cases where git's rename detection optimization of only
considering files that exist on one side of the diff but not the other
causes issues with merges (undetected conflicts, spurious conflicts, or
merged cleanly but wrongly due to deleting files that should be
present).  To fix these cases, we would need some way of including
rewritten files as potential rename candidates, meaning we would also
need to somehow check for rewritten files.  My series does not address
these cases (I'm unsure whether the performance hit would be worth it).
Instead, I simply have a half-dozen relevant test cases and add some
comments to the code about some things that would need to be considered
if we ever want to tackle these cases.

  [32] merge-recursive: Add comments about handling rename/add-source cases

Patch 33 was specifically written because of a rename/directory conflict
testcase, but tries to worry about three-way content merges in
combination with renames and D/F conflicts and possible criss-cross
merges and getting the appropriate index and working directory contents.

  [33] merge-recursive: Improve handling of rename target vs. directory addition

Patch 34 is an attempted simplification of merge-recursive.c.  We really
don't need process_df_entry(), since we can simply iterate through the
unmerged entries in the order we need.  That can make it easier to keep
track of things, which is particularly important for the rename/rename
fixes below...

  [34] merge-recursive: Consolidate process_entry() and process_df_entry()

Patches 35-48 try to fix our handling of rename/rename conflicts (both
one file being renamed to two or two files being renamed to one).  In
such cases, we need to consider that the renames may not be the only
change; there could also be modifications requiring a three-way content
merge.  Further, as with all other rename cases, we need to consider the
recursive case (o->call_depth > 0) and potential D/F conflicts.  There
is also the possibility of rename/add-source issues for each side of the
rename, though we currently can't detect those anyway.  The
rename_rename_1to2 case is especially interesting, as we also have to
worry about each rename potentially also being involved in rename/delete
and rename/add-dest conflicts.  This all makes handling rename/rename
conflicts a bit hairy.

  [35] merge-recursive: Cleanup and consolidation of rename_conflict_info
  [36] merge-recursive: Provide more info in conflict markers with file renames
  [37] merge-recursive: Fix modify/delete resolution in the recursive case
  [38] merge-recursive: Introduce a merge_file convenience function
  [39] merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
  [40] merge-recursive: Small cleanups for conflict_rename_rename_1to2
  [41] merge-recursive: Defer rename/rename(2to1) handling until process_entry
  [42] merge-recursive: Record more data needed for merging with dual renames
  [43] merge-recursive: Create function for merging with branchname:file markers
  [44] merge-recursive: Consider modifications in rename/rename(2to1) conflicts
  [45] merge-recursive: Make modify/delete handling code reusable
  [46] merge-recursive: Have conflict_rename_delete reuse modify/delete code
  [47] merge-recursive: add handling for rename/rename/add-dest/add-dest
  [48] merge-recursive: Fix working copy handling for rename/rename/add/add

 merge-recursive.c                    |  985 +++++++++++++++++++++-------------
 merge-recursive.h                    |    1 +
 t/t6020-merge-df.sh                  |   26 +-
 t/t6022-merge-rename.sh              |  102 ++++-
 t/t6036-recursive-corner-cases.sh    |  502 ++++++++++++++++-
 t/t6039-merge-rename-corner-cases.sh |  556 +++++++++++++++++++
 6 files changed, 1752 insertions(+), 420 deletions(-)
 create mode 100755 t/t6039-merge-rename-corner-cases.sh

-- 
1.7.6.rc0.62.g2d69f
