From: Junio C Hamano <junkio@cox.net>
Subject: My GIT Day
Date: Fri, 19 Aug 2005 20:07:37 -0700
Message-ID: <7voe7tqpae.fsf@assigned-by-dhcp.cox.net>
References: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 05:08:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Jhw-0005n0-A7
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 05:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbVHTDHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 23:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbVHTDHl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 23:07:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56795 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932813AbVHTDHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 23:07:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820030739.NXSG7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 23:07:39 -0400
To: git@vger.kernel.org
In-Reply-To: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 19 Aug 2005 00:45:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> *1* I should probably write a bit about how I do things in a
> separate message as a how-to.

So here it is.

Note that the version of git on my $PATH is usually the one from
the proposed updates branch, so some of the commands I use in
the following text may not work for you unless you also have
built "pu" one yourself.

I am planning to finish updating, testing and documenting what's
in the current proposed updates branch, and have most of them
graduate to the master branch over the weekend.  I am aiming for
doing the 0.99.5 on Wednesday next week.

------------

I have the following heads all the time in my private
repository:

    master	- the one to be pushed to public "master" branch
    pu		- master plus various proposed changes
    rc		- master plus minimum release engineering

    ko-master	- a copy of public "master" branch head
    ko-rc	- a copy of public "rc" branch head

My GIT day always starts with this command:

    $ git fetch ko

I have this in .git/remotes/ko:

    $ cat .git/remotes/ko
    URL: master.kernel.org:/pub/scm/git/git.git/
    Pull: master:ko-master rc:ko-rc
    Push: master pu rc

The Pull: line gives me the default set of <refspec>s to give to
the "git fetch" command.  I slurp "master" and "rc" heads from
the public repository at master.kernel.org, and fast-forward my
ko-master and ko-rc branches with them.  I do not touch these
two branches in any way other than this "git fetch" fast
forwarding.

I have a few "topic branches" in addition to the above; they
change from time to time.  Recently I've been looking at
multi-head fetches, and that work is done in "mhf" branch.
There also is a catch-all topic called "misc".  I started them
like this:

    $ git branch mhf master
    $ git branch misc master

The first thing I do during my GIT day is to process the patches
I received via e-mail.  I store them one topic per file in my
working tree, like this:

    $ ls +*.txt
    +js-glossary.txt  +mc-mailinfo.txt

Depending on the quality of the patch, seriousness of the bug
they fix, and the area of the code they touch, they either go
directly to "master", "misc", or sent back to the sender, but
the last one, luckily for me, rarely happens:

    $ git checkout master
    $ git applymbox -q ./+js-glossary.txt .git/info/signoff

    $ git checkout misc
    $ git applymbox -q ./+mc-mailinfo.txt please

The last parameter to the applymbox command is the name of a
file that has my signoff message.  The latest applymbox in the
"pu" branch has a bit more useful extension to do the same thing
as what "git commit" does.

At this point, I may push out the "master" branch (and nothing
else), like this:

    $ git push ko master

This pushes only "master", ignoring the default <refspec>s
defined in the .git/remotes/ko file you saw earlier.

Once I am done with the outside patches, I go back to where I
left off the previous day:

    $ git checkout mhf

And I check where my head is relative to the master:

    $ git show-branches master mhf
    ! [master] Yet another tweak
     * [mhf] Make git-fetch-script a bit more chatty.
    +  Yet another tweak
    +  Another tweak in Makefile
     + Make git-fetch-script a bit more chatty.
     + Update git-ls-remote-script
     + ...
     + Start adding the $GIT_DIR/remotes/ support.
    ++ [PATCH] Allow file removal when "git commit --all" is used.

The output from show-branches is a poor-man's gitk.  The named
branches are shown, and '+' sign in each column shows whether
the commit is contained in each branch, and the output stops
where all branches converge, or you hit ^C ;-).

If the mhf branch is way behind, I may choose to first rebase
it, to clean up my history:

    $ git rebase master
    $ git show-branches master mhf
    ! [master] Yet another tweak
     * [mhf] Make git-fetch-script a bit more chatty.
     + Make git-fetch-script a bit more chatty.
     + Update git-ls-remote-script
     + ...
     + Start adding the $GIT_DIR/remotes/ support.
    ++ Yet another tweak

I keep working in my topic branches.  I may make some other
changes in "misc" topic branch.  It's a simple cycle of:

    $ edit-and-test
    $ git commit -s -a -v

Eventually I get to a good point where it makes sense to push
things to the public repository.

    $ git show-branches master mhf misc
    ! [master] Yet another tweak
     * [mhf] Make git-fetch-script a bit more chatty.
      ! [misc] Add hooks to tools/git-applypatch.
     +  Make git-fetch-script a bit more chatty.
     +  Update git-ls-remote-script
     +  ...
     +  Start adding the $GIT_DIR/remotes/ support.
    ++  Yet another tweak
    ++  Another tweak in Makefile
      + Add hooks to tools/git-applypatch.
      + Add commit hook and make the verification customizable.
    +++ [PATCH] Allow file removal when "git commit --all" is used.

As you may have noticed, my topic branches are private and not
pushed to the public repository.  Instead, I make a grand total
merge of them into "pu".  The proposed update branch is always
rewound and made from the head of the master:

    $ git checkout pu
    $ git reset master

This checks out the head of "pu" branch, and then resets the
index file to match "master" and updates .git/refs/heads/pu.

What it does _not_ do is to update my working tree to match the
index file.  Linus recommends to do "git checkout -f" at this
point, but I typically do this instead:

    $ git diff -R -p | git apply

Note.  This is an embarrassingly expensive way; the only thing
it buys me over "git checkout -f" is that it removes the files
that were introduced in "pu" branch that did not exist in the
"master" head.  I have to come up with a not so expensive way to
do this.

Then before doing the grand total merge, check again where those
heads are:

    $ git show-branches master mhf misc pu 
    ! [master] Yet another tweak
     ! [mhf] Make git-fetch-script a bit more chatty.
      ! [misc] Add hooks to tools/git-applypatch.
       * [pu] Yet another tweak
     +   Make git-fetch-script a bit more chatty.
     +   Update git-ls-remote-script
     +   ...
     +   Start adding the $GIT_DIR/remotes/ support.
    ++ + Yet another tweak
    ++ + Another tweak in Makefile
      +  Add hooks to tools/git-applypatch.
      +  Add commit hook and make the verification customizable.
    ++++ [PATCH] Allow file removal when "git commit --all" is used.

Notice that I did not rebase "misc" above, but that is OK.  What
I want to do here is to make new "pu" an Octopus over "master",
merging in all my topic branches (currently "mhf" and "misc").

    $ git fetch . mhf misc
    Packing 0 objects
    Unpacking 0 objects
    * committish: a101f32...e5580	refs/heads/mhf from .
    * committish: 4426ac7...0c5bc	refs/heads/misc from .

This fetches two heads from the current repository (!).  The
only reason I do it is that the tentative implementation of "git
octopus" always reads from $GIT_DIR/FETCH_HEAD, and "git fetch"
is the way to populate that file.

    $ git octopus
    Removing git-parse-remote
    Removing git-parse-remote
    Committed octopus merge fe1899156bffa4be6722b2ca0b74ff17b76523da
     Makefile                        |    3 -
     git-commit-script               |   75 +++++-------------
     ...
     tools/git-applypatch            |   87 ++++++++++++++++----
     15 files changed, 551 insertions(+), 224 deletions(-)

This makes an Octopus out of the master and other two topic
branches.  I can make sure that resulting "pu" contains all the
necessary commits from the branches involved:

    $ git show-branches master mhf misc pu
    ! [master] Yet another tweak
     ! [mhf] Make git-fetch-script a bit more chatty.
      ! [misc] Add hooks to tools/git-applypatch.
       * [pu] Octopus merge of the following: 
       + Octopus merge of the following:
     + + Make git-fetch-script a bit more chatty.
     + + Update git-ls-remote-script
     + + ...
     + + Start adding the $GIT_DIR/remotes/ support.
    ++ + Yet another tweak
    ++ + Another tweak in Makefile
      ++ Add hooks to tools/git-applypatch.
      ++ Add commit hook and make the verification customizable.
    ++++ [PATCH] Allow file removal when "git commit --all" is used.

And things are now ready to be pushed out.  First I sanity check
the differences between ko-master and master (the earlier "git
fetch ko" was done only for this step):

    $ git show-branches master ko-master

... and then run "git push":

    $ git push ko

This will push "master" and "rc" but would fail to push "pu",
because that is rebased and not based on what is on the public
repository.  So I push once more, this time with --force, like
this:

    $ git push --force ko pu

This pushes only "pu", ignoring the default <refspec>s defined
in the .git/remotes/ko file you saw earlier.  After that, I go
back to reading the mail and wait until the kernel.org mirror
network catches up.
