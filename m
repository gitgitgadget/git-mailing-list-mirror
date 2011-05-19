From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Thu, 19 May 2011 07:02:59 -0400
Message-ID: <20110519110259.GA11507@sigill.intra.peff.net>
References: <20110517071232.GA19396@mrq1.org>
 <4DD390AF.9020705@drmicha.warpmail.net>
 <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
 <201105191216.51709.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 19 13:03:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN10X-00065K-Hs
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 13:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab1ESLDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 07:03:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab1ESLDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 07:03:02 -0400
Received: (qmail 14798 invoked by uid 107); 19 May 2011 11:05:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 07:05:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 07:02:59 -0400
Content-Disposition: inline
In-Reply-To: <201105191216.51709.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173949>

On Thu, May 19, 2011 at 12:16:51PM +0200, Thomas Rast wrote:

> Junio C Hamano wrote:
> > 
> > I think "single-key" was a poorly designed attempt to improve productivity
> > the ("y" <RET>)*5 into "y"*5
> 
> Actually for me it more often is
> 
>   y RET n RET *think* y RET s RET n RET ...

Yeah. I personally find the concept of "5y" crazy; how do you know that
it is 5, and not 4 or 6, if you haven't yet seen them?

But that just means I don't have any use for it; I don't have a real
objection to it.

> After my little accident I'm also considering an (optional?) safety
> question at the end when in checkout -p mode, since it's inherently
> destructive.  Of course that first requires changing the whole
> operation to be atomic.

I think a confirmation question is a bad idea. It helps with
fat-fingering, but not much else. 99% of the time you will say "yes",
because of course you just looked through the changes and want to
finalize them. So you will start to hit "y" without looking or thinking,
and it becomes a mere annoyance, until the time you _do_ actually lose
some data by hitting "y" without thinking.

At least that's what would happen to me. :)

I think a much better safety valve is to store the user's worktree state
that we are about to destroy. Then when they accidentally erase
something, whether they realize it immediately, or even 5 minutes later,
it is recoverable. And in the common case where everything goes well,
they needn't be bothered at all.

This fits much better with other git recovery mechanisms, too, which
tend to be one of:

  1. Store the previous state, and optionally instruct the user on how
     to recover in the case of error (e.g., reflogs, the new orphan
     checkout warning).

  2. Force the user to give confirmation (e.g., "branch -D"), but _only_
     if we have detected some abnormally dangerous situation (e.g., you
     are deleting a branch that hasn't been merged anywhere). The user
     is more likely to pay attention and think about the confirmation
     because we _don't_ ask every time, and because we are giving them
     additional information that will help in making the decision.

-Peff
