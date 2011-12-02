From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Fri, 2 Dec 2011 12:00:40 -0500
Message-ID: <20111202170040.GA23447@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <1322603788.1728.190.camel@yos>
 <20111130062512.GA5317@sigill.intra.peff.net>
 <1322700075.1710.157.camel@yos>
 <20111201052615.GA22141@sigill.intra.peff.net>
 <1322794744.1673.494.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:00:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWWTf-00029O-S1
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab1LBRAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 12:00:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39022
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884Ab1LBRAn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:00:43 -0500
Received: (qmail 8216 invoked by uid 107); 2 Dec 2011 17:07:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 12:07:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 12:00:41 -0500
Content-Disposition: inline
In-Reply-To: <1322794744.1673.494.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186229>

On Thu, Dec 01, 2011 at 06:59:04PM -0800, Bill Zaumen wrote:

> > What about the server being more clever about hiding the replacement
> > object? E.g., instead of just breaking into kernel.org and inserting a
> > replacement object, the attacker runs a malicious git-daemon that
> > returns the bogus object to cloners, but the real object to fetchers.
> 
> That's really a server-security issue, not a git one.  Perhaps
> repositories should be configured so that all the executables are on
> read-only partitions.  It's an important question in general of
> course, but it is probably useful to distinguish attacks that put
> bad data on a server from ones that install new software.

I don't agree here. You have to assume that the attacker will ignore
attacks you have blocked, but continue with ones you haven't (just to
counter your example, why not replace the running git-daemon
in-memory?).

You can target the narrow window of attacks that compromise the on-disk
repository without being able to execute arbitrary code. But I don't see
a point. After the kernel.org hack, yes, people are interested in
hardening kernel.org. But they are much more interested in cryptographic
sources of authority that let us not have to trust kernel.org at all.
Having some weird half-way trust just complicates things.

> > But we can already do that. Assume you have an existing repo "foo". To
> > verify the copy at git://example.com/foo.git, do a fresh clone to
> > "bar", and then compare the objects in "foo" to "bar", either byte-wise
> > or by digest.
> 
> Of course, but that is an expensive operation - in the case of Git
> transferring some 50 MBytes of data per repository.  A command to
> fetch the SHA-1 ID and a CRC or message digest for each object would
> not only run faster, but should put a much lower load on the server.

Yes, it is more expensive. But again, my threat model is that the server
is not trusted to serve data accurately or consistently. So you can't
come to the server and say "Hey, I'm doing a security verification. Can
you send me the CRCs?" You _have_ to present yourself as one of the
victims to be infected by the bad object, or a smart attacker will send
you the unmodified data.

> Getting back to the birthday attack question (this is an area where
> your comments were very useful for me), there's a case I didn't
> consider.
> [elaborate birthday attack scenario]

>From my quick reading of your scenario, yes, that is a possible attack.
To me, though, it just highlights the need for either a non-colliding
algorithm, or for better trust verification about the authors of objects
(i.e., cryptographically strong trust).

-Peff
