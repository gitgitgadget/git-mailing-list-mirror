From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Subject: Re: git-bisect is magical
Date: Thu, 12 Jan 2006 22:59:47 +0100
Message-ID: <20060112215946.GA5808@speedy.student.utwente.nl>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org> <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org> <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org> <dq168p$3kt$1@sea.gmane.org> <Pine.LNX.4.64.0601101308540.4939@g5.osdl.org> <dq1o88$1bm$1@sea.gmane.org> <Pine.LNX.4.64.0601101846170.3294@g5.osdl.org> <dq3hgn$maf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 22:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExAU4-0001an-6u
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbWALV7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 16:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWALV7t
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 16:59:49 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:50188 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S1161338AbWALV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 16:59:48 -0500
Received: from sytse by speedy.student.utwente.nl with local (Exim 4.50)
	id 1ExATz-0002ZE-4B; Thu, 12 Jan 2006 22:59:47 +0100
To: walt <wa1ter@myrealbox.com>
Content-Disposition: inline
In-Reply-To: <dq3hgn$maf$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14592>

On Wed, Jan 11, 2006 at 10:07:19AM -0800, walt wrote:
> [...]
> After I did the 'git checkout origin' yesterday, I didn't (yet) know
> what I was doing, so I made the following pilot-errors while still
> in 'origin':  I did 'git-reset --hard origin' and then very early
> this morning I did cg-update, both of which seemed to work fine and
> gave no error messages, and I compiled a new kernel from the result.
> 
> After reading the three essays from you guys :o) I realized that I
> had made these two mistakes, and tried to switch back to master:
> $git-branch
>   bisect
>   master
> * origin
> $git-checkout master
> fatal: Entry 'Documentation/kernel-parameters.txt' would be overwritten
> by merge. Cannot merge.
> 
> So I cloned a fresh copy of your repository and built a new kernel.

Funny thing about git is, at least in my experience, that you generally never
really have to do this. Because objects are immutable, and basically the only
thing git -really- cares about is objects, you can always tell git to just
ignore anything you've done (or that anybody else has done, for that matter).
Just point it to an object somebody else made and it won't see any of your
local changes. If you're not satisfied with the way a branch worked out, just
remove it, or point it to another object.

By the way, you can always just move away a broken origin; git-fetch (or
git-pull of course, because it uses git-fetch), will just create a new one. If
git-branch shows that you currently have origin checked out, do

    # Create a new branch named 'bad-bad-origin' based on HEAD (which equals
    # origin at the moment) and check it out
    git-checkout -b bad-bad-origin

otherwise do (because it is faster, as it doesn't touch your index file or
your working tree)

    # Create a new branch named 'bad-bad-origin' based on origin
    git-branch bad-bad-origin origin

... and finally remove the old origin:

    git-branch -d origin

After this, a git-fetch will just recreate origin, and unlike git-pull does
nothing that could give you more headbreaks again, so that fixes your broken
origin. Then optionally backup your master by saying

    git-branch old-master master

and get yourself a nice and clean repository again by typing:

    git-checkout master
    # Reset the current HEAD (namely, master) to origin
    git-reset --hard origin

Before executing any git command that will check out a different tree, though,
you will want to make sure you know what you have done to your working tree and
what git will do to your edits when you execute that command. git-diff*,
git-ls-files, and git-status are your friends. If either git-ls-files -m or
git-ls-files -u (or the combination git-ls-files -m -u, naturally) shows any
files, git will refuse to switch branches if it has to touch any of these
files.

If you're sure you don't want these changes anymore, you can undo any changes
with 'git-reset --hard'. If you wish to save these changes however, you can
either take the classic approach of saving a diff with git-diff HEAD (just a
plain git-diff won't do for files in git-ls-files -u, that is, files that you
already ran git-update-index on) or you can make a commit and save it in a
temporary branch.

For example, you can make a commit before or after the 'git-checkout -b
bad-bad-origin' in the beginning of this mail, and the diff will be in
bad-bad-origin for your later reference by using git-diff-tree -p
bad-bad-origin.


By the way, if you really don't know what to do anymore, there always is the
last resort of fixing things up manually. I'm not recommending you to go this
way, but it has helped me out a couple of times before I knew all the basic
commands, so it seems good to at least mention how you do it.

All branches are in .git/refs/heads/, so you can just go there and move master
and origin or any other branch that you like to another name, or remove them,
or overwrite them with references you pick from other files in .git/refs/heads/
or git log. Just make sure all they contain is a full sha1-hash, so no names,
just the hash. And that .git/HEAD is a symlink pointing to one of the files in
refs/heads/.

The drawback, and the reason you should generally not do this unless you don't
know any better way to do what you want, is that you can leave the index file
and the working tree in a state that doesn't correspond to the current HEAD
anymore. To be sure, you can always go back to the top directory and do a
'git-reset --hard', and then a 'git-ls-files -z -o |xargs -0 rm --'. This will
remove any extra files that you have in your working tree, mind you, so make
sure you move those you still need out of the working tree before doing this.

> What I learned from this was that the new fixes to Makefile and
> setlocalversion (at a minimum) were not actually applied to the
> checked-out sources in my 'origin' misadventure.  (I watched the
> commits being listed by cg-update, so I know the fixes were really
> downloaded -- but they were not applied to the checked-out sources
> as they normally would be.)
>
> Would these anomalous results be expected -- given the, um, unusual
> circumstances?

Yes. If git tries a merge, but fails, it will leave the results in the working
tree for you to fix, so that you can finish the merge. If you don't wish to
finish the merge, just do a git-reset --hard and your tree is clean again.

> Thanks again!

No thank _you_, for explaining so well what exactly you didn't understand! :-)

        Sytse Wielinga
