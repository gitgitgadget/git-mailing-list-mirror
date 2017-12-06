Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1690620C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdLFWKx (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:10:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50540 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751544AbdLFWKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:10:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49B92B1F9F;
        Wed,  6 Dec 2017 17:10:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+1kEZ2ckOFW2eoP2qBocV2TF0fs=; b=oaF0at
        LNw8PV1zI8RJyNDuTMetaHr1TKG3axSj3sqBG7dhgYO12TcB74vEBBy6LII/bMOa
        OgVwRIwr/nDnTrE9HbVjHtitK48CfuDgtvDNiwbfQPx5x9T9uGTeRg7OHM+AMUJz
        vU+fVgpZ0GuBGav4y+HpjjALUTs2iYkWxxVuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FObk7GjhHSLxePutfP3LgyTVSkKYfBrj
        dzlKKP89fkswlOknySNbVwZRwn/croeXd8My2fywL3LGUKrs40Ms/2SlWnj4mDHw
        6D17wDxdMvAR7qXpxXAs4hkyFNq38aNuwWvA5JIvkH8kuLJr/vzOZtBaWF/Z0MkT
        +bM4ypctzP8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41285B1F9C;
        Wed,  6 Dec 2017 17:10:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4269B1F9B;
        Wed,  6 Dec 2017 17:10:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 06/15] transport: use get_refs_via_connect to get refs
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-7-bmwill@google.com>
Date:   Wed, 06 Dec 2017 14:10:50 -0800
In-Reply-To: <20171204235823.63299-7-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 15:58:14 -0800")
Message-ID: <xmqqmv2vfqxh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52571A1E-DAD2-11E7-A07F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Remove code duplication and use the existing 'get_refs_via_connect()'
> function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> 'git_transport_push()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index d75ff0514..7c969f285 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.cloning = transport->cloning;
>  	args.update_shallow = data->options.update_shallow;
>  
> -	if (!data->got_remote_heads) {
> -		connect_setup(transport, 0);
> -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> -				 NULL, &data->shallow);
> -		data->got_remote_heads = 1;
> -	}
> +	if (!data->got_remote_heads)
> +		refs_tmp = get_refs_via_connect(transport, 0);

The updated version is equivalent to the original as long as
transport->data->extra_have is empty at this point.  Were we
deliberately sending NULL, instead of &data->extra_have, in the
original, or is it a mere oversight?

The same comment applies to the other hunk of this patch.
