From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 16:33:04 -0500
Message-ID: <20120227213304.GB19779@sigill.intra.peff.net>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
 <7vr4xg6pn2.fsf@alter.siamese.dyndns.org>
 <20120227211316.GA29081@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28C1-0005R8-GA
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab2B0VdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:33:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59069
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2B0VdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:33:06 -0500
Received: (qmail 32577 invoked by uid 107); 27 Feb 2012 21:33:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 16:33:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 16:33:04 -0500
Content-Disposition: inline
In-Reply-To: <20120227211316.GA29081@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191676>

On Mon, Feb 27, 2012 at 10:13:16PM +0100, Clemens Buchacher wrote:

> > Yes, that was certainly part of my pros-and-cons analysis.  If you run
> > "git fsck" without "--no-dangling" without reading the manual, you may
> > get confused, but that is *not* the primary audience.
> 
> It is not my only concern that users might be confused. I believe the
> command prints a lot of useless messages, which is by itself a UI
> deficiency. But even worse, those numerous messages tend to hide an
> actual problem in a long scrollback buffer. Sometimes my scrollback
> buffer is not even large enough and I have to re-run fsck (which is not
> exactly a fast command), just so I can grep out the dangling blobs.

Yeah, but doesn't adding "--no-dangling" solve that issue?

> > People who are curious can read the manual and figure it out, and the
> > need for "fsck" is much rarer these days, compared to 2005 ;-)
> 
> In my opinion, the need for fsck is much more common these days. With
> the alternates feature, it happens all the time that a repository breaks
> if one is not extremely careful.

Interesting. I can't remember the last time I ran fsck. But I am not the
only git user, and my assumptions are only based on my own experience,
not other data.

> > In that context, only large downsides of potentially breaking and having
> > to adjust existing scripts remains without much upsides, if we were to
> > switch the default.
> 
> There is something wrong with weighting a UI improvement against
> convenient use in scripts. If that were the issue, then we should add a
> plumbing version for all commands, like we do for git status
> --porcelain. Otherwise we can never change anything any more.

I don't think it's convenience as much as scripts which try to detect
dangling by using "git fsck" will now be broken with a really bad
failure mode (i.e., they used to run "git fsck" and parse the dangling
lines on stderr, but now they will erroneously think that nothing is
dangling!).

If we really care about that, then the right answer is our usual:

  1. Introduce --dangling/--no-dangling, leaving the default.

  2. Wait a while until the features are well-established.

  3. Scripts adapt to use --dangling if they want it.

  4. Wait a while for scripts to be updated.

  5. Flip the default to --no-dangling.

I wrote but didn't send in my last email a long analysis of why it is
wrong to combine fsck's default mode of operation (which is really about
"is this repository corrupted or broken") with checking for dangling
objects (which is something you do when you are looking for lost work).
But I don't think that is even really up for debate. If we were
designing fsck from scratch, I think everybody in the thread has the
feeling that reporting dangling by default is wrong. And we should
definitely add "--no-dangling" to address that.

But flipping the default is a different story, and that has to weigh the
potential breakage above versus having a good UI. I'm on the fence about
whether the above is a big enough problem to care about (mostly because
I'm not sure anybody has actually written such a script).

-Peff
