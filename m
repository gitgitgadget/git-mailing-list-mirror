From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Tue, 24 May 2011 16:27:23 -0400
Message-ID: <20110524202723.GG584@sigill.intra.peff.net>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
 <7vzkmc6n1s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 22:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOyCR-0001IT-CW
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 22:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821Ab1EXU10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 16:27:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50777
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab1EXU1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 16:27:25 -0400
Received: (qmail 21380 invoked by uid 107); 24 May 2011 20:27:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 16:27:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 16:27:23 -0400
Content-Disposition: inline
In-Reply-To: <7vzkmc6n1s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174340>

On Tue, May 24, 2011 at 10:11:43AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hopefully the above made sense, but to be clear, what I think we should
> > do is:
> >
> >   1. Suppress the "If you want to keep it..." advice on exit with the
> >      existing advice.detachedhead.
> >
> >   2. Optionally, if anybody cares (and I don't), introduce
> >      advice.detachedOrphanCheck to suppress the check entirely.
> >
> >   3. Optionally remove "Previous HEAD position" in the non-orphan case.
> >      I think it's superfluous, but it's so short that I don't really
> >      care either way.
> 
> I think the above makes sense (sorry for replying a three-week old thread,
> but I am trying to rid as many topics as I can from the Stalled category),

No problem. I have an embarrassing number of stalled topics myself.

> except that #3. might be useful after manually bisecting the existing
> history.  You may not be losing any commit (all are connected), but you
> would be losing the point you have spent efforts to locate by switching
> out.

Yeah, I thought of the "you have found this point via some work" as
something valuable but dismissed it because I couldn't think of a good
example.  But bisection is one such example.

> I also think #2 would not be necessary; scripts that know what they are
> doing should be using -q to suppress output from checkout anyway, and the
> check is disabled in that case.

Ah, I didn't realize that "-q" would suppress it, but yes, that makes
perfect sense.

> So on top of 8e2dc6a (commit: give final warning when reattaching HEAD to
> leave commits behind, 2011-02-18), here is a re-roll.

The output looks good to me. I have an almost-complaint, though. I
applied on top of 8e2dc6a and did a quick test. It is actually quite bad
there, because you get:

  Warning: you are leaving 1 commit behind, not connected to
  any of your branches:

    - some subject

and nothing actually tells you the sha1 of the thing you are losing. :)

However, once it is merged into master, you will get:

     abcd1234 some subject

which is more helpful. Not a big deal, as that merge should happen
before release. But you may want to just apply on top of my 0be240c
(checkout: tweak detached-orphan warning format, 2011-03-20).

> @@ -668,8 +671,6 @@ static void orphaned_commit_warning(struct commit *commit)
>  		die("internal error in revision walk");
>  	if (!(commit->object.flags & UNINTERESTING))
>  		suggest_reattach(commit, &revs);
> -	else
> -		describe_detached_head("Previous HEAD position was", commit);
>  }

Wait, I thought we were keeping this, per your argument above?

-Peff
