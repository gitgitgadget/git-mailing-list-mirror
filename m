From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check for
 batch mode
Date: Mon, 15 Jul 2013 00:17:13 -0400
Message-ID: <20130715041712.GA20900@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
 <20130712062004.GA15572@sigill.intra.peff.net>
 <51DFC2B2.3080300@alum.mit.edu>
 <20130712092212.GA4859@sigill.intra.peff.net>
 <7vk3ksfpum.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyaDv-0004PP-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941Ab3GOERQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:17:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:35608 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab3GOERP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:17:15 -0400
Received: (qmail 20450 invoked by uid 102); 15 Jul 2013 04:18:35 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Jul 2013 23:18:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2013 00:17:13 -0400
Content-Disposition: inline
In-Reply-To: <7vk3ksfpum.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230413>

On Sun, Jul 14, 2013 at 08:45:37PM -0700, Junio C Hamano wrote:

> >> To cat-file we could add an option like "--sha1-only" or "--literal" or
> >> "--no-dwim" (... better names are failing me) which would skip *all*
> >> dwimming of 40-character strings.  It would also assume that any shorter
> >> strings are abbreviated SHA-1s and fail if they are not.  This would be
> >> a nice feature by itself ("these are object names, dammit, and don't try
> >> to tell me differently!") and would have the additional small advantage
> >> of speeding up lookups of abbreviated SHA-1s, which (regardless of your
> >> patch) otherwise go through the whole DWIM process.
> >
> > I can see in theory that somebody might want that, but I am having a
> > hard time thinking of a practical use.
> 
> Would it be a good alternative to call get_sha1_hex() to catch the
> most common case (reading from rev-list output, for example) and
> then let the more general get_sha1() to let extended SHA-1 to be
> handled?

For a 40-byte sha1, that _should_ be what get_sha1 does (i.e., go more
or less directly to the 40-hex code path, and return). And that's
basically what happens now, except that after we do so, we now have the
extra "oh, is it also a refname?" check.

For a shortened sha1, I don't think it would have the same behavior.
Right now, I believe the order is to treat a short sha1 as a possible
refname, and only if that fails consider it as a short sha1.

> > IOW, it seems like a poor default, and we are choosing it only because
> > of backwards compatibility. I guess another option is to switch the
> > default with the usual deprecation dance.
> 
> I agree that "did you mean the unreadable refname or 40-hex object?"
> turned on everywhere get_sha1() is called is a very poor default.  I
> wonder if we can limit it only to the end-user input somehow at the
> API level.

It is easy to do on top of my patch (just flip the default on the switch
I introduced, and turn it back on in whichever code paths are
appropriate).  But the question is: what is end-user input? Do you mean
command-line arguments to "rev-list" and friends?

-Peff
