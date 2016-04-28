From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 2/2] imap-send.c: introduce the GIT_TRACE_CURL
 enviroment variable
Date: Thu, 28 Apr 2016 10:55:24 -0400
Message-ID: <20160428145524.GE25364@sigill.intra.peff.net>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
 <20160428115748.37177-3-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 16:55:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnLu-0008MZ-3F
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcD1Oz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:55:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58381 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752526AbcD1Oz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:55:28 -0400
Received: (qmail 29536 invoked by uid 102); 28 Apr 2016 14:55:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 10:55:26 -0400
Received: (qmail 10061 invoked by uid 107); 28 Apr 2016 14:55:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 10:55:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 10:55:24 -0400
Content-Disposition: inline
In-Reply-To: <20160428115748.37177-3-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292892>

On Thu, Apr 28, 2016 at 11:57:48AM +0000, Elia Pinto wrote:

> diff --git a/imap-send.c b/imap-send.c
> index 938c691..61c6787 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1444,6 +1444,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>  	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
>  
> +	if (curl_trace_want()) {
> +		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
> +		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
> +		curl_easy_setopt(curl, CURLOPT_DEBUGDATA, NULL);
> +	}

In the only other caller of curl_trace_want(), we repeat these exact
same lines (and really, what else would one do with that flag besides
enable curl_trace?).

Perhaps a better abstraction would be:

  int setup_curl_trace(CURL *handle)
  {
	if (!trace_want(&trace_curl))
		return 0;
	curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);
	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
	return 1;
  }

You could even get rid of the return value, too. We do not use it here,
but just let GIT_TRACE_CURL naturally override GIT_CURL_VERBOSE by
setting the DEBUGFUNCTION. In the other caller, we do:

  if (curl_trace_want()) {
     ... set up handle ...
  } else {
     ... check and setup up GIT_CURL_VERBOSE ...
  }

but we can do the else block regardless. It is a noop if tracing is set
up.

-Peff
