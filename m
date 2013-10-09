From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Wed, 9 Oct 2013 15:30:54 -0400
Message-ID: <20131009193054.GA3767@sigill.intra.peff.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:31:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTzTL-0003QB-ES
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab3JITa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:30:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:46464 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754961Ab3JITa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:30:57 -0400
Received: (qmail 5475 invoked by uid 102); 9 Oct 2013 19:30:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 14:30:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 15:30:54 -0400
Content-Disposition: inline
In-Reply-To: <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235838>

On Tue, Oct 08, 2013 at 08:48:06PM +0000, brian m. carlson wrote:

> When using GSS-Negotiate authentication with libcurl, the authentication
> provided will change every time, and so the probe that git uses to determine if
> authentication is needed is not sufficient to guarantee that data can be sent.
> If the data fits entirely in http.postBuffer bytes, the data can be rewound and
> resent if authentication fails; otherwise, a 100 Continue must be requested in
> this case.
> 
> By default, curl will send an Expect: 100-continue if a certain amount of data
> is to be uploaded, but when using chunked data this is never triggered.  Add an
> option http.continue, which defaults to enabled, to control whether this header
> is sent.  The addition of an option is necessary because some proxies break
> badly if sent this header.

[+cc spearce]

I'd be more comfortable defaulting this to "on" if I understood more
about the original problem that led to 959dfcf and 206b099. It sounds
like enabling this all the time will cause annoying stalls in the
protocol, unless the number of non-crappy proxy implementations has
gotten smaller over the past few years.

> diff --git a/remote-curl.c b/remote-curl.c
> index b5ebe01..3b5e160 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -470,7 +470,12 @@ static int post_rpc(struct rpc_state *rpc)
>  
>  	headers = curl_slist_append(headers, rpc->hdr_content_type);
>  	headers = curl_slist_append(headers, rpc->hdr_accept);
> -	headers = curl_slist_append(headers, "Expect:");
> +
> +	/* Force it either on or off, since curl will try to decide based on how
> +	 * much data is to be uploaded and we want consistency.
> +	 */
> +	headers = curl_slist_append(headers, http_use_100_continue ?
> +		"Expect: 100-continue" : "Expect:");

Is there any point in sending the Expect: header in cases where curl
would not send it, though? It seems like we should assume curl does the
right thing most of the time, and have our option only be to override
curl in the negative direction.

-Peff
