Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3261B1F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbcG2V36 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:29:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751755AbcG2V35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:29:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7C0532255;
	Fri, 29 Jul 2016 17:29:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OOG0ZgGldf+/b/cJxnMMWagHQi8=; b=OHh5N0
	9EdbMLVbFFyvnjBTcrnLrRVr76fprQU5bj0oQve8xW5opaA2fMKjwwIX8Mp+f/PD
	tvrFlDkhuXq2aLesRFPXr24Ad34MqRdaQPk7D1x0iPq2rUK0sAwdkFCHmfAZU1mi
	BUz1cG1T8/kEBjcfl1xFI/w1SFDgVWMhtXKXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IulM79Wh4U0QH9hqp0iVMnBQonrHE0zD
	SdM7ji8mzrbgW5jW4C979AoVKKG6UB7d/7yIO+W0LlA/x7cNcxp0OP11t+6qp1wR
	0Q/bmbe25g5nBgUErRSUpAsHVIw6Lvmf6IWYNaiReBNxvL28QoF+b7+Gl1IWw1vT
	t7auQmU9c6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0A2232254;
	Fri, 29 Jul 2016 17:29:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C4432253;
	Fri, 29 Jul 2016 17:29:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-2-kcwillford@gmail.com>
Date:	Fri, 29 Jul 2016 14:29:52 -0700
In-Reply-To: <20160729161920.3792-2-kcwillford@gmail.com> (Kevin Willford's
	message of "Fri, 29 Jul 2016 12:19:17 -0400")
Message-ID: <xmqqeg6cm8tr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97A1DADA-55D3-11E6-B0C4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> +static int patch_id_cmp(struct patch_id *a,
> +			struct patch_id *b,
> +			void *keydata)
>  {
> +	return hashcmp(a->patch_id, b->patch_id);
>  }
>  
>  int init_patch_ids(struct patch_ids *ids)
>  {
>  	memset(ids, 0, sizeof(*ids));
>  	diff_setup(&ids->diffopts);
>  	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
>  	diff_setup_done(&ids->diffopts);
> +	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
>  	return 0;
>  }

This is a tangent, and I do not suggest to change patch 1/4 to flip
the style, but I am not sure if this is a good style, or casting it
the other way around is better from the type-checking point of view,
i.e.

    static int cmp_fn(const void *a_, const void *b_, const void *keydata)
    {
	struct patch_id *a = a_;
        struct patch_id *b = b_;
	return hashcmp(a->patch_id, b->patch_id);
    }

    ...
    	hashmap_init(..., cmp_fn, ...);
    ...

I see many existing calls to hashmap_init() follow this pattern, so
as I said, patch 1/4 is fine as-is.

Thanks.
