Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98DC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B0560C40
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhJ0UdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:33:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57307 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbhJ0UdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:33:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D018EAD68;
        Wed, 27 Oct 2021 16:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VAAxSpQ3dCZKeIf2P6nSxbBjOsukQxJdSaIygs
        0g/tY=; b=TXWjUVLTgBwfaBVISTP1Sqcy+Fmqb7VtsbfGzjxiIrVsmIq9fxVVLh
        Nd3xcEUJvIkZfxehvLlu326/03i7/oRLOaX+e+RCqtD8Jy8gY/aSCfuGuomabXZ6
        ks6Z1IQBguDME3qjVoDLUPnpYH3lbuYBQd7K114ntz80Rr48cUpUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02AA5EAD67;
        Wed, 27 Oct 2021 16:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AF9BEAD66;
        Wed, 27 Oct 2021 16:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/6] ssh signing: make verify-commit consider key
 lifetime
References: <20211027080616.619956-1-fs@gigacodes.de>
        <20211027080616.619956-4-fs@gigacodes.de>
Date:   Wed, 27 Oct 2021 13:30:51 -0700
In-Reply-To: <20211027080616.619956-4-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 27 Oct 2021 10:06:13 +0200")
Message-ID: <xmqqsfwmus5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7703ACC-3764-11EC-8A59-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> +static int parse_payload_metadata(struct signature_check *sigc)
> +{
> +	const char *ident_line = NULL;
> +	size_t ident_len;
> +	struct ident_split ident;
> +	const char *signer_header;
> +
> +	switch(sigc->payload_type) {
> +		case SIGNATURE_PAYLOAD_COMMIT:
> +			signer_header = "committer";
> +			break;
> +		case SIGNATURE_PAYLOAD_TAG:
> +			signer_header = "tagger";
> +			break;
> +		default:
> +			/* Ignore unknown payload types */
> +			return 0;
> +	}

The case arms should be indented to the same level as opening
switch().  Have SP between keyword "switch" and the expression
the statement switches on.

More importantly, can you explain why it is necessary to allow
callers to call this function with a random value in payload_type
and have it silently succeed?  Isn't it a programming error that
deserves a call to BUG("...")?

Thanks.
