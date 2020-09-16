Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957AAC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A6F20936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jh/0hzMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgIPUOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:14:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62855 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgIPUOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 16:14:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AD5CE85B5;
        Wed, 16 Sep 2020 16:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HXAHaxLnXzXyL0nxQBEGrbSKTb0=; b=jh/0hz
        MGc/U4ZhlQym+bGGM7FIBx5bxdWAwInlNI07jvV981j1USDq9z5Ew3tJsnDZCF6s
        Vn3/KWTtj2hDECrXso67a/GGddWF+TOPWm0/7GkButMfKAjuHL+trBnqzoVRb/uG
        JFBWqlTUpBqyxNjD8NUM7gt0yAwZ8TIBu5GZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JExBZPUPjS5pZjuVahH/IHM/X5Y/X9EO
        /JIcPd7PBuv8XfvJgAmif3Y3C4USyqEHgWj8OCVafUjEJYCVdZi4Z34qIQp/5JdV
        VSgnmfyol6wKa/o4FlXg4sPMk556+4M3PlAAqyub25BjmQtycHbJStfMWecSr4QU
        QAa3zYTyPGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 332ECE85B3;
        Wed, 16 Sep 2020 16:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79E7EE85AF;
        Wed, 16 Sep 2020 16:14:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
Date:   Wed, 16 Sep 2020 13:14:08 -0700
In-Reply-To: <20200915135428.GA28038@pflmari> (Alex Riesen's message of "Tue,
        15 Sep 2020 15:54:28 +0200")
Message-ID: <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E8F8060-F859-11EA-973A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> Affecting the transfers caused by git-fetch, the
> option allows to control network operations similar
> to --ipv4 and --ipv6 options.
> ...
> Something like this?

Good start.

If I configure it to "4", I do not see a way to override it and say
"I don't care which one is used".  With the introduction of this
configuration variable, we'd need a bit more support on the command
line side.

How about introducing a new command line option

	--transfer-protocol-family=("any"|<protocol>)

where <protocol> is either "ipv4" or "ipv6" [*1*], and make existing
"--ipv4" a synonym for "--transfer-protocol-family=ipv4" and "--ipv6"
for "--transfer-protocol-family=ipv6"

With such an extended command line override, we can override
configured 

	[transfer]
		ipversion = 6

with "--transfer-protocol-family=any" from the command line.

Also, we should follow the usual "the last one wins" for a
configuration variable like this, which is *not* a multi-valued
variable.  So the config parsing would look more like this:

	if (!strcmp(k, "transfer.ipversion")) {
		if (!v)
			return config_error_nonbool("transfer.ipversion");
		if (!strcmp(v, "any"))
			family = 0;
		else if (!strcmp(v, "4") || !strcmp(v, "ipv4"))
			family = TRANSPORT_FAMILY_IPV4;
		else if (!strcmp(v, "6") || !strcmp(v, "ipv6"))
			family = TRANSPORT_FAMILY_IPV6;
		else
			return error("transfer.ipversion: unknown value '%s'", v);
	}

Would we regret to choose 'ipversion' as the variable name, by the
way?  On the command line side, --transfer-protocol-family=ipv4
makes it clear that we leave room to support protocols outside the
Internet protocol family, and existing --ipv4 is grandfathered in
by making it a synonym to --transfer-protocol-family=ipv4.  Calling
the variable "transfer.ipversion" and still allowing future protocols
outside the Internet protocol family is rather awkward.

Calling "transfer.protocolFamily" would not have such a problem,
though.



[Footnote]

*1* But leave a room to extend it in the future to a comma-separated
    list of them to allow something like "ipv6,ipv7,ipv8" (i.e. "not
    just 'any'---we want to say that 'ipv4' is not welcomed").


>  Documentation/config/transfer.txt |  7 +++++++
>  builtin/fetch.c                   | 11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> index f5b6245270..cc0e97fbb1 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -69,3 +69,10 @@ transfer.unpackLimit::
>  	When `fetch.unpackLimit` or `receive.unpackLimit` are
>  	not set, the value of this variable is used instead.
>  	The default value is 100.
> +
> +transfer.ipversion::
> +	Limit the network operations to the specified version of the transport
> +	protocol. Can be specified as `4` to allow IPv4 only, `6` for IPv6, or
> +	`all` to allow all protocols.
> +	See also linkgit:git-fetch[1] options `--ipv4` and `--ipv6`.
> +	The default value is `all` to allow all protocols.
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 447d28ac29..da01c8f7b3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -118,6 +118,17 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "transfer.ipversion")) {
> +		if (!strcmp(v, "all"))
> +			;
> +		else if (!strcmp(v, "4"))
> +			family = TRANSPORT_FAMILY_IPV4;
> +		else if (!strcmp(v, "6"))
> +			family = TRANSPORT_FAMILY_IPV6;
> +		else
> +			die(_("transfer.ipversion can be only 4, 6, or any"));
> +		return 0;
> +	}
>  	return git_default_config(k, v, cb);
>  }
