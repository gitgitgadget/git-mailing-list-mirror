From: Junio C Hamano <junkio@cox.net>
Subject: On blame/pickaxe
Date: Thu, 12 Oct 2006 18:43:46 -0700
Message-ID: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 04:01:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYC5Z-0006u4-Bv
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 03:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWJMBns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 21:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJMBns
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 21:43:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33677 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751452AbWJMBnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 21:43:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013014347.GHNN18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 21:43:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zdjb1V00X1kojtg0000000
	Thu, 12 Oct 2006 21:43:36 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28826>

I have something that is tentatively called pickaxe, but that is
different from "diff -S<pickaxe>".  The name will need to
change, perhaps to git-blame.

It's quite a while since the original algorithm sketch that led
to the current git-blame was posted here; I suspect that most of
the people recently joined the list haven't seen it.  The idea
in there still applies, though...

Here is a re-drawn sketch of how the 'pickaxe' edition of the
algorithm works.

0. Outline.

We track range of lines from a path in one revision.  That's
what "-L n,m", "path", and "commit" parameters to the command
are about.

When the program starts, the commit given on the command line is
suspected to be responsible for all lines in the given range.
But being a suspect and determined to be the guilty party are
different things.

The name of the game is "not taking responsibility but passing
the blame to your parents".  In other words, "that's not a new
problem I introduced -- it was there before my patch was
applied".  You are exonerated for those lines that you can
successfully pass blame to your parent, making that parent a new
suspect for the lines.  There will remain lines you cannot pass
blame to anybody else -- you will be determined to be the guilty
party for them.  When nobody can pass any more blame to anybody
else, the dance stops and we will know who is guilty for every
line of the input.


1. Data structure.

We keep track of who the current suspect for each line is in the
structure called 'scoreboard'.  It is a collection of ranges,
called 'blame_entry'.

Each blame_entry describes which lines (in the final image) it
is about, who the current suspect for the range is, if the
suspect is already known to be guilty, where in the suspected
commit the lines came from (path and line number).

In the 'blame' implementation, a suspect is represented by a
commit object with one path hanging to its util field.
'pickaxe' edition introduces the concept of 'origin', which is a
pair of <commit,path>.  We currently do not use more than one
path per commit, but hopefully we will soon.


2. Operation.

First the scoreboard is initialized with a single blame_entry
that makes the path in the commit on the command line the
suspect for all lines.

Then, we repeatedly pick one entry from the scoreboard, and give
a chance to the suspect to exonerate himself, by calling
pass_blame().  The suspect passes the blame to its parents by
updating the scoreboard, removing his name from ranges of lines
he can prove that came from his parent and instead writing that
suspected parent's name.  Inside pass_blame(), just before it
returns, if the suspect cannot pass blame for some lines to
anybody else, it becomes guilty for them.

When there is no blame_entry in the scoreboard whose truly
guilty party is still undetermined, we have fully blamed the
input, and the loop finishes.


3. Passing the blame.

You (a <commit,path> tuple) are suspected for introducing
certain lines, and you would want to pass blame to your parent.
How would you do that?

First, you find if your parent has the same path; if not, you
find if between your parent and you there was a rename and find
the original path in the parent.  If you are a merge, you do so
for all your parents.  The path in the parent and your path may
have many common lines, and if the lines you are the suspect are
the same as the ones in the parent, you can pass the blame,
because these lines were there before you touched them.

How would you find what's common?  We run "diff" (diff -u0).
Unified context-0 diff would give something like:

        @@ -n,m +l,k @@
        -removed
        +added
        ...

In this application, we are not interested in the diff text
itself at all.  In fact, we are interested in what's outside the
diff.  If the above is output from parent to you, what it tells
us is that lines before your line "l" are the same as lines
before parent's "n", so if the above is the first hunk, you can
say your lines 1..(l-1) came from your parent and you are not
responsible for them.  The above hunk also tells us that in your
path, lines after (l+k) are the same as the lines in parent's
lines (n+m); we will know how many such same lines there are
(could be zero) by inspecting the next hunk.

For efficiency reasons, inside pass_blame(), we run just one
diff between the parent and you, and scan the blame_entry for
the same <commit,path> in the scoreboard, and check overlap with
each of them.  Suppose we are suspected for these lines:

                <---- e ----->

and by looking the diff, we determined the range from one parent
is like this:

                   <--p--->

Then we can split the blame_entry into three parts:

                <-><--p---><->

You are still suspected for the first and the last part of the
original entry, but for the mid-part you successfully passed the
blame to that parent.  Depending on how the ranges overlap, this
may split into two, or parent may take blame for the whole range
(i.e. no split).  This is computed in blame_overlap().

When done with one parent, if you are a merge, you will then try
to pass the blame on the remaining part that you are still
suspected for to other parents.

The classic 'blame' algorithm stops here, and the current
pickaxe does the same; you take responsibility for the
remainder.


4. Passing more blame.

Instead of taking responsibility for the remainder, there are
other ways to find other people to pass blame on.  That's what
the "NEEDSWORK" comment in pass_blame() is about.

A typical example is a change that moves one static C function
from lower part of the file to upper part of the same file,
because you added a new caller in the middle.  The path in your
parent and the path in you would look like this:

        parent                          you

        A                               static foo() {
        B                               }
        C                               A
        D                               B
        E                               C
        F                               D
        G                               ... call foo();
        static foo() {                  E
        }                               F
        I                               G
        J                               I

With the common part finding code with diff, you will be able to
pass blames for lines A B C D E F G I J to your parent.  You are
truly guilty for introducing "... call foo();".  The problem
here is that in addition, you will be blamed for the lines that
implement "static foo() { ... }" at the beginning of your file.

To blame the implementation of foo() to the parent, we could do
something like this:

        for each blame_entry that you are still suspected for,
        diff those lines (and only those lines) with the parent,
        to see if you find a copy.  If there is a copy, you can
        pass the blame to the parent.

This needs to be limited for non-trivial changes only, though.
For example, one of the typical things you would do is to add one
"else if" clause to a sequence of already existing "if .. else if
.." chain, like this:

        if (foo) {
                ...
        }
        else if (bar) {
                ...
+       }
+       else if (baz) {
+               ...
        }

You are suspected for these three lines; if the "find copies
again" is allowed to find any insignificant copy, the first line
(closing brace) you introduced could easily be blamed to an
unrelated line anywhere in the parent that match /^\t\}$/.  To
prevent such nonsense from happening, we need to limit such
"find copies" attempt to say minimum of N lines (and minimum of
M tokens that consist of non-whitespace, non-punctuation
letters).  Also we probably would not want to find a match in
the whole parent but only in the part of the parent that is
removed in the parent-to-you diff.

Another typical example is a code restructuring to move one
function from a file to another file.  The same "find copies"
principle, and caveat for small and insignificant copies, apply
to this situation as well.  If it is a code movement, the file
that the function moved from needs to be identified, which can
be done by running diff-tree between parent and you -- anything
that was modified or removed is a good candidate to look for
such copies.  Again, we probably need to limit the copy-finding
source to the part that was removed from the parent in the diff
to you.

After the operation 3 (Passing the blame) runs, if movement of
lines from another file is detected as in the above sketch, we
will pass blame to an unrelated path in the parent.  Some lines
are blamed on the file we started tracking in the parent, and
some other lines are blamed on a different file in the parent.
This is why 'pickaxe' uses <commit,path> tuple (aka 'origin') to
represent a suspect.

All of this sounds quite simple and not so difficult to code,
although rejecting insignificant copies would involve fair
amount of heuristic tweaking like I needed to do while working
on the rename detection.
