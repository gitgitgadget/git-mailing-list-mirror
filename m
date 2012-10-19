From: Jeff King <peff@peff.net>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 06:36:28 -0400
Message-ID: <20121019103627.GA29366@sigill.intra.peff.net>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 <7vd30fl736.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: szager@google.com, git@vger.kernel.org, sop@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 12:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP9wh-0003hp-Af
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 12:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469Ab2JSKgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 06:36:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab2JSKgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 06:36:37 -0400
Received: (qmail 14791 invoked by uid 107); 19 Oct 2012 10:37:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Oct 2012 06:37:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2012 06:36:28 -0400
Content-Disposition: inline
In-Reply-To: <7vd30fl736.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208041>

On Thu, Oct 18, 2012 at 03:59:41PM -0700, Junio C Hamano wrote:

> > It will sometimes happen that curl_multi_fdset() doesn't
> > return any file descriptors.  In that case, it's recommended
> > that the application sleep for a short time before running
> > curl_multi_perform() again.
> >
> > http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
> >
> > Signed-off-by: Stefan Zager <szager@google.com>
> > ---
> 
> Thanks.  Would it be a better idea to "patch up" in problematic
> case, instead of making this logic too deeply nested, like this
> instead, I have to wonder...
> 
> 
> 	... all the existing code above unchanged ...
> 	curl_multi_fdset(..., &max_fd);
> +	if (max_fd < 0) {    
> +		/* nothing actionable??? */
> +		select_timeout.tv_sec = 0;
> +		select_timeout.tv_usec = 50000;
> +	}
> 
> 	select(max_fd+1, ..., &select_timeout);

But wouldn't that override a potentially shorter timeout that curl gave
us via curl_multi_timeout, making us unnecessarily slow to hand control
back to curl?

The current logic is:

  - if curl says there is something to do now (timeout == 0), do it
    immediately

  - if curl gives us a timeout, use it with select

  - otherwise, feed 50ms to selection

It should not matter what we get from curl_multi_fdset. If there are
fds, great, we will feed them to select with the timeout, and we may
break out early if there is work to do. If not, then we are already
doing this wait.

IOW, it seems like we are _already_ following the advice referenced in
curl's manpage. Is there some case I am missing? Confused...

-Peff
