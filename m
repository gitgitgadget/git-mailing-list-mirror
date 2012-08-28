From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: GC of alternate object store (was: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?)
Date: Tue, 28 Aug 2012 21:19:53 +0200 (CEST)
Message-ID: <hbf.20120828vnfp@bombur.uio.no>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
	<loom.20120827T233125-780@post.gmane.org>
Cc: git@vger.kernel.org
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 21:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6RKX-0000c1-MF
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 21:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab2H1TT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 15:19:57 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:56832 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab2H1TTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 15:19:55 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1T6RKM-0005rA-AU; Tue, 28 Aug 2012 21:19:54 +0200
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx2.uio.no with esmtp  (Exim 4.80)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1T6RKL-0006J9-PF; Tue, 28 Aug 2012 21:19:54 +0200
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 86C1E81C; Tue, 28 Aug 2012 21:19:53 +0200 (CEST)
In-Reply-To: <loom.20120827T233125-780@post.gmane.org>
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 4 sum msgs/h 1 total rcpts 2565 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-1.018,UIO_DOLLAR=0.5,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 46BCE0DBAACAF88ED46DCB2DF587ED5EE5691CB0
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -54 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 1338 max/h 33 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204448>

Oswald Buddenhagen wrote:
> (...)so the second approach is the "bare aggregator repo" which adds
> all other repos as remotes, and the other repos link back via
> alternates. problems:
> 
> - to actually share objects, one always needs to push to the aggregator

Run a cron job which frequently does that?

> - tags having a shared namespace doesn't actually work, because the
> repos have the same tags on different commits (they are independent
> repos, after all)

Junio's proposal partially fixes that: It pushes refs/* instead of
refs/heads/*, to refs/remotes/<borrowing repo>/.  However...

> - one still cannot safely garbage-collect the aggregator, as the refs
> don't include the stashes and the index, so rebasing may invalidate
> these more transient objects.

Also if you copy a repo (e.g. making a backup) instead of cloning it,
and then start using both, they'll push into the same namespace -
overwriting each other's refs.  Non-fast-forward pushes can thus lose
refs to objects needed by the other repo.

receive.denyNonFastForwards only rejects pushes to refs/heads/ or
something.  (A feature, as I learned when I reported it as bug:-)
IIRC Git has no config option to reject all non-fast-forward pushes.

> i would re-propose hallvard's "volatile" alternates (at least i think that's
> what he was talking about two weeks ago): they can be used to obtain
> objects, but every object which is in any way referenced from the current
> clone must be available locally (or from a "regular" alternate). that means
> that diffing, etc.  would get objects only temporarily, while cherry-picking
> would actually copy (some of) the objects. this would make it possible to
> "cross-link" repositories, safely and without any "3rd parties".

I'm afraid that idea by itself won't work:-(  Either you borrow from a
store or not.  If Git uses an object from the volatile store, it can't
always know if the caller needs the object to be copied.

OTOH volatile stores which you do *not* borrow from would be useful:
Let fetch/repack/gc/whatever copy missing objects from there.


2nd attempt for a way to gc of the alternate repo:  Copy the with
removed objects into each borrowing repo, then gc them.   Like this:

1. gc, but pack all to-be-removed objects into a "removable" pack.

2. Hardlink/copy the removable pack - with a .keep file - into
   borrowing repos when feasible:  I.e. repos you can find and
   have write access to.  Update their .git/objects/info/packs.
   (Is there a Git command for this?)  Repeat until nothing to do,
   in case someone created a new repo during this step.

3. Move the pack from the alternate repo to a backup object store
   which will keep it for a while.

4. Delete the .keep files from step (2).  They were needed in case
   a user gc'ed away an object from the pack and then added an
   identical object - borrowed from the to-be-removed pack.

5. gc/repack the other repos at your leisure.

666. Repos you could not update in step (2), can get temporarily
   broken.  Their owners must link the pack from the backup store by
   hand, or use that store as a volatile store and then gc/repack.

Loose objects are a problem:  If a repo has longer expiry time(s)
than the alternate store, it will get loads of loose objects from all
repos which push into the alternate store.  Worse, gc can *unpack*
those objects, consuming a lot of space.  See threads "git gc == git
garbage-create from removed branch" (3 May) and "Keeping unreachable
objects in a separate pack instead of loose?" (10 Jun).

Presumably the work-arounds are:
- Use long expiry times in the alternate repo.  I don't know which
  expiration config settings are relevant how.
- Add some command which checks and warns if the repo has longer
  expiry time than the repo it borrows from.
Also I hope Git will be changed to instead pack such loose objects
somewhere, as discussed in the above threads.

All in all, this isn't something you'd want to do every day.  But it
looks doable and can be scripted.
