Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8FB203C1
	for <e@80x24.org>; Fri, 15 Jul 2016 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcGOTSn (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 15:18:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751470AbcGOTSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 15:18:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C74BD2C247;
	Fri, 15 Jul 2016 15:18:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=COZSJs9u1iClCDF6T3UulQm3rOI=; b=HbjDPw
	4sICBzknixTKtWjKXyPaMLLOXOnlIqx3+x5LoTZlB6wtxdltIFsQ+MTSsBTyq4Fo
	Garv39LU8PB0pf9fU4Neg6V+xdr3vcqe9I0Uph5ICGT0AiWGMzXjIUw197S8wx8/
	JCU9zXMIfsvtUsXtGjo5uRCkmkVQ4aHn+gBns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p/lKMrmGIo027ddAYtkrrFNbhTVQ0U87
	PhHnvbGEm6KxMTRCyv20Iy9sT3k5I7x4IED/YaTcRp0ms0dGw3uNk1ce1BgdwRoS
	lNEgSWGJPHrtAc3PFIjCTUgju6EbUMcZWk/QVHDVqa+sPrVxwZYORG7Q6HVE0z+I
	Ef6+wGBehKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C00E62C245;
	Fri, 15 Jul 2016 15:18:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 462812C243;
	Fri, 15 Jul 2016 15:18:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
References: <20160715102506.GA23164@sigill.intra.peff.net>
	<20160715104347.GL19271@sigill.intra.peff.net>
Date:	Fri, 15 Jul 2016 12:18:38 -0700
In-Reply-To: <20160715104347.GL19271@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jul 2016 06:43:47 -0400")
Message-ID: <xmqq7fcmn20h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F00DCF76-4AC0-11E6-A237-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 1cba120..54f2cfb 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1626,6 +1626,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	struct pack_idx_option opts;
>  	unsigned char pack_sha1[20];
>  	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
> +	int report_end_of_input = 0;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(index_pack_usage);
> @@ -1697,6 +1698,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  				verbose = 1;
>  			} else if (!strcmp(arg, "--show-resolving-progress")) {
>  				show_resolving_progress = 1;
> +			} else if (!strcmp(arg, "--report-end-of-input")) {
> +				report_end_of_input = 1;
>  			} else if (!strcmp(arg, "-o")) {
>  				if (index_name || (i+1) >= argc)
>  					usage(index_pack_usage);
> @@ -1754,6 +1757,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  		obj_stat = xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat));
>  	ofs_deltas = xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
>  	parse_pack_objects(pack_sha1);
> +	if (report_end_of_input)
> +		write_in_full(2, "\0", 1);
>  	resolve_deltas();
>  	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
>  	free(ofs_deltas);

I naively thought "well, if we are teaching index-pack a new trick
anyway, why not make it do the keepalive?", but that would not work
because a keepalive is a 0-byte payload on band#1, i.e. "0005\1",
and index-pack is not aware of the sideband framing at all.

So I agree that a-nul-in-fd#2 is the best mechansim we can make it
work.

Thanks.
