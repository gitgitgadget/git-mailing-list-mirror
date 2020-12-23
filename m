Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE0C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B52522473
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLWVgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:36:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60808 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWVgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 16:36:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0023410BB6B;
        Wed, 23 Dec 2020 16:36:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fid+lgxe8UCGGkAa/UIHerniv88=; b=H6BGC6
        cmu0x2RXvMgR41+HiSme8ZcbiLJzylWfsZ4z1lEoBKwltjUp9ucN8YI2g/Dc+BDy
        nfKGiwvJmfSPV5+xUeTD89O+RlaemZEIaWQ2i2t4pS7/6eb12pqauWkkZvVFZCX9
        gt3kbIfWTZnMTv+mg5fW8JrUszrbvABIbgC3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TkXgUB7dhMeGhJgEczuB94CXJF8HLSHX
        8/dMau3SbdTImvRq8FepMbFZO/NUED7/6d/Llb3xuWNkngdE2SmT8XL0fy5B2DJw
        F227Q3goDsXoznhwl7Py4YtUwb6CpMaf309Fvj3QxJ2NIeCQyvmwZdCdbhs1z1Op
        UBJ2b2mxp3A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED89710BB6A;
        Wed, 23 Dec 2020 16:36:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4F2D10BB68;
        Wed, 23 Dec 2020 16:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im> <cover.1608104755.git.ps@pks.im>
        <56c9221c4cc8c3e52823938938e3f65a3433f9bf.1608104755.git.ps@pks.im>
Date:   Wed, 23 Dec 2020 13:35:59 -0800
In-Reply-To: <56c9221c4cc8c3e52823938938e3f65a3433f9bf.1608104755.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 16 Dec 2020 08:52:47 +0100")
Message-ID: <xmqq5z4s6w8w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9E4738A-4566-11EB-A536-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +--config-env=<name>=<envvar>::
> +	Like `-c <name>=<var>` except the value is the name of an
> +	environment variable from which to retrieve the value. Unlike

Let's avoid overusing the word "value", as it can refer to
<name>=<envvar> as the whole (which is the value given to
--config-env), or <envvar> itself (which may appear to the value
given to <name>), or the value in the environment veraible.

	Like `-c <name>=<value>`, give configuration variable
	'<name>' a value, where <envvar> is the name of an
	environment variable from which to retrieve the
	value.

or something along that line.

> +	`-c` there is no shortcut for directly setting the value to an
> +	empty string, instead the environment variable itself must be
> +	set to the empty strin. Errors if the `<envvar>` does not exist

	set to the empty string.  It is an error if the ...

> +	in the environment. `<envvar>` may not contain an equals sign
> +	to avoid ambiguity with `<name>`s which contain one.

	which may contain one.

> +	This is useful for cases where you want to pass transitory
> +	configuration options to git, but are doing so on OS's where
> +	other processes might be able to read your cmdline
> +	(e.g. `/proc/self/cmdline`), but not your environ
> +	(e.g. `/proc/self/environ`). That behavior is the default on
> +	Linux, but may not be on your system.
> +
> +	Note that this might add security for variables such as
> +	`http.extraHeader` where the sensitive information is part of
> +	the value, but not e.g. `url.<base.insteadOf` where the

"url.<base>.insteadOf"

> +	sensitive information can be part of the key.

When writing multi-paragraph description, the second and later
paragraphs need to be dedented and the paragraph breaks are denoted
not by a blank line but by a line with only a single '+' on it.

I didn't look at the implementation or tests, as I think it hasn't
changed since the last round, and the last round was looked at by
Peff already.

Thanks.
