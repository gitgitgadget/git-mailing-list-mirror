From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Thu, 23 May 2013 14:37:59 -0400
Message-ID: <20130523183759.GB1275@thunk.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se>
 <20130522134212.GB13731@poseidon.cudanet.local>
 <20130522144531.GB2777@thunk.org>
 <7v8v36kiau.fsf@alter.siamese.dyndns.org>
 <20130522180403.GB20848@thunk.org>
 <7vvc6aj14r.fsf@alter.siamese.dyndns.org>
 <20130523021123.GA23155@thunk.org>
 <CALkWK0kyRno4eMYHXC3RkJFCVZ6DJWgFX=pR+WCu8=Gaf9q=Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 20:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfaP7-00087b-EU
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142Ab3EWSiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 14:38:16 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:51267 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028Ab3EWSiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:38:15 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UfaRW-0007c2-30; Thu, 23 May 2013 18:40:50 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 031CF5814B2; Thu, 23 May 2013 14:37:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kyRno4eMYHXC3RkJFCVZ6DJWgFX=pR+WCu8=Gaf9q=Mw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225281>

On Thu, May 23, 2013 at 03:22:50PM +0530, Ramkumar Ramachandra wrote:
> Theodore Ts'o wrote:
> > Right now I do this just by being careful, but if there was an
> > automatic safety mechanism, it would save me a bit of work, since
> > otherwise I might not catch my mistake until I do the "git push
> > publish", at which point I curse and then start consulting the reflog
> > to back the state of my tree out, and then reapplying the work I had
> > to the right tree.
> 
> My scenario is a bit different, and I think this safety feature is
> highly overrated.  It's not that "I'll never rewind some branches, but
> rewind other branches", but rather "I might rewind anything at any
> time, but I want immediate information so I can quickly inspect @{1}
> to see if that was undesirable".

Spekaing of which, what I'd really appreciate is timestamps associated
with the reflog.  That's because the most common time when I've
screwed something up is after doing a "git rebase -i" and so the
reflog has a *huge* number of entries on it, and figuring out which
entry in the reflog is the right one is painful.  If could tell at a
glance when each entry of the reflog was created, it would make it a
lot easier to untangle a tree mangled by git rebase -i.

In practice, it means I waste five minutes carefully inspecting a few
dozen entries on the reflog, so it's not a disaster, although I'm
generally cursing the whole time while I'm trying to untangle the
whole mess.

This issue with reflogs not having timestamps isn't primarily about
rewind safety, BTW; it's just one of the things which make consulting
the reflog painful --- and it's much more likely happens after I screw
up a git rebase -i, generally because of what happens when there's a
merge conflict and then I accidentally fold two commits together
unintentionally.  The times when I've screwed up a non-rewinding
branch and then needed to recover after discovering the problem when I
try to publish said branch are admittedly rare; maybe once or twice
times in the past twelve months.

> So, do you still need this rewinding safety thing?

Meh; I don't *need* it.  But then again, I'm an fairly experienced git
user.  The fact that I use guilt without the "guilt/master" safety
feature and have never gotten bitten by it --- in fact I deliberately
publish rewindable branches with a guilt patch series applies speaks
to the fact that I'm pretty experienced at rewindable heads.

The only reason why I suggested it is because I believe it would be
useful for people with less experience, and perhaps it would help make
rewindable branches less scary, and less subject to a lot of the
fearmongering that you see on the blogosphere.

> 
> > So what I do is something like this:
> >
> > git push publish ; git push repo ; git push code
> 
> While we can definitely make the UI better for this (maybe push
> --multiple?), there is no fundamental change: we have to re-initialize
> all the refspecs, connect to the remote via the transport layer and
> prepare a packfile to send.  In other words, it's impossible to make
> it any faster than what you get with the above.

Sure, and if I cared I'd make a git alias to automate this, instead of
depending on finger macros.

> So you're a batched-push person.  And the above makes it clear that
> you don't want to explicitly differentiate between a push and push -f
> (the +pu thing).  And this assumes that you never create any new
> branches (I branch out all the time), otherwise you'd have rules for
> refs/heads/*.

I create new branches all the time.  But they are for my own personal
testing purposes.  So it's fairer to say that I rarely *publish* new
branches; I generally stick to the standard set of next, master,
maint, and pu.  And part of that is that even publishing this number
of branches is enough to sometimes confuse the e2fsprogs developers
who are pulling from my tree.

So what I've done in the past is to create a whole bunch of feature
branches, and then merge them into the pu branch, and then only
publish the pu branch.  And I try to get the feature branches cleaned
up as quickly as I have time, so they can appear on the maint or
master/next branches sooner rather than later.

> Just out of curiosity, do you ever have ref-renaming
> requirements (like push = refs/heads/*:refs/heads/tt/*)?  We were
> discussing that on another thread, but I haven't found an
> implementation I'm happy with yet.

In general, no, I don't do that, for the reasons stated above --- even
publishing four branches gets to be confusing enough for people who
are looking at my tree.

I'm sure other people and other communities use git differently, so
please insert the standard disclaimer that there's more than one way
to skin a cat.

Regards,

						- Ted
