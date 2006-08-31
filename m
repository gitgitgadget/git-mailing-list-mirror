From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-rev-list(1): group options; reformat; document more options
Date: Fri, 1 Sep 2006 00:37:15 +0200
Message-ID: <20060831223715.GC482@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 01 00:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvA6-0007Mn-NX
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 00:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWHaWhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 18:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWHaWhX
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 18:37:23 -0400
Received: from [130.225.96.91] ([130.225.96.91]:47326 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932463AbWHaWhV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 18:37:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 3731177005F
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:37:18 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07743-14 for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:37:16 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 444DD77004C
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:37:16 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 7ED176DF8B3
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:35:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2AE8D62A06; Fri,  1 Sep 2006 00:37:16 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26282>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-rev-list.txt |  254 ++++++++++++++++++++++++++++++----------
 1 files changed, 188 insertions(+), 66 deletions(-)

An attempted facelift to the neglected git-rev-list manpage. One
question if I may, the diff-related -r and -t options, how are they
supposed to work?

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a446a6b..d6c86db 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,111 +27,233 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+
 Lists commit objects in reverse chronological order starting at the
 given commit(s), taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
-Commits which are stated with a preceding '{caret}' cause listing to stop at
-that point. Their parents are implied. "git-rev-list foo bar {caret}baz" thus
+Commits which are stated with a preceding '{caret}' cause listing to
+stop at that point. Their parents are implied. Thus the following
+command:
+
+-----------------------------------------------------------------------
+	$ git-rev-list foo bar ^baz
+-----------------------------------------------------------------------
+
 means "list all the commits which are included in 'foo' and 'bar', but
 not in 'baz'".
 
-A special notation <commit1>..<commit2> can be used as a
-short-hand for {caret}<commit1> <commit2>.
+A special notation "'<commit1>'..'<commit2>'" can be used as a
+short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
+the following may be used interchangeably:
 
-Another special notation is <commit1>...<commit2> which is useful for
-merges.  The resulting set of commits is the symmetric difference
+-----------------------------------------------------------------------
+	$ git-rev-list origin..HEAD
+	$ git-rev-list HEAD ^origin
+-----------------------------------------------------------------------
+
+Another special notation is "'<commit1>'...'<commit2>'" which is useful
+for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
-------------
-$ git-rev-list A B --not $(git-merge-base --all A B)
-$ git-rev-list A...B
-------------
+-----------------------------------------------------------------------
+	$ git-rev-list A B --not $(git-merge-base --all A B)
+	$ git-rev-list A...B
+-----------------------------------------------------------------------
+
+gitlink:git-rev-list[1] is a very essential git program, since it
+provides the ability to build and traverse commit ancestry graphs. For
+this reason, it has a lot of different options that enables it to be
+used by commands as different as gitlink:git-bisect[1] and
+gitlink:git-repack[1].
 
 OPTIONS
 -------
---pretty::
-	Print the contents of the commit changesets in human-readable form.
+
+Commit Formatting
+~~~~~~~~~~~~~~~~~
+
+Using these options, gitlink:git-rev-list[1] will act similar to the
+more specialized family of commit log tools: gitlink:git-log[1],
+gitlink:git-show[1], and gitlink:git-whatchanged[1]
+
+--pretty[='<format>']::
+
+	Pretty print the contents of the commit logs in a given format,
+	where '<format>' can be one of 'raw', 'medium', 'short', 'full',
+	and 'oneline'. When left out the format default to 'medium'.
+
+--relative-date::
+
+	Show dates relative to the current time, e.g. "2 hours ago".
+	Only takes effect for dates shown in human-readable format, such
+	as when using "--pretty".
 
 --header::
-	Print the contents of the commit in raw-format; each
-	record is separated with a NUL character.
+
+	Print the contents of the commit in raw-format; each record is
+	separated with a NUL character.
 
 --parents::
+
 	Print the parents of the commit.
 
---objects::
-	Print the object IDs of any object referenced by the listed commits.
-	'git-rev-list --objects foo ^bar' thus means "send me all object IDs
-	which I need to download if I have the commit object 'bar', but
-	not 'foo'".
+Diff Formatting
+~~~~~~~~~~~~~~~
 
---objects-edge::
-	Similar to `--objects`, but also print the IDs of
-	excluded commits prefixed with a `-` character.  This is
-	used by `git-pack-objects` to build 'thin' pack, which
-	records objects in deltified form based on objects
-	contained in these excluded commits to reduce network
-	traffic.
+Below are listed options that control the formatting of diff output.
+Some of them are specific to gitlink:git-rev-list[1], however other diff
+options may be given. See gitlink:git-diff-files[1] for more options.
 
---unpacked::
-	Only useful with `--objects`; print the object IDs that
-	are not in packs.
+-c::
+
+	This flag changes the way a merge commit is displayed.  It shows
+	the differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a parent
+	and the result one at a time. Furthermore, it lists only files
+	which were modified from all parents.
+
+--cc::
+
+	This flag implies the '-c' options and further compresses the
+	patch output by omitting hunks that show differences from only
+	one parent, or show the same change from all but one parent for
+	an Octopus merge.
+
+-r::
+
+	Show recursive diffs.
+
+-t::
+
+	Show the tree objects in the diff output. This implies '-r'.
+
+Commit Limiting
+~~~~~~~~~~~~~~~
+
+Besides specifying a range of commits that should be listed using the
+special notations explained in the description, additional commit
+limiting may be applied.
+
+--
+
+-n 'number', --max-count='number'::
 
---bisect::
-	Limit output to the one commit object which is roughly halfway
-	between the included and excluded commits. Thus, if 'git-rev-list
-	--bisect foo {caret}bar {caret}baz' outputs 'midpoint', the output
-	of 'git-rev-list foo {caret}midpoint' and 'git-rev-list midpoint
-	{caret}bar {caret}baz' would be of roughly the same length.
-	Finding the change
-	which introduces a regression is thus reduced to a binary search:
-	repeatedly generate and test new 'midpoint's until the commit chain
-	is of length one.
-
---max-count::
 	Limit the number of commits output.
 
---max-age=timestamp, --min-age=timestamp::
-	Limit the commits output to specified time range.
+--since='date', --after='date'::
+
+	Show commits more recent than a specific date.
+
+--until='date', --before='date'::
 
---sparse::
-	When optional paths are given, the command outputs only
-	the commits that changes at least one of them, and also
-	ignores merges that do not touch the given paths.  This
-	flag makes the command output all eligible commits
-	(still subject to count and age limitation), but apply
-	merge simplification nevertheless.
+	Show commits older than a specific date.
+
+--max-age='timestamp', --min-age='timestamp'::
+
+	Limit the commits output to specified time range.
 
 --remove-empty::
+
 	Stop when a given path disappears from the tree.
 
 --no-merges::
+
 	Do not print commits with more than one parent.
 
 --not::
-	Reverses the meaning of the '{caret}' prefix (or lack
-	thereof) for all following revision specifiers, up to
-	the next `--not`.
+
+	Reverses the meaning of the '{caret}' prefix (or lack thereof)
+	for all following revision specifiers, up to the next '--not'.
 
 --all::
-	Pretend as if all the refs in `$GIT_DIR/refs/` are
-	listed on the command line as <commit>.
 
---topo-order::
-	By default, the commits are shown in reverse
-	chronological order.  This option makes them appear in
-	topological order (i.e. descendant commits are shown
-	before their parents).
+	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
+	command line as '<commit>'.
 
 --merge::
+
 	After a failed merge, show refs that touch files having a
 	conflict and don't exist on all heads to merge.
 
---relative-date::
-	Show dates relative to the current time, e.g. "2 hours ago".
-	Only takes effect for dates shown in human-readable format,
-	such as when using "--pretty".
+--boundary::
+
+	Output uninteresting commits at the boundary, which are usually
+	not shown.
+
+--dense, --sparse::
+
+When optional paths are given, the default behaviour ('--dense') is to
+only output commits that changes at least one of them, and also ignore
+merges that do not touch the given paths.
+
+Use the '--sparse' flag to makes the command output all eligible commits
+(still subject to count and age limitation), but apply merge
+simplification nevertheless.
+
+--bisect::
+
+Limit output to the one commit object which is roughly halfway between
+the included and excluded commits. Thus, if
+
+-----------------------------------------------------------------------
+	$ git-rev-list --bisect foo ^bar ^baz
+-----------------------------------------------------------------------
+
+outputs 'midpoint', the output of the two commands
+
+-----------------------------------------------------------------------
+	$ git-rev-list foo ^midpoint
+	$ git-rev-list midpoint ^bar ^baz
+-----------------------------------------------------------------------
+
+would be of roughly the same length.  Finding the change which
+introduces a regression is thus reduced to a binary search: repeatedly
+generate and test new 'midpoint's until the commit chain is of length
+one.
+
+--
+
+Commit Ordering
+~~~~~~~~~~~~~~~
+
+By default, the commits are shown in reverse chronological order.
+
+--topo-order::
+
+	This option makes them appear in topological order (i.e.
+	descendant commits are shown before their parents).
+
+--date-order::
+
+	This option is similar to '--topo-order' in the sense that no
+	parent comes before all of its children, but otherwise things
+	are still ordered in the commit timestamp order.
+
+Object Traversal
+~~~~~~~~~~~~~~~~
+
+These options are mostly targeted for packing of git repositories.
+
+--objects::
+
+	Print the object IDs of any object referenced by the listed
+	commits.  'git-rev-list --objects foo ^bar' thus means "send me
+	all object IDs which I need to download if I have the commit
+	object 'bar', but not 'foo'".
+
+--objects-edge::
+
+	Similar to '--objects', but also print the IDs of excluded
+	commits prefixed with a "-" character.  This is used by
+	gitlink:git-pack-objects[1] to build "thin" pack, which records
+	objects in deltified form based on objects contained in these
+	excluded commits to reduce network traffic.
+
+--unpacked::
+
+	Only useful with '--objects'; print the object IDs that are not
+	in packs.
 
 Author
 ------
@@ -139,9 +261,9 @@ Written by Linus Torvalds <torvalds@osdl
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves, Junio C Hamano and the git-list
+<git@vger.kernel.org>.
 
 GIT
 ---
 Part of the gitlink:git[7] suite
-
-- 
1.4.2.g2ba6b-dirty

-- 
Jonas Fonseca
