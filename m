Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3109FC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33486140C
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFODxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:53:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56118 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhFODxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:53:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD8CEDFA7A;
        Mon, 14 Jun 2021 23:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YYtgbX5WKO+HiSHO490R3btbbpFJyUA31jweXS
        SaRNY=; b=JdmRLdexvheaVFI9biXihD6WZdp7j3wD4KPXbWZBUpVe1j5e08CAcY
        5L3QmtcsE7U5WqhOX2rurC3vO/VRD/zUmeWBtmoxBwFyr009Xl6JMRsgJb+fpaA2
        LhtxJ2wzYtYTCcBgEWWITLQfXZGgKZ4cI+ICLfuLJitMGdxrCWi1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C55E1DFA79;
        Mon, 14 Jun 2021 23:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57FB5DFA78;
        Mon, 14 Jun 2021 23:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] submodule--helper: refactor module_clone()
References: <20210610083916.96243-1-raykar.ath@gmail.com>
        <20210614125157.99426-1-raykar.ath@gmail.com>
        <20210614125157.99426-2-raykar.ath@gmail.com>
Date:   Tue, 15 Jun 2021 12:51:28 +0900
In-Reply-To: <20210614125157.99426-2-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Mon, 14 Jun 2021 18:21:55 +0530")
Message-ID: <xmqqzgvrwzsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F75755D2-CD8C-11EB-AA05-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Separate out the core logic of module_clone() from the flag
> parsing---this way we can call the equivalent of the `submodule--helper
> clone` subcommand directly within C, without needing to push arguments
> in a strvec.
> ---

Missing sign-off?

>  builtin/submodule--helper.c | 241 +++++++++++++++++++-----------------
>  1 file changed, 128 insertions(+), 113 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..321b623d81 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1658,45 +1658,20 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  


> +struct module_clone_data {
> +	const char* prefix;

Asterisk sticks to identifier not type in this codebase, i.e.

	const char *prefix;

Other than that, the split makes sense, especially for the purpose
of more easily reusing this helper without having to unparse and
reparse the option strings.

