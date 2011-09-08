From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 8 Sep 2011 15:35:55 -0400
Message-ID: <20110908193555.GC16064@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:36:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1o8g-0004S5-DW
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab1IHXgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:36:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46836
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab1IHXgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:36:01 -0400
Received: (qmail 16411 invoked by uid 107); 8 Sep 2011 19:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 15:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 15:35:55 -0400
Content-Disposition: inline
In-Reply-To: <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181006>

On Wed, Sep 07, 2011 at 01:57:27PM -0700, Junio C Hamano wrote:

> If a tag is GPG-signed, and if you trust the cryptographic robustness of
> the SHA-1 and GPG, you can guarantee that all the history leading to the
> signed commit is not tampered with. However, it would be both cumbersome
> and cluttering to sign each and every commit. Especially if you strive to
> keep your history clean by tweaking, rewriting and polishing your commits
> before pushing the resulting history out, many commits you will create
> locally end up not mattering at all, and it is a waste of time to sign
> them.
> 
> A better alternative could be to sign a "push certificate" (for the lack
> of better name) every time you push, asserting that what commits you are
> pushing to update which refs. The basic workflow goes like this:

I think this is the right direction, but I was a little turned off by
the idea that it needs a protocol extension. As I see it, there are two
ways to care about the contents of a push certificate:

  1. The server might care, because it only wants to accept pushes that
     are accompanied by a certificate matching a certain key.

  2. A client fetching from the server might care, because they want the
     integrity and authenticity of the data to be ensured by the gpg key
     of the pusher, not by trusting the server.

I think (1) is actually not all that interesting. The server already has
credentials for each user via ssh or http. So it knows who each pusher
is already. It can't relay that information cryptographically to a
client who fetches later, of course, but we are just talking about
whether or not to accept the push at this moment.

But if you really did want to do that, it seems like a pre-receive hook
would be sufficient.

For (2), you don't want to trust the server, so the user's
authentication to the server isn't enough. You want a cryptographic
chain leading back to the original pusher. But the server doesn't
actually need to see or understand that cryptographic chain for this
purpose. If it were stored in a notes-tree or other format pointed to by
a ref, then a client could pull down those notes and do the verification
themselves.

Which means you can start using this immediately, without having to care
about whether your hosting provider supports it or not (or even whether
your provider supports the git protocol. Such a system would Just Work
across dumb http, local clones, sneakernet bundles, etc).

The only issue I foresee is one of atomicity. IIRC, we never have a
whole-repo lock during push, so it's possible that a client might
succeed in pushing the ref with the certificate, but fail at one or more
refs that the certificate mentions. And maybe a protocol extension is
required for that. You've looked much more closely at this than I have,
so maybe you already considered something simpler.

-Peff
