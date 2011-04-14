From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 17:42:30 -0400
Message-ID: <20110414214230.GB7709@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
 <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUJE-0001BW-0f
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab1DNVmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:42:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56011
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab1DNVme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:42:34 -0400
Received: (qmail 4157 invoked by uid 107); 14 Apr 2011 21:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 17:43:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 17:42:30 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171563>

On Thu, Apr 14, 2011 at 11:19:09PM +0200, Erik Faye-Lund wrote:

> > Note that it relies on the commit header having a space before the "<",
> > which forms the continuation whitespace for the header. This is probably
> > reasonable, but we could double-check if we want to handle malformed
> > commit headers better.
> 
> I think that's a reasonable assumption; this field comes straight from
> the commit. It should already be well-formed, no?

Probably; it was just something I noted while writing the patch, and I
like to be paranoid about assumptions. :)

> > Or we could just ignore it. AFAICS, this doesn't actually violate
> > rfc2047, nor rfc5322. The 78-character limit is simply a SHOULD, and
> > we have up to 998 for MUST. For a single-address header[1], this seems
> > kind of unlikely to me.
> 
> True. But since the fix is as simple as it is, perhaps it's worth it
> just for the clean conscience?

Fair enough. Patch to follow.

> > [1] For multi-address headers like "format-patch --cc=foo --cc=bar", it
> > looks like we already break them across lines.
> 
> Yes, but this is even worse: these fields don't get encoded at all!

Ugh, you're right. That is a totally separate issue, and one I really
don't want to get into. Because it means we have to _parse_ those
headers and understand which part is a name and which is an address.

People who use "--cc" or format.headers will have to deal with that
themselves. I consider both to be somewhat useless, since you can
post-process the mbox after format-patch is run (or in your MUA).
Whereas quoting and encoding fields in format-patch is necessary to give
unambiguous input to the MUA (be it send-email or whatever).

-Peff
