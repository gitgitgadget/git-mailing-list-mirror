From: Jeff King <peff@peff.net>
Subject: Re: Suggestion on hashing
Date: Fri, 2 Dec 2011 12:54:44 -0500
Message-ID: <20111202175444.GB24093@sigill.intra.peff.net>
References: <1322813319.4340.109.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Bill Zaumen <bill.zaumen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:54:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWXJz-00033l-DG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab1LBRyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 12:54:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39070
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab1LBRyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:54:46 -0500
Received: (qmail 8616 invoked by uid 107); 2 Dec 2011 18:01:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 13:01:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 12:54:44 -0500
Content-Disposition: inline
In-Reply-To: <1322813319.4340.109.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186234>

On Fri, Dec 02, 2011 at 12:08:39AM -0800, Bill Zaumen wrote:

> At one point Nguyen said that "What I'm thinking is whether it's
> possible to decouple two sha-1 roles in git, as object identifier
> and digest, separately. Each sha-1 identifies an object and an extra
> set of digests on the "same" object."
> 
> My code pretty much does that (it just uses a CRC instead of a real
> digest, but I can easily change that).   So the question is whether
> using SHA-1 as an ID and SHA-256(?) as a digest is a better long term
> solution than simply replacing SHA-1.

I think your code is solving the wrong problem (or solving the right
problem in a half-way manner). The only things that make sense to me
are:

  1. Do nothing. SHA-1 is probably not broken yet, even by the NSA, and
     even if it is, an attack is extremely expensive to mount. This may
     change in the future, of course, but it will probably stay
     expensive for a while.

  2. Decouple the object identifier and digest roles, but insert the
     digest into newly created objects, so it can be part of the
     signature chain. I described such a scheme in one of my replies to
     you. It has some complexities, but has the bonus that we can build
     directly on older history, preserving its sha1s.

  3. Replace SHA-1 with a more secure algorithm.

I'm probably in favor of (1) at this point. Whether to do (2) or (3)
will depend on where we are when SHA-1 gets feasibly broken. It may be
many years away, at which point we may be considering a git 2.0 that
breaks repository compatibility, anyway. That would be a natural time to
consider changing the algorithm.

> Replacing SHA-1 with something like SHA-256 sounds easier to implement,
> but the problem is all the existing repositories.

Right. I don't think anyone is denying that it would be a giant pain.

-Peff
