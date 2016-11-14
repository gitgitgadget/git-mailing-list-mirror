Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DACF203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 21:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938730AbcKNVTx (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 16:19:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50961 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938697AbcKNVTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 16:19:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BEED4E46E;
        Mon, 14 Nov 2016 16:19:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CZ2qMcQ2jkUYdxr8NVciDiCdKNk=; b=FWzGJn
        Cm5vLpsmabYoDusAI7Gq6dDsU//0dVCgVTdLlLIdvvW7pjAtpbn33+JxqShC0INQ
        JShMxssz1LOAaqnqx6iBDmRazQn18OlNulJyXsdXEFlmGvY2+Z1Z7VaeI/DCH61n
        KDkQ3fNEwo8MAwH2a1eP1P1tboTugqHC//CUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mYxRCeITgLJQgsklfNEtKnVjhu1julQL
        O55SIoJ7zs/UGxtRGNrj96Ul5H8n9ei6wqphoLSls3M9krODb1GiDefxRptlFZtF
        ygdJ0Yb5xa3UdVtNFKM9pkcA5vs9HT+V3bUgifCcdnVOq2Epw66KG14jKIiRm860
        ScIwOSdjs34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6430E4E46D;
        Mon, 14 Nov 2016 16:19:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D02334E46C;
        Mon, 14 Nov 2016 16:19:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any output
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
        <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
        <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
Date:   Mon, 14 Nov 2016 13:19:49 -0800
In-Reply-To: <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Nov 2016 14:40:49 -0500")
Message-ID: <xmqqpolxwyh6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 140C06BE-AAB0-11E6-B4F7-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So something like this. It turned out to be a lot uglier than I had
> hoped because we get fed the data from curl in odd-sized chunks, so we
> need a state machine.

It is unfortunate that we have to snoop the protocol like this to
infer an error, but I do not think we can do better than that
approach.  FWIW, I did not find the logic in update_pktline_state()
you wrote ugly at all.

Having to assume that the end of each round from the other end must
be a FLUSH does feel somewhat ugly and brittle, though.

> diff --git a/remote-curl.c b/remote-curl.c
> index f14c41f4c..605357d77 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -403,6 +403,18 @@ struct rpc_state {
>  	struct strbuf result;
>  	unsigned gzip_request : 1;
>  	unsigned initial_buffer : 1;
> +
> +	enum {
> +		RPC_PKTLINE_ERROR, /* bogus hex chars in length */
> +		RPC_PKTLINE_INITIAL, /* no packets received yet */
> +		RPC_PKTLINE_1, /* got one hex char */
> +		RPC_PKTLINE_2, /* got two hex chars */
> +		RPC_PKTLINE_3, /* got three hex chars */
> +		RPC_PKTLINE_DATA, /* reading data; pktline_len holds remaining */
> +		RPC_PKTLINE_END_OF_PACKET, /* last packet completed */
> +		RPC_PKTLINE_FLUSH, /* last packet was flush */
> +	} pktline_state;
> +	size_t pktline_len;
>  };
>  
>  static size_t rpc_out(void *ptr, size_t eltsize,
> @@ -451,11 +463,77 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
>  }
>  #endif
>  
> +static void update_pktline_state(struct rpc_state *rpc,
> +				 const char *buf, size_t len)
> +{
> +#define READ_ONE_HEX(shift) do { \
> +	int val = hexval(buf[0]); \
> +	if (val < 0) { \
> +		warning("error on %d", *buf); \
> +		rpc->pktline_state = RPC_PKTLINE_ERROR; \
> +		return; \
> +	} \
> +	rpc->pktline_len |= val << shift; \
> +	buf++; \
> +	len--; \
> +} while(0)
> +
> +	while (len > 0) {
> +		switch (rpc->pktline_state) {
> +		case RPC_PKTLINE_ERROR:
> +			/* previous error; there is no recovery */
> +			return;
> +
> +		/* We can start a new pktline at any of these states */
> +		case RPC_PKTLINE_INITIAL:
> +		case RPC_PKTLINE_FLUSH:
> +		case RPC_PKTLINE_END_OF_PACKET:
> +			rpc->pktline_len = 0;
> +			READ_ONE_HEX(12);
> +			rpc->pktline_state = RPC_PKTLINE_1;
> +			break;
> +
> +		case RPC_PKTLINE_1:
> +			READ_ONE_HEX(8);
> +			rpc->pktline_state = RPC_PKTLINE_2;
> +			break;
> +
> +		case RPC_PKTLINE_2:
> +			READ_ONE_HEX(4);
> +			rpc->pktline_state = RPC_PKTLINE_3;
> +			break;
> +
> +		case RPC_PKTLINE_3:
> +			READ_ONE_HEX(0);
> +			if (rpc->pktline_len) {
> +				rpc->pktline_state = RPC_PKTLINE_DATA;
> +				rpc->pktline_len -= 4;
> +			} else
> +				rpc->pktline_state = RPC_PKTLINE_FLUSH;
> +			break;
> +
> +		case RPC_PKTLINE_DATA:
> +			if (len < rpc->pktline_len) {
> +				rpc->pktline_len -= len;
> +				len = 0;
> +			} else {
> +				buf += rpc->pktline_len;
> +				len -= rpc->pktline_len;
> +				rpc->pktline_len = 0;
> +				rpc->pktline_state = RPC_PKTLINE_END_OF_PACKET;
> +			}
> +			break;
> +		}
> +	}
> +#undef READ_ONE_HEX
> +}
> +
>  static size_t rpc_in(char *ptr, size_t eltsize,
>  		size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
>  	struct rpc_state *rpc = buffer_;
> +	update_pktline_state(rpc, ptr, size);
>  	write_or_die(rpc->in, ptr, size);
>  	return size;
>  }
> @@ -659,6 +737,8 @@ static int post_rpc(struct rpc_state *rpc)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
>  
> +	rpc->pktline_state = RPC_PKTLINE_INITIAL;
> +
>  	err = run_slot(slot, NULL);
>  	if (err == HTTP_REAUTH && !large_request) {
>  		credential_fill(&http_auth);
> @@ -667,6 +747,11 @@ static int post_rpc(struct rpc_state *rpc)
>  	if (err != HTTP_OK)
>  		err = -1;
>  
> +	if (rpc->pktline_state != RPC_PKTLINE_FLUSH) {
> +		error("invalid or truncated response from http server");
> +		err = -1;
> +	}
> +
>  	curl_slist_free_all(headers);
>  	free(gzip_body);
>  	return err;
