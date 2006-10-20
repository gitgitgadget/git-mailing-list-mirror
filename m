From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:17:47 -0700
Message-ID: <7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<200610201945.43957.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201049250.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 22:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0oS-00069w-HL
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbWJTURt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422980AbWJTURt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:17:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60378 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422979AbWJTURs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 16:17:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020201747.HDBW22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 16:17:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ckHY1V00R1kojtg0000000
	Fri, 20 Oct 2006 16:17:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201049250.3962@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 20 Oct 2006 10:59:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29532>

Linus Torvalds <torvalds@osdl.org> writes:

> ...  We're starting to see 
> git actually being able to track file content moving between files: even 
> when the files themselves didn't move (ie Junio's "git pickaxe" work could 
> do things like that).

I've reordered the git-pickaxe I parked in "pu" while 1.4.3-rc
cycle and merged it into "next".

The earlier one I was futzing with in "pu" had built-in
heuristics and pure mechanisms mixed together in the same patch,
which was quite bad as development history.  I think the
reordered sequence shows the logical evolution better.

  1. git-pickaxe: blame rewritten.

     This implements the infrastructure (parent traversal,
     identifying "corresponding path" in the parent -- aka
     "handling renames", passing blames to the parents and
     taking responsibility for the remainder) and uses the the
     same old "single diff with parent file identifies what we
     inherited from the parent" logic git-blame uses for passing
     blames.

  2. git-pickaxe -M: blame line movements within a file.

     This adds logic to find swapped groups of lines in the same
     file.  When the file in the parent had A and B and the child
     has B and A, "single diff with parent" would find only one
     of A or B is inherited from the parent, not both.  This
     re-diffs the remainder with the parent's file to find both.

     I used to have heuristics to avoid trivial groups of lines
     from being subject to this step, but in this version they
     have been removed, so that we can see the core logic and
     need for heuristics more clearly.

     On the other hand, the version I used to have in "pu" gave
     blame to the first match.  This one tries to find the best
     match and assign the blame to it.

  3. git-pickaxe -C: blame cut-and-pasted lines.

     This adds logic to find groups of lines brought in from
     existing file in the parent.  We scan the remainder using
     the same logic as -M detection, but it is done against
     other files in the parent.

     There was a heuristic that gave the blame to the parent
     right then and there when we find a copy-and-paste instead
     of allowing the parent to pass blame further on to its
     ancestors; again I removed this heuristics in the reordered
     series.

The next logical step is to come up with a good set of
heuristics to avoid excessive nonsense matches the code
currently gives.

Groups of small number of empty lines, lines with indentation
blanks followed by a closing brace, and '#include' lines that
include common header files occur so commonly, that without any
heuristics (which can be seen in the "next" branch today) the
algorithm would give surprisingly idiotic results.  For example:

	git -p pickaxe -C -f -n v1.4.3 -- commit.c

tells you that the first line of commit.c in v1.4.3 release,
which is '#include "cache.h"' came from the first line of
receive-pack.c which is total nonsense (this particular line
could actually be a bug in the -M or -C logic -- I need to
check).

A less "obviously wrong" but still idiotic case is that we find
ll.409-411 came from ll.94-96 of describe.c in commit 908e5310.
These three lines read as:

	409		}
        410	}
        411

While this blame assignment might be technically correct, it
does not add much value to pass blames on in such a case.

On the brighter side, we find that ll.415-419 (the beginning of
function "static int get_one_line()") originally came from
diff-tree.c (commit cee99d22, ll.275-279).
