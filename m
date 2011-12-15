From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Thu, 15 Dec 2011 03:37:32 -0500
Message-ID: <20111215083732.GA5958@sigill.intra.peff.net>
References: <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org>
 <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org>
 <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu>
 <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
 <7vborct37c.fsf@alter.siamese.dyndns.org>
 <20111214023320.GA22141@sigill.intra.peff.net>
 <4EE9AD7C.2050605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Drew Northup <drew.northup@maine.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb6ot-0007ny-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 09:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625Ab1LOIhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 03:37:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50417
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab1LOIhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 03:37:34 -0500
Received: (qmail 6965 invoked by uid 107); 15 Dec 2011 08:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 03:44:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 03:37:32 -0500
Content-Disposition: inline
In-Reply-To: <4EE9AD7C.2050605@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187199>

On Thu, Dec 15, 2011 at 09:19:08AM +0100, Michael Haggerty wrote:

> Now I'm looking at the uses of extra_refs in git-clone.  One thing it
> does is add some extra refs then write them to the packed-refs file.  I
> still have to dig into it, but this seems strange.  If the refs are
> being written to packed-refs, it seems like they must be real (not
> extra) refs, or perhaps are just about to become real refs as part of
> the clone.  Or is something more egregious is going on?

I think what is happening is that the extra_refs system is doing double
duty here. If you do:

  git clone --reference $local $origin

then the code does something like:

  1. Add all of the refs in $local are added to extra_refs, because we
     want to advertise them during the pack fetch (see add_one_reference,
     called through setup_reference at l. 626).

  2. We then get the list of remote refs from $origin and store them in
     mapped_refs (ll. 657-658). The fetch uses the extra refs from (1).

  3. We call clear_extra_refs to drop those temporary refs (l. 663).

  4. We call write_remote_refs (l. 664), which adds all of the
     mapped_refs from (2) to extra_refs, then calls pack_refs which will
     pack all of the existing refs (of which there should be none, I
     would think), including extras (i.e., all the stuff we just
     cloned).

     Afterwards we clear_extra_refs again, though I think that is
     probably unnecessary.

Keeping the ".have" sha1s out of extra_refs would make this a lot
clearer.  Arguably it would also be better to have some way to just pass
the set of mapped_refs to pack_refs, instead of shoving them in the
global extra_refs and relying on pack_refs to find them there.

-Peff
