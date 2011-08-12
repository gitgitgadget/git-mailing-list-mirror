From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 00/57] Re-roll of en/merge-recursive from pu
Date: Thu, 11 Aug 2011 23:19:33 -0600
Message-ID: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDr-00066y-Pc
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1HLFUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:35 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab1HLFUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:33 -0400
Received: by iye16 with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gSzeAzshJI/R/BlcZLoFHZOj0ZXTQi5MZWL4G86s0YA=;
        b=C+put7kYl9bxqPjJNyjRm9fu40AZhihiZNKvLhv5nr21K0PPBHhDsvoELGbYeGzQJz
         d0x3cMDpNHoDhO0PbwlitZFkDmUKANyLzxT0+mlHI6afNLU1LZCJzNlktwa2gn4froeV
         KFnWjfml8IAMq9H9wAfkI9hcPIqSJ5XLQAGtQ=
Received: by 10.42.139.6 with SMTP id e6mr506925icu.188.1313126433219;
        Thu, 11 Aug 2011 22:20:33 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.30
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179216>

This is a re-roll of en/merge-recursive from pu, fixing half a dozen
bugs (some pre-existing ones, some caused by my first series).

I think the series is now ready for wide consumption and should be
safe for the upcoming release, particularly due to some heavy
additional testing I performed.  If others disagree, I'm fine and can
wait out another release cycle.  Either way, I am open for suggestions
or ideas on additional testing people would like to see if they have
worries about the robustness of these changes.


*** Heavy additional testing I performed ***

Because it's so hard to rule out regressions with so many changes to a
complicated portion of the code (though hopefully it is less complicated
now), and because we've had multiple problems in the past with the
changes I've been making to merge-recursive, I came up with an idea to
test this series more thoroughly.  So, I wrote a script to take every
single merge commit in git.git that had exactly two parents (no octopus
merges) and redid them both with /usr/bin/git and the version of git
from this series.  I checked to ensure that the two different versions
of git:
  (a) EITHER both failed to merge cleanly OR both merged cleanly
AND
  (b) the output of 'git ls-tree -r HEAD' matched between the two

I ran this process with the original version of the series and indeed
found that my original series mis-merged half a dozen or so merges (out
of about 5000).

With this new version of the series, I get no such mis-merges, which
gives me relatively strong confidence that there are no merge
regressions relative to git-1.7.4.4 (the version I happened to have in
/usr/bin).

*** What's fixed ***

Everything that I claimed the original series fixed, is still fixed in
this series.

This series fixes the following bugs from the previous series:
  * The mis-merge that Junio reported (which would have been found had I
    been more thorough in the new testcases I myself had added -- oops)
  * The windows bug identified by Johannes (at least I hope I fixed that
    one -- I'll need him to verify)
  * The potential incorrect deletion of a path that I reported (while
    discussing the patch that Johannes flagged for other reasons)
  * A fix to my more detailed conflict markers when renames are involved
    (it sometimes swapped filenames between branches)

This series also fixes the following bugs that exist in current git and
had not been fixed by my previous series:
  * The incorrectly-deleted file in the created virtual merge base problem
    that Junio identified when rename/rename(1to2) conflicts also involved
    rename/add-dest conflicts for one or more of the two renames.  [That's
    a mouthful, isn't it?]
  * Sometimes git would erroneously print 'refusing to lose untracked file...'
    warning messages.
  * There are three more cases where files were needlessly getting rewritten
    despite already having the correct contents (though none of these
    cases involved content merges).

The fixes to problems in the original series were made as modifications to
the relevant patches.  The new fixes were simply added to the end of the
series, in order to facilitate review.

*** What's changed ***

I took the series with Junio's modifications in pu, and made changes as
necessary to address his comments and other problems that were found.  I
have left his signed-off-by on patches where no changes were made.  Most
patches were unchanged; the full list of changed patches are:

  [05] t6042: Add tests for content issues with modify/rename/directory conflicts
    Changes: Fleshed out the commit message

  [07] t6042: Ensure rename/rename conflicts leave index and workdir in sane state
    Changes: Move this patch prior to the previous one (as suggested by
             Junio), since it has a simpler rename/rename(1to2) case in
             it.  (Did not remove Junio's s-o-b, since this was a
             trivial test-reorder change.)

  [08] t6036: Add differently resolved modify/delete conflict in criss-cross test
    Changes: Made wording change suggested by Junio.  (Did not remove
             Junio's s-o-b, since I took his exact suggestion.)

  [10] t6036: tests for criss-cross merges with various directory/file conflicts
    Changes: Lots of wording cleanups and making the tests more thorough

  [11] t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
    Changes: More thorough testing of result, usage of some of Junio's
             wording in a comment

  [12] t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
    Changes: More thorough testing of result, improvement on wording describing test

  [15] t6022: Add testcase for merging a renamed file with a simple change
    Changes: Fix to check actual result is correct; that would have caught the
             bug Junio instead found the hard way.

  [19] merge-recursive: Consolidate different update_stages functions
    Changes: Moved earlier in the series, as per Junio's request; used
             to be patch number 27.  (Did not remove Junio's s-o-b,
             since no significant changes were necessary.)

  [23] merge-recursive: Fix sorting order and directory change assumptions
    Changes: Mentioned Johannes' squashed-in changes and added his
             signed-off-by from his squashed-in patch.  (Did not remove
             Junio's s-o-b, since he had added his to Johannes' patch.)

  [27] string-list: Add API to remove an item from an unsorted list
    Changes: This is an entirely new patch, recently submitted to the list by
             Johannes.

  [28] merge-recursive: Allow make_room_for_path() to remove D/F entries
    Changes: (1) Made use of Johannes' new string-list API to remove
             items we have already checked in order to avoid trying to
             unlink a path more than once, (2) fixed bug with not
             checking that basepath was directory

  [36] merge-recursive: Provide more info in conflict markers with file renames
    Changes: Fix bug where I could get filenames from two branches reversed

  
  [37] merge-recursive: When we detect we can skip an update, actually skip it
    Changes: Moved to later in the series (used to be patch #29).  Also,
             changed the "was_tracked" logic to use information about
             what paths were involved in renames to determine whether
             the file really 'was tracked' before the merge started.
             Also, added another minor tweak to get the expected
             "Skipped" messages that t6022.12 expects.

  [51-56]
    These are entirely new patches providing testcases and fixes for
    bugs that exist with current git and were not fixed in my previous
    series (but probably should have been).

*** What is still missing ***

Two things:
  * Junio had a great suggestion about alternate handling of the index in the
    case of rename/rename(2to1) and directory/file conflicts (just rename the
    entry in the index to match how we are renaming in the working copy to
    some new unique name, in order to allow 'git diff' to provide more useful
    information to the user).  Just didn't get to it.
  * Support for running break detection in diffs, in order to fix the testcase
    corrected by Peff in this series.  Simply didn't get around to it either.
Neither of these two things represent regressions relative to what is in
current releases of git, however.

*** Full patch list and diffstat ***

Elijah Newren (54):
  [01] t6042: Add a testcase where git deletes an untracked file
  [02] t6042: Add failing testcase for rename/modify/add-source conflict
  [03] t6042: Add a pair of cases where undetected renames cause issues
  [04] t6042: Add a testcase where undetected rename causes silent file deletion
  [05] t6042: Add tests for content issues with modify/rename/directory conflicts
  [06] t6042: Ensure rename/rename conflicts leave index and workdir in sane state
  [07] t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
  [08] t6036: Add differently resolved modify/delete conflict in criss-cross test
  [09] t6036: criss-cross with weird content can fool git into clean merge
  [10] t6036: tests for criss-cross merges with various directory/file conflicts
  [11] t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
  [12] t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
  [13] t6022: Remove unnecessary untracked files to make test cleaner
  [14] t6022: New tests checking for unnecessary updates of files
  [15] t6022: Add testcase for merging a renamed file with a simple change
  [16] merge-recursive: Make BUG message more legible by adding a newline
  [17] merge-recursive: Correct a comment
  [18] merge-recursive: Mark some diff_filespec struct arguments const
  [19] merge-recursive: Consolidate different update_stages functions
  [20] merge-recursive: Remember to free generated unique path names
  [21] merge-recursive: Avoid working directory changes during recursive case
  [22] merge-recursive: Fix recursive case with D/F conflict via add/add conflict
  [23] merge-recursive: Fix sorting order and directory change assumptions
  [24] merge-recursive: Fix code checking for D/F conflicts still being present
  [25] merge-recursive: Save D/F conflict filenames instead of unlinking them
  [26] merge-recursive: Split was_tracked() out of would_lose_untracked()
  [28] merge-recursive: Allow make_room_for_path() to remove D/F entries
  [29] merge-recursive: Split update_stages_and_entry; only update stages at end
  [30] merge-recursive: Fix deletion of untracked file in rename/delete conflicts
  [31] merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
  [32] merge-recursive: Add comments about handling rename/add-source cases
  [33] merge-recursive: Improve handling of rename target vs. directory addition
  [34] merge-recursive: Consolidate process_entry() and process_df_entry()
  [35] merge-recursive: Cleanup and consolidation of rename_conflict_info
  [36] merge-recursive: Provide more info in conflict markers with file renames
  [37] merge-recursive: When we detect we can skip an update, actually skip it
  [38] merge-recursive: Fix modify/delete resolution in the recursive case
  [39] merge-recursive: Introduce a merge_file convenience function
  [40] merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
  [41] merge-recursive: Small cleanups for conflict_rename_rename_1to2
  [42] merge-recursive: Defer rename/rename(2to1) handling until process_entry
  [43] merge-recursive: Record more data needed for merging with dual renames
  [44] merge-recursive: Create function for merging with branchname:file markers
  [45] merge-recursive: Consider modifications in rename/rename(2to1) conflicts
  [46] merge-recursive: Make modify/delete handling code reusable
  [47] merge-recursive: Have conflict_rename_delete reuse modify/delete code
  [48] merge-recursive: add handling for rename/rename/add-dest/add-dest
  [49] merge-recursive: Fix working copy handling for rename/rename/add/add
  [51] t6022: Add testcase for spurious "refusing to lose untracked" messages
  [52] merge-recursive: Fix spurious 'refusing to lose untracked file...' messages
  [53] t6022: Additional tests checking for unnecessary updates of files
  [54] merge-recursive: Avoid unnecessary file rewrites
  [55] t6042: Add testcase demonstrating missing file in virtual merge base
  [56] merge-recursive: Fix virtual merge base for rename/rename(1to2)/add-dest

Jeff King (1):
  [50] t3030: fix accidental success in symlink rename

Johannes Sixt (1):
  [27] string-list: Add API to remove an item from an unsorted list

 Documentation/technical/api-string-list.txt |   10 +
 merge-recursive.c                           | 1067 +++++++++++++++++----------
 merge-recursive.h                           |    1 +
 string-list.c                               |    9 +
 string-list.h                               |    1 +
 t/t3030-merge-recursive.sh                  |    7 +-
 t/t6020-merge-df.sh                         |   26 +-
 t/t6022-merge-rename.sh                     |  291 +++++++-
 t/t6036-recursive-corner-cases.sh           |  598 ++++++++++++++-
 t/t6042-merge-rename-corner-cases.sh        |  625 ++++++++++++++++
 10 files changed, 2207 insertions(+), 428 deletions(-)
 create mode 100755 t/t6042-merge-rename-corner-cases.sh

-- 
1.7.6.100.gac5c1
