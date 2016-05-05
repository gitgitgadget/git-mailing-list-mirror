From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/2] http: support sending custom HTTP headers
Date: Thu, 5 May 2016 16:03:27 -0400
Message-ID: <20160505200327.GC9162@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <ff7edf51fe8baf57f6f4cab170602154e5b1e73e.1462342213.git.johannes.schindelin@gmx.de>
 <67F2E414-657C-4C6C-9746-9B3026737C66@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:03:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPUr-0008Fz-N9
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbcEEUDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:03:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:34693 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755120AbcEEUDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:03:32 -0400
Received: (qmail 14722 invoked by uid 102); 5 May 2016 20:03:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 16:03:31 -0400
Received: (qmail 21786 invoked by uid 107); 5 May 2016 20:03:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 16:03:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2016 16:03:27 -0400
Content-Disposition: inline
In-Reply-To: <67F2E414-657C-4C6C-9746-9B3026737C66@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293673>

On Thu, May 05, 2016 at 09:10:21PM +0200, Lars Schneider wrote:

> > +<LocationMatch /smart_headers/>
> > +	<RequireAll>
> > +		Require expr %{HTTP:x-magic-one} == 'abra'
> > +		Require expr %{HTTP:x-magic-two} == 'cadabra'
> > +	</RequireAll>
> 
> I think "<RequireAll>" depends on mod_authz_core which is only
> available in Apache HTTPD 2.3 or later [1].
> 
> Right now the test only checks if Apache version greater 2
> is installed. Should we guard this test with a special version
> check? Or do you see a way to check the magic values without
> "<RequireAll>"?

I think you can get rid of RequireAll with:

 Require expr %{HTTP:x-magic-one} == 'abra' && %{HTTP:x-magic-two} == 'cadabra'

But I am also not sure that "expr" existed in Apache 2.2.

I think the older way of checking headers was to do some trickery with
RewriteCond; I tried briefly to make that work when I wrote the test,
but never did (but I'm far from an expert in Apache; the only reason I
have touched it in the last 15 years is for Git's test suite).

The nuclear option would be to put a shell script between Apache and
git-http-backend that checks for those headers (I suspect we'd still
need some magic in the Apache config to pass the headers out in the
environment, though).

-Peff
