From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 03:45:58 -0500
Message-ID: <20070217084558.GE27864@spearce.org>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 09:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILCy-0001kw-Fa
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 09:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946464AbXBQIqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 03:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946506AbXBQIqF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 03:46:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34007 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946464AbXBQIqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 03:46:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HILCi-0000ss-2o; Sat, 17 Feb 2007 03:46:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E3B020FBAE; Sat, 17 Feb 2007 03:45:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39975>

Junio C Hamano <junkio@cox.net> wrote:
> The detection of corresponding subtree is done by comparing the
> pathnames and types in the toplevel of the tree.
> 
> Heuristics galore!  That's the git way ;-).

I have some concerns about the match-tree heuristic you are using here.

For example, it is very common for Java projects to have the same
tree "shape".  Just look at egit/jgit for an example, the three
top level directories are:

	org.spearce.egit.core/
		META-INF/
		build.properties
		plugin.xml
		src/

	org.spearce.egit.ui/
		META-INF/
		build.properties
		plugin.xml
		src/

	org.spearce.jgit
		META-INF/
		src/

If I were to treat the first two as subprojects this new subtree
merge strategy might fail here as it could easily match to the
wrong directory.


What about a different approach?

In a merge of commit#1 (parent project) and commit#2 (subroject)...

We have the set of merge bases readily available.  We just have
to find out in each merge base where the files went from commit#2,
then modify commit#2 to conform to that same shape.

Really that isn't too different from a rename detection.  In other
words do something like the following:

  a) Scan the parents of the merge base B for a commit that is
  in commit#2's ancestory but not commit#1's ancestory, except by
  the merge commit B.  Such a parent must be from the project that
  commit#2 is also from.  For sake of explaining this, lets call
  this parent B^2.

  b) Perform a partial rename-diff between B^2 and B.  The magic
  here is we need to discard any path in B that also appears in
  B^1 and B^2, and that has the same SHA-1 as in B^1, before we do
  the rename-diff.

  c) Find the most common prefix within the renamed files.

  d) Fit commit#2 to use that prefix, and merge.


Here's a real example.  In 67c75759 you merged git-gui.git.
67c75759^1 is from git.git, 67c75759^2 is from git-gui.git.

The stock rename-diff:

  $ git diff-tree --abbrev -r -M --diff-filter=MRD 67c75759^2 67c75759
  :100644 100644 c714d38... d99372a... M  .gitignore
  :100755 100755 8fac8cb... 7a10b60... M  GIT-VERSION-GEN
  :100644 100644 fd82d9d... 5d31e6d... M  Makefile
  :100644 100644 b95a137... b95a137... R100       TODO    git-gui/TODO
  :100755 100755 f5010dd... f5010dd... R100       git-gui.sh      git-gui/git-gui.sh

The problem here is both ^1 and ^2 defines the first three paths,
so we think we modified them in the merge rather than moved them.
But these three files match ^1, as we did not do an evil merge here.
That's why they are showing as modified in this diff.

Now take 67c7 and whack those three files (step b above), and rediff:

  $ C=$(git ls-tree 67c75759 | sed '
          /       .gitignore$/d
          /       GIT-VERSION-GEN$/d
          /       Makefile$/d' | git mktree)
  $ git diff-tree --abbrev -r -M --diff-filter=MRD 67c75759^2 $C
  :100644 100644 c714d38... c714d38... R100       .gitignore      git-gui/.gitignore
  :100755 100755 8fac8cb... 8fac8cb... R100       GIT-VERSION-GEN git-gui/GIT-VERSION-GEN
  :100644 100644 fd82d9d... fd82d9d... R100       Makefile        git-gui/Makefile
  :100644 100644 b95a137... b95a137... R100       TODO    git-gui/TODO
  :100755 100755 f5010dd... f5010dd... R100       git-gui.sh      git-gui/git-gui.sh

Wow, look at that, everything starts with 'git-gui/'!  ;-)

Then we just need to pick the most popular common prefix of all
renamed paths and fit commit#2 to conform to that structure.
Finally we can run the merge through.

The (now functional) pretend object stuff can be useful here,
such as to make $C above so we can pass it off to diffcore.


I think popping off the 'git-gui/' prefix would be the same deal,
only we'd be looking at the old names to determine the prefix to pop,
rather than the new names.

We already do rename detection in merge-recursive.  Slapping an extra
rename pass in front of things when it is invoked as merge-subtree
can't performance hurt that much.

Thoughts?

-- 
Shawn.
