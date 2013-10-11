From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] http: add option to enable 100 Continue responses
Date: Fri, 11 Oct 2013 16:43:07 -0700
Message-ID: <20131011234307.GU9464@google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 01:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUmMW-0005vJ-6J
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 01:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab3JKXnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 19:43:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44212 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab3JKXnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 19:43:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so5073463pad.33
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OXMqmwzE7MfA+rsxYVN5h9atreE1SPRT0pmjJEompjI=;
        b=iRaapFYTAQ9ZvciYbXflLMi+AOfoJTevfjsuvGe5IsRxbBU24bNF8GHWqGky65rLKL
         KhKy7KfZhffDycULPbubqmDHN1WheORJQhb8uXRDDGmMu+sxCNgyMZNRyNZ6PBHdZ+fs
         W6R/4TcGzKv6BeRTL83HREQX64zYwrOwHWzJiJYJgJ3ujK4Sn8J3TBHRQInobObGxGNR
         8MNpr2d+cOVUgd2sgi6JATv8bB6aRj6emKa4eYQGxutHNOvxpx0pNRzFD7Zwwi9ByxFH
         1SYW/o4jCHX1NYDhKXA7GPa/ZxEihW1ec+sAdTJrEnYB0gy5LuO3NuIiYgak/ZaVZSaz
         voHA==
X-Received: by 10.66.192.132 with SMTP id hg4mr24623511pac.84.1381534991226;
        Fri, 11 Oct 2013 16:43:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qn1sm62333877pbc.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 16:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381530945-90590-2-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235926>

brian m. carlson wrote:

> When using GSS-Negotiate authentication with libcurl, the authentication
> provided will change every time, and so the probe that git uses to determine if
> authentication is needed is not sufficient to guarantee that data can be sent.
> If the data fits entirely in http.postBuffer bytes, the data can be rewound and
> resent if authentication fails; otherwise, a 100 Continue must be requested in
> this case.
>
> By default, curl will send an Expect: 100-continue if a certain amount of data
> is to be uploaded, but when using chunked data this is never triggered.  Add an
> option http.continue, which defaults to disabled, to control whether this header
> is sent.  The addition of an option is necessary because some proxies break
> badly if sent this header.

"By default" means "when allowed to make its own choice", right?  (i.e.,
the behavior git never gave libcurl a chance to try :))

Makes sense.

[...]
> --- a/http.c
> +++ b/http.c
> @@ -11,6 +11,7 @@
>  int active_requests;
>  int http_is_verbose;
>  size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
> +int http_use_100_continue = 0;

Style: git tends to omit the '= 0' implicit for globals, since they are
already 0 by default.

[...]
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

Style:

	/*
	 * Multi-line comments in git have the starting and ending comment
	 * delimiters on their own lines, like this.
	 */

Will make the fixups mentioned above, squash with documentation, and
apply.  Thanks.
