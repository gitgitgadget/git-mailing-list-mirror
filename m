From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 13:27:48 -0400
Message-ID: <20130410172748.GA16908@sigill.intra.peff.net>
References: <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPyoT-0001TZ-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216Ab3DJR14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 13:27:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38902 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964866Ab3DJR1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:27:55 -0400
Received: (qmail 4274 invoked by uid 107); 10 Apr 2013 17:29:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 13:29:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 13:27:48 -0400
Content-Disposition: inline
In-Reply-To: <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220707>

On Wed, Apr 10, 2013 at 09:37:01AM -0700, Junio C Hamano wrote:

> > The missing case 4 is obviously:
> >
> >   dst=missing, refs=present
> > ...
> > Do you want to explain your thinking? I'm guessing it has to do with the
> > fact that choosing branch.*.remote is about trying to push to the
> > configured upstream (even though we traditionally do _not_ take into
> > account branch.*.merge when doing so).
> 
> With the branch.$name.remote, the user tells us "When I am on this
> branch, I want to talk to this remote".  When you did
> 
> 	git push -- master next ;# case #4
> 
> on branch maint, branch.maint.remote should not come into play.

I understand that's your position, but I don't understand _why_.

If branch.$name.remote is "when I am on this branch, I want to talk to
this remote", that rule is not be impacted by the presence of refspecs
at all.

If it meant "when I am on this branch, and I do not specify any
refspecs, then I would by default want to push this branch to that
remote", then your proposed behavior would make more sense. And if you
are using push.default=upstream, that is what happens.

But historically the default push has been "matching". So in your other
examples:

> Would we want to push our 'master' to branch.master.remote in a way 
> 
> 	git checkout master && git push
> 
> would do, while at the same time because we were told to do the same
> for 'next', we do the same as
> 
> 	git checkout next && git push

These do not have anything to do with pushing the checked-out branch in
particular. The first one may very well be pushing "next" to the remote
specified by branch.master.remote.

So I would argue that one of these two makes sense:

  1. branch.*.remote means "use this as the default remote on this
     branch, no matte which refs we are pushing"

  2. branch.*.remote is not respected at all for remote selection with
     "matching". It is used only when combined with branch.*.merge,
     which means that only the "upstream" mode would use it.

I advocated (1) in my previous message, but I would also be OK with (2),
even though it is a change from the current behavior. But what you are
suggesting seems like an inconsistent mix of the two.

> would do?  That would work if you give just branch names, but that
> is not a general enough definition to cover your case #4, e.g.
> 
> 	git push -- v1.2.3 master:refs/remotes/mothership/master
> 
> If we define case #4 to push to the remote.pushdefault (falling back
> to remote.default), this case would do what can simply be expected;
> if the earlier cases also push to that same place, ignoring
> branch.$name.remote for master and next, that would be consistent.

So I think what you are getting at is that branch.*.remote is about
saying "when we push X, it goes to remote Y". And with v1.2.3, we
obviously cannot have such a hint, because it is not a branch. But my
point is that is _not_ how it works today.  So if you want consistency,
we would also need to adjust how branch.*.remote interacts with
"matching".

-Peff
