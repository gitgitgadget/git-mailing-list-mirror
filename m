From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sun, 17 Mar 2013 01:40:39 -0400
Message-ID: <20130317054039.GA16070@sigill.intra.peff.net>
References: <20130316102428.GA29358@sigill.intra.peff.net>
 <7v7gl6txl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:41:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6LE-0001Ro-O9
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab3CQFkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 01:40:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3CQFkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 01:40:42 -0400
Received: (qmail 6867 invoked by uid 107); 17 Mar 2013 05:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 01:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 01:40:39 -0400
Content-Disposition: inline
In-Reply-To: <7v7gl6txl3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218333>

On Sat, Mar 16, 2013 at 10:16:40PM -0700, Junio C Hamano wrote:

> > ... (I had several bug reports
> > within a few hours of deploying v1.8.1.5 on github.com)
> 
> Nice to have a pro at the widely used site ;-)  I often wish it had
> a mechanism to deploy the tip of 'master' or 'maint', or even 'next'
> for 0.2% of its users' repositories to give us an early feedback.

We are quite slow and conservative at deploying new git, preferring
instead to let the rest of the world act as our testbed. :)

As seen with this bug, though, we really do get a lot more coverage of
weird cases due to our size. In the cases I looked at, the trigger
seemed to be clients doing the equivalent of of "git clone --depth=X
--no-single-branch". Almost nobody would do that intentionally, but
prior to v1.7.10, we did not have --single-branch; older clients using
--depth on a repository with multiple branches started failing clones
almost immediately.

We do have the capability to roll out to one or a few of our servers
(the granularity is not 0.2%, but it is still small). I'm going to try
to keep us more in sync with upstream git, but I don't know if I will
get to the point of ever deploying "master" or "next", even for a small
portion of the population. We are accumulating more hacks[1] on top of
git, so it is not just "run master for an hour on this server"; I have
to actually merge our fork.

I had been handling our hacks as patch series to be rebased on top of
upstream git releases, but that was getting increasingly unwieldy
(especially as people besides me work on it). Going forward, I'm going
to treat upstream git as a vendor branch and merge in occasionally to
get fixes.

One thing I might try is to keep a local "next-upstream" branch, that is
continually merging what is on upstream master with our local production
version. Then I could graduate it to production just like any other
topic branch when it comes time (instead of doing a gigantic painful
merge when we decide to upgrade upstream git).

That would mean I could test-deploy the "next-upstream" branch to a few
servers on any given day without doing a lot of work. So it might make
sense to do it at key times, like when we are in -rc here, to help shake
out any existing bugs before you make a release.

> >   [3/3]: upload-pack: load non-tip "want" objects from disk
> >
> >     While investigating the bug, I found some weirdness around the
> >     stateless-rpc check_non_tip code. As far as I can tell, that code
> >     never actually gets triggered. It's not too surprising that we
> >     wouldn't have noticed, because it is about falling back due to a
> >     race condition. But please sanity check my explanation and patch.
> 
> Thanks. That fall-back is Shawn's doing and I suspect that nobody is
> exercising the codepath (he isn't).

I almost wonder if we should cut it out entirely. It is definitely a
possible race condition, but I wonder if anybody actually hits it in
practice (and if they do, the consequence is that the fetch fails and
needs to be retried). As far as I can tell, the code path has never
actually been followed, and I do not recall ever seeing a bug report or
complaint about it (though perhaps it happened once, which spurred the
initial development?).

-Peff
