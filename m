From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-gui: Call changes "Staged" and "Unstaged" in file list titles.
Date: Tue, 08 May 2007 12:29:42 -0700
Message-ID: <7vmz0f2jx5.fsf@assigned-by-dhcp.cox.net>
References: <46405FF2.1B600CBE@eudaptics.com>
	<20070508143859.GO11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 21:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVNe-0005y7-Jn
	for gcvg-git@gmane.org; Tue, 08 May 2007 21:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031419AbXEHT3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031535AbXEHT3p
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 15:29:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59611 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031419AbXEHT3o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 15:29:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508192944.NPFR6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 15:29:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wjVi1W00C1kojtg0000000; Tue, 08 May 2007 15:29:43 -0400
In-Reply-To: <20070508143859.GO11311@spearce.org> (Shawn O. Pearce's message
	of "Tue, 8 May 2007 10:38:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46609>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yes.  But...
>  
>>  git-gui/git-gui.sh |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> That's the wrong path.  Clearly you made this patch in git.git and
> not the git-gui.git repository itself.  Fortunately for me I added
> -3 to git-am out of habit:
>
>   $ git am -3 -s gg
>   Applying 'git-gui: Call changes "Staged" and "Unstaged" in file list titles.'
>   
>   error: git-gui/git-gui.sh: does not exist in index
>   Using index info to reconstruct a base tree...
>   Falling back to patching base and 3-way merge...
>   Renamed git-gui/git-gui.sh => git-gui.sh
>   Wrote tree 8e034a94d9533af707279766e174b78ddf3874cc
>   Committed: a1a4975824e8f9f88a8c96ae908c488a2c6047c5
>
> Yay Git!  Go go gadget rename detection!  ;-)
>
> I didn't even realize the git-gui/ prefix on the path in the patch
> until after I saw the rename detection message.

Yeah, -3 is a magic, isn't it?

For the benefit of people who are unfamiliar with the internal,
here is how it works.

 - The patch Hannes gave Shawn had a change to
   git-gui/git-gui.sh, like this:

    git-gui/git-gui.sh |    4 ++--
    1 files changed, 2 insertions(+), 2 deletions(-)

   diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
   index 60e79ca..45d251e 100755
    --- a/git-gui/git-gui.sh
    +++ b/git-gui/git-gui.sh
    @@ -5494,7 +5494,7 @@ pack .vpane -anchor n -side top -fill both -expand 1


 - Shawn had a tree that looked like this:

        GIT-VERSION-GEN
        Makefile
        git-gui.sh
        lib/blame.tcl
        lib/branch.tcl
        ...

 - The patch obviously does not apply, as Shawn does not have
   git-gui/git-gui.sh.  However, Shawn instructed "git am" to
   fall back on 3-way merge, which prepared two "fake" trees.

   Fake tree 1 (the ancestor) is prepared by reading the index
   line to figure out what blob the patch applies to.  The
   answer is 60e79ca, which Shawn has in his repository.  The
   resulting tree looks like this:

        040000 tree 0df2c7b...  git-gui
        100755 blob 60e79ca...  git-gui/git-gui.sh

   Fake tree 2 (update) is prepared by applying the patch to the
   ancestor fake tree.

        040000 tree 950e50d...	git-gui
        100755 blob 45d251e...	git-gui/git-gui.sh

 - Then, it falls back to the 3-way merge, using the fake tree 1
   as the common ancestor, Shawn's repository as "our" tree, and
   fake tree 2 as the update being merged into "our" tree.

   To this merge, most of the paths in "our" tree appear as if
   Shawn added them since the common ancestor, except that
   git-gui.sh at the toplevel in "our" tree was moved up by
   Shawn from git-gui subdirectory (and then possibly further
   modified), while git-gui/git-gui.sh was modified by Hannes.

   At the path level, this is the classic case of "one side
   (Shawn) modifies, while the other side (Hannes) kept it at
   the place it was before", 3-way merge at the path level takes
   Shawn's change (which is to "move the file up one level").

   At the same time, at the contents level, this is just a
   normal "common ancestor 60e79ca was modified to Shawn's
   git-gui.sh on one side while Hannes's side modified it to
   45d251e", and the contents are merged using the file level
   3-way merge.  The result is left in git-gui.sh.

   All the other paths look as if Shawn added them to the common
   ancestor that did not have any of them while Hannes did not
   do any such change, so the merge algorithm takes Shawn's
   "additions".

So in the end, Shawn ends up with most of his paths intact,
except that Hannes's patch which were meant to apply to
git-gui/git-gui.sh gets applied to his git-gui.sh.
