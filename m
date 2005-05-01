From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 1 May 2005 13:29:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org>
References: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net> <7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 22:22:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSKxJ-0007a1-2p
	for gcvg-git@gmane.org; Sun, 01 May 2005 22:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVEAU2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVEAU2S
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 16:28:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:57018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262660AbVEAU2F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 16:28:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41KS0s4027781
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 13:28:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41KRxQR028950;
	Sun, 1 May 2005 13:27:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Junio C Hamano wrote:
> 
> Linus, have you decided to like or dislike the behaviour of
> git-merge-one-file-script touching the work tree in some cases
> but not in other cases?  A straightforward merge implementation
> that does a "git-read-tree -m" followed by a "git-merge-cache
> git-merge-one-file-script" does the following to your work tree
> and the cache:
> 
>  - Paths merged unsuccessfully makes git-merge-cache phase fail
>    and the work tree is not affected for such paths.
> 
>  - Paths merged "git-read-tree -m" trivially does not change the
>    work tree and "git-read-tree -m" result is kept in the cache.
> 
>  - Paths merged by "merge" successfully, and paths chosen from a
>    single side by "git-merge-one-file-script" change the work
>    tree, possibly checking out the file if you started out from
>    an empty work tree.
>  
> I am not worried about the first case where you will have to
> manually examine and resolve anyway. I am wondering if the rest
> is the desired behavior for _your_ way of using the GIT merge.
> After a successful merge, what kind of verification would you
> typically do?

I don't care about the _successful_ merge, since a successful merge is 
basically always followed by a "git-checkout-cache -f -a" anyway (and 
update-cache + remove now-stale files etc).

So let's totally ignore the case of "the tree was up-to-date before, and 
the merge is successful". It's not an interesting case.

No, the reason I'd prefer to be consistent is for the _strange_ cases, 
where the merge fails. There's two of those:
 - we had local modifications that weren't checked in
 - we had a real conflict that wasn't automatically merged.

and in both of these cases we end up having to fix things up, and I
generally think that we're better off if we do _not_ update the working
tree.

In particular, the "local modifications" case is much nicer to handle if
we can just do the merge totally (and successfully) in the index, and then
handle the "local modifications" as a failure case of "git-checkout-cache"
instead.

In particular, I think the "apply the patch forward" (that cogito does) is
as wrong with the "local modifications" as it is for the merge itself, and
that a truly good merge would actually have _another_ three-way merge on
the working file - the "original" is the version in our old HEAD branch,
with the two branches being merged are "working copy before the merge" and
"merge results".

Notice? See how this _nice_ handling of the local modifications actually
meant that our merge itself should never have touched the working tree
file. We'd actually commit the merge, and then do the "checkout-cache -f
-a", adn leave the dirty files with the result of being merged with the
new (which may, of course, have a merge clash: the user sees that very
clearly from the output of "git-diff-cache").

The other case is the "real conflict" case, and that's the case where I
again don't like modifying the working tree, because I think it's a
perfectly natural thing to do to say "ok, the merge didn't work out this
way", so let's not do it at all. Again, that means that the working tree
should not have been modified, and we should _not_ have written out the
conflict file to the same file that was conflicting. We'd be much better
off if we left _all_ checked-out files in the original state instead.

So my personal preference is still that if we actually have a real 
conflict, we don't actually "consummate" the merge at all, and that very 
much means that we don't write out some partially merged state. We'd leave 
the working directory alone, and now we can fairly easily create a MERGE 
directory which has it's .git file as a symlink to ../.git, and which 
contains all the files that had conflicts in them.

Then, if you decide to not go forwared with the merge, just doing

	read-tree $(cat .git/HEAD)
	rm -rf MERGE

does exactly that. Boom, it's gone.

See? THAT is good behaviour, I think.

> I am wondering if the following changes would make sense and
> make things easier for you:
> 
>  * git-merge-one-file-script is changed to register the path
>    with --cacheinfo using magic SHA1 0{40} instead of using the
>    resulting file on the filesystem.

This sounds fine.

>					  Do keep the current
>    behaviour of leaving the merge results of trivial merges
>    (both kind) in the work tree.

I'd actually prefer not to. Exactly because it fails _both_ the "dirty
files" case _and_ the "merge didn't complete" case.

But if the "magic SHA1" meant that we look for it in a special merge 
directory, that would work.

>  * git-write-tree is changed to refuse to write from a cache
>    that records the magic SHA1.
> 
>  * git-ls-files acquires a new option --merged to notice the
>    magic SHA1 and shows the paths that have such SHA1.
> 
>  * git-update-cache acquires a new option --resolve to notice
>    the magic SHA1 and:
> 
>    - if the named path is not in the work tree anymore, delete
>      the entry.
> 
>    - if the named path exists in the work tree, compute the
>      latest SHA1 for that file and update the entry.

Sounds sane.

On the other hand, I think it would actually be easier to just make your 
"magic SHA1" be just another "stage".

		Linus
