From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git range merge (cherry-pick a range)
Date: Thu, 16 Jul 2009 12:27:33 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907161200480.2147@iabervon.org>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil> <24512201.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bshOriginal <mindplayintricks@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 16 18:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRToC-0004Mi-GA
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 18:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbZGPQ1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbZGPQ1k
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 12:27:40 -0400
Received: from iabervon.org ([66.92.72.58]:34509 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbZGPQ1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 12:27:40 -0400
Received: (qmail 26657 invoked by uid 1000); 16 Jul 2009 16:27:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jul 2009 16:27:33 -0000
In-Reply-To: <24512201.post@talk.nabble.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123407>

On Thu, 16 Jul 2009, bshOriginal wrote:

> 
> Playing around with GIT, we encountered the following strange situation for
> which we would
> like to have an answer:
> 
> Scenario
> ========
> 
> We want to merge the range B to D from branch B1 to master
> 
> Master:       o-
>                   \
> Branch B1:      A-B-C-D-E
> 
> 
> Commit B:
> ---------
> FluidSolver::FluidSolver(int argc, char* argv[]) {
>     init(argc, argv);
>     // test edit 1: a + b
> }
> 
> Commit C:
> --------
> FluidSolver::FluidSolver(int argc, char* argv[]) {
>     init(argc, argv);
>     // test edit 1: a + b
>     // test edit 2: a - b
> }
> 
> Commit D:
> --------
> FluidSolver::FluidSolver(int argc, char* argv[]) {
>     init(argc, argv);
>     // test edit 1: a + b
>     // test edit 2: a - b
>     // test edit 3: a * b
> }
> 
> Commit E:
> --------
> FluidSolver::FluidSolver(int argc, char* argv[]) {
>     init(argc, argv);
>     // test edit 1: a + b
>     // test edit 2: a - b
>     // test edit 3: a * b
>     // test edit 4: a / b
> }
> 
> 
> Range merge (the GIT way):
> =========================
> 
> 1) Switch to Branch B1
> 
> 2) Create a temporary branch which does not contain anything beyond commit D
> 
>    $ git checkout -b volatileBranch D
> 
>     Master:                 o-
>                                 \
>     Branch B1:                A-B-C-D-E
>                                                 \
>     Branch volatileBranch:              (A)-(B)-(C)-(D)
> 
> 3) Rebase volatile branch to master from commit (B) to master's HEAD
>    git rebase --onto master (A) 
> 
> 
>     Branch volatileBranch:   (B)-(C)-(D)
>                                      /
>     Master:                      o-
>                                      \
>     Branch B1:                   A-B-C-D-E
>                                        
> 
> Rebasing output:
> ----------------
> 
> First, rewinding head to replay your work on top of it...
> Applying: test edit 2: a - b
> error: patch failed: fluidsolver.cpp:28
> error: fluidsolver.cpp: patch does not apply
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merging fluidsolver.cpp
> CONFLICT (content): Merge conflict in fluidsolver.cpp
> Failed to merge in the changes.
> Patch failed at 0001 test edit 2: a - b

What's happening here is that the first commit you're keeping adds an edit 
to a version of the file which has the first edit as well, and that first 
edit is right next to the second edit, and so it's reasonably likely that 
the second edit has to be done differently in order to not require the 
first edit.

> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase --abort".
> 
> 
> Conflicts:
> ----------
> FluidSolver::FluidSolver(int argc, char* argv[]) {
>     init(argc, argv);
> <<<<<<< HEAD:fluidsolver.cpp
> =======
>     // test edit 1: a + b
>     // test edit 2: a - b
> >>>>>>> test edit 2: a - b:fluidsolver.cpp
> }

This is the merge conflict output for the case where you're applying a 
change which is based on a version with some of the final code already 
there to a base that doesn't have that code. It's not a necessary 
conflict, but it is a likely conflict (that is, there's a unique logical 
guess as to the right resolution, but there's also a good change that the 
resulting code doesn't work). Of course, if the edits actually overlap, it 
becomes a necessary conflict.

> After manually resolving the conflict and continuing the rebasing 
> with git rebase --continue, we are finally finished.
> 
> Since we only had updates in branch 1, it is astonishing that we get a
> conflict at all.
> Same situation works like a charme in subversion.

Except when it generates broken code like a charm...

> We would be happy to get an explanation for this merge bahaviour, since 
> many edits in large projects could as a matter of principle result a lot of
> merge conflicts
> which all have to be treated manually.
> 
> We believe that GIT's interface for range merges needs to get more user
> friendly.
> Since steps 1) - 3) use already developed components of GIT, there should be
> a layer above 'em
> which performs a range merge by internally calling 1) - 3).
> 
> Example: git cherry-pick $from_branch@startCommitHash
> $to_branch@endCommitHash 

The main issue is the:

 git ??? --continue

that you use after you resolve any conflicts. The existing components need 
to be reorganized in order to support doing the correct later steps when a 
multi-step operation supplied by a higher layer was previously suspended 
for user assistance in the middle.

	-Daniel
*This .sig left intentionally blank*
