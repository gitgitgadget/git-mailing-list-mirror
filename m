Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45879C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB3207D8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgERQW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:22:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728043AbgERQW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:22:27 -0400
Received: (qmail 20380 invoked by uid 109); 18 May 2020 16:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 16:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3581 invoked by uid 111); 18 May 2020 16:22:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 12:22:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 12:22:25 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/7] remote-curl: error on incomplete packet
Message-ID: <20200518162225.GB42240@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <52ce5fdffd6741eeee8d69b804403383da0d879d.1589816719.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52ce5fdffd6741eeee8d69b804403383da0d879d.1589816719.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 11:47:22AM -0400, Denton Liu wrote:

> +struct check_pktline_state {
> +	char len_buf[4];
> +	int len_filled;
> +	int remaining;
> +};
> +
> +static void check_pktline(struct check_pktline_state *state, const char *ptr, size_t size)

Thanks for converting this. I think having this broken out makes it a
bit easier to reason about, and it should be much easier to reuse if we
need it elsewhere.

> +{
> +	while (size) {
> +		if (!state->remaining) {
> +			int digits_remaining = 4 - state->len_filled;
> +			if (digits_remaining > size)
> +				digits_remaining = size;
> +			memcpy(&state->len_buf[state->len_filled], ptr, digits_remaining);
> +			state->len_filled += digits_remaining;
> +			ptr += digits_remaining;
> +			size -= digits_remaining;

Having personally written and screwed up this kind of parsing state
machine before, I read over this logic quite carefully. ;) I believe
it's correct.

Another way would be to loop by single characters:

  while (state->len_filled < 4 && size) {
          state->len_buf[state->len_filled++] = *ptr;
	  ptr++;
	  size--;
  }

which I _think_ is equivalent, and is a bit shorter. I'm OK with either
(see below, especially).

I'm not sure if it's worth replacing "4" with ARRAY_SIZE(state->len_buf).
I generally try to avoid magic numbers, but it's certainly not like one
could change the size of len_buf and this code would still be useful. :)

> +			if (state->len_filled == 4) {
> +				state->remaining = packet_length(state->len_buf);
> +				if (state->remaining < 0) {
> +					die(_("remote-curl: bad line length character: %.4s"), state->len_buf);
> +				} else if (state->remaining < 4) {
> +					state->remaining = 0;
> +				} else {
> +					state->remaining -= 4;
> +				}
> +				state->len_filled = 0;
> +			}
> +		}

This part makes sense. We'll either leave len_filled as 1-3 (incomplete),
or we'll read a whole packet (for a flush), or we'll be waiting to read
the rest of the packet.

> +		if (state->remaining) {
> +			int remaining = state->remaining;
> +			if (remaining > size)
> +				remaining = size;
> +			ptr += remaining;
> +			size -= remaining;
> +			state->remaining -= remaining;
> +		}
> +	}
> +}

And here we most certainly don't want to read character-by-character,
because we're not doing anything with each one, and we expect there to be
a lot more of them. Having the earlier loop match the form of this one is
perhaps a good reason to leave it alone.

> [...]
> @@ -936,6 +984,11 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
>  	if (!rpc->any_written)
>  		err = -1;
>  
> +	if (rpc_in_data.pktline_state.len_filled)
> +		err = error(_("%d bytes of length header were received"), rpc_in_data.pktline_state.len_filled);
> +	if (rpc_in_data.pktline_state.remaining)
> +		err = error(_("%d bytes of body are still expected"), rpc_in_data.pktline_state.remaining);

And here's the payoff for all of the state machine checks. Makes sense.

> @@ -702,6 +746,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  		return size;
>  	if (size)
>  		data->rpc->any_written = 1;
> +	if (data->check_pktline)
> +		check_pktline(&data->pktline_state, ptr, size);
>  	write_or_die(data->rpc->in, ptr, size);
>  	return size;
>  }

And this is now conditional. Good...

> @@ -920,6 +966,8 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
>  	rpc_in_data.rpc = rpc;
>  	rpc_in_data.slot = slot;
> +	rpc_in_data.check_pktline = stateless_connect;
> +	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));

And we enable it only for stateless-connect. Makes perfect sense.

> --- /dev/null
> +++ b/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
> @@ -0,0 +1,3 @@
> +printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
> +echo
> +printf "%s%s\n" "0079" "45"

Nice. Just having a deterministic half-written packet is way easier to
reason about than my "truncating proxy" suggestion.

> --- /dev/null
> +++ b/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
> @@ -0,0 +1,3 @@
> +printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
> +echo
> +printf "%s\n" "00"

Thanks for covering this case, too.

I confirmed (as I'm sure you did) they both cause git-remote-http to hang
without the fix in this patch.

-Peff
