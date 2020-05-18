Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F581C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC71A207C4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="udAgU3Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgERSlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:41:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62596 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgERSlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:41:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A487F4A882;
        Mon, 18 May 2020 14:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WoRBrFG/KQujyVKFtAxVpHaU4Oc=; b=udAgU3
        Ngrc7X9RbpyETYoicXuB2Isu6DUBN7BnrG0a4+aefDw2e7E5rQOpezaqnC5Oz00h
        /7Ac7/GXMBNztrX+wejldBnz+bIv4e5W839glTcucJbex24BNkNakxzCgIEcz/JZ
        F7NFnSWyobBb+ePlr7+w1By4g822GgK8QcFzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZbCrYWoPPh3hyq2TcHG3xz+tfyKnCIOZ
        w0Ckpq1Ldcl3RXIubc32KzTS9rmqk/Sfn2/sWn3CnaRQBnXdhIWlKX1Z7Xd4D5jc
        vFZMHrO7au+5n1ig0tA8cxKJnDWze5ZKjN/SV0DxBcNKm6p956t0EByzrJe6dvJ0
        PEHzXhm4r9U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B2204A881;
        Mon, 18 May 2020 14:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27B884A880;
        Mon, 18 May 2020 14:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/7] transport: extract common fetch_pack() call
References: <cover.1589393036.git.liu.denton@gmail.com>
        <cover.1589816718.git.liu.denton@gmail.com>
        <3a42575bd5d124b6b2e536b1511107ebf5ec1091.1589816719.git.liu.denton@gmail.com>
Date:   Mon, 18 May 2020 11:40:58 -0700
In-Reply-To: <3a42575bd5d124b6b2e536b1511107ebf5ec1091.1589816719.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 18 May 2020 11:47:20 -0400")
Message-ID: <xmqqpnb12iit.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DE14B6C-9937-11EA-BD5A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In the switch statement, the difference between the `protocol_v2` and
> `protocol_v{1,0}` arms is a preparatory call to die_if_server_options() in
> the latter. The fetch_pack() call is identical in both arms. However,
> since this fetch_pack() call has so many parameters, it is not
> immediately obvious that the call is identical in both cases.

Sure.

	if (data->version < protocol_v2)
		die_if_server_options(transport);
	else if (data->version == protocol_unknown_version)
		BUG("...");

	refs = fetch_pack(...);

might have been even easier to follow, but that's OK.

>  	switch (data->version) {
>  	case protocol_v2:
> -		refs = fetch_pack(&args, data->fd,
> -				  refs_tmp ? refs_tmp : transport->remote_refs,
> -				  to_fetch, nr_heads, &data->shallow,
> -				  &transport->pack_lockfile, data->version);
> +		/* do nothing */
>  		break;
>  	case protocol_v1:
>  	case protocol_v0:
>  		die_if_server_options(transport);
> -		refs = fetch_pack(&args, data->fd,
> -				  refs_tmp ? refs_tmp : transport->remote_refs,
> -				  to_fetch, nr_heads, &data->shallow,
> -				  &transport->pack_lockfile, data->version);
>  		break;
>  	case protocol_unknown_version:
>  		BUG("unknown protocol version");
>  	}
> +	refs = fetch_pack(&args, data->fd,
> +			  refs_tmp ? refs_tmp : transport->remote_refs,
> +			  to_fetch, nr_heads, &data->shallow,
> +			  &transport->pack_lockfile, data->version);
>  
>  	close(data->fd[0]);
>  	close(data->fd[1]);
