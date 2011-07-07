From: Jeff King <peff@peff.net>
Subject: Re: generation numbers
Date: Thu, 7 Jul 2011 15:08:28 -0400
Message-ID: <20110707190828.GC12044@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <20110706065623.GB14164@elie>
 <20110706070311.GA3790@sigill.intra.peff.net>
 <m3mxgr4has.fsf_-_@localhost.localdomain>
 <20110706150103.GA2693@thunk.org>
 <20110706181200.GD17978@sigill.intra.peff.net>
 <7viprfhu4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 21:08:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QetwC-0003P2-O2
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 21:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab1GGTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 15:08:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52699
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1GGTIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 15:08:30 -0400
Received: (qmail 1645 invoked by uid 107); 7 Jul 2011 19:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 15:08:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 15:08:28 -0400
Content-Disposition: inline
In-Reply-To: <7viprfhu4w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176771>

On Wed, Jul 06, 2011 at 04:22:23PM -0700, Junio C Hamano wrote:

> As to the low level implementation detail I agree everything you said, but
> I have been wondering how the generation number should intereact with
> grafts and replaces. It certainly would be safest whenever you change
> grafts (which should be a rare event anyway).

Ugh. I hadn't even considered grafting. Yeah, grafting or replacing
could make the generation numbers totally wrong. And not just for the
replaced commit, but for everything that builds on top. That's perhaps
an argument against putting them into the commit header at all; once you
graft, everything after will have bogus generation numbers.

So yeah, you would want to clear the cache any time you tweak
replacements or grafts (which I think is what you were saying in your
final sentence).

You could do a hybrid solution, in which you have generation numbers in
the commit header, and an external cache. You need the cache anyway to
support older commits without the header. And then you could use the
built-in generation numbers when there's no grafting or replacing going
on, and the cache otherwise. That keeps the common case (no grafts)
faster.

Still, if we can get the external lookup to be faster than my initial
notes attempt (which really should not be that hard), the performance
difference may not end up that big, and it won't even be worth putting
them into the header at all.

-Peff
