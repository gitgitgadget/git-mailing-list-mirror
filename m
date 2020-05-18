Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B8C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCE6207E8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgERQnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:43:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727020AbgERQnK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:43:10 -0400
Received: (qmail 20444 invoked by uid 109); 18 May 2020 16:43:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 16:43:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3717 invoked by uid 111); 18 May 2020 16:43:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 12:43:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 12:43:08 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH v2 7/7] stateless-connect: send response end packet
Message-ID: <20200518164308.GC42240@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <4b079bcd83ea80b8a0e81b0c1e3d5e083efeb9c6.1589816719.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b079bcd83ea80b8a0e81b0c1e3d5e083efeb9c6.1589816719.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 11:47:24AM -0400, Denton Liu wrote:

> A separate control packet is chosen because we need to be able to
> differentiate between what the remote server sends and remote-curl's
> control packets. By ensuring in the remote-curl code that a server
> cannot send response end packets, we prevent a malicious server from
> being able to perform a denial of service attack in which they spoof a
> response end packet and cause the described deadlock to happen.

Thanks for thinking about this. I was wondering what mischief a server
might be able to cause by sending such a packet.

> @@ -446,6 +447,13 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  	if (reader->status != PACKET_READ_FLUSH)
>  		die(_("expected flush after ref listing"));
>  
> +	if (stateless_rpc) {
> +		if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
> +			die(_("expected response end packet after ref listing"));
> +		if (packet_reader_read(reader) != PACKET_READ_FLUSH)
> +			die(_("expected flush packet after response end"));
> +	}

Having two packets here surprised me. We'd have already received the
actual flush from the server (as you can see in the context above).
Wouldn't a single RESPONSE_END be enough to signal the reader?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index f73a2ce6cb..bcbbb7e2fb 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1468,6 +1468,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct fetch_negotiator negotiator_alloc;
>  	struct fetch_negotiator *negotiator;
>  	int seen_ack = 0;
> +	int check_http_delimiter;

This flag was more complicated than I expected, and I'm not sure how we
can easily be certain that all necessary paths are covered.

E.g., in FETCH_PROCESS_ACKS, we'll always be reading a response via
process_acks(). Why do COMMON_FOUND and NO_COMMON_FOUND check for
end-of-response, but READY doesn't? I think the answer is that we'd
continue to read the same response via FETCH_GET_PACK in this instance.

I just wonder if there is a better place to put this logic that would be
more certain to catch every place we'd expect to read to the end of a
response. But I suppose not. We could push it down into process_acks(),
but it would have the same READY logic that's here. I'll admit part of
my complaint is that the existing do_fetch_pack_v2 state-machine switch
is kind of hard to follow, but that's not your fault.

Two things that might help:

  - put a comment in READY to indicate why we don't need to check
    end-of-response (but do for its sibling cases)

  - instead of setting and clearing a variable and then using it to
    check at the end of the loop, call check_http_delimiter(&reader,
    args->stateless_rpc) at the moment we're done with the packet. The
    actual executed code would have the same behavior, I think, but it
    might be easier to understand that we're trying to hit the end of
    each response.

Also, it probably should be check_stateless_delimiter() or something.
There could be other helpers that support stateless-connect besides
http.

Speaking of which: this is a change to the remote-helper protocol, since
we're now expecting stateless-connect helpers to produce these delim
packets (and failing if they don't). I kind of doubt that anybody but
remote-curl has implemented v2 stateless-connect, but should we be
marking this with an extra capability to be on the safe side?

> +		if (args->stateless_rpc && check_http_delimiter) {
> +			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
> +				die(_("git fetch-pack: expected response end packet"));
> +			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
> +				die(_("git fetch-pack: expected flush packet"));
> +		}

I wondered also if stateless_rpc might catch cases besides
stateless-connect. But I guess we're in the v2 fetch-pack path, and that
_only_ understands stateless-connect.

-Peff
