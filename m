From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Date: Wed, 6 Jul 2011 03:03:11 -0400
Message-ID: <20110706070311.GA3790@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <20110706065623.GB14164@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeM8k-00025C-Vd
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab1GFHDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:03:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50815
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab1GFHDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:03:13 -0400
Received: (qmail 16498 invoked by uid 107); 6 Jul 2011 07:03:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 03:03:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 03:03:11 -0400
Content-Disposition: inline
In-Reply-To: <20110706065623.GB14164@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176644>

On Wed, Jul 06, 2011 at 01:56:23AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > The problem is that existing objects don't have this generation number.
> > It's easy to calculate, though, and we could in theory use a notes-cache
> > to store it externally. Obviously the complexity and performance aren't
> > going to be as good as if it were just in the commit object, but we're
> > sadly 6 years too late to make that decision.
> 
> I am still digesting the rest of what you wrote, but wouldn't this be
> easy to do today?  One could just use a notes-cache while prototyping
> and if it seems to work well, introduce new loose and packed object
> formats that include a field for the cached generation number.

Yes, that's exactly how to do it. I'm just not sure "introduce new loose
and packed object formats" is "easy to do". Though I'm not sure we need
new formats. It is really just a new header in the commit object. And if
we write the code carefully, we should be able to transparently use
newly-generated objects with the field, and fall back to a notes-cache
(with autogeneration) when it isn't there.

Existing git will ignore the new generation field. It does mean that old
and new git will generate different sha1s for the exact same commit. I
don't know how big a deal this is in practice. It matters a lot more for
blobs and trees. But for commits, even if you are replaying a commit,
you should be updating the commit timestamp, which is going to give a
new sha1.

The other thing I worry about is performance. You are building a full
notes tree and looking up every commit in the traversal. I don't know
how bad that will be (though from my other back-of-the-envelope tests,
it may not actually be that bad; notes were designed to be fast for
exactly this case).

-Peff
