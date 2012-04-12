From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 18:42:30 -0400
Message-ID: <20120412224230.GA22988@sigill.intra.peff.net>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
 <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
 <20120412220516.GG21018@sigill.intra.peff.net>
 <7vd37c4msm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISir-0003Ht-QY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966140Ab2DLWmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:42:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60453
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966131Ab2DLWmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 18:42:32 -0400
Received: (qmail 32662 invoked by uid 107); 12 Apr 2012 22:42:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 18:42:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 18:42:30 -0400
Content-Disposition: inline
In-Reply-To: <7vd37c4msm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195382>

On Thu, Apr 12, 2012 at 03:18:01PM -0700, Junio C Hamano wrote:

> > So as far as I can tell, these are equivalent:
> >
> >   http_proxy=http://127.0.0.1:1080
> >   http_proxy=https://127.0.0.1:1080
> >   http_proxy=foobar://127.0.0.1:1080
> 
> Yes, that is exactly what I was trying to say.  The foobar:// part does
> not matter; "http" in "http_proxy" is what matters, as it is how you can
> specify two separate proxies depending on what destination you are going
> via what protocol.

But you snipped the later part of my message, which is that the "http"
in "http_proxy" does _not_ matter. It is about which destinations to
apply the proxy to, not how you talk to the proxy (and the latter is what
should matter for the credentials).

> > Not splitting "http" and "http-proxy" does have a slight confusion, as
> > the default proxy port is "1080". So a proxy of "http://127.0.0.1" would
> > mean "http://127.0.0.1:1080", whereas a regular request would mean
> > "http://127.0.0.1:80". The credential code includes the port as part of
> > the unique hostname, but since the default-port magic happens inside
> > curl, we have no access to it (short of re-implementing it ourselves).
> 
> Ok, so how about this as a replacement patch for what I have had for the
> past few days?

My other message argued "the http-proxy distinction might be important,
but probably isn't". But I didn't talk about "the http-proxy distinction
might break helpers". The stock helpers will be fine; they are totally
clueless about what the protocol means, and just treat it as a string to
be matched. But for something like osxkeychain, where it is converting
the protocol string into some OS-specific magic value, it does matter,
and http-proxy would cause it to exit in confusion.

It looks like OS X defines a SOCKS type and an HTTPProxy type for its
keychain API. So in either case, it should probably be updated to handle
these new types. And I guess that argues for making the distinction,
since at least one helper does want to care about it.

-Peff
