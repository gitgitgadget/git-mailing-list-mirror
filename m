From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Mon, 15 Jan 2007 22:46:37 +0000
Message-ID: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	 <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	 <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	 <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 15 23:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6abR-0004Is-BG
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXAOWqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbXAOWqm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:46:42 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:21229 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbXAOWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:46:40 -0500
Received: by an-out-0708.google.com with SMTP id b33so919349ana
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 14:46:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hhHPzp1ynw+P/GrddmwQhkw6ffpkXcPe1LlyR3IbetCAqgKiTYnCRAmzpH1IJfCJ70rjSk0OUMjK/JUqZaLcDStmQ9CdGrR7oz9AvHGT85tirQWC0gfbUA/6bRKUphXGlRJtl6XJuasbKwQYDNV/iFAG/ee7o5jjFn5N7C/7dUg=
Received: by 10.65.103.17 with SMTP id f17mr6507123qbm.1168901197398;
        Mon, 15 Jan 2007 14:46:37 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Mon, 15 Jan 2007 14:46:37 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36899>

On 15/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Jan 15, 2007 at 02:26:36PM +0100, Guilhem Bonnefille wrote:
> > >What you should have done is moving your stack base from your old
> > >origin branch to remotes/trunk - something that StGIT does not support
> > >yet from command-line, but I've done this manually in the past
> > >(migrating an StGIT stack after re-running a full git-cvsimport after
> > >the original cvs branch got corrupted).
>
> I have started work on implementing "stg pull --to <newbase>", but I'm
> facing some issues.

I think the combination of 'pull' and '--to' is confusing (at least to
me) if you think of there English meaning.

>  "stg pull", after popping all patches, currently calls "git pull",
>  which indeed has 2 roles:
>
> - running "git fetch" on the parent branch
> - updating the head of the stack (which matches the base since
>   no patch is applied), by relying on git-pull to fast-forward the
>   stack head

As Petr suggested at the OLS last year, I added the possibility to
configure the 'git pull' command so that people use whatever script
they like.

> The latter is, unless I miss something:
>
> - overkill when what we want is just to move the head to another place

Doesn't git automatically detect that it can do a fast forward? A
fetch is still necessary anyway.

I'm not sure how people intend to use StGIT. Some might have their own
changes to the base of the stack (maybe caused by 'stg commit') and
would want 'git pull' to do a proper merge and not just fast-forward.

I actually did the above when maintaining a public (well, ARM internal
only currently) kernel branch for other people to pull from. Since
StGIT is not public branch friendly, I was working on a set of patches
(mainly picking from other branches and minor modifications) and just
committing them when finishing. Further updates from kernel.org
triggered full merges with the base.

> - problematic when the parent branch is one that would be tracker with
> "+" in the remote pull line (eg. "next", "pu", or an stgit stack).  In
> that case, although "git fetch" refuses to update the parent head
> because it would not be a fast-forward, git-pull then attempt to do a
> merge, which completely breaks expectations.

Is there any way to configure git (via gitconfig) to behave
differently? You can add some per-branch options with the parent to
pull from but this would require separate .git/remotes/ files for each
branch.

> What my implementation of "pull --to" does is just moving the head
> with the following code added to git.py:
>
> def move_branch(tree_id):
>     """Move HEAD to another commit
>     """
>     __set_head(tree_id)
>     switch(tree_id)

The switch() function already calls __set_head()

>     if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
>         os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))

When is the MERGE_HEAD file generated? Is there any harm in leaving this file?

> I would be of the opinion to stop calling "git pull" entirely, and use
> "git fetch and the git.move_branch show above.  Unless I hear about
> better ideas, my next patch set will be along those lines.

Or replace the 'git pull' in the config file with 'git fetch && git
reset --hard MERGE_HEAD'? I might be wrong though as I almost never
use git directly :-).

-- 
Catalin
