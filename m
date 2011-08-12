From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 30/56] merge-recursive: Fix deletion of untracked file in rename/delete conflicts
Date: Thu, 11 Aug 2011 23:20:03 -0600
Message-ID: <1313126429-17368-31-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCK-0005Kt-2Q
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab1HLFV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:56 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1HLFVe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:34 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XUYHwdjBBEtdh0DJXF3oeip2Gub5KmFBE02C5c7jUVg=;
        b=FI7Rkt1NrBinc6iUrfTZ4U8+sc/Wth30YKZylMME2S7EXR6YkkOK8l1o0NiYG43ZZV
         vZ7cnhUwOka0AQtLydVU0q9rj+Xo5xu3rphZLt0xG+14N5iC1JPuJouFPHzr/eNdzrWt
         JoV3OENnSrnlFUV1GRMwC6v130W4dyNIG2tVw=
Received: by 10.231.115.26 with SMTP id g26mr1140266ibq.32.1313126494331;
        Thu, 11 Aug 2011 22:21:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.32
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179189>

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
  "renamed_stage == 2 || !was_tracked(ren1_src)", in order to remove
  unnecessary code and avoid deleting untracked files.

96 lines of explanation in the changelog to describe a one-line fix...

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                    |    3 ++-
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 650d5ec..f395d20 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1117,7 +1117,8 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
+			remove_file(o, 1, ren1_src,
+				    renamed_stage == 2 || !was_tracked(ren1_src));
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 427fe1c..668ec6d 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup rename/delete + untracked file' '
 	echo "Myyy PRECIOUSSS" >ring
 '
 
-test_expect_failure "Does git preserve Gollum's precious artifact?" '
+test_expect_success "Does git preserve Gollum's precious artifact?" '
 	test_must_fail git merge -s recursive rename-the-ring &&
 
 	# Make sure git did not delete an untracked file
-- 
1.7.6.100.gac5c1
