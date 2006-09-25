From: Junio C Hamano <junkio@cox.net>
Subject: On ref locking
Date: Mon, 25 Sep 2006 02:26:31 -0700
Message-ID: <7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 25 11:27:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRmk1-000053-O9
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 11:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIYJ0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 05:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIYJ0e
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 05:26:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:2520 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750787AbWIYJ0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 05:26:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060925092632.VJPV16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Sep 2006 05:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SZSV1V00D1kojtg0000000
	Mon, 25 Sep 2006 05:26:30 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200609240645.54467.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sun, 24 Sep 2006 06:45:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27729>

The comments you added to the strawman I sent suggested use of
rather heavyweight locks, which made me feel we were somehow
going in a wrong direction.  Before going into the details of
branch removing, let's first see if we can summarize what kind
of guarantee we would want from ref updates.  The current
locking scheme is very carefully and nicely done by Linus and
Daniel Barkalow around June last year, and I do not want to lose
good property of it.

 - When reading and/or listing refs you do not need to acquire
   any lock.

 - When you are going to update an existing $ref, you create
   $ref.lock, and do a compare-and-swap.

What the latter means is that an updater:

 (1) first learns the current value of the $ref, without
     locking;

 (2) decides based on the knowledge from (1) what the next value
     should be;

 (3) gets $ref.lock, makes sure $ref still is the value it
     learned in (1), updates it to the desired value and
     releases the lock.

The above 3-step sequence prevents updater-updater races with an
extremely short critical section.  We only need to hold the lock
while we do compare and swap.

The mandatory "fast-forward" check by receive-pack introduced by
Johannes (see receive-pack.c::update()) does exactly the above.
The program reads the current value of refs involved very early,
and verifies fast-forward-ness of the update here.  After doing
that, it gets the lock, makes sure the refs are still the same
as we read earlier (meaning, nobody else updated the ref while
we were doing other things, thereby invalidating the checks
we've done earlier) and then finally unlocks it.

Side note: we might want to move the call to run_update_hook()
before creating the lock for the same reason as we do the new
fast-forwards test before acquiring the lock.

I am not sure if the current code in receive-pack is doing the
right thing to prevent creator-creator race, though.  While
creating a new ref, verify_old_ref() is called with 0{40} as the
old value (meaning, "we are creating this ref and setting it to
this value, based on our previous knowledge that it did not
exist").  It happily returns without checking anything in this
case, but I think it should make sure nobody created the ref
while we were looking the other way.  With the current code, we
would allow overwriting somebody else's push.  And the race
window is not so small -- the check that the ref is a new one we
are about to create is performed during the initial protocol
handshake, and then we can spend quite some time unpacking the
pack stream until we get to verify_old_ref().

The same 3-step sequence is done by refs.c::lock_ref_sha1() and
lock_any_ref_for_update() API and Porcelains are expected to use
git-update-ref.  You call them with the current value of the ref
as you learned earlier, and you would get a lock.  If you get a
lock successfully, you write the new value out.

Side note: I think the same issue of creator-creator race exists
in verify_lock(), by the way.  I think we can fix this by
accepting 0{40} SHA1 to git-update-ref to mean "I am creating
this based on the assumption that it does not exist yet -- that
is my understanding from my earlier check".

We are very relaxed about deleting refs right now, compared to
the updates described above.  "git branch -d" barfs if the ref
it wanted to delete is not an ancestor of the current branch,
but it does not have any lock between the time it checks and the
time it actually deletes it.

There are very loosely written ref updates in Porcelains. "git
tag" and "git branch" barf if the ref they wanted to create
exists, but both have rather large race window without the
protection of any lock.  Especially "git tag" race window is
large -- it lets you open an editor to type the tag message and
runs gpg to sign the message after checking if you are not
overwriting an existing tag X-<.  These should be fixed, and I
think we can do so by the above fix to git-update-ref I
mentioned in the above side note.

We might need to update the ref locking to adjust to packed
refs, and getting locks around ref deletion right becomes more
important if we want to do the funky .git/deleted-refs/$ref~ref
business.  But we should try to stick to the same 3-step
sequence.  What this means is that a deleter:

 (1) first learns the current value of the $ref, without
     locking;

 (2) decides based on the knowledge from (1) it indeed wants to
     delete it;

 (3) gets the $ref.lock, makes sure $ref still has the value it
     learned in (1), and deletes it.  As a special case, if $ref
     no longer exists, that does not have to be an error.
     Somebody else deleted it while we were looking the other
     way, but a delete is a delete is a delete, and we are
     simply happy that the ref is gone.

This should protect us from deleter-updater race.  $ref.lock
would protect us from deleter-creator race.  So I do not think
we would need to take .git/packed-refs.lock while deleting a
ref.  Even if you implement "(3) ... deletes it" with the
proposed .git/deleted-refs/$ref~ref file.

I think the way Linus did git-pack-refs protects us from
packer-packer race, and packer-updater, packer-creator, and
packer-deleter race does not exist, because pack-refs:

 (0) takes .git/packed-refs.lock

 (1) learns the current value of all refs without any further locking;

 (2) writes out the current values;

 (3) releases .git/packed-refs.lock.

If somebody else creates or updates a ref while the above is
running, the new result from loose refs will be used by later
user, making the entry in packed-refs obsolete.  So there is no
packer-updater or packer-creator race here.  If we do the
proposed .git/deleted-refs/$ref~ref to mark deletion, that would
also override whatever is in the resulting packed-refs, so we do
not have to worry about packer-deleter race either.

I am reasonably sure there is no pruner-updater and pruner-creator
races.  "pack-refs --prune":

 (1) learns the current value of all refs without any locking,
     as part of the packing operation during the same run.

     For each ref:

 (2) takes $ref.lock, makes sure $ref still has the value it
     learned from (1), and deletes .git/$ref (because the same
     value is recorded in .git/packed-refs), and then unlocks
     $ref.lock

I haven't thought through packer-pruner race (pruner needs to
unlock .git/packed-refs.lock first -- otherwise if it dies in
the middle of pruning we would lose refs that are stashed in the
.git/packed-refs.lock file, that hasn't made to its final
location), but I think we do not have any problem.
