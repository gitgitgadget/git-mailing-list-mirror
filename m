From: Theodore Tso <tytso@mit.edu>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 22:00:54 -0400
Message-ID: <20070319020053.GA11371@thunk.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7Bb-0006Qg-DC
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXCSCBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933620AbXCSCBD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:01:03 -0400
Received: from THUNK.ORG ([69.25.196.29]:56535 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152AbXCSCBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:01:01 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT7H1-0001I0-0U; Sun, 18 Mar 2007 22:06:59 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT7B8-0008HV-2f; Sun, 18 Mar 2007 22:00:54 -0400
Content-Disposition: inline
In-Reply-To: <vpq648ye9w6.fsf@olympe.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42559>

On Sun, Mar 18, 2007 at 06:31:21PM +0100, Matthieu Moy wrote:
> I have a repository with a working tree on a machine A, did a clone to
> another machine B and commited there locally.
> 
> I want my changes to get back into the first repository, so I did a
> "push". The new commit is in the history, I can see it with "git log",
> but the modifications are not in the working tree.

The general answer (which you've already received) is to tell folks is
to simply don't use "git push" to remote trees; basically, if you ever
have a non-bare repository, it doesn't do what you expect, and it will
leave the novice user horribly confused.  A much better answer is to
simply go back to machine A, and pull from machine B.

I was exploring though to see if there was anything we could do
better, and so I used my standard test repository of the GNU Hello,
world program, and did the following:

	git clone hello r1
	git clone r1 r2
	cd r1
	<edit hello.c's headers to be GPL v2 only>
	git commit -a -m "GPL v2 only"
	cd ../r2
	<edit hello.c so that the message printed is "Hello, world!" 
		instead of "hello, world">
	cd ..

OK, so this sets up the standard test setup of repositories r1 and r2.
r1 contains a committed change so that hello.c is GPLv2 only.  r2
contains an uncommitted change to the actual text printed by hello.c.
The changes are nicely seprated in distaince by over 100 lines, so
there should be no problems with merges.  Let's play...

Experiment #1.  Let's try pushing from r1 to r2.

	cd r1
	git push ../r2

This pushes the change GPLv2 change from r1 to r2.  However, it leaves
the working tree and the index untouched, which leads to some very
unexpected and surprising behavior:

  a) If you do a "git commit" you will commit the current contents of
     the index, which is usually the contents of the head of r2 before 
     the push.
  b) If you do a "git commit -a" you will commit the modified changes to 
     the working directory --- based off of the state of r2 before the
     push.  What will therefore show up in the revision log is something
     which appears to be based off of the more recent change in r1, but 
     which is really based off of the old history as of r2 before the push.

All of this is bad, which is why "git push" to a non-bare repository
is extremely surprising.  (As an aside, what Bitkeeper would do is to
update the working tree, but it added the constraint that it would
only allow the "bk push" if the push resulted in a fast-forward merge,
thus guaranteeing no conflicts, and if the none of the files that
would need to be updated in the working tree had been locally
modified; if either constraint were modified, the push would be
aborted, and the remote repository not modified at all.  It would be
nice if we could enforce these constraints using the appropriate
hooks, but from what I can tell the hooks aren't in the right place
for us to be able to do that, or to be able to undo or recover from a
bad push.  More on that in a bit.)

OK, so suppose we do the push anyway.  As you suggested, one possible
solution is:

> $ git reset --soft <commit-id-before-the-push>
> $ git merge <commit-id-after-the-push>
> 
> But it means I have to remember <commit-id-before-the-push>.

Is it at all possible to figure out <commit-id-before-the-push>?  It
seems the answer is no, and I suspect that's a bug.  Maybe it doesn't
make sense to save the original HEAD in ORIG_HEAD in r2, but surely
the original HEAD should be saved in the reflog, right?  Well, at the
moment it saves it in neither case.

The problem is without doing this, it is as far as I can tell
impossible to determine what revision the index is currently
corresponding to, and without this information, it's very limited in
what you can do.

What possible solution which you *can* do is:

	git diff > /tmp/stage-patch
	git reset --hard
	patch -p1 < /tmp/stage-patch

But that seems a bit manual and somewhat kludgy.  If we had the
revision of r2 before the push, it would be possible to do a 3-way
merge, which in some cases might result in a cleaner merge of the
modified files in the working tree.

Experiment #2.  Let's try pulling from r2 to r1

So this is what we tell people they should do; so how well does it
work in this case?

	<do the above experimental setup>
	cd r2
	git pull ../r1

What do we get?

	Updating f2e3cc0..37508dc
	hello.c: needs update
	fatal: Entry 'hello.c' not uptodate. Cannot merge.
	 hello.c |    7 +++----
	 1 files changed, 3 insertions(+), 4 deletions(-)

Oh, dear.  Since hello.c was locally modified, git-merge refused to do
a 3-way merge to the local file.  That's unfortunate, since if it had,
it would have succeeded, and in this case it would have done the right
thing.  git-checkout will do something similar, but it at has an -m
option which will do a 3-way merge to update the local working file.
Unfortunately git-merge and git-pull do not have such an option.
'twould be nice if it did, but that's going to have to wait someone
wanting to scratch that particular itch...

The failure leaves the index and the working tree in the same confused
state as the "git push" scenario, though --- the index is still
referring to original state of the tree before the pull, but the HEAD
has been updated to after the pull, so "git commit" will lead to the
same confusing behavior.  Fortunately, though, when we do a pull,
ORIG_HEAD and the reflog are updated, so we can get back to our
original state via a command like this:

	git update-ref HEAD ORIG_HEAD

So ok, let's break down the git pull into its two constiuent parts.
The git-fetch and the git-merge.  

	git fetch
	git merge FETCH_HEAD

This fails in the same way:

   Updating f2e3cc0..37508dc
   hello.c: needs update
   fatal: Entry 'hello.c' not uptodate. Cannot merge.
    hello.c |    7 +++----
    1 files changed, 3 insertions(+), 4 deletions(-)

And just as before, it leaves HEAD updated to FETCH_HEAD, even though
it failed.  So it's consistent, but that's not what the documentation
for git-merge states:

      You  may  have  local modifications in the working tree files. In other
      words, git-diff is allowed to report changes. However, the  merge  uses
      your  working  tree  as  the  working area, and in order to prevent the
      merge operation from losing such changes, it makes sure  that  they  do
      not  interfere  with the merge. Those complex tables in read-tree docu-
      mentation define what it means  for  a  path  to  "interfere  with  the
      merge".  And  if  your  local  modifications  interfere with the merge,
      again, it stops before touching anything.
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Well, it certainly stops before touching any local files, but it has
already updated HEAD, which leaves things in a very confusion
situation.  Maybe it would be better if git-merge atomically failed
and left HEAD back pointing at the original revision?   

						- Ted
