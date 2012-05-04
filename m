From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] http: handle proxy proactive authentication
Date: Fri, 4 May 2012 09:55:15 -0400
Message-ID: <20120504135514.GA29590@sigill.intra.peff.net>
References: <4FA2B4DA.60908@seap.minhap.es>
 <20120504071632.GB21895@sigill.intra.peff.net>
 <4FA3DFE3.5050702@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 15:55:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIyh-0004N9-B4
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab2EDNzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 09:55:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57911
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322Ab2EDNzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 09:55:17 -0400
Received: (qmail 20022 invoked by uid 107); 4 May 2012 13:55:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 09:55:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 09:55:15 -0400
Content-Disposition: inline
In-Reply-To: <4FA3DFE3.5050702@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197022>

On Fri, May 04, 2012 at 03:55:47PM +0200, Nelson Benitez Leon wrote:

> >> Also take care that CURLOPT_PROXY don't include username or
> >> password, as we now set them in the new set_proxy_auth() function
> >> where we use their specific cURL options.
> > 
> > Do we actually need to do that? If we set CURLOPT_PROXYUSERNAME, will
> > curl ignore it in favor of what's in the URL? 
> 
> I explicitly remove username/pass from CURLOPT_PROXY to not having to worry
> about that question, to not provide cURL with two different sets of proxy auth
> info, common sense dictates cURL specific proxy options should take precedence
> over embedded in url by I haven't seen that mentioned by any cURL docs so we 
> should look at the source to know the truth but even then that could change in
> the future so I think is safer to only provide one path for auth info.

Yes, I would expect the specific proxy options to take over. And that is
what happens for the regular URL case, where we do not do any munging at
all. I phrased my question as I did because that was the only set of
circumstances I could see where not munging the URL would _hurt_ us. In
other words, I do not find it likely that it will hurt us to leave it
intact.

But it may hurt us to munge it.  My concern is that we are adding a
bunch of code to replicate how curl behaves (with respect to pulling the
proxy information from the environment). If we leave the proxy URL
untouched, then if we fail to do the same thing as curl, the worst case
is that we don't get the credential properly (if one is even necessary).
But if we do rewrite the proxy, then we are potentially screwing up what
curl would do, whether a credential would have been necessary or not.

So to me it is the lower-risk path to let curl do its regular thing
(pulling the proxy from the environment), and just let us handle the
credential acquisition side of things. And it also is less code for us.

> Having username/password on the CURLOPT_PROXY option gives us no special gain at
> the cost of not permitting usernames with reserved characters like '@' or ':' which
> are not unusual at all. So I'm inclined to preserve current set_proxy_auth() 
> function and re-introduce the code that sets CURLOPT_PROXY with only $prot://$host.
> 
> Are you ok with this? or do you prefer I change set_proxy_auth() to a set_curl_proxy()
> function where I embedded user/pass in CURLOPT_PROXY ? that is the remaining thing I need
> to know to send a new re-roll.

No, I think you should leave CURLOPT_PROXY unset, unless you are giving
curl the verbatim URL given to us via git-config. Let our parsing be
only for credentials, and let curl handle everything else.

-Peff
