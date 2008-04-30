From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Making submodules easier to work with (auto-update on checkout
 or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 11:31:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:32:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9bb-00019R-BX
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbYD3KbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbYD3KbT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:31:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:51046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754610AbYD3KbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:31:18 -0400
Received: (qmail invoked by alias); 30 Apr 2008 10:31:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 30 Apr 2008 12:31:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BEfAr4/uB0W2hRwQoep10J88r5Zom8/GQGuIV1p
	P2WH6TGnDNHYkD
X-X-Sender: user@eeepc-johanness
In-Reply-To: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80824>

Hi,

On Tue, 29 Apr 2008, Tim Harper wrote:

> 1) The submodule stays in the working copy when changing to a branch 
>    that does not have a submodule.  This can break a build and cause 
>    problems.  To work around, I have to delete the folder completely 
>    (git-clean).  Then, when I switch back to the branch again, I have to 
>    re-download the submodule.

The problem, of course, is that you can easily have valuable, but 
not-tracked, files in there.  Deleting the submodule is therefore no 
option.

> 2) I have to type "git checkout branch && git submodule init && git 
>    submodule update" to be sure that I really have the whole contents of 
>    the branch.  That's 3 commands, and a lot of typing.

There is no way around "checkout branch", and I think that is a good 
thing.

But once you did "submodule init", you will never need to run it again, 
since it edits your .git/config, which does not change when switching 
branches.

And as for "submodule update", I like the fact that the submodule is not 
updated automatically.  For example, when I actively develop a submodule, 
but have to rebase the superproject, I would _hate_ it if the submodule 
wass updated.

The whole idea about submodules is that they are repositories of their own 
right, and therefore the superproject should not mess with them, _unless_ 
explicitely asked to, with "submodule update".

> 3) If I don't run "git submodule update", and carelessly run "git commit 
>    -a"  or "git add .", I risk propagating a submodule version from 
>    another branch or undoing an important change.

git commit -a is something that might make sense for newbies, but you 
really should learn to use git add -p and commit without -a.

> SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE BUNDLE)
> When pulling / merging / changing branches:
> 1) cache all submodules to ~/.git/submodules_cache
>   a) move from the working directory to a folder that is a MD5 hex-hash of
> both the submodule path and the submodule url
> 2) execute the pull / merge / branch change
> 3) restore all defined submodules to ~/.git/submodules_cache (only the
> submodules that are still defined after the merge / change / pull)
> 4) execute git submodule init && git submodule update
> 
> 
> PITFALLS:
> pitfall)
> If you commit a change on a submodule that's not on a branch, auto-updating
> submodules will make it difficult to revive that change.
> 
> workaround)
> Don't allow the user to commit unless they are on a branch.
> 
> ... couldn't think of anymore.  Anyone?

I do not like that.  I think that the user should be responsible to take 
care of the up-to-dateness of the submodule.  As far as the superproject 
is concerned, it just keeps track of the committed submodule state, but 
does not enforce it.

FWIW I restarted on my --ignore-submodules patch, which can be seen here:

http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/my-next

It lacks tests, therefore it has not been submitted for review yet.

The basic idea is that not only "checkout" ignores the _contents_ of the 
submodules, but optionally "diff", and using that option "stash" and 
"rebase".

IOW you can "stash apply" even if the submodule is dirty.  Which makes 
sense, given that "stash" succeeds, too...

Ciao,
Dscho
