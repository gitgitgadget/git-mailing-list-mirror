From: ebiederm@xmission.com (Eric W. Biederman)
Subject: A series file for git?
Date: Fri, 23 Jun 2006 05:37:34 -0600
Message-ID: <m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
	<7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 13:38:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftjz9-0006vC-Gb
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 13:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWFWLiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 07:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933047AbWFWLh7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 07:37:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24743 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932586AbWFWLh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 07:37:58 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5NBbZM6027520;
	Fri, 23 Jun 2006 05:37:35 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5NBbYGk027519;
	Fri, 23 Jun 2006 05:37:34 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpshtyffk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 31 May 2006 15:53:19 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22407>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>>  (a) git-rev-list --pretty=oneline "$upstream"..ORIG_HEAD > rev-list
>>
>>  (b) edit the rev-list, moving the single lines around, deleting them, etc
>>
>>  (c) cat rev-list |
>>      git-format-patch -k --stdout --stdin --full_index |
>>      git-am
>>

> Tentatively my feeling is that we should make it known that the
> list format-patch takes from --stdin is supposed to be _not_
> reversed, and do nothing in format-patch.  In other words, the
> list fed is a moral equivalent to quilt "series" file.

Agreed that seem to make a lot of sense.

> What this means is:
>
> 	git-format-patch $revargs
>
> is not equivalent to
>
> 	git-rev-list $revargs | git-format-patch --stdin
>
> but is equivalent to
>
> 	git-rev-list $revargs | tac | git-format-patch --stdin

At least for now the using tac is fine.  Longer term I think
having some reverse arguments to rev-list or even better
git-log so we can review patches in order instead backwards
would be very interesting.

> Thoughts from the list?

So I have played with this some and a bit of feedback.

I was using:
	git-rev-list $revargs | tac > list

	for sha1 in $(cat list); do git-cherry-pick -r $sha1 ; done

Is there any real difference between using git-format-patch | git-am
and using git-am to apply patches.  I was using git-cherry-pick simply
because it was easier to sha1 too.

- When you reorder patches minor merge conflicts are common
  so a big pipe won't work very often in practice.  So you
  need a way to handle failures in the middle.

- Keeping patches in git and just remembering their sha1 is nice
  but it has the downside that it can be really easy to loose
  the sha1, and thus the patch.  So some sort of history mechanism
  so you can get back to where you were would be nice.

- This is a similar technique to topic branches.  However in some
  of the more interesting cases a topic branch can't be used because
  you have a whole series of little changes, that allow depend on
  each other.  So topic branches need not apply.

- One of the places where we currently uses series files
  (patch-scripts && quilt), and heavy cherry picking is for patch
  aging.  That is letting patches sit in a testing branch for 
  a while so people have a chance to test and look at them.

  The important pieces there are the ability to reorder the changes
  to put the patches with the highest confidence first.

  The ability to comment on the patches so that it is possible
  to record groups of patches and information about their relative
  stability.  As once a patch series gets large without at least
  a few comments it is too much for a person to remember what
  is happening with each patch without a few clues.

- The other place where we use series files is in pure development
  where we are breaking up or otherwise creating the needed changes
  in a set of simple obviously correct changes.

....

So I think it could be very interesting to have a series file
as something the base git porcelain helps to deal with.

If we create a meta data branch with just the series file
we can remove the risk of loosing things, as we always
have a path back to the old history if we want it.

We can keep track of the series file with a SERIES_HEAD
similar to FETCH_HEAD.  This fairly easily allows editing
in different places in the patch stack that normally happens
with  quilt or patch-scripts.

We can put comments in a series file to keep track of probationary
patches.

The two tricky pieces I see with this idea are:
- teaching git-fsck-objects that we have a sha1 in a blob objects.

- Where to put the active checkout series file when we are working,
  so we don't stumble on it.

...

I'm trying to sort out a sane work flow for developing with a large
number of highly related patches on the development side.  I care
because the way I think I usually fix the root cause of problems.

It took me nearly 25 patches to decouple the brain damage the msi
code imposed on x86 irq handling.   In the development of that
I had to reorder and edit things extensively as I broke the
work up, and created a sane patch flow.

The trick with rev-list | tac to create a series file for reordering
changes was very useful but it wasn't enough to say it solve the
problem.  

One trivial issue was that git-cherry-pick -r always does the full
git-commit so it is much more I/O bound than necessary, because
git-commit does git-status.  Which is just silly if you are applying
a bunch of changes that apply without errors.

Eric
