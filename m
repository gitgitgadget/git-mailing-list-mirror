From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sat, 5 Feb 2011 14:37:09 -0500
Message-ID: <20110205193708.GA2192@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 20:37:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plnwe-0000d9-Bz
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 20:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1BEThN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 14:37:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563Ab1BEThM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 14:37:12 -0500
Received: (qmail 17527 invoked by uid 111); 5 Feb 2011 19:37:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Feb 2011 19:37:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Feb 2011 14:37:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166116>

On Sat, Feb 05, 2011 at 01:39:57PM -0500, Nicolas Pitre wrote:

> So that's what has to be fixed.  If you get duplicated tag names then 
> just warn the user and give priority to the local one, or error out with 
> a "ambiguous tag specification" if no local but multiple remote tags 
> with the same name are found (the user would have to be more precise in 
> the tag scope in that case).

The latter seems like a regression for the common case of fetching from
two upstreams. E.g., I usually pull from Junio, getting
remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
pull from him, getting remotes/spearce/v1.7.0, which he previously
fetched from Junio. Under the current code, I can still do "git show
v1.7.0"; under the scheme described above I now have to say
"origin/v1.7.0" to disambiguate.

The real issue, I think, is that we are claiming ambiguity even though
those tags almost certainly point to the same sha1. When handling
ambiguous tags, should we perhaps check to see if all of the ambiguities
point to the same sha1, and in that case, just pick one at random?

In the case of resolving a ref to a sha1, then by definition they are
all equivalent to pick. For things that care (e.g., "git checkout") we
should probably still complain (although many of those commands have
their own disambiguation code to prefer refs/heads/ or whatever anyway).

-Peff
