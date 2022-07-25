Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51565C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiGYXH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGYXH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:07:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1F248F2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:07:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DCAA1A56EB;
        Mon, 25 Jul 2022 19:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B0pahc4XKjLbn0yg/qZZ07IY8Y8WjtnfpGY0JN
        u7w9A=; b=wdkLqMZe6yRsW0g+Cv/vYuORqGfQua/11mr5pkGPEAz98p6LYBbW6L
        0wvOpOjLXtnKPzKVPKD/Jl90h2FCvAmqoCZ7kQDpyHezqfWgGQB4bAwGKQv9DlaA
        CsxqwMt+WMrUJ8V+2+nSRYGTw2tqi2qxah5zblWzTpGt092rgPF5Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 964411A56EA;
        Mon, 25 Jul 2022 19:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A8D21A56E9;
        Mon, 25 Jul 2022 19:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: add tracing for negotiation rounds
References: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
Date:   Mon, 25 Jul 2022 16:07:21 -0700
In-Reply-To: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 25 Jul 2022 15:13:32 -0700")
Message-ID: <xmqqilnkyeom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A37C618-0C6E-11ED-AB39-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
> the entire negotiation process. However, we'd like additional data, such
> as timing for each round of negotiation or the number of "haves" in each
> round. Additionally, "independent negotiation" (AKA push negotiation)
> has no tracing at all. Having this data would allow us to compare the
> performance of the various negotation implementations, and to debug
> unexpectedly slow fetch & push sessions.

Quite sensibly argued.  I do not necessarily see the current code as
"broken", and "fix" at the beginning of the next line may not be an
appropriate word to describe this enhancement, but I think it would
be nice to have such numbers.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index cb6647d657..01a451e456 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -299,6 +299,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  {
>  	int fetching;
>  	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
> +	int negotiation_round = 0, haves = 0;
>  	const struct object_id *oid;
>  	unsigned in_vain = 0;
>  	int got_continue = 0;
> @@ -441,9 +442,19 @@ static int find_common(struct fetch_negotiator *negotiator,
>  		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
>  		print_verbose(args, "have %s", oid_to_hex(oid));
>  		in_vain++;
> +		haves++;
>  		if (flush_at <= ++count) {
>  			int ack;
>  
> +			negotiation_round++;
> +			trace2_region_enter_printf("negotiation_v0_v1", "round",
> +						   the_repository, "round-%d",
> +						   negotiation_round);

Not an objection, but all the hits to existing calls to this
function show the data in a format as vanilla as possible without
frills (presumably to make it easier to mechanically parse the value
out when needed???), and the "round-" prefix we see here somehow
looks out of place.  Doesn't the fact that the record is in the
"negotiation_v0_v1" category and has label "round" clear enough sign
that the value presented is the negotiation_round?

> +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> +					   "haves_added", haves);
> +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> +					   "in_vain", in_vain);
> +			haves = 0;
>  			packet_buf_flush(&req_buf);
>  			send_request(args, fd[1], &req_buf);
>  			strbuf_setlen(&req_buf, state_len);
> @@ -465,6 +476,9 @@ static int find_common(struct fetch_negotiator *negotiator,
>  						      ack, oid_to_hex(result_oid));
>  				switch (ack) {
>  				case ACK:
> +					trace2_region_leave_printf("negotiation_v0_v1", "round",
> +								   the_repository, "round-%d",
> +								   negotiation_round);
>  					flushes = 0;
>  					multi_ack = 0;
>  					retval = 0;
> @@ -490,6 +504,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  						const char *hex = oid_to_hex(result_oid);
>  						packet_buf_write(&req_buf, "have %s\n", hex);
>  						state_len = req_buf.len;
> +						haves++;
>  						/*
>  						 * Reset in_vain because an ack
>  						 * for this commit has not been
> @@ -510,14 +525,26 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			flushes--;
>  			if (got_continue && MAX_IN_VAIN < in_vain) {
>  				print_verbose(args, _("giving up"));
> +				trace2_region_leave_printf("negotiation_v0_v1", "round",
> +							   the_repository, "round-%d",
> +							   negotiation_round);
>  				break; /* give up */
>  			}
> -			if (got_ready)
> +			if (got_ready) {
> +				trace2_region_leave_printf("negotiation_v0_v1", "round",
> +							   the_repository, "round-%d",
> +							   negotiation_round);
>  				break;
> +			}
> +			trace2_region_leave_printf("negotiation_v0_v1", "round",
> +						   the_repository, "round-%d",
> +						   negotiation_round);
>  		}

Having many duplicated calls to "leave" makes the whole thing look
somewhat confused.  Is this primarily because we have too many
"break" that breaks out of the loop?

> @@ -1603,6 +1632,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct oidset common = OIDSET_INIT;
>  	struct packet_reader reader;
>  	int in_vain = 0, negotiation_started = 0;
> +	int negotiation_round = 0;
>  	int haves_to_send = INITIAL_FLUSH;
>  	struct fetch_negotiator negotiator_alloc;
>  	struct fetch_negotiator *negotiator;
> @@ -1659,6 +1689,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  						    "negotiation_v2",
>  						    the_repository);
>  			}
> +			negotiation_round++;
> +			trace2_region_enter_printf("negotiation_v2", "round",
> +						   the_repository, "round-%d",
> +						   negotiation_round);
>  			if (send_fetch_request(negotiator, fd[1], args, ref,
>  					       &common,
>  					       &haves_to_send, &in_vain,
> @@ -1686,12 +1720,20 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			} else {
>  				do_check_stateless_delimiter(args->stateless_rpc, &reader);
>  				state = FETCH_SEND_REQUEST;
> +				trace2_region_leave_printf("negotiation_v2", "round",
> +							   the_repository, "round-%d",
> +							   negotiation_round);
>  			}
>  			break;
>  		case FETCH_GET_PACK:
> +			trace2_region_leave_printf("negotiation_v2", "round",
> +						   the_repository, "round-%d",
> +						   negotiation_round);

Hmph.  Doesn't this logically belong to the "FETCH_PROCESS_ACKS"
case arm?  We "leave" the current round when we did not get "ready"
and "enter" the next round by moving to "FETCH_SEND_REQUEST" state,
but at the same location when we did get "ready", we can "leave" the
current (and final) round and move to "FETCH_GET_PACK" state.  I
suspect the code structure and control flow becomes easier to see
when expressed that way.

>  			trace2_region_leave("fetch-pack",
>  					    "negotiation_v2",
>  					    the_repository);
> +			trace2_data_intmax("negotiation_v2", the_repository,
> +					   "total_rounds", negotiation_round);
>  			/* Check for shallow-info section */
>  			if (process_section_header(&reader, "shallow-info", 1))
>  				receive_shallow_info(args, &reader, shallows, si);
