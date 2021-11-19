Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03EC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F051261872
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhKSGTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:19:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64321 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhKSGTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 01:19:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B597AEC6DD;
        Fri, 19 Nov 2021 01:15:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/+0La/TIZv6WR6SIOjFtAFX9y7cn4fHfI2t2lp
        kWZZo=; b=VU3UCZc0WKXowpqDmlXzKKSvX4bPrYOTspyjH9klspreHuNLsDV2je
        Wl8GizNPNxks36iHrimqkJbG5E5WIZ8m5ja9s/HDAwEkbt2F7kjxAdvYvS3Gt+jO
        7DGu0efK/w2W7GhLlUsiGOjpvTDz5C3hEwGIZXkE8ZNtfv5Sb8aN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC979EC6DC;
        Fri, 19 Nov 2021 01:15:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20E2BEC6DB;
        Fri, 19 Nov 2021 01:15:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 7/7] ssh signing: verify ssh-keygen in test prereq
References: <xmqqsfwmus5g.fsf@gitster.g>
        <20211117093529.13953-1-fs@gigacodes.de>
        <20211117093529.13953-8-fs@gigacodes.de>
Date:   Thu, 18 Nov 2021 22:15:56 -0800
In-Reply-To: <20211117093529.13953-8-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 17 Nov 2021 10:35:29 +0100")
Message-ID: <xmqqfsrssmar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2930CC8E-4900-11EC-A5AB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> @@ -123,12 +119,19 @@ test_lazy_prereq GPGSSH '
>  	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
>  	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
> -	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
> +	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null &&
> +
> +	# Verify if at least one key and ssh-keygen works as expected
> +	echo "testpayload" | ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" > gpgssh_prereq.sig &&

Style:
 . Avoid overlong line by breaking the line after pipe.
 . No SP between redirection operator '>' and redirection target.

	echo "testpayload" |
	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" >gpgssh_prereq.sig &&

Also I wonder if preparation of GPGSSH_ALLOWED_SIGNERS file can be
simplified and made easier to read.  Instead of adding one line at a
time like this:

>  	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"

if you define variables with meaningful name and used here document,
e.g.

	ts2005a=200504070000 ts2005b=200504100000 &&
	key_timeboxedvalid=$(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub") &&

	ts2999=299901010000 &&
	key_notyetvalid=$(cat "${GPGSSH_KEY_NOTYETVALID}.pub") &&

	cat >"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
	"principal with not yet valid key" valid-after="$ts2999" $key_notyetvalid
	"timeboxed valid key" valid-after="$ts2005a",valid-before="$ts2005b" $key_timeboxedvalid
	...
	EOF

