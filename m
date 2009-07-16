From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git range merge (cherry-pick a range)
Date: Thu, 16 Jul 2009 13:36:06 +0200
Message-ID: <4A5F10A6.80003@drmicha.warpmail.net>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil> <24512201.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bshOriginal <mindplayintricks@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 16 13:36:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRPGL-0006Rd-Er
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 13:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZGPLgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZGPLgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 07:36:25 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35446 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752242AbZGPLgY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 07:36:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E09BA3BB0D2;
	Thu, 16 Jul 2009 07:36:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 16 Jul 2009 07:36:23 -0400
X-Sasl-enc: M2pCNF59IR9DuinVYE93WRiYUOeMAx9gCdSIHRx//lVf 1247744183
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2AA0F822A;
	Thu, 16 Jul 2009 07:36:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <24512201.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123397>

bshOriginal venit, vidit, dixit 16.07.2009 10:11:
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

Did you use a monospaced font when composing this e-mail? All graphs
come out disconnect/distorted when reading your e-mail with a monospaced
font.

I assume that above, a is the first additional commit of B1 which
branches off o.

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
> 
> 
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
>>>>>>>> test edit 2: a - b:fluidsolver.cpp
> }
> 
> 
> After manually resolving the conflict and continuing the rebasing 
> with git rebase --continue, we are finally finished.
> 
> Since we only had updates in branch 1, it is astonishing that we get a
> conflict at all.
> Same situation works like a charme in subversion.

Ahem, how could /anything/ work like a charm in subversion? (I've been
using it myself.)

Seriously, if, in subversion, you merge -rA:D onto master then
subversion only computes the diff between A and D and applies it to
master. You an do this in git as well, of course, but that's not a merge
and does not preserve individual commit messages.

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
> 

If I read you graphs correctly you could just as well fast-forward
master to D (using reset or merge) and then "rebase -i" in order to
remove A.

Alternatively, you can use "git format-patch --stdout revrange | git am".

Michael
