From: Junio C Hamano <junkio@cox.net>
Subject: Re: Trying to Update All Heads of a Repository
Date: Thu, 03 Nov 2005 18:42:21 -0800
Message-ID: <7vy8453zhu.fsf@assigned-by-dhcp.cox.net>
References: <E1EXpN9-00034x-7g@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 03:42:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXrXA-0000AX-HN
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 03:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbVKDCmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 21:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbVKDCmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 21:42:25 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22234 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161104AbVKDCmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 21:42:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104024126.GWAM24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 21:41:26 -0500
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11117>

Jon Loeliger <jdl@freescale.com> writes:

> First, I have this, because it came with a git-clone:
>
>     % cat .git/remotes/origin
>     URL: rsync://rsync.kernel.org/pub/scm/git/git.git
>     Pull: master:origin
>
> I don't know how to say "Grab all the updates for
> all the heads for which I have heads in my .git/refs".

My "guinea pig" repository has this in $GIT_DIR/remotes/origin:

        URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
        Pull: +pu:pu
        Pull: maint:maint

This means that my "master" is copied to the "origin" branch of
the guinea pig repository and "pu" and "maint" are copies of my
"pu" and "maint" branches.  You never do your own development on
branches that appear on the right hand side of colon on "Pull"
lines (i.e. origin, pu and maint) in this repository.  They are
to be updated by git-fetch.

And the regular workflow over there is:

	$ cd over-there
        $ git checkout master
        $ git pull
        ... build, test, install

> So I hope "git pull --help" will tell me:

You're right.  We need to add --help to that command.

> Like could I have just said?:
>
>     % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git
> or
>     % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git master:origin
>     % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git pu:pu
>     % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git todo:todo

You could.  Alternatively, with your original remotes/origin
file, you should be able to do:

	$ git checkout master
	$ git fetch origin master:origin +pu:pu maint:maint
        $ git pull . origin

> On to the pu branch:
>
> Rats.  But why did this fail?  I've changed nothing in my tree.
> I'm pulling remote pu into local pu directly.  I think this
> should Just Work...

My "pu" is somewhat special; it is rewound and rebased all the
time, so merging with its older self would conflict with it.
That's why my example remotes/origin file has '+' in front of
it.  It tells git-fetch that the other side _might_ rebase and
fetch would not result in a fast-forward merge when that happens.

I should advertise that fact more often, for people who came
here after I did the last such advertisement.

> But I really thought that this should Just Work?
> Shouldn't this be a fast forward, nice-n-clean-n-easy?

Sorry, my "pu" does not fast forward.  The branch is to showcase
what I've received or picked up from the list, and what changes
are under consideration for inclusion.

The "pu" head is built by pulling a handful topic branches on
top of the "master" branch.  My private repository right now
looks like this:

    ! [hold/draw] Illustration: "Commit DAG Revision Naming"
     ! [hold/http] [PATCH 2/2] Add support for git-http-push to git-pu...
      ! [hold/svn] Several fixes to import mono's svn tree
       ! [jcmu] git-tag: Do not assume the working tree root is writab...
        ! [maint] GIT 0.99.9c
         * [master] Illustration: "Commit DAG Revision Naming"
          ! [pu] Merge branch 'toys'
           ! [toys] git-shallow-pack
    --------
          +  [pu] Merge branch 'toys'
          ++ [toys] git-shallow-pack
          +  [pu^] Merge branches 'hold/svn' and 'hold/http'
     +    +  [hold/http] [PATCH 2/2] Add support for git-http-push to ...
     +    +  [hold/http^] [PATCH 1/2] Add support for pushing to a rem...
      +   +  [hold/svn] Several fixes to import mono's svn tree
       +  +  [jcmu] git-tag: Do not assume the working tree root is wr...
        +    [maint] GIT 0.99.9c
    +  ++++  [hold/draw] Illustration: "Commit DAG Revision Naming"
    +  ++++  [hold/draw^] Illustration: "Git Diff Types"
    +  ++++  [hold/draw~2] Illustration: "Fundamental Git Index Operat...
    +  ++++  [hold/draw~3] git-merge-ours: make sure our index matches...
    +  ++++  [hold/draw~4] Add 'ours' merge strategy.
    +  ++++  [hold/draw~5] Add --no-commit to git-merge/git-pull.
    +  ++++  [hold/draw~6] Document --since and --until options to rev...
    ++++++++ [hold/draw~7] Be careful when dereferencing tags.

The "hold/draw" topic branch (thanks for your ASCII art) is
fully merged into my "master"; in fact it's head is the master
branch head.  Nick's http-push and Yaacov's svnimport fixes are
kept in separate topic branches, which originated at the
previous "master" (now master~7 == hold/draw~7), and they have
not been rebased, partly I am lazy and partly there are no
changes that would cause merge conflicts with other branches.

On the other hand, the commit structure of my public repository
right now looks like this:

    ! [maint] GIT 0.99.9c
     * [master] Illustration: "Commit DAG Revision Naming"
      ! [pu] Merge branch 'toys'
    ---
      + [pu] Merge branch 'toys'
      + [pu^2] git-shallow-pack
      + [pu^] Merge branches 'hold/svn' and 'hold/http'
      + [pu^^3] [PATCH 2/2] Add support for git-http-push to git-push script
      + [pu^^3^] [PATCH 1/2] Add support for pushing to a remote reposito...
      + [pu^^2] Several fixes to import mono's svn tree
      + [pu~2] git-tag: Do not assume the working tree root is writable.
    +   [maint] GIT 0.99.9c
    +++ [master] Illustration: "Commit DAG Revision Naming"

That is, I do not publish the heads of my topic branches, but
you can get them yourselves by looking at the merge logs in the
"pu" branch.  "toys" head is pu^2, "hold/svn" head is pu^^2, etc.

I think this "bundling together into one pu" head policy
somewhat discourages contributor developments on top of "pu"
material, but on the other hand the topic branches in my
repository tend to have relatively short lifespan, and I'd
rather not clutter people's cloned repositories with these
transient branches.

If you wanted to try out Nick's http-push from "hold/http"
branch, for example, but prefer not to worry about bugs in other
things in "pu", you need to do this:

1. Find out if I keep the change as a separate topic branch.
   Either run "gitk --all" and inspect the commit structure
   between "master" and "pu", or look at the "pu" merge log from
   "git-show-branch" output above.

2. Isolate the topic branch from "pu", discarding other stuff
   you are not interested in.  After step 1, you figured out
   that pu^^3 is the tip of hold/http branch, so make a local
   branch for that, and merge the tip of "origin" on top of it,
   because hold/http branch may not have been rebased to the
   current master:

    $ git checkout -b http-push pu^^3
    $ git pull -n . origin
    $ git show-branch origin http-push http-push^
    ! [origin] Illustration: "Commit DAG Revision Naming"
     * [http-push] Merge branch 'master'
      ! [http-push^] [PATCH 2/2] Add support for git-http-push to ...
    ---
     +  [http-push] Merge branch 'master'
    ++  [origin] Illustration: "Commit DAG Revision Naming"
    ++  [origin^] Illustration: "Git Diff Types"
    ++  [origin~2] Illustration: "Fundamental Git Index Operations"
    ++  [origin~3] git-merge-ours: make sure our index matches HEAD
    ++  [origin~4] Add 'ours' merge strategy.
    ++  [origin~5] Add --no-commit to git-merge/git-pull.
    ++  [origin~6] Document --since and --until options to rev-parse.
     ++ [http-push^] [PATCH 2/2] Add support for git-http-push to ...
     ++ [http-push^^] [PATCH 1/2] Add support for pushing to a rem...
    +++ [http-push^~2] Be careful when dereferencing tags.

3. Build, test, install and have fun.

4. Suppose you came up with a neat enhancement idea or two to
   Nick's http-push.  Do your development and make commits on
   top of the current branch.  Your commit structure would look
   like this after a couple of commits:

    $ git show-branch origin http-push
    ! [origin] Illustration: "Commit DAG Revision Naming"
     * [http-push] Add feature nitfol.
    --
     + [http-push] Add feature nitfol.
     + [http-push^] Add feature frotz.
     + [http-push~2] Merge branch 'master'
    ++ [origin] Illustration: "Commit DAG Revision Naming"

5. Then feed me your changes, perhaps CC:ing the original author:

    $ git format-patch -k -m http-push~2
    * 0001-Add-feature-frotz.txt
    * 0002-Add-feature-nitfol.txt

You could publish the head of this branch and tell me to pull
from there, but I have a slight preference to receiving e-mail
patches if the changes are about the material still in "pu".
