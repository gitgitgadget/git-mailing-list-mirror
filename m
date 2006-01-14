From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 00:59:40 -0800
Message-ID: <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 09:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExhGE-0007PA-Jg
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 09:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWANI7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 03:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWANI7n
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 03:59:43 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2480 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750890AbWANI7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 03:59:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114085724.PXWB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 03:57:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 11 Jan 2006 09:42:44 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14663>

Linus Torvalds <torvalds@osdl.org> writes:

> I'd suggest adding a new kind of object ("gitlink") which has some 
> well-specified format (20-byte SHA1 + ASCII C string "name" - the name 
> translation to external repository would be done in the .git/config file 
> of the "outer" project). Then a special file mode to indicate that in the 
> "struct tree", and support for "git-update-cache" to understand how such 
> an object is really tied into the "<pathname>/.git/HEAD" file rather than 
> the rest of the directory contents.
>
> Then a "git fetch" would have to be taught to recursively fetch the other 
> subproject when the "gitlink" changes.

There are two positive properties about this setup, and one
negative:

 + The contained project is kept totally independent and does
   not have to know it is contained.

 + The tree for the contained project can be rooted anywhere in
   the containing project's tree.

 - The contained project cannot be rooted at the same level or
   higher than the containing project; the containing project
   can only delegate a whole subdirectory to the contained
   project.

The "embedded software" example Simon originally suggested can
be represented with the above.  I'll think aloud for a while
here, because I am of a slow kind who needs a more-or-less
concrete illustration to understand what is being discussed
(that is primarily why I have not said anything on this topic so
far).

The "containing" project would have a handful "gitlink" objects
among other things.  The toplevel tree object from a commit in
such a project might look like this (mode bits 0160000 is
S_IFDIR|S_IFLNK, which is what this thing is):

	$ git ls-tree HEAD
        0100644 blob 012345... Makefile
        0100644 blob 123456... README
        0160000 link 234567... gcc-4.0
        0160000 link 345678... linux-2.6
	0040000 tree 456789... src
	$ git cat-file -t 345678
        link
        $ git cat-file link 345678
        commit 87530db5ec7d519c7ba334e414307c5130ae2da8
	url git://...torvalds/linux-2.6.git/

        The upstream Linux 2.6 repository.
	$ cd linux-2.6 && git-rev-parse --verify HEAD
        87530db5ec7d519c7ba334e414307c5130ae2da8

URL will be used as a suggestion for people who cloned this tree
to set up their repository.  The place and method you clone from
Linus tree might be different, so this has to stay suggestion
and should be overridable by the repository owner.  And to help
people at an unusual location you could have textual comment at
the end, just like tags.

How would this get set up initially?  Here is one way.

        $ git init-db
        $ edit Makefile README src/*
	$ git clone git://...torvalds/linux-2.6.git/ linux-2.6
        $ git clone git://.../gcc-4.0.git/ gcc-4.0
        $ link=$(echo 'The upstream Linux 2.6 repository.' |
                 git-mklink linux-2.6)
	$ git update-index --add --cacheinfo 0160000 $link linux-2.6
        $ : ;# same for gcc-4.0
        $ git add . ;# add the rest as usual
	$ git commit

I presume that the index file have the "gitlink" object just
like in a tree object.  The usual merge rules would apply to
those index entries; we should be able to treat gitlinks just
like we handle symlinks.

Interesting would be "git checkout-index linux-2.6" (or what
"git read-tree -u" does in this "containing" project for
linux-2.6 subdirectory).  After descending into linux-2.6, it
should not just do "git reset --hard $commit" for the commit
recorded in the gitlink (the user may have local modifications
in the subtree).  Doing "git update-ref HEAD $commit" there is
not quite right either because the index there would then need
to be adjusted as well.  Perhaps the real core level commands
such as "checkout-index" and "read-tree -u" should fail when the
subproject tree is dirty, just like "read-tree -m old new" does
not always have to succeed.

What does "git-diff-index/git-diff-tree/git-diff-files" would do
with them?

	$ git-diff-files linux-2.6

would compare the commit recorded in the link and what is
checked out in the linux-2.6/.git/HEAD and report that
difference.  So do other git-diff-* siblings.  At the core level
we do not have to recurse and look at linux-2.6/.git/index (we
may end up doing so at the end, I dunno; initially we said at
the core level we do not have to generate patches but we ended
up having -p option go all of git-diff-* siblings).

Fetching/cloning at the core level is easy.  "git-fetch-pack"
would just need to do one level, but Porcelains need to address
how to actually arrange the subprojects cloning to happen, which
is harder.

"git clone" would say: "Ah, now I see these gitlinks; we need to
clone them.  linux-2.6 directory needs to be populated with
commit 87530d from git://...torvalds/linux-2.6.git/ repository.
Would this work for you, or would you use different mirror?"
and then it clones the repository and sets linux-2.6/.git/HEAD
to the named commit and does a checkout.  The URL used for this
actual subcloning would need to be stored somewhere in $GIT_DIR/,
perhaps in config as you suggested.  I do not think we need a
separate name for it -- we can probably say "linux-2.6" for this
(i.e. use the pathname itself as the key).

What happens if the containing project wants to move these
gitlinks (or remove them)?  When checking out such a commit with
"git-read-tree -u", would the subproject directory be wiped out
(again, such a "read-tree" would be prevented if it would result
in information loss)?

All of this sounds quite a lot of change with brittleness.


Now I'll think aloud about a completely different design.

We could simply overlay the projects.  I think this is what
Johannes suggested earlier.

You keep one branch for each "subproject", and make commits into
each branch (i.e. if you modified files for the upstream kernel,
the change is committed to the branch for linux-2.6 subproject),
but when checking things out, you do an equivalent of octopus
merge across subprojects.

One downside of this approach is we cannot re-root the
subprojects until we update read-tree and write-tree, but I
suspect that would be a lot smaller change.  Once that is done,
we could:

 $ git init-db
 $ mkdir linux-2.6
 $ H=$(git-fetch-pack -k git://...torvalds/linux-2.6.git/ master)
 $ echo $H >.git/refs/heads/kernel
 $ : ;# same for gcc-4.0
 $ cat .git/config <<EOF
 [core]
 	branchroot = linux-2.6 for kernel
 	branchroot = gcc-4.0 for gcc
 EOF
 $ git add . ;# add src and stuff
 $ git commit ;# commits only the scaffolding into "master"

So far, we fetched the kernel and gcc HEAD with needed objects
and stored them into separate branches.  Then:

 $ git setup-overlay embed master kernel gcc ;# works like an octopus

The setup-overlay command would create a new branch "embed" to
hold an octopus merge across named branches "master", "kernel",
and "gcc", and mark that the repository is in a funny "overlay"
mode, in which various commands work differently from usual:

 $ edit linux-2.6/CREDITS gcc-4.0/COPYING Makefile
 $ git commit -a

The "commit" needs to be taught to look at what setup-overlay
left for us, pick out paths that belong to each constituent
branch and do a re-rooting write-tree, for each branch.

This would keep changes to subprojects independent painlessly,
but we would also need a way to tie the versions of subprojects
together (i.e. "this version of src was done with this
particular version of linux-2.6").  This can be done by
committing the octopus to "embed" branch.  Probably easiest
would be to make one commit each to modified constituent branch,
and after that make another commit to "embed" to commit the
octopus to keep track of the aggregation --- the commit would
have the parents set to the previous embed and top commit of
each constituent branch.

If we do not need re-rooting (e.g. redo your slurping gitk into
git.git), I think all of the above can be done without any core
changes.  It would be a lot of Porcelainish work, but I suspect
the core impact would be smaller.
