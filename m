From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] http: Fix crash when passing malformed URL
Date: Wed, 16 Mar 2016 17:42:00 -0400
Message-ID: <20160316214200.GB4441@sigill.intra.peff.net>
References: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
 <1458125647-32707-2-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip@i4.informatik.uni-erlangen.de, i4passt@cs.fau.de,
	git@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:42:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJCm-0001nZ-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933996AbcCPVmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:42:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:32856 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965007AbcCPVmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:42:04 -0400
Received: (qmail 27467 invoked by uid 102); 16 Mar 2016 21:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:42:03 -0400
Received: (qmail 20699 invoked by uid 107); 16 Mar 2016 21:42:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:42:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:42:00 -0400
Content-Disposition: inline
In-Reply-To: <1458125647-32707-2-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289048>

On Wed, Mar 16, 2016 at 11:54:07AM +0100, Anton Wuerfel wrote:

> When passing a malformed URL to http_init() in http.c, git dies from a null
> pointer dereference. An example for a malformed URL is http:/git-scm.com (note
> the single slash after the protocol).
> This patch adds simple error handling as git notices the malformed URL already,
> but never checks the error value.
> 
> When passing a malformed URL, credential_from_url(struct credential *c, const char *url)
> initializes *c with null values. When the existence of `://` in url is checked,
> the function returns without further change of *c.
> The null pointer dereference occurs in get_curl_handle () at http.c:593, when
> the `protocol` field of struct credential is strcmp'ed:

So I think the most direct bug here is that line 593 assumes that
http_auth.protocol is not NULL, when it might very well be (if we could
not parse the protocol). Your solution is to detect early that we don't
have a URL that curl can parse, and bail.

I think that's probably a reasonable thing to do in general. But it
doesn't make me certain that there's a case that curl might parse that
our credential url-parser might not. And the code in question does not
even care about credentials at all! It's just piggy-backing on the
earlier parse done by the credential code.

I think it would make much more sense for it to rely on the normalized
url we produce. IOW, to do something like:

  if (starts_with(normalized_url, "https://"))
	/* https stuff */
  else if (starts_with(normalized_url, "http://"))
	/* http stuff */
  else
	/* other stuff */

Note that the current code doesn't actually check for "http" (versus
other protocols; despite the name http_init(), this code gets run for
the probably-never-used-these-days git-over-ftp protocol). I suspect we
are respecting http_proxy for ftp connections, which is silly.

Note that normalized_url is freed before this point, so we may have to
hold onto it longer. Or it may be possible to use the broken-down
representation from config.url; I didn't look.

-Peff
