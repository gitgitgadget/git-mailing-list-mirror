From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 30/48] merge-recursive: Fix deletion of untracked file in rename/delete conflicts
Date: Wed,  8 Jun 2011 01:31:00 -0600
Message-ID: <1307518278-23814-31-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEg-0006q0-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab1FHHaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:01 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab1FHH34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:56 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=az9D7cVl1sUaAwaPRedW7vIk+ySw9Wj3KtT03LbzWZY=;
        b=kfWoqBYLYr4N9exoNqFhG/TI0GvjS8ev3s76MxAlZR1SyF6tqaAPImyCpxSwzZ5LD3
         VB1EzW0zkffU0JO6N3+3DtIEPMluc9FKBdtN2sx1/300QRu9GXtubTHhLFenirlPZ/b3
         stLTMKLFRLbfSMZfiUQM5hmPD3Md+P8N0eCVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rmkn9/in+LXisjgx8zV/6IXCs6Bh5lT8vMdGj0UCMWkqAiNJJO+xFR7ObMlGVImkYm
         lta1c/WT/WzeU5hRZfWk4HFa+Jkx5tfPTXCaq4K4vTDKCy83PR8msgCerWa6P5Ngct/N
         2JMnFlS0gL28oE/So0AVW0bLEwf1Im7yDHJXE=
Received: by 10.68.50.164 with SMTP id d4mr583722pbo.261.1307518196207;
        Wed, 08 Jun 2011 00:29:56 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.54
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175316>

In the recursive case (o->call_depth > 0), we do not modify the working
directory.  However, when o->call_depth==0, file renames can mean we need
to delete the old filename from the working copy.  Since there have been
lots of changes and mistakes here, let's go through the details.  Let's
start with a simple explanation of what we are trying to achieve:

  Original goal: If a file is renamed on the side of history being merged
  into head, the filename serving as the source of that rename needs to be
  removed from the working directory.

The path to getting the above statement implemented in merge-recursive took
several steps.  The relevant bits of code may be instructive to keep in
mind for the explanation, especially since an English-only description
involves double negatives that are hard to follow.  These bits of code are:
  int remove_file(..., const char *path, int no_wd)
  {
    ...
    int update_working_directory = !o->call_depth && !no_wd;
and
  remove_file(o, 1, ren1_src, <expression>);
Where the choice for <expression> has morphed over time:

65ac6e9 (merge-recursive: adjust to loosened "working file clobbered"
check 2006-10-27), introduced the "no_wd" parameter to remove_file() and
used "1" for <expression>.  This meant ren1_src was never deleted, leaving
it around in the working copy.

In 8371234 (Remove uncontested renamed files during merge. 2006-12-13),
<expression> was changed to "index_only" (where index_only ==
!!o->call_depth; see b7fa51da).   This was equivalent to using "0" for
<expression> (due to the early logic in remove_file), and is orthogonal to
the condition we actually want to check at this point; it resulted in the
source file being removed except when index_only was false.  This was
problematic because the file could have been renamed on the side of history
including head, in which case ren1_src could correspond to an untracked
file that should not be deleted.

In 183d797 (Keep untracked files not involved in a merge. 2007-02-04),
<expression> was changed to "index_only || stage == 3".  While this gives
correct behavior, the "index_only ||" portion of <expression> is
unnecessary and makes the code slightly harder to follow.

There were also two further changes to this expression, though without
any change in behavior.  First in b7fa51d (merge-recursive: get rid of the
index_only global variable 2008-09-02), it was changed to "o->call_depth
|| stage == 3".  (index_only == !!o->call_depth).  Later, in 41d70bd6
(merge-recursive: Small code clarification -- variable name and comments),
this was changed to "o->call_depth || renamed_stage == 2" (where stage was
renamed to other_stage and renamed_stage == other_stage ^ 1).

So we ended with <expression> being "o->call_depth || renamed_stage == 2".
But the "o->call_depth ||" piece was unnecessary.  We can remove it,
leaving us with <expression> being "renamed_stage == 2".  This doesn't
change behavior at all, but it makes the code clearer.  Which is good,
because it's about to get uglier.

  Corrected goal: If a file is renamed on the side of history being merged
  into head, the filename serving as the source of that rename needs to be
  removed from the working directory *IF* that file is tracked in head AND
  the file tracked in head is related to the original file.

Note that the only difference between the original goal and the corrected
goal is the two extra conditions added at the end.  The first condition is
relevant in a rename/delete conflict.  If the file was deleted on the
HEAD side of the merge and an untracked file of the same name was added to
the working copy, then without that extra condition the untracked file
will be erroneously deleted.  This changes <expression> to "renamed_stage
== 2 || !was_tracked(ren1_src)".

The second additional condition is relevant in two cases.

The first case the second condition can occur is when a file is deleted
and a completely different file is added with the same name.  To my
knowledge, merge-recursive has no mechanism for detecting deleted-and-
replaced-by-different-file cases, so I am simply punting on this
possibility.

The second case for the second condition to occur is when there is a
rename/rename/add-source conflict.  That is, when the original file was
renamed on both sides of history AND the original filename is being
re-used by some unrelated (but tracked) content.  This case also presents
some additional difficulties for us since we cannot currently detect these
rename/rename/add-source conflicts; as long as the rename detection logic
"optimizes" by ignoring filenames that are present at both ends of the
diff, these conflicts will go unnoticed.  However, rename/rename conflicts
are handled by an entirely separate codepath not being discussed here, so
this case is not relevant for the line of code under consideration.

In summary:
  Change <expression> from "o->call_depth || renamed_stage == 2" to
  "renamed_stage == 2 || !was_tracked(ren1_src)", in order to
  remove unnecessary code and avoid deleting untracked files.

96 lines of explanation in the changelog to describe a one-line fix...

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |    3 ++-
 t/t6039-merge-rename-corner-cases.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 987a985..749e501 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1102,7 +1102,8 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
+			remove_file(o, 1, ren1_src,
+				    renamed_stage == 2 || !was_tracked(ren1_src));
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 06c7ea5..4f94528 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup rename/delete + untracked file' '
 	echo "Myyy PRECIOUSSS" >ring
 '
 
-test_expect_failure "Does git preserve Gollum's precious artifact?" '
+test_expect_success "Does git preserve Gollum's precious artifact?" '
 	test_must_fail git merge -s recursive rename-the-ring &&
 
 	# Make sure git did not delete an untracked file
-- 
1.7.6.rc0.62.g2d69f
