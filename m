Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A1C433E9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7805A22D07
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 22:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbhAKWfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 17:35:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52940 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbhAKWfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 17:35:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20E86123A1D;
        Mon, 11 Jan 2021 17:35:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3sl2G+NkFwOPGfQYiLh4Kszsvkc=; b=g0ftdr
        XCXnh/OBL1rB3xvZrttbFGeg+9sacEOSxq3NThvp2V2ciWFer9068HUlpRQWb6gq
        nTkL0DIwjhr2UyidVr9mTRTlcxdrBSzxeIDu+vF8bCHGYUSjOZrgdspSVQKWoUzn
        DFpedoGy6UZDRxDCQcr8LGBgBgTSc7i4u1t+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FJ9Yrk6LrhaF5SzOXkrOWfkyIpB9RDRc
        l1jtDfJdJg5MxFs68ulUiosYDYht1Ct01ma+hnpCcqFzFT5oCIU4gYP1x11kFaKO
        PJpdIfWxliX6VnJRJT/Wpb8rmFq1pyLQuZE8GZZtTot8RjjtUD99UKayGNHrOE3q
        9OHaW1Ob8S4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19A57123A1C;
        Mon, 11 Jan 2021 17:35:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6DDEC1239F7;
        Mon, 11 Jan 2021 17:34:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v7 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im> <cover.1610353895.git.ps@pks.im>
        <b9cf47afe896f8a6a76ba2e8aa87155e147ff31d.1610353895.git.ps@pks.im>
Date:   Mon, 11 Jan 2021 14:34:31 -0800
In-Reply-To: <b9cf47afe896f8a6a76ba2e8aa87155e147ff31d.1610353895.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 11 Jan 2021 09:36:49 +0100")
Message-ID: <xmqq1rer6r2g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D5CA118-545D-11EB-A1B3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +void git_config_push_env(const char *spec)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *env_name;
> +	const char *env_value;
> +
> +	env_name = strrchr(spec, '=');
> +	if (!env_name)
> +		die(_("invalid config format: %s"), spec);
> +	env_name++;
> +	if (!*env_name)
> +		die(_("missing value for --config-env"));

If reporting the name of the configuration variable, for which we
checked an environment variable, is worth doing in the !env_value
case below, shouldn't we be doing the same here, too?  I.e.

		die(_("missing environment variable name in %s", spec));;

or something to complain against "git --config-env foo="?

> +	env_value = getenv(env_name);
> +	if (!env_value)
> +		die(_("missing environment variable '%s' for configuration '%.*s'"),
> +		    env_name, (int)(env_name - spec - 1), spec);

> +test_expect_success 'git --config-env=key=envvar support' '
> +	cat >expect <<-\EOF &&
> +	value
> +	value
> +	false
> +	EOF
> +	{
> +		env ENVVAR=value git --config-env=core.name=ENVVAR config core.name &&
> +		env ENVVAR=value git --config-env=foo.CamelCase=ENVVAR config foo.camelcase &&
> +		env ENVVAR= git --config-env=foo.flag=ENVVAR config --bool foo.flag

These "env " prefixes are not wrong per-se but are unnecessary.  The
same for the rest of this patch.

> +	} >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git --config-env fails with invalid parameters' '
> +	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
> +	test_i18ngrep "invalid config format" error &&
> +	test_must_fail git --config-env=foo.flag= config --bool foo.flag 2>error &&
> +	test_i18ngrep "missing value for --config-env" error &&
> +	test_must_fail git --config-env=foo.flag=NONEXISTENT config --bool foo.flag 2>error &&

How are we making sure 

	$ NONEXISTENT=True make test

is not what the end-user is running?

	sane_unset X &&
	test_must_fail git --config-env foo.flag=X config --bool foo.flag

or something along that line, perhaps?
