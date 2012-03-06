From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] http: handle proxy proactive authentication
Date: Tue, 6 Mar 2012 05:09:47 -0500
Message-ID: <20120306100947.GA710@sigill.intra.peff.net>
References: <4F54D98C.2070909@seap.minhap.es>
 <20120306083052.GD21199@sigill.intra.peff.net>
 <4F55EDF3.2030201@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:10:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4rLF-0002YE-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 11:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab2CFKJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 05:09:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41985
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756807Ab2CFKJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 05:09:54 -0500
Received: (qmail 6587 invoked by uid 107); 6 Mar 2012 10:10:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 05:10:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 05:09:47 -0500
Content-Disposition: inline
In-Reply-To: <4F55EDF3.2030201@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192328>

On Tue, Mar 06, 2012 at 11:58:59AM +0100, Nelson Benitez Leon wrote:

> > Also, when turning it back into a URL to hand to curl, should we be
> > percent-encoding the items we put in? If my password has an "@" in it,
> > wouldn't we generate a bogus URL? Although looking at how the http auth
> > code handles this, we set CURLOPT_USERPWD directly. Should you be
> > setting CURLOPT_PROXYUSERPWD instead of munging the proxy URL?
> 
> Ok, but it seems is CURLOPT_PROXYUSERNAME and CURLOPT_PROXYPASSWORD what
> we need here as per documentation[1]
> 
> [1] http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTPROXYUSERNAME

Yes, the split CURLOPT_USERNAME and CURLOPT_PASSWORD interface is much
better (it allows the username to contain a colon). But it was not
introduced until curl 7.19.3, and we support older versions.

We could do an #if on LIBCURL_VERSION_NUM to use the new form when it's
available, but nobody has complained so far.

> >> +			free ((void *)curl_http_proxy);
> > 
> > Please don't cast to void. This is C, not C++, and casts to void
> > pointers are implicit.  They can never help, and might cover up an
> > actual type error (e.g., casting a non-pointer type).
> 
> Ok, will remove it, I copy/paste it from the http code and I must admit
> I didn't understand why this was needed.

Ah.  I grepped for the spot you copied. The cast is to get rid of the
"const" on curl_http_proxy. But if it's a pointer to allocated memory,
it should not be declared const in the first place. Unfortunately,
fixing this means casting in the call to git_config_string (which for
some reason takes a pointer-to-const-pointer, even though the value it
puts in will always be allocated by xstrdup). Or fixing
git_config_string, but that cascades to require fixing in lots of other
places. Ugh.

-Peff
