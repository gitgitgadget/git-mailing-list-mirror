From: Junio C Hamano <junkio@cox.net>
Subject: Re: sending changesets from the middle of a git tree
Date: Sun, 14 Aug 2005 18:37:39 -0700
Message-ID: <7vfytc9dzw.fsf@assigned-by-dhcp.cox.net>
References: <42FEBC16.9050309@austin.rr.com>
	<Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
	<7vhddtdk86.fsf@assigned-by-dhcp.cox.net>
	<20050814092757.GP5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 03:38:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4TvM-0000Xo-9P
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 03:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVHOBhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 21:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVHOBhq
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 21:37:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64657 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932623AbVHOBhp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 21:37:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815013741.WBAT19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 21:37:41 -0400
To: git@vger.kernel.org
In-Reply-To: <20050814092757.GP5608@pasky.ji.cz> (Petr Baudis's message of
	"Sun, 14 Aug 2005 11:27:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
>> Linus Torvalds <torvalds@osdl.org> writes:
>> 
>> > Junio, maybe you want to talk about how you move patches from your "pu" 
>> > branch to the real branches.
>> 
> Actually, wouldn't this be also precisely for what StGIT is intended to?

Exactly my feeling.  I was sort of waiting for Catalin to speak
up.  With its basing philosophical ancestry on quilt, this is
the kind of task StGIT is designed to do.

I just have done a simpler one, this time using only the core
GIT tools.

I had a handful commits that were ahead of master in pu, and I
wanted to add some documentation bypassing my usual habit of
placing new things in pu first.  At the beginning, the commit
ancestry graph looked like this:

                             *"pu" head
    master --> #1 --> #2 --> #3

So I started from master, made a bunch of edits, and committed:

    $ git checkout master
    $ cd Documentation; ed git.txt git-apply-patch-script.txt ...
    $ cd ..; git add Documentation/*.txt
    $ git commit -s -v

NOTE.  The -v flag to commit is a handy way to make sure that
your additions are not introducing bogusly formatted lines.

After the commit, the ancestry graph would look like this:

                              *"pu" head
    master^ --> #1 --> #2 --> #3
          \
            \---> master

The old master is now master^ (the first parent of the master).
The new master commit holds my documentation updates.

Now I have to deal with "pu" branch.

This is the kind of situation I used to have all the time when
Linus was the maintainer and I was a contributor, when you look
at "master" branch being the "maintainer" branch, and "pu"
branch being the "contributor" branch.  Your work started at the
tip of the "maintainer" branch some time ago, you made a lot of
progress in the meantime, and now the maintainer branch has some
other commits you do not have yet.  And "git rebase" was written
with the explicit purpose of helping to maintain branches like
"pu".  You _could_ merge master to pu and keep going, but if you
eventually want to cherrypick and merge some but not necessarily
all changes back to the master branch, it often makes later
operations for _you_ easier if you rebase (i.e. carry forward
your changes) "pu" rather than merge.  So I ran "git rebase":

    $ git checkout pu
    $ git rebase master pu

What this does is to pick all the commits since the current
branch (note that I now am on "pu" branch) forked from the
master branch, and forward port these changes.

    master^ --> #1 --> #2 --> #3
          \                                  *"pu" head
            \---> master --> #1' --> #2' --> #3'

The diff between master^ and #1 is applied to master and
committed to create #1' commit with the commit information (log,
author and date) taken from commit #1.  On top of that #2' and #3'
commits are made similarly out of #2 and #3 commits.

Old #3 is not recorded in any of the .git/refs/heads/ file
anymore, so after doing this you will have dangling commit if
you ran fsck-cache, which is normal.  After testing "pu", you
can run "git prune" to get rid of those original three commits.

While I am talking about "git rebase", I should talk about how
to do cherrypicking using only the core GIT tools.

Let's go back to the earlier picture, with different labels.

You, as an individual developer, cloned upstream repository and
amde a couple of commits on top of it.

                              *your "master" head
   upstream --> #1 --> #2 --> #3

You would want changes #2 and #3 incorporated in the upstream,
while you feel that #1 may need further improvements.  So you
prepare #2 and #3 for e-mail submission.

    $ git format-patch master^^ master

This creates two files, 0001-XXXX.txt and 0002-XXXX.txt.  Send
them out "To: " your project maintainer and "Cc: " your mailing
list.  You could use contributed script git-send-email-script if
your host has necessary perl modules for this, but your usual
MUA would do as long as it does not corrupt whitespaces in the
patch.

Then you would wait, and you find out that the upstream picked
up your changes, along with other changes.

   where                      *your "master" head
  upstream --> #1 --> #2 --> #3
    used   \ 
   to be     \--> #A --> #2' --> #3' --> #B --> #C
                                                *upstream head

The two commits #2' and #3' in the above picture record the same
changes your e-mail submission for #2 and #3 contained, but
probably with the new sign-off line added by the upsteam
maintainer and definitely with different committer and ancestry
information, they are different objects from #2 and #3 commits.

You fetch from upstream, but not merge.

    $ git fetch upstream

This leaves the updated upstream head in .git/FETCH_HEAD but
does not touch your .git/HEAD nor .git/refs/heads/master.  
You run "git rebase" now.

    $ git rebase FETCH_HEAD master

Earlier, I said that rebase applies all the commits from your
branch on top of the upstream head.  Well, I lied.  "git rebase"
is a bit smarter than that and notices that #2 and #3 need not
be applied, so it only applies #1.  The commit ancestry graph
becomes something like this:

   where                     *your old "master" head
  upstream --> #1 --> #2 --> #3
    used   \                      your new "master" head*
   to be     \--> #A --> #2' --> #3' --> #B --> #C --> #1'
                                                *upstream
                                                head

Again, "git prune" would discard the disused commits #1-#3 and
you continue on starting from the new "master" head, which is
the #1' commit.

-jc
