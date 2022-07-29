Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B799C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiG2SGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiG2SGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:06:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F389675
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:06:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B96211363C8;
        Fri, 29 Jul 2022 14:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8IZf2E50/QF7KlkxwaYkvMbE/oBJ1LHtXFH5SE
        vqvog=; b=JgxMT32fCm6Q4XpYgwaIL+CV7ubBzPab8jLjHr+JLkxa0A71TuQegQ
        TtQz/ZAWuJLDX07b8lXVtcBLNCnf5jaCcf1NjM29wug4kkgVR7L3gHSmC3DZAD9w
        IEJQl7JYLUbX1fmcH0MAbmDoYKAesoi5k1NtaJhxF6X2VkTgGgnQM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B11601363C7;
        Fri, 29 Jul 2022 14:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24D381363C6;
        Fri, 29 Jul 2022 14:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-6-calvinwan@google.com>
Date:   Fri, 29 Jul 2022 11:06:16 -0700
In-Reply-To: <20220728230210.2952731-6-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:09 +0000")
Message-ID: <xmqqbkt77q07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24336392-0F69-11ED-AED5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +	size_t i;
> +
> +	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "type"))
> +		packet_buf_write(&req_buf, "type");
> +
> +	if (args->oids) {
> +		for (i = 0; i < args->oids->nr; i++)
> +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
> +	}

If !args->oids then we say "we want to request object-info to learn
size and type for the following objects: oh, there are no objects we
are interested in".  I wonder if an early return

	if (!args->oids)
		return;

at the beginning of the function that turns it into a benign no-op,
may make more sense?  Calling "send_X()" helper and seeing nothing
come out on the wire might make it look awkward, though.

> @@ -363,10 +437,12 @@ static int fetch_refs_via_pack(struct transport *transport,
>  			       int nr_heads, struct ref **to_fetch)
>  {
>  	int ret = 0;
> +	size_t i;
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs = NULL;
>  	struct fetch_pack_args args;
>  	struct ref *refs_tmp = NULL;
> +	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));

Style: no SP between "sizeof" and "(".
