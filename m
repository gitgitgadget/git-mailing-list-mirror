From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Wed, 22 May 2013 22:11:23 -0400
Message-ID: <20130523021123.GA23155@thunk.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se>
 <20130522134212.GB13731@poseidon.cudanet.local>
 <20130522144531.GB2777@thunk.org>
 <7v8v36kiau.fsf@alter.siamese.dyndns.org>
 <20130522180403.GB20848@thunk.org>
 <7vvc6aj14r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 04:11:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfL0G-0007iz-2D
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 04:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057Ab3EWCLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 22:11:36 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50988 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab3EWCLf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 22:11:35 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UfL2g-0006Hx-Q8; Thu, 23 May 2013 02:14:10 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 7B13D5814B7; Wed, 22 May 2013 22:11:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvc6aj14r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225208>

On Wed, May 22, 2013 at 11:55:00AM -0700, Junio C Hamano wrote:
> But in a triangular workflow, the way to make the result reach the
> "upstream" is *not* by pushing there yourself.  For developers at
> the leaf level, it is to push to their own repository (often on
> GitHub), which is different from where they (initially) clone from
> in order to bootstrap themselves, and (subsequently) pull from in
> order to keep them up-to-date.  And then they request the published
> work to be pulled by the "upstream".

Yep, what I do personally is to call the destination of this "publish", i.e.:

[remote "publish"]
	url = ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.g
	push = +master:master
	push = +origin:origin
	push = +dev:dev

So my typical work flow when I am ready to submit to Linus is:

   git tag -s ext4_for_linus
   git push publish
    <wait for this to propagate from ra.kernel.org to git.kernel.org,
     typically ~5 minutes>
   git request-pull git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git origin > /tmp/pull
    <use /tmp/pull as the e-mail body to send to Linus, cc'ing
     LKML and linux-ext4@vger.kernel.org>

But actually, it's much more common that I am doing a "git push
publish" so that (a) it can get picked up by the daily linux-next tree
(for integration testing even before Linus pulls it into his tree),
and (b) so other ext4 developers so they can either test or develop
against the ext4 tree in progress.

I suppose it would be convenient for "git push" to push to the
"publish" target, but I don't get confused about pushing to origin,
since semantically what I am doing is publishing the current state of
the ext4 tree so other people can see it.  So "git push publish" makes
a lot of sense to me.

> Even in a triangular workflow, @{u} should still refer to the place
> you integrate with, i.e. your "upstream", not to the place you push
> to publish the result of your work.
> 
> This branch.<branch>.rewindable safety however cannot be tied to
> @{u}.  The bottom boundary you want to be warned when you cross is
> the change you pushed out to your publishing repository, and it may
> not have reached remotes.origin.<branch> yet.

Indeed, and in fact for my use case what I promise people is that all
of the commits between origin..master are non-rewindable.  It's the
commits betewen master..dev which are rewindable.  So for me, I'd
still use the safety feature even for my rewindable branch, but
instead of using remotes/publish/dev the "no-rewind" point, I'd want
to use remotes/publish/master as the "no-rewind" point.

Right now I do this just by being careful, but if there was an
automatic safety mechanism, it would save me a bit of work, since
otherwise I might not catch my mistake until I do the "git push
publish", at which point I curse and then start consulting the reflog
to back the state of my tree out, and then reapplying the work I had
to the right tree.

> We will be introducing remote.pushdefault configuration in the
> upcoming 1.8.3 release, so that you can say.....
>
> and hopefully it would let you do this:
> 
> 	git checkout master
>         ... after working on it ...
>         git push

Yes, that would be convenient.  BTW, one of the other things which I
do for e2fsprogs is that I use multiple publishing points, which is
mostly for historical reasons --- it used to be that repo.or.cz wasn't
all that reliable, and the 10-15 minute replication time from
ra.kernel.org to git.kernel.org got really old.

So what I do is something like this:

git push publish ; git push repo ; git push code

where....

[remote "publish"]
	url = ssh://gitolite@ra.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
	fetch = +refs/heads/*:refs/heads/*
	push = next
	push = master
	push = maint
	push = debian
	push = +pu

[remote "code"]
	url = https://code.google.com/p/e2fsprogs/
	fetch = +refs/heads/*:refs/heads/*
	push = next
	push = master
	push = maint
	push = debian
	push = +pu

[remote "repo"]
	url = ssh://repo.or.cz/srv/git/e2fsprogs.git
	push = next
	push = master
	push = maint
	push = debian
	push = +pu

I don't know if this is something you'd want git to encourage, or
support explicitly, but I thought I'd mention it.

						- Ted
