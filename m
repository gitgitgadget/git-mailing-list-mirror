Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0591F462
	for <e@80x24.org>; Thu, 21 Feb 2019 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfBUNqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:46:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:52536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726199AbfBUNqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:46:12 -0500
Received: (qmail 20323 invoked by uid 109); 21 Feb 2019 13:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12445 invoked by uid 111); 21 Feb 2019 13:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:46:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:46:10 -0500
Date:   Thu, 21 Feb 2019 08:46:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] remote-curl: use post_rpc() for protocol v2 also
Message-ID: <20190221134609.GA21406@sigill.intra.peff.net>
References: <cover.1550170980.git.jonathantanmy@google.com>
 <25ea75eb435ed8fed759b30a4c362a68818a8905.1550170980.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25ea75eb435ed8fed759b30a4c362a68818a8905.1550170980.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 11:06:39AM -0800, Jonathan Tan wrote:

> diff --git a/remote-curl.c b/remote-curl.c
> index 32c133f636..13836e4c28 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -504,6 +504,18 @@ struct rpc_state {
>  	int any_written;
>  	unsigned gzip_request : 1;
>  	unsigned initial_buffer : 1;
> +
> +	/*
> +	 * Whenever a pkt-line is read into buf, append the 4 characters
> +	 * denoting its length before appending the payload.
> +	 */
> +	unsigned write_line_lengths : 1;

Hmm, so we read a packet, and then we "append its length" before
appending the contents. But that would always be the length we just
read, right? I wonder if it would be simpler to just call this option
something like "proxy_packets" or "full_packets", teach the packet code
to give us the full packets, and then just treat that whole buffer as a
unit. I dunno. There might be some gotchas in practice, and it's not
like it's that much simpler. Just a thought.

> +	/*
> +	 * rpc_out uses this to keep track of whether it should continue
> +	 * reading to populate the current request. Initialize to 0.
> +	 */
> +	unsigned stop_reading : 1;

OK, so we need this because the v2 proxying will require us to stop
reading but keep the channel open? Kind of awkward, but I don't see a
way around it.

> +static int rpc_read_from_out(struct rpc_state *rpc, int options,
> +			     size_t *appended,
> +			     enum packet_read_status *status) {
> +	size_t left;
> +	char *buf;
> +	int pktlen_raw;
> +
> +	if (rpc->write_line_lengths) {
> +		left = rpc->alloc - rpc->len - 4;
> +		buf = rpc->buf + rpc->len + 4;
> +	} else {
> +		left = rpc->alloc - rpc->len;
> +		buf = rpc->buf + rpc->len;
> +	}

OK, so we push the packets 4 bytes further into the buffer in that case,
leaving room for the header. Makes sense.

>  	if (left < LARGE_PACKET_MAX)
>  		return 0;
>  
> -	*appended = packet_read(rpc->out, NULL, NULL, buf, left, 0);
> -	rpc->len += *appended;
> +	*status = packet_read_with_status(rpc->out, NULL, NULL, buf,
> +			left, &pktlen_raw, options);
> +	if (*status != PACKET_READ_EOF) {
> +		*appended = pktlen_raw + (rpc->write_line_lengths ? 4 : 0);
> +		rpc->len += *appended;
> +	}
> +
> +	if (rpc->write_line_lengths) {
> +		switch (*status) {
> +		case PACKET_READ_EOF:
> +			if (!(options & PACKET_READ_GENTLE_ON_EOF))
> +				die("shouldn't have EOF when not gentle on EOF");
> +			break;
> +		case PACKET_READ_NORMAL:
> +			set_packet_header(buf - 4, *appended);
> +			break;
> +		case PACKET_READ_DELIM:
> +			memcpy(buf - 4, "0001", 4);
> +			break;
> +		case PACKET_READ_FLUSH:
> +			memcpy(buf - 4, "0000", 4);
> +			break;
> +		}
> +	}

And here we fill it in. Make sense. It's a little awkward that we have
to re-translate READ_DELIM, etc, back into their headers.

> @@ -531,15 +580,32 @@ static size_t rpc_out(void *ptr, size_t eltsize,
>  	size_t max = eltsize * nmemb;
>  	struct rpc_state *rpc = buffer_;
>  	size_t avail = rpc->len - rpc->pos;
> +	enum packet_read_status status;
>  
>  	if (!avail) {
>  		rpc->initial_buffer = 0;
>  		rpc->len = 0;
> -		if (!rpc_read_from_out(rpc, &avail))
> -			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
> -		if (!avail)
> -			return 0;
>  		rpc->pos = 0;
> +		if (!rpc->stop_reading) {
> +			if (!rpc_read_from_out(rpc, 0, &avail, &status))
> +				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");

Do we actually need it to be LARGE_PACKET_MAX+4 here? I guess not,
because LARGE_PACKET_DATA_MAX is the "-4" version. So I think this BUG()
was perhaps already wrong?

> +			if (status == PACKET_READ_FLUSH)
> +				/*
> +				 * We are done reading for this request, but we
> +				 * still need to send this line out (if
> +				 * rpc->write_line_lengths is true) so do not
> +				 * return yet.
> +				 */
> +				rpc->stop_reading = 1;
> +		}
> +	}
> +	if (!avail && rpc->stop_reading) {
> +		/*
> +		 * "return 0" will notify Curl that this RPC request is done,
> +		 * so reset stop_reading back to 0 for the next request.
> +		 */
> +		rpc->stop_reading = 0;
> +		return 0;

OK, and here's where we handle the stop_reading thing. It is indeed
awkward, but I think your comments make it clear what's going on.

If we get stop_reading, do we care about "avail"? I.e., shouldn't we be
able to return non-zero to say "we got the whole input, this is not a
too-large request"?

> +test_expect_success 'clone big repository with http:// using protocol v2' '
> +	test_when_finished "rm -f log" &&
> +
> +	git init "$HTTPD_DOCUMENT_ROOT_PATH/big" &&
> +	# Ensure that the list of wants is greater than http.postbuffer below
> +	for i in $(seq 1 1500)
> +	do
> +		test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/big" "commit$i"
> +	done &&

As Junio noted, this should be test_seq. But I think it would be nice to
avoid looping on test_commit here at all. It kicks off at least 3
processes; multiplying that by 1500 is going to be slow.

Making a big input is often much faster by generating a fast-import
stream (which can often be done entirely in-shell). There's some prior
art in t3302, t5551, t5608, and others.

-Peff
