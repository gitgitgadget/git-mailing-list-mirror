From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/37] Audit and fix corner case bugs in recursive merge
Date: Mon, 20 Sep 2010 02:28:33 -0600
Message-ID: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:27:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxbiq-0005iZ-GN
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0ITI1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0ITI13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:29 -0400
Received: by pzk34 with SMTP id 34so1070478pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Yv1R5f1cOoo8BLKFCsoQNZbwyOM8iDtOLuYaiaDPVW4=;
        b=EcF4ynhHiC9xdYCoIYHKPx5M+DE/zYoMXpFIpkQ48z+reAyHroLGIKiFVQ5FUsSI4s
         9z+UdsszSa5/ILASPUtJeFvnlHUWe9RaOoo2qhm3+jLCy4vMuv/0KOFo0s2s/iLYYddN
         zF43rSXTJEjf2fyCn2YC8VnzfmSQEGF/IirU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v4iN6EDYL7A3VIvvnVR62+CHezF0oKZxyAFcTIeHbWYFc+0QngR6i/MBWVdUYL5Q07
         PTBrYfCXsqyQSsyTaOMyX3ZF8SO20gzwW0KqDnri6ki2SzIJTd9kpPIAcEMh7yJ5UgZQ
         rcbQ9c/EGFwDuqLHv9M8KaREs8AQ1Qc+KfHj0=
Received: by 10.142.218.2 with SMTP id q2mr7345924wfg.246.1284971249099;
        Mon, 20 Sep 2010 01:27:29 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156559>

I may want to add another test or two, and tweak some things here or
there, but I finally have this series working enough that others could
test or comment on it now...

This patch series serves as an audit and fix of a number of corner
case bugs in the recursive merge algorithm.  The initial thrust for
the audit came from this exchange (from
http://thread.gmane.org/gmane.comp.version-control.git/155770/focus=155917):

On Thu, Sep 9, 2010 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>> ... git can't know that there's a conflict
>> until after it's tried resolving paths involving newsub/newfile to see if
>> they are still in the way at the end (and if newsub/newfile is not in the
>> way at the end, there should be no conflict at all, which did not hold with
>> git previously).
>
> I'll queue this patch to 'pu', but anybody who wrote the above to
> correctly arriave at the crux of the issue in his analysis would know that
> this is another band-aid on top of band-aid.  The approach merge-recursive
> takes to first grab the set of directories and files fundamentally is
> wrong---it should be resolving the paths in-core first and then look at
> the result to ignore a directory that has become empty.

Junio is right, of course -- on all counts.  Inspection of the current
band-aids shows that there are still a number of bugs in the recursive
merge algorithm in corner cases with renames and directory/file (D/F)
conflicts.  My investigation also turned up a bug not involving
renames but dealing with D/F conflicts in combination with
modify/delete conflicts.  I also happened to find a bug not involving
D/F conflicts where git could incorrectly resolve a merge involving
prior criss-cross merges (in some cases silently accepting one side of
the merge as the final resolution without detecting a relevant
conflict).

This patch series is predominantly about doing exactly as Junio
suggests: resolving paths in-core first and then looking at the result
to see if the D/F conflicts still have paths in the way of each other
at the end.  However, it also includes the creation of several
testcases showing how and where the current algorithm is insufficient,
and addresses the undetected merge conflict found as well.

This series is based on next as it modifies/builds-on en/rename-d-f;
it cannot be played directly on top of that series as it also depends
on ks/recursive-rename-add-identical from master.

This series also includes three patches previously posted on the list
but which have not yet been picked up in pu or elsewhere: One from
Junio to allow creation of new process_*() functions and modifying
process_df_entry() to work with such chaining, one from Ken Schalk to
add a testcase for resolving a rename/add conflict involving symlinks,
and a previous submission of mine to rename/clarify the 'stage'
variable in process_renames().

The series ended up being bigger than I realized when I started.
Also, since it's whole purpose is to handle corner cases, I know that
it may be harder to review than other series.  I've tried to break it
down to address that, but I'm not sure if I have split the patches too
finely or too coarsely, or whether I've added sufficient explanation.
Let me know.


Schalk, Ken (1):
  t3030: Add a testcase for resolvable rename/add conflict with
    symlinks

Junio C Hamano (1):
  merge-recursive: Restructure showing how to chain more process_*
    functions

Elijah Newren (35):
  t6032: Add a test checking for excessive output from merge
  t6022: Add test combinations of {content conflict?, D/F conflict
    remains?}
  t6022: Add tests for reversing order of merges when D/F conflicts
    present
  t6022: Add tests with both rename source & dest involved in D/F
    conflicts
  t6022: Add paired rename+D/F conflict: (two/file, one/file) -> (one,
    two)
  t6022: Add tests for rename/rename combined with D/F conflicts
  t6020: Modernize style a bit
  t6020: Add a testcase for modify/delete + directory/file conflict
  t6036: Test index and worktree state, not just that merge fails
  t6036: Add a second testcase similar to the first but with content
    changes
  t6036: Add testcase for undetected conflict

The above patches are all about adding testcases both to extend our
coverage of different cases, and to expose corner case bugs.

  merge-recursive: Small code clarification -- variable name and
    comments
  merge-recursive: Rename conflict_rename_rename*() for clarity
  merge-recursive: Nuke rename/directory conflict detection

These three patches are just small code cleanups.  No bug fixes yet.

  merge-recursive: Move rename/delete handling into dedicated function
  merge-recursive: Move delete/modify handling into dedicated function
  merge-recursive: Move process_entry's content merging into a function

These three patches are just moving code into functions which will
later be called from multiple places.  Still no bug fixes.

  merge-recursive: New data structures for deferring of D/F conflicts
  merge-recursive: New function to assist resolving renames in-core
    only
  merge-recursive: Have process_entry() skip D/F or rename entries
  merge-recursive: Structure process_df_entry() to handle more cases
  merge-recursive: Update conflict_rename_rename_1to2() call signature
  merge-recursive: Update merge_content() call signature

These patches introduce new data structures and update the call
signatures of various functions to make it so I can pass additional
D/F conflict information to them.  Still no bug fixes yet.

  merge-recursive: Avoid doubly merging rename/add conflict contents

This patch is for what I belive to be the most concerning of the
corner case bugs I found (since git will under some circumstances
create and report a clean merge when it should have detected a
conflict), and the only one that doesn't involve D/F conflicts.

  merge-recursive: Move handling of double rename of one file to two
  merge-recursive: Move handling of double rename of one file to other
    file
  merge-recursive: Delay handling of rename/delete conflicts
  merge-recursive: Delay content merging for renames
  merge-recursive: Delay modify/delete conflicts if D/F conflict
    present

These patches simply move anything related to D/F conflicts from
process_renames() and process_entry() into process_df_entry().  Just
moving the code without further changes already fixes a couple bugs.

  conflict_rename_delete(): Check whether D/F conflicts are still
    present
  conflict_rename_rename_1to2(): Fix checks for presence of D/F
    conflicts
  merge_content(): Check whether D/F conflicts are still present
  handle_delete_modify(): Check whether D/F conflicts are still present
  merge-recursive: Make room for directories in D/F conflicts

These patches are where the majority of the corner case bugs involving
D/F conflicts get fixed, now that the appropriate structure is in place.

  merge-recursive: Remove redundant path clearing for D/F conflicts

...and one final clean up patch, due to the fact that keeping all the
tests passing in intermediate commits meant using ad-hoc methods to
make room for directories in D/F conflicts.


 merge-recursive.c                 |  649 ++++++++++++++++++++++++-------------
 t/t3030-merge-recursive.sh        |   37 ++-
 t/t6020-merge-df.sh               |   82 ++++-
 t/t6022-merge-rename.sh           |  366 +++++++++++++++++++++
 t/t6032-merge-large-rename.sh     |   30 ++
 t/t6036-recursive-corner-cases.sh |  185 +++++++++++-
 6 files changed, 1108 insertions(+), 241 deletions(-)

-- 
1.7.3.271.g16009
