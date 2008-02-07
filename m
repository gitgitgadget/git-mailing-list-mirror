From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Wed, 6 Feb 2008 23:23:33 -0500
Message-ID: <20080207042332.GA7632@sigill.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 05:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMyJD-0005kx-Rv
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 05:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbYBGEXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 23:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbYBGEXu
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 23:23:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3057 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245AbYBGEXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 23:23:49 -0500
Received: (qmail 8770 invoked by uid 111); 7 Feb 2008 04:23:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 06 Feb 2008 23:23:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 23:23:33 -0500
Content-Disposition: inline
In-Reply-To: <pan.2008.02.06.21.56.35@progsoc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72890>

On Wed, Feb 06, 2008 at 09:56:35PM +0000, Anand Kumria wrote:

> With GIT_SSL_NO_VERIFY defined, it fails with:
> 
> $ GIT_SSL_NO_VERIFY=1 ../git/git-fetch richard
> error: gnutls_handshake() failed: ASN1 parser: Element was not found. (curl_result = 35, http_code = 0, sha1 = 510567ca41e201253445528ca6eb89ed43e71fce)
> Getting pack list for https://server.example.com/~richard/newfoo.git
> error: gnutls_handshake() failed: ASN1 parser: Element was not found.
> Getting alternates list for https://server.example.com/~richard/newfoo.git
> error: Unable to find 510567ca41e201253445528ca6eb89ed43e71fce under https://server.example.com/~richard/newfoo.git
> Cannot obtain needed object 510567ca41e201253445528ca6eb89ed43e71fce
> fatal: Fetch failed.

OK, I was finally able to reproduce your bug. It seems that it _only_
happens when using curl built against gnutls. I built against the
libcurl4-openssl-dev in Debian unstable, and the problem goes away.

Can you confirm that building using the openssl version of curl fixes
the problem?

Googling for your error message turns up only one other instance: a bug
in pidgin where the result was "this seems like a bug in gnutls." I hate
to say "it's not our bug" without knowing exactly what is causing it,
though. And it does seem odd that it works with 1.5.3.8. I wonder if
there is some difference in the way we are calling curl that matters.

> I *think* what is happening is that it is it is trying for the object
> - not seeing it and then not attempting to get the pack file.

No, it only fails to see objects because of the curl failure (it tries
the loose and then the pack).

-Peff
