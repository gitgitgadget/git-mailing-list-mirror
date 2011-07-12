From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 15:45:40 -0400
Message-ID: <20110712194540.GA21180@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgitv-0004u9-Ab
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab1GLTpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:45:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55054
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179Ab1GLTpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:45:42 -0400
Received: (qmail 16580 invoked by uid 107); 12 Jul 2011 19:46:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 15:46:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 15:45:40 -0400
Content-Disposition: inline
In-Reply-To: <20110712193844.GA17322@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176973>

On Tue, Jul 12, 2011 at 09:38:44PM +0200, Clemens Buchacher wrote:

> > I'm not sure there's a general solution to that. You can't keep the
> > commit you want intact, because you are rebasing and therefore building
> > on top of the other broken commit. So in a history like:
> > 
> >     B'--C'
> >    /
> >   A--B--C
> > 
> > You really want to perform the transformation of B to B', but on top of
> > C (i.e., "git checkout C; git diff B' B | git apply"). But if B and C
> > are textually related, it's going to conflict horribly. And I don't
> > think there is a general solution short of a darcs-style patch algebra.
> 
> FWIW, I tried this in darcs and it has exactly the same problem.

It has been a long time since I've looked at darcs, but from my
recollection, it will only work with specific patch types. That is, it
works if B and C are commutative. For text patches that touch the same
area, that is not the case. But if "B" were a token-renaming patch, for
example, I think it might work.

Anyway, that is not really relevant to git. I think we decided long ago
that being simple and stupid about the content changes (i.e., blob A
became blob B) is better in general, even when there are a few corner
cases that might have been better off the other way.

> It does have better granularity when detecting changes. For
> example, it will recognize the changes of B' in B, even if B
> contains non-conflicting hunks on top of the changes in B'. Git
> only recognizes identical commits, and this is something where we
> could improve without too much difficulty (think per-hunk
> patch-ids).

I'd be curious to see an example worked out. In my experience, even if
something like patch-ids don't match, it's not a big deal for the hunks
that do match, because when we get to the actual content merge, we will
realize that both sides made the same change to that hunk.  So it's not
like you are getting unrelated conflicts; whatever small part of the
diff made the patch-id different will be the part where you get the
conflict, and the should merge cleanly.

Having said something so general, I'm sure there is probably some corner
case that proves me wrong.

-Peff
