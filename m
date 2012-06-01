From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Fri, 1 Jun 2012 04:35:37 -0400
Message-ID: <20120601083537.GA32340@sigill.intra.peff.net>
References: <4FC7EFB7.4090704@steadfast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kevin Stange <kevin@steadfast.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNL6-0006Fa-LI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 10:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968Ab2FAIfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 04:35:44 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39633
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887Ab2FAIfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 04:35:42 -0400
Received: (qmail 30749 invoked by uid 107); 1 Jun 2012 08:35:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 04:35:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 04:35:37 -0400
Content-Disposition: inline
In-Reply-To: <4FC7EFB7.4090704@steadfast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198957>

On Thu, May 31, 2012 at 05:24:55PM -0500, Kevin Stange wrote:

> Request credentials from the user if none are already defined when a
> HTTP 401 is received on a restricted repository.  Then, resubmit the
> request and return the final result.
> 
> This allows all webdav transactions to obtain credentials without having
> to individually handle the case in each request.  Having push working
> with HTTP auth is needed for a use case I have where storing the
> credentials in .netrc or using SSH keys is inappropriate.

We already do this at a higher level in http_request, which in turns
calls into finish_active_slot. So if we were going to go this route,
wouldn't we also want to remove the 401 handling in http_request?

The dumb-http push code is the only thing that does not go through
http_request these days. So another option would be to refactor it to go
through that central point. I took a brief look at this when I was
updating the credential code a few months ago, but didn't consider it a
priority, as most people should be using smart http these days. Is there
a reason you can't use smart-http? It's significantly more efficient.

You also don't necessarily need to handle 401 in every code path of
http-push; once we see the credential once, we will use it everywhere,
so you really only need to handle it on the initial request (assuming
that all requests will have the same authorization requirements).

> Apologies for anything wrong I might have done here.  I'm not used to
> procedures for this sort of patch submission, or terribly familiar with
> the code base.  I'm seeking advice on whether this approach is sane or
> completely crazy, and I'm willing to adjust it to make it suitable for
> inclusion.
> 
> Signed-off-by: Kevin <kevin@steadfast.net>
> ---

Cover letter material (i.e., anything that would not go into the commit
message of the final commit) should go below the "---".

> diff --git a/http.c b/http.c
> index 5cb87f1..e1c9e65 100644
> --- a/http.c
> +++ b/http.c
> @@ -668,6 +668,21 @@ void finish_active_slot(struct active_request_slot
> *slot)
>  	closedown_active_slot(slot);
>  	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
> 
> +	if (slot->http_code == 401) {
> +		if(!http_auth.username && !http_auth.password) {
> +			active_requests++;
> +			credential_fill(&http_auth);
> +			init_curl_http_auth(slot->curl);
> +			(*slot->finished) = 1;
> +			if (start_active_slot(slot)) {
> +				run_active_slot(slot);
> +				return;
> +			}
> +		} else {
> +			fprintf(stderr,"Authentication Failed!\n");
> +		}
> +	}

Is it safe to just run start_active_slot again without reinitializing
the request? The 401-handling code in http_request actually restarts a
new request. I don't immediately see any state that would need to be
reset; we might have written some data to the output file if curl gave
us any body data, but presumably it would not have done so for a 401.

In the "else" clause you add, I don't think there's any point in
printing an error. The 401 should get propagated back to the caller, who
will produce an error. However, you _should_ call credential_reject,
since you know that the credential you have doesn't work.

Similarly, you would want to call credential_accept after a successful
request, so that helpers can store it.

-Peff
