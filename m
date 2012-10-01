From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 1 Oct 2012 18:18:17 -0400
Message-ID: <20121001221817.GA12496@sigill.intra.peff.net>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIoJv-0003mJ-K3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 00:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab2JAWSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 18:18:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37508 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab2JAWSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 18:18:20 -0400
Received: (qmail 24015 invoked by uid 107); 1 Oct 2012 22:18:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Oct 2012 18:18:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2012 18:18:17 -0400
Content-Disposition: inline
In-Reply-To: <1349126586-755-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206773>

On Mon, Oct 01, 2012 at 02:23:06PM -0700, Shawn O. Pearce wrote:

> From: "Shawn O. Pearce" <spearce@spearce.org>
> 
> When libcurl fails to connect to an SSL server always retry the
> request once. Since the connection failed before the HTTP headers
> can be sent, no data has exchanged hands, so the remote side has
> not learned of the request and will not perform it twice.
> 
> In the wild we have seen git-remote-https fail to connect to
> some load-balanced SSL servers sporadically, while modern popular
> browsers (e.g. Firefox and Chromium) have no trouble with the same
> server pool.
> 
> Lets assume the site operators (Hi Google!) have a clue and are
> doing everything they already can to ensure secure, successful
> SSL connections from a wide range of HTTP clients. Implementing a
> single level of retry in the client can make it more robust against
> transient failure modes.

I find this a little distasteful just because we haven't figured out the
actual _reason_ for the failure. That is, I'm not convinced this isn't
something that curl or the ssl library can't handle internally if we
would only configure them correctly. Did you ever follow up on tweaking
the session caching options for curl?

Have you tried running your fails-after-a-few-hours request with other
clients that don't have the problem and seeing what they do (I'm
thinking a small webkit harness or something would be the most
feasible)?

That being said, you did make it so that it only kicks in during ssl
connect errors:

> +	for (attempts = 0; attempts < 2; attempts++) {
> +		if (start_active_slot(slot)) {
> +			run_active_slot(slot);
> +			if (slot->results->curl_result == CURLE_SSL_CONNECT_ERROR)
> +				continue;
> +			ret = handle_curl_result(slot);
> +		} else {
> +			error("Unable to start HTTP request for %s", url);
> +			ret = HTTP_START_FAILED;
> +		}
> +		break;

which means it shouldn't really be affecting the general populace. So
even though it feels like a dirty hack, at least it is self-contained,
and it does fix a real-world problem. If your answer to the above
questions is "hunting this further is just not worth the effort", I can
live with that.

> diff --git a/remote-curl.c b/remote-curl.c
> index a269608..04a379c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -353,6 +353,8 @@ static int run_slot(struct active_request_slot *slot)
>  
>  	slot->results = &results;
>  	slot->curl_result = curl_easy_perform(slot->curl);
> +	if (slot->curl_result == CURLE_SSL_CONNECT_ERROR)
> +		slot->curl_result = curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);

How come the first hunk gets a nice for-loop and this one doesn't?

Also, are these hunks the only two spots where this error can come up?
The first one does http_request, which handles smart-http GET requests.
the second does run_slot, which handles smart-http POST requests.

Some of the dumb http fetches will go through http_request. But some
will not. And I think almost none of dumb http push will.

-Peff
