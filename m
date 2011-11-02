From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 16:32:21 -0400
Message-ID: <20111102203221.GB5628@sigill.intra.peff.net>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, daniel@haxx.se
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:33:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLhUc-0001QW-81
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab1KBUc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:32:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60380
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935Ab1KBUcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:32:24 -0400
Received: (qmail 16057 invoked by uid 107); 2 Nov 2011 20:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 16:38:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 16:32:21 -0400
Content-Disposition: inline
In-Reply-To: <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184667>

On Wed, Nov 02, 2011 at 09:21:27PM +0100, Mika Fischer wrote:

> Instead of sleeping unconditionally for a 50ms, when no data can be read
> from the http connection(s), use curl_multi_fdset to obtain the actual
> file descriptors of the open connections and use them in the select call.
> This way, the 50ms sleep is interrupted when new data arrives.
> ---
>  http.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/http.c b/http.c
> index a4bc770..ae92318 100644
> --- a/http.c
> +++ b/http.c
> @@ -664,14 +664,14 @@ void run_active_slot(struct active_request_slot *slot)
>  		}
>  
>  		if (slot->in_use && !data_received) {
> -			max_fd = 0;
> +			max_fd = -1;
>  			FD_ZERO(&readfds);
>  			FD_ZERO(&writefds);
>  			FD_ZERO(&excfds);
> +			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
>  			select_timeout.tv_sec = 0;
>  			select_timeout.tv_usec = 50000;
> -			select(max_fd, &readfds, &writefds,
> -			       &excfds, &select_timeout);
> +			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}

Do we still need to care about data_received?

My understanding was that the code was originally trying to do:

  1. Call curl, maybe get some data.

  2. If we got data, then ask curl against immediately for some data.

  3. Otherwise, sleep 50ms and then ask curl again.

But now that we are actually selecting on the proper descriptors, it
should now be safe to just do:

  1. Call curl, maybe get some data.

  2. Call select, which will wake immediately if curl is going to get
     data.

At least that's my reading. I am working on unrelated patches that clean
up the handling of data_received, but if it could go away altogether,
that would be even simpler.

-Peff
