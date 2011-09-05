From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Mon, 5 Sep 2011 16:47:29 -0400
Message-ID: <20110905204729.GB4221@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0g7k-0003oU-Lh
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab1IEUrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:47:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab1IEUrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:47:31 -0400
Received: (qmail 20612 invoked by uid 107); 5 Sep 2011 20:48:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Sep 2011 16:48:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2011 16:47:29 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180760>

On Mon, Sep 05, 2011 at 11:15:26AM -0700, Shawn O. Pearce wrote:

> > One possible solution is that the local config could dynamically depend
> > on the remote config. E.g., the fetch refspec has something like a
> [...]
> 
> What are we trying to do here?

We veered way off topic into the idea of generally pulling config from a
remote. This was just one specific example of how it could be used, and
what kinds of complications that might entail.

> If the attacker knows Git clients always fetch rewinds, he might be
> tempted to rewrite some part of history and serve his modified history
> of events to clients. But the repository owner (if using a private
> per-user repository model like the Linux kernel developers use) would
> notice on their next push, and sound the alarm that her repository has
> been damaged and should not be trusted.
> 
> If on the other hand Git clients never fetch rewinds, the attacker
> would just add a new commit to the tip of the history, and serve that.
> Again, the repository owner would notice on their next push, and
> notify people the repository is not to be trusted.
> 
> Either way, the "+" in the fetch spec has no impact on the attack. The
> default just changes the attacker's choices slightly.

Exactly. This is what I was hinting at in my original email in this
thread. My gut feeling is that it's not useful as a security measure,
but I was trying to challenge people to prove me wrong by showing a case
where the attacker can't just trivially modify his attack to get the
same result.

> Maybe instead of getting a project policy from the server, we observe
> the server's behavior over time from the client's reflog. If every
> update to "maint" that _I_ have observed has always been a
> fast-forward, a rewind on that branch should be a lot more verbose in
> the fetch output than "force update". That is pretty easy to observe
> from the reflog too, its just a scan of the records and either
> matching the message, or checking the merge status of the old-new
> pairs listed in the record. We don't even need to read the entire log
> on every fetch, we could cache this data.

Hmm. That would probably work most of the time in practice. But it seems
like it would be quite confusing when the heuristic is wrong (e.g.,
Junio rewinds next once every few months, and other than that, it always
fast forwards). On the other hand, if the failure mode of the heuristic
is only a slightly bigger warning, then it's not that big a deal.

> The main reason to alert the user that a branch rewound is to give
> them a chance to correct their client if they need to. If a branch
> normally doesn't rewind (e.g. next) but then suddenly does (e.g.
> release cycle), but I haven't used this client in 3 weeks, its nice to
> give me more of a "HEY STUPID FIX YOUR TOPICS" warning than just the
> little quiet "force update" we give.

Sure. I'm totally open to the idea of making the non-fast-forward
warning more obvious. Suggestions for wording (though I am tempted by
"HEY STUPID" above ;) )?

-Peff
