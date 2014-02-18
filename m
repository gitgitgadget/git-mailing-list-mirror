From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git http connection reuse
Date: Tue, 18 Feb 2014 02:55:34 -0500
Message-ID: <20140218075534.GB29804@sigill.intra.peff.net>
References: <20140216040538.GA4754@sigill.intra.peff.net>
 <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
 <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
 <20140217235625.GB20499@sigill.intra.peff.net>
 <alpine.DEB.2.00.1402180806070.15465@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Feb 18 08:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFfWn-000565-OY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 08:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbaBRHzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 02:55:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:52487 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753573AbaBRHzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 02:55:36 -0500
Received: (qmail 17835 invoked by uid 102); 18 Feb 2014 07:55:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 01:55:36 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 02:55:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1402180806070.15465@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242279>

On Tue, Feb 18, 2014 at 08:13:16AM +0100, Daniel Stenberg wrote:

> >Right; I'd expect multiple connections for parallel requests, but
> >in this case we are completing the first and removing the handle
> >before starting the second. Digging further, I was able to
> >reproduce the behavior with a simple program:
> 
> Yeah, given your description I had no problems to repeat it either.
> Turns out we had no decent test case that checked for this so in our
> eagerness to fix a security problem involving "over-reuse" we broke
> this simpler reuse case. Two steps forward, one step backward... :-/

You are talking about the NTLM fix here, right?

I think there is still an unrelated issue with curl_multi preventing
connection reuse, but I'm not sure from what you say below...

> >Does that apply to the handle after it has finished its transaction
> >and been removed from the multi object (in which case git is Doing
> >It Wrong)?
> 
> No it doesn't. The man page should probably be clarified to express
> that slightly better. It just means that _while_ a handle is added to
> a multi handle it cannot be used with curl_easy_perform().

Thanks for the clarification. That was my guess from reading it, but
given that it wasn't working as expected, I wondered if we were
violating the rules. I saw the documentation fix you just pushed; it
looks reasonable to me.

> Several internal caches are kept in the multi handle when that's used
> though, so when getting the easy handle out after having used it with
> the multi interface and then using it with the easy interface may
> cause libcurl to do a little more work than if you would be able to
> re-add it to the same multi handle do to the operation with that...

I'm not clear whether you mean by this that it is _expected_ in my test
program for curl not to reuse the connection. Or that curl may simply
have to do a little more work, and it is still a bug that the connection
is not reused.

We can certainly teach git to use the multi interface, even when doing a
single blocking request.

-Peff
