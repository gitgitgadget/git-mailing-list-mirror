From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Tue, 16 Jan 2007 00:39:58 +0100
Message-ID: <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 16 00:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6bR2-0004fK-Fj
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 00:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbXAOXkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 18:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXAOXkM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 18:40:12 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:60615 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbXAOXkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 18:40:11 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id E557855B5;
	Tue, 16 Jan 2007 00:40:07 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id B9D641F09E; Tue, 16 Jan 2007 00:39:58 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36902>

On Mon, Jan 15, 2007 at 10:46:37PM +0000, Catalin Marinas wrote:
> >I have started work on implementing "stg pull --to <newbase>", but I'm
> >facing some issues.
> 
> I think the combination of 'pull' and '--to' is confusing (at least to
> me) if you think of there English meaning.

That's possible, I'm not a native english speater :)

The idea is that we pull our stack from one place (current base) to
another.  Another possiblity would have been "stg rebase", but I'm not
very keen on adding another command to do a very similar job.


> > "stg pull", after popping all patches, currently calls "git pull",
> > which indeed has 2 roles:
> >
> >- running "git fetch" on the parent branch
> >- updating the head of the stack (which matches the base since
> >  no patch is applied), by relying on git-pull to fast-forward the
> >  stack head
> 
> As Petr suggested at the OLS last year, I added the possibility to
> configure the 'git pull' command so that people use whatever script
> they like.

Right.  Maybe different workflows should have this option set to
different values in different repos ?  I'm merely trying to get the
best default :)

> >The latter is, unless I miss something:
> >
> >- overkill when what we want is just to move the head to another place
> 
> Doesn't git automatically detect that it can do a fast forward? A
> fetch is still necessary anyway.

Yes, it detects it when it is one.  The problem is merely that it
can break things (for stgit's purpose) when it isn't.

> I'm not sure how people intend to use StGIT. Some might have their own
> changes to the base of the stack (maybe caused by 'stg commit') and
> would want 'git pull' to do a proper merge and not just fast-forward.
> 
> I actually did the above when maintaining a public (well, ARM internal
> only currently) kernel branch for other people to pull from. Since
> StGIT is not public branch friendly,

Making StGIT public-branch friendly is indeed the primary goal for
this set of patches - it is much less important to me to be able to
base my stack on GIT's "pu" or "next".

The idea is that, once we have are able to rebase a stack anyway,
rebasing to the new tip of a branch that is an StGIT stack is in many
aspects only a particular case (modulo any unapplied patches).


> I was working on a set of patches (mainly picking from other
> branches and minor modifications) and just committing them when
> finishing. Further updates from kernel.org triggered full merges
> with the base.

But doing this means that you can end with a base that is not any more
on the parent branch, but on a local merge, right ?  I'm not sure it
is an easy thing to work with.


> >- problematic when the parent branch is one that would be tracker with
> >"+" in the remote pull line (eg. "next", "pu", or an stgit stack).  In
> >that case, although "git fetch" refuses to update the parent head
> >because it would not be a fast-forward, git-pull then attempt to do a
> >merge, which completely breaks expectations.
> 
> Is there any way to configure git (via gitconfig) to behave
> differently? You can add some per-branch options with the parent to
> pull from but this would require separate .git/remotes/ files for each
> branch.

I'm not sure there is anything currently.  The solution which I
remember was proposed was that such a branch "advertises" its status
in some way, so that the creator of the remote.<name>.fetch config
entry can indeed insert the "+" itself automatically.

On the StGIT front, we could have "stg clone" look at
patches/<branch>/current or so, and then modify the
remote.<name>.fetch entry accordingly.  Or do you think of any
workflow that would break under this change ?


> The switch() function already calls __set_head()

Yup, noticed that when running the testsuite - I meant to run switch
then reset instead.


> >    if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
> >        os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))
> 
> When is the MERGE_HEAD file generated? Is there any harm in leaving this 
> file?

This is a leftover from sources of inspiration that create_branch and
switch_branch were.  I'm not 100% sure of why we want to get rid of
it, but it looked like the situation was similar enough.

It is apparently generated by git-merge (and git-resolve), and
currently out of the scope of stgit anyway.  If we're moving our
stack, it is probable it will loose any sort of accurateness.

Maybe instead we would want to block stgit operations if we see it,
because there certainly have been (illegal ?) operations done outside
of StGIT.


> >I would be of the opinion to stop calling "git pull" entirely, and use
> >"git fetch and the git.move_branch show above.  Unless I hear about
> >better ideas, my next patch set will be along those lines.
> 
> Or replace the 'git pull' in the config file with 'git fetch && git
> reset --hard MERGE_HEAD'? I might be wrong though as I almost never
> use git directly :-).

Hm.  Probably rather FETCH_HEAD.  Will have to look at that - but see
above.

FWIW, I now mostly have a patch to change from git-pull to git-fetch,
which finally passes the current testsuite.

Note that I did not think of using FETCH_HEAD, I was rather thinking
of using information about the parent branch (which I had worked on
recently), with the idea that this info probably belongs to
branch.<name>.merge - which would complement Pavel's 87c69539 about
branch.<name>.remote.

Even if we would not need it here, it would be good to have those 2
parameters set when we can infer them.  That reminds me that "stg
clone" does not appear to allow selecting a specific branch in the
parent repo (which explains why the .merge parameter is not so
crucially needed yet: we always clone the main branch).

Best regards,
-- 
Yann.
