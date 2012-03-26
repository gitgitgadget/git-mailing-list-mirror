From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 13:18:23 -0400
Message-ID: <20120326171823.GA12843@hmsreliant.think-freely.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <4F708AFD.4070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDZ9-00031c-P9
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076Ab2CZRSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:18:42 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36943 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740Ab2CZRSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:18:42 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SCDYm-0001xI-KU; Mon, 26 Mar 2012 13:18:38 -0400
Content-Disposition: inline
In-Reply-To: <4F708AFD.4070402@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193932>

On Mon, Mar 26, 2012 at 10:27:57AM -0500, Neal Kreitzinger wrote:
> On 3/23/2012 1:52 PM, Neil Horman wrote:
> >Hey all-
> >	I hit a strange problem with git rebase and I can't quite decide if its
> >a design point of the rebase command, or if its happening in error.  When doing
> >upstream backports of various kernel components I occasionally run accross
> >commits that, for whatever reason, I don't want/need or can't backport.  When
> >that happens, I insert an empty commit in my history noting the upstream commit
> >hash and the reasoning behind why I skipped it (I use git commit -c<hash>
> >--allow-empty).  If I later rebase this branch, I note that all my empty commits
> >fail indicating the commit cannot be applied.  I can of course do another git
> >commit --allow-empty -c<hash>; git rebase --continue, and everything is fine,
> >but I'd rather it just take the empty commit in the rebase if possible.
> >
> >I know that git cherry-pick allows for picking of empty commits, and it appears
> >the rebase script uses cherry-picking significantly, so I'm not sure why this
> >isn't working, or if its explicitly prevented from working for some reason.
> >
> >anyone have any insight?
> >
> FWIW, I'm not sure what you mean by "backport", but IMHO backporting
> a critical fix to an earlier version seems by nature to be a
> cherry-pick operation as opposed to a rebase operation.  A rebase
I work on RHEL, among other things, keeping network drivers up to date with
upstream bugfixes/features/etc.  When I say 'backport' I mean exactly that,
backporting an upstream fix/feature/change to various RHEL kernel versions.

Nominally, I would love to be able to do a merge from upstream to just take
everything, but for various and sundry reasons we can't take all upstream
changes (ABI commitments, core API availabliilty, etc).  So In my workflow, I
review each commit to the drivers I'm working on, and either cherry-pick them
back to the relevant RHEL kernel, or I add an empty commit on my private working
branch using the upstream changelog entry, referencing the upstream commit hash.
That way I have a positive indicator that I've looked at a given upstream
commit, and decided not to cherry-pick it.  Prior to integrating with the
mainline kernel I do an interactive rebase of my private branch, and drop any
commits that I've marked as empty.

However, during the period that I'm backporting a driver, I occasionally have
need to do a rebase where I want to keep my empty commits (perhaps I've made a
mistake in cleaning up a previous cherry-pick, or want to rebase my branch to
the origin/master to pick up a common fix).  At those times, I like to keep my
history in tact, empty commits and all, so I can hold on to my notes about which
commits I've reviewed and their dispositions in my work.

> implies "I want everything" -- that doesn't sound like a backport.
Rebases aren't equivalent to "I wan't everything" (at least not always).  I
think what you're thinking of is a merge. A rebase (in the sense that I'm using
it), is either just a movement of my work branch to a newer base, or a replay of
my history to correct an error.

> A cherry-pick implies "I only want certain things" -- that sounds
> like a backport. Maybe your really using rebase to cherry-pick
> several commits.  Using your technique of "empty commit
> placeholders", it seems you could end up with quite a lot of "empty"
> commit placeholders which doesn't seem to make much sense.  Why
See above, the empty commits are really just personal notes.  I expunge them
prior to integration with master.  The empty commits are just personal notes, an
inline area to indiate to myself what upstream commits I have (and have yet to)
consider.

> would you want a bunch of empty commit placeholders in your older
> version bugfix history saying "I didn't want this, but its in the
> newer version."  (who cares?).  Isn't having the stuff you do want
I care, for the purposes of my backporting work..

> recorded as commits enough to make it clear what you brought over?
> You could even edit the "cherry-picked" (or rebased) commit messages
> to document the sha1 of the commit being cherry picked from the
> newer version.  That seems to make more sense to document what you
Yes, I do that, using cherry-pick -x.

> did, as opposed to documenting what you didn't do.
> 
 I document both what I selected to backport, and what I opted not to backport
and why (using the empty commit logs).  

Regardless, the rational behind my specific case doesn't matter too much.  We
allow the creation of empty commits (via git commit --allow-empty) because
explicitly empty commits are sometimes useful.  It would seems to me that, while
it makes sense that rebasing cleaning empty commits by default is quite sane, it
would make good sense to add an allow-empty option to rebase to let them
survive.  I'm looking into adding that option now.

Regards
Neil
