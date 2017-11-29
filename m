Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A042F20954
	for <e@80x24.org>; Wed, 29 Nov 2017 03:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdK2DWS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 22:22:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:43108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751482AbdK2DWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 22:22:17 -0500
Received: (qmail 29164 invoked by uid 109); 29 Nov 2017 03:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Nov 2017 03:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16343 invoked by uid 111); 29 Nov 2017 03:22:35 -0000
Received: from rrcs-98-101-163-98.midsouth.biz.rr.com (HELO sigill.intra.peff.net) (98.101.163.98)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 28 Nov 2017 22:22:35 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Nov 2017 22:22:14 -0500
Date:   Tue, 28 Nov 2017 22:22:14 -0500
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171129032214.GB32345@sigill.intra.peff.net>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-2-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171126193813.12531-2-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 09:38:12PM +0200, Max Kirillov wrote:

> From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Date: Wed, 30 Mar 2016 10:54:21 +0200
> 
> http-backend reads whole input until EOF. However, the RFC 3875 specifies
> that a script must read only as many bytes as specified by CONTENT_LENGTH
> environment variable. Web server may exercise the specification by not closing
> the script's standard input after writing content. In that case http-backend
> would hang waiting for the input. The issue is known to happen with
> IIS/Windows, for example.
> 
> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the variable is not defined, keep older behavior
> of reading until EOF because it is used to support chunked transfer-encoding.

I missed out on review of the earlier iterations from the past few days,
but I looked this over in light of the comments I made long ago in:

  https://public-inbox.org/git/20160329201349.GB9527@sigill.intra.peff.net/

The concerns I had there were:

  1. It did the wrong thing when CONTENT_LENGTH was not present in the
     environment. Your version here gets this right.

  2. I earlier was worried that this wouldn't kick in for the
     inflate_request() code path. It looks like we do use read_request()
     from inflate_request(), but only when buffer_input is true. Which
     means we wouldn't do so for receive-pack (i.e., for pushes).

     I'm not sure if the client would ever gzip a push request. Without
     double-checking, I suspect it would if the list of refs to update
     was sufficiently large (and at any rate, I think other clients
     potentially could do so).

     That _might_ be OK in practice. If the gzip stream is well-formed,
     we'd stop at its end. We'd possibly still try to read() more bytes
     than were promised, but if I understand the original problem,
     that's not that big a deal as long as we don't hang waiting for
     EOF.

     If the stream isn't well-formed, we'd hang waiting for more bytes
     (rather than seeing the EOF and complaining that the gzip stream is
     truncated). That's poor, but no worse than the current behavior.

  3. For large inputs (like incoming packfiles), we connect the
     descriptor directly to index-pack or unpack-objects, and they try
     to read to EOF.

     For a well-formed pack, I _think_ this would work OK. We'd see the
     end of the pack and quit (there's a check for garbage at the end of
     the pack, but it triggers only for the non-pipe case).

     For a truncated input, we'd hang forever rather than report an
     error.

So I suspect there are lurking problems that may trigger in corner
cases. That said, I don't think this pack makes any case _worse_, and it
may make some common ones better. So I'm not opposed, though we may be
giving people a false sense of security that it actually works robustly
on IIS.

> ---
>  config.c       |  2 +-
>  config.h       |  1 +
>  http-backend.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 51 insertions(+), 2 deletions(-)

The patch itself looks OK, modulo the comments already made by others.
Two minor observations, and a possible bug:

> +static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **out)
> +{

I did wonder if this "stop at n bytes" could simply be rolled into the
existing read_request loop (by limiting the length we pass to
read_in_full there). But it may be cleaner to just have a separate
function. There's some repetition, but not much since we can rely on a
single malloc and read_in_full() for this case.

> +	unsigned char *buf = NULL;
> +	ssize_t cnt = 0;
> +
> +	if (max_request_buffer < req_len) {
> +		die("request was larger than our maximum size (%lu): %lu;"
> +			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
> +			    max_request_buffer,
> +			    req_len);
> +	}
> +
> +	if (req_len <= 0) {
> +		*out = NULL;
> +		return 0;
> +	}

I was slightly surprised by "<= 0" here. We should never get here with a
negative req_len, since we'd catch that in the read_request() wrapper
here. If we want to document that assumption, should this be
assert(req_len >= 0)?

I'm also puzzled about the behavior with a zero-byte CONTENT_LENGTH.
We'd return NULL here. But in the other read_request_eof() path, we'd
end up with a non-NULL pointer. I'm not sure if it matters to the caller
or not, but it seems like a potential trap.

Is it even worth special-casing here? Our xmalloc and read_in_full
wrappers should handle the zero-byte just fine. I think this whole
conditional could just go away.

-Peff
