From: Jeff King <peff@peff.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 07:59:09 -0500
Message-ID: <20110228125909.GA9054@sigill.intra.peff.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <4D6B95E3.7040603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mart =?utf-8?B?U8O1bWVybWFh?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 13:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2h4-0002wT-TQ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab1B1M7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:59:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab1B1M7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 07:59:13 -0500
Received: (qmail 23052 invoked by uid 111); 28 Feb 2011 12:59:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 12:59:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 07:59:09 -0500
Content-Disposition: inline
In-Reply-To: <4D6B95E3.7040603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168106>

On Mon, Feb 28, 2011 at 01:32:35PM +0100, Michael J Gruber wrote:

> > Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
> > without the sha1. In fact, we don't even provide it for a strict 100%
> > rename, and for a rename-with-patch, you can apply the patch, assuming
> > you have the original file in any form. So they are really about "is
> > your recipient using git", not "is your recipient using git _and_ will
> > he/she have the right sha1".
> 
> $ git mv Makefile Dofile
> $ git staged # yadayada
> diff --git c/Makefile i/Dofile
> similarity index 100%
> rename from Makefile
> rename to Dofile
> 
> Same with copy.
> 
> But that's not good, is it? I mean, Alice sends me her "copy patch" and
> I send her my Makefile patch, both on top of the same base. We both
> apply each other's patch cleanly. We end up with different "Dofile".
> Checking the sha1 would prevent this. It's no surprise that patch
> application is non-commutative, but shouldn't we catch this?

Won't you either get a conflict or end up with the same Dofile? Clearly
you will have a Dofile with your Makefile changes, as you applied the
movement on top of your changes.

Alice will either:

  1. Apply not using rename detection (e.g., not using git, or using
     "git am" without "-3"). In this case, she gets a conflict because
     she no longer has Makefile.

  2. Apply using rename detection (e.g., via "git am -3"). In this case,
     we will notice the movement of Makefile to Dofile, and apply the
     patch to Dofile.

Still, I do wonder if we should be including an index line on a straight
rename patch. It lets the recipient check that what is being renamed is
what they have (IOW, it gives the same check that they would do if they
ahd the whole patch text). And then the recipient can decide how to
resolve the conflict.

-Peff
