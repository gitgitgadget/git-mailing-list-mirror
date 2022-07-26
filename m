Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797CCCA48A
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 00:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiGZAE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiGZAE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 20:04:56 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CFF22BFD
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:04:53 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C40EF3F4114;
        Mon, 25 Jul 2022 20:04:52 -0400 (EDT)
Received: from jeffhost-mbp.lan (96-93-223-209-static.hfc.comcastbusiness.net [96.93.223.209])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0C1163F4090;
        Mon, 25 Jul 2022 20:04:51 -0400 (EDT)
Subject: Re: [PATCH] fetch-pack: add tracing for negotiation rounds
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <16998c06-8394-1c8a-06d1-0f7ac4034cf4@jeffhostetler.com>
Date:   Mon, 25 Jul 2022 20:04:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/25/22 6:13 PM, Josh Steadmon wrote:
> Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
> the entire negotiation process. However, we'd like additional data, such
> as timing for each round of negotiation or the number of "haves" in each
> round. Additionally, "independent negotiation" (AKA push negotiation)
> has no tracing at all. Having this data would allow us to compare the
> performance of the various negotation implementations, and to debug
> unexpectedly slow fetch & push sessions.
> 
> Fix this by adding per-round trace2 regions for all negotiation
> implementations (V0+V1, V2, and independent negotiation), as well as an
> overall region for independent negotiation. Add trace2 data logging for
> the number of haves and "in vain" objects for each round, and for the
> total number of rounds once negotiation completes.  Finally, add a few
> checks into various tests to verify that the number of rounds is logged
> as expected.

I've been wanting to add data like this around the negotiation
code for a while now.  Thanks!

> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>   fetch-pack.c                       | 62 +++++++++++++++++++++++++++++-
>   t/t5500-fetch-pack.sh              |  4 +-
>   t/t5516-fetch-push.sh              | 10 ++++-
>   t/t5601-clone.sh                   |  6 ++-
>   t/t5703-upload-pack-ref-in-want.sh |  6 ++-
>   5 files changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index cb6647d657..01a451e456 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -299,6 +299,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>   {
>   	int fetching;
>   	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
> +	int negotiation_round = 0, haves = 0;
>   	const struct object_id *oid;
>   	unsigned in_vain = 0;
>   	int got_continue = 0;
> @@ -441,9 +442,19 @@ static int find_common(struct fetch_negotiator *negotiator,
>   		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
>   		print_verbose(args, "have %s", oid_to_hex(oid));
>   		in_vain++;
> +		haves++;
>   		if (flush_at <= ++count) {
>   			int ack;
>   
> +			negotiation_round++;
> +			trace2_region_enter_printf("negotiation_v0_v1", "round",
> +						   the_repository, "round-%d",
> +						   negotiation_round);

I'm wondering here if the "round-%d" should have some number
of leading zeros so that multiple rounds will sort correctly
when you have a bunch of them.

I'm also wondering (and this is more of a style thing, so feel
free to ignore) if we could just use trace2_region_enter()
and make the "label" field be the "round/%04d" and not need
the extra args.


> +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> +					   "haves_added", haves);
> +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> +					   "in_vain", in_vain);
> +			haves = 0;

Thanks,
Jeff
