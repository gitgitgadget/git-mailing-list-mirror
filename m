From: Jeff King <peff@peff.net>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 15:33:59 -0400
Message-ID: <20120726193359.GA28711@sigill.intra.peff.net>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
 <20120726171256.GC13942@sigill.intra.peff.net>
 <7v8ve672ar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTpQ-0001XT-6F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab2GZTeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:34:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37525 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516Ab2GZTeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:34:01 -0400
Received: (qmail 12619 invoked by uid 107); 26 Jul 2012 19:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 15:34:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 15:33:59 -0400
Content-Disposition: inline
In-Reply-To: <7v8ve672ar.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202296>

On Thu, Jul 26, 2012 at 12:25:16PM -0700, Junio C Hamano wrote:

> There are three cases with respect to ident:
> 
>  - There is a user-configured one;
> 
>  - We derive one from the system and that is syntactically correct,
>    but we know from the past experience the system is often
>    misconfigured.
> 
>  - We derive one from the system and that is empty.

Yes, modulo s/empty/bogus in some way/ in the last one (e.g., we will
complain about both empty names and bogus hostnames).

> Before your tightening commit, the latter two cases were treated the
> same way and gave the reminder to the user.  After the tightening,
> these were separated into two and give different results.

Sort of. They were _not_ treated the same in the long run, as the second
one is OK, but the third case would eventually fail. It is only that
they were treated the same for the first half of git-commit running,
meaning it got as far as running the editor.

The problem is that the test relied on git-commit reaching a certain
point before failing in case 3. But that is a bad assumption of the
test, and one that actively hurts users (who would rather git fail
early).

> Perhaps the tightening was not such a good idea in the first place?
> The user would have seen a bad committer ident in the log editing
> session without the new code anyway, so perhaps we should have added
> a messasge e.g. "Abort the editor session and do not edit further;
> fix your ident first--this commit will fail anyway" there, or
> something?

We could do that, but why? We _know_ it's going to fail, so why not just
fail?

> The second case can lead to commits that the user may have to redo
> with filter-branch, as the command does not even error out.

Sure. And that's why we show the committer at all. In other words, we
have three levels of confidence with three outcomes:

  1. The user definitely told us who they are. Proceed without warning.

  2. We guessed who the user is, and we have reasonable confidence that
     it is right. Proceed, but warn.

  3. We guessed who the user is, but we know that it is syntactically
     bad. Do not proceed.

That has always been the behavior, and was not changed by the recent
tightening. Only _when_ we stopped proceeding changed, and that is not
something I think this test should care about.

> And we do want to make sure that the user is given a chance to verify
> that the commit will carry a name that the user is happy with with
> this test.  I think that is far more important than a user on a system
> with broken GECOS field has to run the editor twice.

Yes, and they are given that chance. This is not about the behavior of
git, but about stupid assumptions by the test.

I'm close to finished with a series that I think will at least make it
better. Stay tuned.

-Peff
