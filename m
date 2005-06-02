From: Junio C Hamano <junkio@cox.net>
Subject: CVS migration section to the tutorial.
Date: Thu, 02 Jun 2005 12:43:26 -0700
Message-ID: <7vll5s35pd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdvZn-0003CS-AK
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFBTol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFBTod
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:44:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5037 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261232AbVFBTnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 15:43:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602194325.SSQP8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 15:43:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 30 May 2005 13:00:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think a section to discuss "I am used to doing 'cvs xxx' to solve
this problem, how do I do that in GIT" would be a good idea.  Here is
an example to talk about "cvs annotate".

------------

CVS annotate.

The core GIT itself does not do "cvs annotate" equivalent, but it has
something much nicer.

Let's step back a bit and think about the reason why you would want to
do "cvs annotate a-file.c" to begin with.

	- Are you really interested in _all_ the lines in that file?

	- Are you interested in lines _only_ in that file and do not
          care if the file was created by renaming from a different
          file?

You would use "cvs annotate" on a file when you have trouble with a
function (or even a single "if" statement in that function) that
happens to be defined in the file, which does not do what you want it
to do.  And you would want to find out why it was written in that way,
because you are about to modify it to suit your needs, and at the same
time you do not want to break its current callers.  For that, you want
to find out why the original author did things that way in the
original context.  That's why you want "cvs annotate".  So your answer
to the first question _should_ be "no".  You do not care about the
whole file, only a segment of it.

Also, in the original context, the same statement might have appeared
at first in a different file and later the file was renamed to
"a-file.c".  Or the entire program may have constructs similar to the
"if" statement you are having trouble with in different places, that
you are still not aware of.  So your answer to the second question
_should_ be "no" as well.

As an example, assuming that you have this piece code that you are
interested in in the HEAD version:

	if (frotz) {
		nitfol();
	}

you would use git-rev-list and git-diff-tree like this:

	$ git-rev-list HEAD |
	  git-diff-tree --stdin -v -p -S'if (frotz) {
		nitfol();
	}'

We have already talked about the "--stdin" form of git-diff-tree
command that reads the list of commits and compares each commit with
its parents.  What the -S flag and its argument does is called
"pickaxe", a tool for software archaeologists.  When "pickaxe" is
used, git-diff-tree command outputs differences between two commits
only if one tree has the specified string in a file and the
corresponding file in the other tree does not.  The above example
looks for a commit that has the "if" statement in it in a file, but
its parent commit does not have it in the same shape in the
corresponding file (or the other way around, where the parent has it
and the commit does not), and the differences between them are shown,
along with the commit message (thanks to the -v flag).  It does not
show anything for commits that do not touch this "if" statement.

To make things more interesting, you can give the -C flag to
git-diff-tree, like this:

	$ git-rev-list HEAD |
	  git-diff-tree --stdin -v -p -C -S'if (frotz) {
		nitfol();
	}'

When the -C flag is used, file renames and copies are followed.  So if
the "if" statement in question happens to be in "a-file.c" in the
current HEAD commit, even if the file was originally called "o-file.c"
and then renamed in an earlier commit, or if the file was created by
copying an existing "o-file.c" in an earlier commit, you will not lose
track.  If the "if" statement did not change across such rename or
copy, then the commit that does rename or copy would not show in the
output, and if the "if" statement was modified while the file was
still called "o-file.c", it would find the commit that changed the
statement when it was in "o-file.c".

[ BTW, the current versions of "git-diff-tree -C" is not eager enough
  to find copies, and it will miss the fact that a-file.c was created
  by copying o-file.c unless o-file.c was somehow changed in the same
  commit.]

To make things even more interesting, you can use the --pickaxe-all
flag in addition to the -S flag.  This causes the differences from all
the files contained in those two commits, not just the differences
between the files that contain this changed "if" statement:

	$ git-rev-list HEAD |
	  git-diff-tree --stdin -v -p -C -S'if (frotz) {
		nitfol();
	}' --pickaxe-all


