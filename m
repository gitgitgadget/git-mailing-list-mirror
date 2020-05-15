Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867FC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C6D20643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEOViq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726228AbgEOVip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:38:45 -0400
Received: (qmail 28252 invoked by uid 109); 15 May 2020 21:38:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 21:38:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16323 invoked by uid 111); 15 May 2020 21:38:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 17:38:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 17:38:44 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] remote-curl: error on incomplete packet
Message-ID: <20200515213844.GD115445@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <3ed7cf87aaa40ee66b20aa929d89d28fefcec312.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ed7cf87aaa40ee66b20aa929d89d28fefcec312.1589393036.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 02:04:57PM -0400, Denton Liu wrote:

> Currently, remote-curl acts as a proxy and blindly forwards packets
> between an HTTP server and fetch-pack. In the case of a stateless RPC
> connection where the connection is terminated with a partially written
> packet, remote-curl will blindly send the partially written packet
> before waiting on more input from fetch-pack. Meanwhile, fetch-pack will
> read the partial packet and continue reading, expecting more input. This
> results in a deadlock between the two processes.
> 
> Instead of blindly forwarding packets, inspect each packet to ensure
> that it is a full packet, erroring out if a partial packet is sent.

Hmm. Right now there's no assumption in rpc_in that we're writing
pktlines. Will this always be the case?

I think the answer is probably yes. If there's a case where it isn't, it
might be something like v0 git-over-http against a server which doesn't
have the sideband capability.

> diff --git a/remote-curl.c b/remote-curl.c
> index da3e07184a..8b740354e5 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -682,6 +682,8 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
>  struct rpc_in_data {
>  	struct rpc_state *rpc;
>  	struct active_request_slot *slot;
> +	struct strbuf len_buf;
> +	int remaining;

This remaining is "remaining in the current packet", I assume? An "int"
should be OK for that.

Using a strbuf feels a bit like overkill, because we have to remember to
free it (which I think doesn't actually happen in your patch). Could we
just use a "char len_buf[4]" (you'd need an extra int to count how many
bytes you've received there).

> @@ -702,7 +705,42 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  		return size;
>  	if (size)
>  		data->rpc->any_written = 1;
> -	write_or_die(data->rpc->in, ptr, size);
> +
> +	while (unwritten) {
> +		if (!data->remaining) {
> +			int digits_remaining = 4 - data->len_buf.len;
> +			if (digits_remaining > unwritten)
> +				digits_remaining = unwritten;
> +			strbuf_add(&data->len_buf, ptr, digits_remaining);
> +			ptr += digits_remaining;
> +			unwritten -= digits_remaining;

So we actually save up the 4 bytes, not sending them at all until we get
them. I wonder if this might be easier to follow if our count was simply
advisory. I.e., continue to write data as we get it, but keep a small
state machine tracking pktlines (which could even be done in its own
separate struct/function pair).

I dunno. It might be about the same level of confusing, but it makes it
easy to keep the logic separate from rpc_in, and it lets us put all of
the policy bits at the end, after we know we've received all of the
data (in post_rpc):

  if (data->len_buf.len < 4)
          die("incomplete packet header");
  if (data->remaining)
          die("incomplete packet");
  /* imagine we kept the actual pktlen value, instead of just counting
   * down remaining */
  if (data->pktlen)
          die("did not end in flush");

Notably, I'm not sure if your code will complain if the connection dies
will reading the 4-byte header (remaining would still be 0). That won't
leave the caller trying to read the packet (we never sent them the
header), but they may still be waiting for a response.

> +			if (data->len_buf.len == 4) {
> +				data->remaining = packet_length(data->len_buf.buf);
> +				if (data->remaining < 0) {
> +					die(_("remote-curl: bad line length character: %.4s"), data->len_buf.buf);
> +				} else if (data->remaining <= 1) {
> +					data->remaining = 0;

This treats 0001 delimiters the same as a 0000 flush. Expecting 0 more
bytes is the right thing, but would we later want to differentiate in
post_rpc()? I.e., is it ever correct for the server data to end with a
delim?

> +				} else if (data->remaining < 4) {
> +					die(_("remote-curl: bad line length %d"), data->remaining);

We don't use an 0002 or 0003 packet for anything yet, but this would
need to be updated if we ever did. I wonder if we should treat them also
as zero-length packets and quietly pass through, which is likely the
right thing to do. OTOH, this should complain loudly enough that
somebody would presumably notice as soon as they tried to use those
packets.

Regarding testing, I think the ideal thing would be a proxy layer we
could insert that simply eats all data after N bytes. That would be easy
to do if we could use --upload-pack='git-upload-pack | head -c 500' or
something. But we need it to happen between curl and the server side of
Git. Possibly we could insert something between apache and
git-http-backend (simialr to how we handle broken-smart-http.sh.

-Peff
