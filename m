Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3C91F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfADKao (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 05:30:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:54534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbfADKao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 05:30:44 -0500
Received: (qmail 32335 invoked by uid 109); 4 Jan 2019 10:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 10:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16745 invoked by uid 111); 4 Jan 2019 10:30:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 05:30:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 05:30:42 -0500
Date:   Fri, 4 Jan 2019 05:30:42 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] Change how HTTP response body is returned
Message-ID: <20190104103042.GB26185@sigill.intra.peff.net>
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181229194447.157763-1-masayasuzuki@google.com>
 <20181229194447.157763-2-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229194447.157763-2-masayasuzuki@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 29, 2018 at 11:44:46AM -0800, Masaya Suzuki wrote:

> +/*
> + * A callback for CURLOPT_WRITEFUNCTION. The return value is the bytes consumed
> + * from ptr.
> + */
>  static size_t rpc_in(char *ptr, size_t eltsize,
>  		size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> -	struct rpc_state *rpc = buffer_;
> +	struct rpc_in_data *data = buffer_;
> +	long response_code;
> +
> +	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
> +			      &response_code) != CURLE_OK)
> +		return size;

This hunk was unexpected to me. The function here is just writing out
the data, and I expected we'd handle the error after the whole transfer
is done. But we do that anyway eventually via run_slot() (which uses
handle_curl_result). I guess the goal here is to start throwing away
data when we see an error, rather than storing it?

That makes some sense, though I do wonder if there's any case where curl
would call our WRITEFUNCTION before it knows the HTTP status. That
implies a body before our header, which seems impossible, though.

> +	if (response_code != 200)
> +		return size;

The current behavior with CURLOPT_FAILONERROR treats codes >= 400 as an
error. And in handle_curl_result(), we treat >= 300 as an error (since
we only see 3xx for a disabled redirect). I suppose it's unlikely for us
to see any success code besides 200, but we probably ought to be
following the same rules here.

-Peff
