Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE26C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607DD206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qJpzBzSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgEDVAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:00:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDVAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:00:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 015EF4C89D;
        Mon,  4 May 2020 17:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/z5vSGcD10JQX5RP26aYqfW9/Nk=; b=qJpzBz
        SR5yIOJ9n8tat2g9kz/v2k/PrOuOCltzANVDSSIjI6GABPlANbcEhOyES6wduJvS
        hP7UyCO82vNO1GrBIYnD9QOASW15nwSwAFBZWU8yTeft0S9El5EeZigTJZla9HDT
        dJJYe4sHsJ1emrS9RSepDFLIl9xy/IZXRSKEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aKqE9+seC1txikpRYi1jH0QzKp6AY5u8
        nM9Ki2BzVfbK7pFm6o693VKuXxs0JBGiaVS0uoeTW7GMgWlaw96VhXQbCgo/9MUb
        sMg5vVH39jPYFSURDSqXcohzvZNfDEgQ30fRnxKQ9vCSA+shi715pAaXyni87uSa
        VUgWoNNJTXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA05B4C89C;
        Mon,  4 May 2020 17:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B9E94C89B;
        Mon,  4 May 2020 17:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
References: <20200503090952.GA170768@coredump.intra.peff.net>
        <20200503091157.GA170902@coredump.intra.peff.net>
Date:   Mon, 04 May 2020 14:00:12 -0700
In-Reply-To: <20200503091157.GA170902@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 3 May 2020 05:11:57 -0400")
Message-ID: <xmqqh7wvfmar.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8F46A8-8E4A-11EA-8811-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> would sort the primary key (taggername) case-insensitively, but sort the
> refname case-sensitively. We have two options here:
>
>   - teach callers to set ignore_case on the whole list
>
>   - replace the ref_sorting list with a struct that contains both the
>     list of sorting keys, as well as options that apply to _all_
>     keys
>
> I went with the first one here, as it gives more flexibility if we later
> want to let the users set the flag per-key (presumably through some
> special syntax when defining the key; for now it's all or nothing
> through --ignore-case).

A good design decision I would fully support.

> +test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
> +	# name refs numerically to avoid case-insensitive filesystem conflicts

Very considerate.  If I were writing these nested loops, I am sure I
would have used "tag-$email-$subject" to be cute.

Queued.  Thanks.

> +	nr=0 &&
> +	for email in a A b B
> +	do
> +		for subject in a A b B
> +		do
> +			GIT_COMMITTER_EMAIL="$email@example.com" \
> +			git tag -m "tag $subject" icase-$(printf %02d $nr) &&
> +			nr=$((nr+1))||
> +			return 1
> +		done
> +	done &&
> +	git for-each-ref --ignore-case \
> +		--format="%(taggeremail) %(subject) %(refname)" \
> +		--sort=refname \
> +		--sort=subject \
> +		--sort=taggeremail \
> +		refs/tags/icase-* >actual &&
> +	cat >expect <<-\EOF &&
> +	<a@example.com> tag a refs/tags/icase-00
> +	<a@example.com> tag A refs/tags/icase-01
> +	<A@example.com> tag a refs/tags/icase-04
> +	<A@example.com> tag A refs/tags/icase-05
> +	<a@example.com> tag b refs/tags/icase-02
> +	<a@example.com> tag B refs/tags/icase-03
> +	<A@example.com> tag b refs/tags/icase-06
> +	<A@example.com> tag B refs/tags/icase-07
> +	<b@example.com> tag a refs/tags/icase-08
> +	<b@example.com> tag A refs/tags/icase-09
> +	<B@example.com> tag a refs/tags/icase-12
> +	<B@example.com> tag A refs/tags/icase-13
> +	<b@example.com> tag b refs/tags/icase-10
> +	<b@example.com> tag B refs/tags/icase-11
> +	<B@example.com> tag b refs/tags/icase-14
> +	<B@example.com> tag B refs/tags/icase-15
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
