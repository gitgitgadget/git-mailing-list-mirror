From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Fri, 21 Sep 2012 01:26:06 -0400
Message-ID: <20120921052606.GA9659@sigill.intra.peff.net>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <20120920034804.GA32313@sigill.intra.peff.net>
 <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <20120920172408.GC18655@sigill.intra.peff.net>
 <CAJo=hJvyEtTDVJ6+Gv1kgqs1=UQEVbLaSFMEmUmCX-JWRCrDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 07:26:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEvks-0003lW-9x
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab2IUF0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:26:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52287 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049Ab2IUF0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:26:09 -0400
Received: (qmail 29312 invoked by uid 107); 21 Sep 2012 05:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 01:26:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 01:26:06 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvyEtTDVJ6+Gv1kgqs1=UQEVbLaSFMEmUmCX-JWRCrDxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206104>

On Thu, Sep 20, 2012 at 04:05:03PM -0700, Shawn O. Pearce wrote:

> But right now I am seeing failures in libcurl's SSL connection that
> may also be causing the smart connection failures. For example this
> trace, where libcurl was just not able to connect to respond to the
> 401 with a password. I suspect what is happening is the SSL session
> dropped out of cache on our servers, and libcurl couldn't reuse the
> existing SSL session. Instead of discarding the bad session and
> retrying, Git aborts. I'm willing to bet modern browsers just discard
> the bad session and start a new one, because clients can't assume the
> remote server will be able to remember their session forever.

That's something I haven't seen. But then, I don't usually see the
client side; I just see the fallback dumb fetch in our logs, and
have occasionally followed up.

Is there a long pause while the user is typing their password?

> * SSL re-using session ID
> * Unknown SSL protocol error in connection to android.googlesource.com:443
> * Expire cleared
> * Closing connection #0
> error: Unknown SSL protocol error in connection to
> android.googlesource.com:443  while accessing
> https://android.googlesource.com/a/platform/tools/build/info/refs?service=git-upload-pack
> fatal: HTTP request failed

You could try turning off CURLOPT_SSL_SESSIONID_CACHE and seeing if that
improves it. Of course, it is probably hard to reproduce, so it would be
tough to know if that helped or not. It would also be nice if you could
dump more information on the error from the ssl library (I typically
build curl against openssl; I wonder if it could be related to using
gnutls or something).

-Peff
