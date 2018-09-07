Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92381F404
	for <e@80x24.org>; Fri,  7 Sep 2018 04:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIGI7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:59:43 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:48362
        "EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIGI7n (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Sep 2018 04:59:43 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id y8G7fb5f3eCBny8G9fCTxS; Thu, 06 Sep 2018 21:20:42 -0700
Date:   Fri, 7 Sep 2018 07:20:39 +0300
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180907042039.GB20545@jessie.local>
References: <20180906193516.28909-1-max@max630.net>
 <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
 <20180907032740.GA20545@jessie.local>
 <20180907033831.GB1383@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907033831.GB1383@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMx/NjqIXzp4eUfWl8GQhMufdgTUEst9Vn0Ote03U/hO10rIzcvhw4nYg91Apm5qr+srKyhz8hxs+jUT+NafwYCSgPvT1bxQCl+UBgkXkd03SVB3MbP9
 SeEam1XMkzgffZFjUEHvLLBjOGEWUfx6WWVkGCVcRTV/5hdZnwUgFm6nwpOL4ZwpeIj0+FkuVh+ec5VXq+EGMxbyaWBp6krJatb5jOergWiNVZ25F6Ok54Ch
 R3z8xtuOeuhP/zSEwNU4X5taNeeUeGcUXDjRcnCHAL4nKjPoNBqLyi1z6winqK3G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 11:38:31PM -0400, Jeff King wrote:
> My understanding from Jelmer's report is that a present-but-empty
> variable should be counted as "0" to mean "do not read any body bytes".
> That matches my reading of RFC 3875, which says:
> 
>   If no data is attached, then NULL (or unset).
> 
> (and earlier they explicitly define NULL as the empty string). That
> said, we do not do what they say for the "unset" case. And cannot
> without breaking chunked encoding from apache. So I don't know how much
> we want to follow that rfc to the letter, but at least it makes sense to
> me to revert this case back to what Git used to do, and what the rfc
> says.

I could find this discussion about it:
https://lists.gt.net/apache/users/373042

Basically, it says the CGI RFC was written before chunked
encoding appeared, so implementations should choose between
caching all boody before calling script, or breaking the
spec some way. So apache does it so.

(I wonder how IIS would handle it)

> In other words, I think the logic we want is:
> 
>   if (!str) {
> 	/*
> 	 * RFC3875 says this must mean "no body", but in practice we
> 	 * receive chunked encodings with no CONTENT_LENGTH. Tell the
> 	 * caller to read until EOF.
> 	 */
> 	val = -1;
>   } else if (!*str) {
> 	/*
> 	 * An empty length should be treated as "no body" according to
> 	 * RFC3875, and this seems to hold in practice.
> 	 */
> 	val = 0;
>   } else {
> 	/*
> 	 * We have a CONTENT_LENGTH; trust what's in it as long as it
> 	 * can be parsed.
> 	 */
> 	if (!git_parse_ssize_t(str, &val))
> 	        die(...);
>   }

I feel reluctant to treat empty and unset differently, but
probably this is the only thing which could be done.

I'll resumbmit some time later.
