From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Wed, 12 Oct 2011 16:14:10 -0400
Message-ID: <20111012201410.GB1502@sigill.intra.peff.net>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20111004103056.GB11236@sigill.intra.peff.net>
 <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
 <201110050034.46334.chriscool@tuxfamily.org>
 <7v62k4ban7.fsf@alter.siamese.dyndns.org>
 <CAH5451kUf=vPfgOOusmJjfbiyueX9VByJLzZ9WbyqLd0z78wxA@mail.gmail.com>
 <7vr52ibydy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE5By-0002Q9-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 22:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1JLUOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 16:14:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58805
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab1JLUON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 16:14:13 -0400
Received: (qmail 16272 invoked by uid 107); 12 Oct 2011 20:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 16:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 16:14:10 -0400
Content-Disposition: inline
In-Reply-To: <7vr52ibydy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183410>

On Tue, Oct 11, 2011 at 09:57:13PM -0700, Junio C Hamano wrote:

> With an obvious addition of non-interactive short-cut subcommands "git
> bisect yes" and "git bisect no", I think --removed= is a much better
> wording than --used-to= I suggested in the discussion.

Agreed.

> I however am still worried about the flipping of the mapping between
> <good,bad> and <yes,no> this design requires. What are we going to do to
> the labels of low-level machinery (i.e $GIT_DIR/refs/bisect/bad and
> $GIT/refs/bisect/good)? They appear in "bisect visualize" and I was hoping
> that it would be simpler in the code if we do not have to change them in
> such a way that depends on this introduced/removed switch, and that was
> the reason why I was trying to see if we can solve this without the
> switchable mapping between <good,bad> and <yes,no>.

Hmm. I hadn't thought about the labels. In a yes/no situation, though,
couldn't you use the labels as the user sees them?

Then it is simply a matter of flipping yes/no inside the bisect script
whenever we interact with the user (i.e., "git bisect yes") or when we
interact with the on-disk labels.

Certainly it's more complex than not allowing reversing, though.

> More specifically, I was hoping that we can rename "good" to "old" and
> "bad" to "new" unconditionally and be done with it. We would ask the user
> "What did the code used to do in the olden days?" and "Does this version
> behave the same as it used to?". The possible answers the user can give
> are "git bisect old" (it behaves the same as the older versions) and "git
> bisect new" (it behaves the same as the newer versions). Then we do not
> have to worry about having to flip the meaning of <yes> and <no> at the UI
> level.

Hmm. I think this is not quite as nice, but it is way simpler. It may be
worth trying for a bit to see how people like it. If they don't, the
cost of failure is that we have to maintain "old/new" forever, even
after we implement a yes/no reversible scheme. But maintaining the
old/new mapping from yes/no would not be any harder than the good/bad
mapping, which we would need to do anyway.

So it sounds like a reasonable first step.

-Peff
