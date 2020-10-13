Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CCC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301F9216C4
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgJMVOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 17:14:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:59064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgJMVOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 17:14:55 -0400
Received: (qmail 13223 invoked by uid 109); 13 Oct 2020 21:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Oct 2020 21:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9415 invoked by uid 111); 13 Oct 2020 21:14:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Oct 2020 17:14:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Oct 2020 17:14:53 -0400
From:   Jeff King <peff@peff.net>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, masayasuzuki@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201013211453.GB3678071@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013191729.2524700-3-smcallis@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 01:17:29PM -0600, Sean McAllister wrote:

> Some HTTP response codes indicate a server state that can support
> retrying the request rather than immediately erroring out.  The server
> can also provide information about how long to wait before retries to
> via the Retry-After header.  So check the server response and retry
> some reasonable number of times before erroring out to better accomodate
> transient errors.
> 
> Exiting immediately becomes irksome when pulling large multi-repo code
> bases such as Android or Chromium, as often the entire fetch operation
> has to be restarted from the beginning due to an error in one repo. If
> we can reduce how often that occurs, then it's a big win.

I had hoped that libcurl might have some retry mechanisms, since the
curl command-line tool has several --retry-* options. But it looks like
that is all only at the tool level, and the library code doesn't know
anything about it. So we are stuck driving the process ourselves.

I do think you could be leveraging CURLINFO_RETRY_AFTER rather than
implementing your own header parsing, though.

>  static int http_request(const char *url,
>  			void *result, int target,
>  			const struct http_get_options *options)
>  {

It looks like you trigger retries only from this function. But this
doesn't cover all http requests that Git makes. That might be sufficient
for your purposes (I think it would catch all of the initial contact),
but it might not (it probably doesn't cover subsequent POSTs for fetch
negotiation nor pack push; likewise I'm not sure if it covers much of
anything after v2 stateless-connect is established).

>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -	struct curl_slist *headers = http_copy_default_headers();
> +	struct curl_slist *headers;

So here we stop copying the headers at the top of the function...

> [...]
> +retry:
> [...]
> +	headers = http_copy_default_headers();
>  	if (accept_language)
>  		headers = curl_slist_append(headers, accept_language);

And instead set them up totally here. Which make some sense, because we
wouldn't want to append accept_language over and over. But who frees the
old ones? There is a call to curl_slist_free_all(headers) later in the
function, but it's after your "goto retry". So I think each retry would
leak another copy of the list.

The ideal thing would probably be to create the header list once, and
then use it for each retry. That would require reordering some of the
setup. If that's too much, then it would be OK to just create a new list
from scratch on each call. Though in the latter case I suspect it may be
simpler to wrap the whole function, like:

  static int http_request(...)
  {
	int try;
	int result;
	for (try = 0; try < max_retries; i++) {
		result = http_request_try(...);
		if (...result is not retryable...)
			break;
	}
	return result;
  }

and then we'd know that the single-try function just needs to be
self-contained, without worrying about gotos jumping around in it.

-Peff
