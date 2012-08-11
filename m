From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Sat, 11 Aug 2012 11:35:53 +0200 (CEST)
Message-ID: <hbf.20120811d15z@bombur.uio.no>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 12:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T08gH-0002iz-JP
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 12:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab2HKKLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 06:11:40 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:43949 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab2HKKLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 06:11:39 -0400
X-Greylist: delayed 2141 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Aug 2012 06:11:38 EDT
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1T086u-0004gG-8d; Sat, 11 Aug 2012 11:35:56 +0200
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.80)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1T086t-0003bp-LJ; Sat, 11 Aug 2012 11:35:56 +0200
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 960304EB; Sat, 11 Aug 2012 11:35:53 +0200 (CEST)
In-Reply-To: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 3 sum msgs/h 2 total rcpts 2545 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.5, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_DOLLAR=0.5,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: CF6C15062D9AB816DDFA7FEE4C12272B3185732E
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -44 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 1321 max/h 33 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203283>

Junio C Hamano wrote:
>    Some ideas:
> 
>    - Make "clone --reference" without "-s" not to borrow from the
>      reference repository.  (...)

Generalize: Introduce volatile alternate object stores.  Commands like
(remote) fetch, repack, gc will copy desired objects they see there.

That allows pruneable alternates if people want them: Make every
borrowing repo also borrow from a companion volatile store.  To prune
some shared objects:  Move them from the alternate to the volatile.
Repack or gc all borrowing repos.  Empty the volatile alternate.
Similar to detach from one alternate repo while keeping others:
gc with the to-be-dropped alternate as a volatile.

Also it gives a simple way to try to repair a repo with missing
objects, if you have some other repositories which might have the
objects: Repack with the other repositories as volatile alternates.

BTW, if a wanted object disappears from the volatile alternate while
fetch is running, fetch should get it from the remote after all.

>    - Make the distinction between a regular repository and an object
>      store that is meant to be used for object sharing stronger.
> 
>      Perhaps a configuration item "core.objectstore = readonly" can
>      be introduced, and we forbid "clone -s" from pointing at a
>      repository without such a configuration.  We also forbid object
>      pruning operations such as "gc" and "repack" from being run in
>      a repository marked as such.

I hope Michael's "append-only"/"donor" is feasible instead.  In which
case safer gc/repack are needed, like you outline:

>      It may be necessary to allow some special kind of repacking of
>      such a "readonly" object store, in order to reduce the number
>      of packfiles (and get rid of loose object files); it needs to
>      be implemented carefully not to lose any object, regardless of
>      local reachability.

And it needs to be default behavior in such stores, so users won't
need don't-shoot-myself-in-foot options.

>    - It might not be a bad idea to have a dedicated new command to
>      help users manage alternates ("git alternates"?); obviously
>      this will be one of its subcommand "git alternates detach" if
>      we go that route.

"git object-store <subcommand>  -- manage alternates & object stores"?

>    - Or just an entry in the documentation is sufficient?

Better doc would be useful anyway, and this command gives a place to
put it:-)  I had no idea alternates were intended to be read-only,
but that does explain some seeming defects I'd wondered about.

>  - When you have two or more repositories that do not share objects,
>    you may want to rearrange things so that they share their objects
>    from a single common object store.
> 
>    There is no direct UI to do this, as far as I know.  You can
>    obviously create a new bare repository, push there from all
>    of these repositories, and then borrow from there, e.g.
>    
> 	git --bare init shared.git &&
> 	for r in a.git b.git c.git ...
>         do
> 	    (
> 		cd "$r" &&
> 	        git push ../shared.git "refs/*:refs/remotes/$r/*" &&
> 		echo ../../../shared.git/objects >.git/objects/info/alternates
>    	    )
> 	done
> 
>    And then repack shared.git once.

...and finally gc the other repositories.

The refs/remotes/$r/ namespace becomes misleading if the user renames
or copies the corresponding Git repository, and then cleverly does
something to the shared repo and the repo (if any) in directory $r.

I suggest refs/remotes/$unique_number/ and note $unique_number
somewhere in the borrowing repo.  If someone insists on being clever,
this may force them to read up on what they're doing first.

Or store no refs, since the shared repo shouldn't lose objects anyway.

If we're sure objects won't be lost: Create a proper remote with the
shared repo.  That way the user can push into it once in a while, and
he can configure just which refs should be shared.

> 
>    Some ideas:
> 
>    - (obvious: give a canned command to do the above, perhaps then
>      set the core.objectstore=readonly in the resuting shared.git)

That's getting closer to 'bzr init-repository': One dir with the
shared repo and all borrowing repositories.  A simple model which Git
can track and the user need not think further about.

This way, git clone/init of a new repo in this dir can learn to notice
and use the shared repo.

We can also have a command (git object-store?) to maintain the
repository collection, since Git knows where to find them all:
Push from all repos into the shared repo, gc all repos, even prune
unused objects from the shared repo - after imlementing sufficient
paranoia.

>  - When you have one object store and a repository that does not yet
>    borrow from it, you may want to make the repository borrow from
>    the object store.  Obviously you can run "echo" like the sample
>    script in the previous item above, but it is not obvious how to
>    perform the logical next step of shrinking $GIT_DIR/objects of
>    the repository that now borrows the objects.
> 
>    I think "git repack -a -d" is the way to do this, but if you
>    compare this command to "git repack -a -d -f" we saw previously
>    in this message, it is not surprising that the users would be
>    confused---it is not obvious at all.

Hopefully users only need to know "git gc".

> [Footnote]
> 
> *1* Making the borrowed object store aware of all the repositories
> that borrow from it, so that operations like "gc" and "repack" in
> the repository with the borrowed object store can keep objects that
> are needed by borrowing repositories, is theoretically possible, but
> is not a workable approach in practice, as (1) borrowers may not
> have a write access to the shared object store to add such a back
> pointer to begin with,

Thus this can only be an optional feature.
Not via direct backrefs though, see above about refs/remotes/$r/.

> (2) "gc"/"repack" in the borrowed object
> store and normal operations in the borrowing repositories can easily
> race with each other, without any coordination between the users,

This sounds like a bug to me, unless you refer to deleting objects
from the shared store.  The doc does not warn that we can't even
maintain shared store while using Git commands in borrowing
repositories.

> and (3) a casual "borrowing" can simply be done with a simple "echo"
> as shown in the main text of this message, and there is no way to
> ensure a backpointer from the borrowed object store to such a
> borrowing repository.

-- 
Hallvard
