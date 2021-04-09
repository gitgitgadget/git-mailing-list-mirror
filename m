Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68929C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428746008E
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhDIW4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:56:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61993 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbhDIW4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:56:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1A3B1180B4;
        Fri,  9 Apr 2021 18:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WlWpuKVkOY8kGpEjGspn4jiUuDw=; b=FZ/PRB
        9IoPf5bIXrjURPv1insUrFn9oKxN5rpAIBaD+0hzSXIJfkIXGMWMvkWJuEvq0yWd
        jXugQOxc8kl4JR12NYMd9UZ7Td/Q0/8wGcrT23/sC2ETH8RsUzbgZ/hAQM8HiUBe
        bnDo2fugFqMqbpD8553FWlxCKVi7eoYvuW+7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iUeOe4BYBnrhFZ1sWCw/iTMrW8Xoyll3
        h494QfTNBpCKg7BHWtnm0431uk5wlKF3/UUZKVssBN1jHpP++JHtc2KTIhRrOVSO
        amsWmZR5o8bCT8YAd9MBAcWtzCxx+9uZgFC8R7Rg1fSIWmZntcod/DzZk8QDJQsP
        WcyhVrpD738=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8A371180B1;
        Fri,  9 Apr 2021 18:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C4C81180AB;
        Fri,  9 Apr 2021 18:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
        <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 15:56:29 -0700
In-Reply-To: <YHDVAxxKDzfTlq3h@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 18:28:19 -0400")
Message-ID: <xmqqtuofkqxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D31A488A-9986-11EB-A117-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +   If <script> is `-` (a single dash), then the script to run is read
> +   from stdin. This lets you more easily use single quotes within the
> +   script by using a here-doc. For example:
> +
> +        test_expect_success 'output contains expected string' <<-\EOT

Missing '-'?

> +	        grep "this string has 'quotes' in it" output
> +	EOT
> +
> ...
> +	# start with a newline, to match hanging newline from open-quote style
> +	eval "$1=\$LF"
> +	local test_line
> +	while IFS= read -r test_line
> +	do
> +		eval "$1=\${$1}\${test_line}\${LF}"
> +	done

I wonder if we can do this without relying on "read -r" (which I
distrust, perhaps out of superstition)?  Perhaps by slurping the
whole thing with "$(cat)"?

Thanks.
