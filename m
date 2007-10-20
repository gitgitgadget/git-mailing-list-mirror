From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Fix diffcore-break total breakage
Date: Sat, 20 Oct 2007 12:31:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710201158580.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPlx-00077r-52
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbXJUBiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXJUBiF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:38:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423AbXJUBiB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 21:38:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9KJVV18010595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Oct 2007 12:31:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9KJVVxd032150;
	Sat, 20 Oct 2007 12:31:31 -0700
X-Spam-Status: No, hits=-4.719 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61854>



Ok, so on the kernel list, some people noticed that "git log --follow" 
doesn't work too well with some files in the x86 merge, because a lot of 
files got renamed in very special ways.

In particular, there was a pattern of doing single commits with renames 
that looked basically like

 - rename "filename.h" -> "filename_64.h"
 - create new "filename.c" that includes "filename_32.h" or 
   "filename_64.h" depending on whether we're 32-bit or 64-bit.

which was preparatory for smushing the two trees together.

Now, there's two issues here:

 - "filename.c" *remained*. Yes, it was a rename, but there was a new file 
   created with the old name in the same commit. This was important, 
   because we wanted each commit to compile properly, so that it was 
   bisectable, so splitting the rename into one commit and the "create 
   helper file" into another was *not* an option.

   So we need to break associations where the contents change too much. 
   Fine. We have the -B flag for that. When we break things up, then the 
   rename detection will be able to figure out whether there are better 
   alternatives.

 - "git log --follow" didn't with with -B.

Now, the second case was really simple: we use a different "diffopt" 
structure for the rename detection than the basic one (which we use for 
showing the diffs). So that second case is trivially fixed by a trivial 
one-liner that just copies the break_opt values from the "real" diffopts 
to the one used for rename following. So now "git log -B --follow" works 
fine:

	diff --git a/tree-diff.c b/tree-diff.c
	index 26bdbdd..7c261fd 100644
	--- a/tree-diff.c
	+++ b/tree-diff.c
	@@ -319,6 +319,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
	 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
	 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
	 	diff_opts.single_follow = opt->paths[0];
	+	diff_opts.break_opt = opt->break_opt;
	 	paths[0] = NULL;
	 	diff_tree_setup_paths(paths, &diff_opts);
	 	if (diff_setup_done(&diff_opts) < 0)

however, the end result does *not* work. Because our diffcore-break.c 
logic is totally bogus!

In particular:

 - it used to do

	if (base_size < MINIMUM_BREAK_SIZE)
		return 0; /* we do not break too small filepair */

   which basically says "don't bother to break small files". But that 
   "base_size" is the *smaller* of the two sizes, which means that if some 
   large file was rewritten into one that just includes another file, we 
   would look at the (small) result, and decide that it's smaller than the 
   break size, so it cannot be worth it to break it up! Even if the other 
   side was ten times bigger and looked *nothing* like the samell file!

   That's clearly bogus. I replaced "base_size" with "max_size", so that 
   we compare the *bigger* of the filepair with the break size.

 - It calculated a "merge_score", which was the score needed to merge it 
   back together if nothing else wanted it. But even if it was *so* 
   different that we would never want to merge it back, we wouldn't 
   consider it a break! That makes no sense. So I added

	if (*merge_score_p > break_score)
		return 1;

   to make it clear that if we wouldn't want to merge it at the end, it 
   was *definitely* a break.

 - It compared the whole "extent of damage", counting all inserts and 
   deletes, but it based this score on the "base_size", and generated the 
   damage score with

	delta_size = src_removed + literal_added;
	damage_score = delta_size * MAX_SCORE / base_size;

   but that makes no sense either, since quite often, this will result in 
   a number that is *bigger* than MAX_SCORE! Why? Because base_size is 
   (again) the smaller of the two files we compare, and when you start out 
   from a small file and add a lot (or start out from a large file and 
   remove a lot), the base_size is going to be much smaller than the 
   damage!

   Again, the fix was to replace "base_size" with "max_size", at which 
   point the damage actually becomes a sane percentage of the whole.

With these changes in place, not only does "git log -B --follow" work for 
the case that triggered this in the first place, ie now

	git log -B --follow arch/x86/kernel/vmlinux_64.lds.S

actually gives reasonable resulys. But I also wanted to verify it in 
general, by doing a full-history

	git log --stat -B -C

on my kernel tree with the old code and the new code. 

There's some tweaking to be done, but generally, the new code generates 
much better results wrt breaking up files (and then finding better rename 
candidates). Here's a few examples of the "--stat" output:

 - This:
	include/asm-x86/Kbuild        |    2 -
	include/asm-x86/debugreg.h    |   79 +++++++++++++++++++++++++++++++++++------
	include/asm-x86/debugreg_32.h |   64 ---------------------------------
	include/asm-x86/debugreg_64.h |   65 ---------------------------------
	4 files changed, 68 insertions(+), 142 deletions(-)

      Becomes:

	include/asm-x86/Kbuild                        |    2 -
	include/asm-x86/{debugreg_64.h => debugreg.h} |    9 +++-
	include/asm-x86/debugreg_32.h                 |   64 -------------------------
	3 files changed, 7 insertions(+), 68 deletions(-)

 - This:
	include/asm-x86/bug.h    |   41 +++++++++++++++++++++++++++++++++++++++--
	include/asm-x86/bug_32.h |   37 -------------------------------------
	include/asm-x86/bug_64.h |   34 ----------------------------------
	3 files changed, 39 insertions(+), 73 deletions(-)

      Becomes

	include/asm-x86/{bug_64.h => bug.h} |   20 +++++++++++++-----
	include/asm-x86/bug_32.h            |   37 -----------------------------------
	2 files changed, 14 insertions(+), 43 deletions(-)

Now, in some other cases, it does actually turn a rename into a real 
"delete+create" pair, and then the diff is usually bigger, so truth in 
advertizing: it doesn't always generate a nicer diff. But for what -B was 
meant for, I think this is a big improvement, and I suspect those cases 
where it generates a bigger diff are tweakable.

So I think this diff fixes a real bug, but we might still want to tweak 
the default values and perhaps the exact rules for when a break happens.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Hmm? At least the "should_break()" tests seem to make some amount of sense 
now, I think. 

		Linus

----
 diffcore-break.c |   11 +++++++----
 tree-diff.c      |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index ae8a7d0..c71a226 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -45,8 +45,8 @@ static int should_break(struct diff_filespec *src,
 	 * The value we return is 1 if we want the pair to be broken,
 	 * or 0 if we do not.
 	 */
-	unsigned long delta_size, base_size, src_copied, literal_added,
-		src_removed;
+	unsigned long delta_size, base_size, max_size;
+	unsigned long src_copied, literal_added, src_removed;
 
 	*merge_score_p = 0; /* assume no deletion --- "do not break"
 			     * is the default.
@@ -63,7 +63,8 @@ static int should_break(struct diff_filespec *src,
 		return 0; /* error but caught downstream */
 
 	base_size = ((src->size < dst->size) ? src->size : dst->size);
-	if (base_size < MINIMUM_BREAK_SIZE)
+	max_size = ((src->size > dst->size) ? src->size : dst->size);
+	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
 
 	if (diffcore_count_changes(src, dst,
@@ -89,12 +90,14 @@ static int should_break(struct diff_filespec *src,
 	 * less than the minimum, after rename/copy runs.
 	 */
 	*merge_score_p = (int)(src_removed * MAX_SCORE / src->size);
+	if (*merge_score_p > break_score)
+		return 1;
 
 	/* Extent of damage, which counts both inserts and
 	 * deletes.
 	 */
 	delta_size = src_removed + literal_added;
-	if (delta_size * MAX_SCORE / base_size < break_score)
+	if (delta_size * MAX_SCORE / max_size < break_score)
 		return 0;
 
 	/* If you removed a lot without adding new material, that is
diff --git a/tree-diff.c b/tree-diff.c
index 26bdbdd..7c261fd 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -319,6 +319,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
+	diff_opts.break_opt = opt->break_opt;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
