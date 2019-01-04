Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DCE1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfADKtJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 05:49:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:54550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726028AbfADKtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 05:49:09 -0500
Received: (qmail 637 invoked by uid 109); 4 Jan 2019 10:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 10:49:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16828 invoked by uid 111); 4 Jan 2019 10:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 05:48:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 05:49:07 -0500
Date:   Fri, 4 Jan 2019 05:49:07 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/2] Unset CURLOPT_FAILONERROR
Message-ID: <20190104104907.GC26185@sigill.intra.peff.net>
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181229194447.157763-1-masayasuzuki@google.com>
 <20181229194447.157763-3-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229194447.157763-3-masayasuzuki@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 29, 2018 at 11:44:47AM -0800, Masaya Suzuki wrote:

> When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
> to stderr. However, if the response is an error response and
> CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
> won't dump the headers. Showing HTTP response headers is useful for
> debugging, especially for non-OK responses.

Out of curiosity, does GIT_TRACE_CURL do any better? Or is it simply
that curl closes the handle when it sees the bad response code, and
nobody ever gets to see the rest of the data?

> This is substantially same as setting http_options.keep_error to all
> requests. Hence, remove this option.

The assumption here is that every code path using FAILONERROR is
prepared to handle the failing http response codes itself (since we no
longer set it at all in get_active_slot()). Is that so?

Anything that uses handle_curl_result() is OK. That means run_one_slot()
is fine, which in turn covers run_slot() for RPCs, and http_request()
for normal one-at-a-time requests. But what about the parallel multiple
requests issued by the dumb-http walker code?

There I think we end up in step_active_slots(), which calls into
finish_active_slot() for completed requests. I think that
unconditionally fetches the http code without bothering to look at
whether curl reported success or not.

So I _think_ that's probably all of the users of the curl handles
provided by get_active_slot(). Though given the tangled mess of our HTTP
code, I won't be surprised if there's a corner case I missed in that
analysis.

-Peff
