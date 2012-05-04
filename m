From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 4 May 2012 03:39:13 -0400
Message-ID: <20120504073913.GA22388@sigill.intra.peff.net>
References: <4FA2B4D3.90809@seap.minhap.es>
 <20120504070802.GA21895@sigill.intra.peff.net>
 <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri May 04 09:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQD6m-0002nV-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab2EDHjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:39:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57644
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538Ab2EDHjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:39:16 -0400
Received: (qmail 16476 invoked by uid 107); 4 May 2012 07:39:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:39:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:39:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197006>

On Fri, May 04, 2012 at 09:27:16AM +0200, Daniel Stenberg wrote:

> On Fri, 4 May 2012, Jeff King wrote:
> 
> >I don't see any way around it besides implementing curl's full
> >tokenizing and matching algorithm, which is about a page of code.
> >I'd really prefer not to re-implement bits of curl (especially
> >because they may change later), but AFAIK there is no way to ask
> >curl "is there a proxy configured, and if so, what is it?".
> 
> Sorry for being thick, but I lost track on this thread. Why does it
> need this info again?

We need to know information about the proxy in order to look up the
username and password in our credential database. Before the request is
made in some cases, and in others, after we see a 407. If we fed the
proxy to curl via CURLOPT_PROXY, it's easy. But if the proxy came from
the environment, we have to replicate curl's lookup rules.

> Or perhaps put another way: if there was an ideal way to get this
> done or provide this to libcurl other than the current way, how would
> you suggest it would be done from a git internal point of view?

The absolute simplest way for us would be to stop using
CURLOPT_PROXYUSERNAME/PASSWORD to set it ahead of time, and instead
provide a callback that curl would call on a 407. That callback would
just need the URL of the proxy, and would return the username/password
(or even just set them on the curl object via
CURLOPT_PROXYUSERNAME/PASSWORD).

For that matter, it would simplify our code to do the same for regular
http auth, too. And though we usually know our URL in that case, we
might not if we got a 302 with FOLLOWLOCATION set.

-Peff
