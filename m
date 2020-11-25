Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5E7C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C3820B1F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OQA+tb67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKYHlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:41:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58490 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKYHlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 02:41:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58C4BF6C05;
        Wed, 25 Nov 2020 02:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1LtqdIXdZZVJg9PID92yUKTCW/w=; b=OQA+tb
        67molp3M5HNGXmxdCT3iUnX1+yGRwwrHWpmVxwx9D0BAOGuF/Jy2f//WyxghRiFM
        ST2W8a+vScfFf9yIFUveBDHRDhLLY4EDVd9kVxfKeF6ivzHD9SIZe9wRg+CQJ9Hp
        hqaXm+lslR1T3xVhE/zUeTYJ8+xbW6xdAfIdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pPoi/68l4nPpbXo9namhEvwNzE3B6MgO
        GA8aLMusiIvdfo7Ds57xMmshW6cTrhJYBPx3Ek4o01yAGuE6l72e9OQSjyQyh26z
        +ZK5nCCHQGpM9Ge748DqVqzrsRkbNqfaAavG6E758inU6lxuC5vfKs7RAq+qMOiR
        2qLYNK+GCsc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5147FF6C04;
        Wed, 25 Nov 2020 02:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98FB2F6C02;
        Wed, 25 Nov 2020 02:41:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im>
        <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
        <xmqqtutef6kb.fsf@gitster.c.googlers.com> <X74CigYS7AUtMo9Q@tanuki>
Date:   Tue, 24 Nov 2020 23:41:34 -0800
In-Reply-To: <X74CigYS7AUtMo9Q@tanuki> (Patrick Steinhardt's message of "Wed,
        25 Nov 2020 08:06:50 +0100")
Message-ID: <xmqqpn41g9xt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5ABB6CC-2EF1-11EB-9F0B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> > +		for (i = 0; i < count; i++) {
>> > +			const char *key, *value;
>> > +
>> > +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
>> > +			key = getenv(envvar.buf);
>> > +			if (!key) {
>> > +				ret = error(_("missing config key %s"), envvar.buf);
>> > +				goto out;
>> > +			}
>> > +			strbuf_reset(&envvar);
>> > +
>> > +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
>> > +			value = getenv(envvar.buf);
>> > +			if (!value) {
>> > +				ret = error(_("missing config value %s"), envvar.buf);
>> > +				goto out;
>> > +			}
>> > +			strbuf_reset(&envvar);
>> 
>> Didn't we got bitten by number of times that the string returned by
>> getenv() are not necessarily nonvolatile depending on platforms?  I
>> think the result of getenv() would need to be xstrdup'ed.
>> 
>> cf. 6776a84d (diff: ensure correct lifetime of external_diff_cmd,
>> 2019-01-11)
>
> We did, but do we have to in this case? There is no interleaving calls
> to getenv(3P), so we don't depend on at least $n getenv(3P) calls
> succeeding without clobbering old values. It's true that it could be
> that any other caller in the callchain clobbers the value, but as far as
> I can see none does.

Doesn't the code expect "key" will stay valid even after another
call to getenv() grabs "value"?

> It is required as this is what sets precedence of GIT_CONFIG_PARAMETERS
> and thus `git -c` over GIT_CONFIG_COUNT.

OK, that is what the "will be overridden by any explicit options"
was about.  Perhaps that deserves an in-code comment, something like

	/*
	 * process GIT_CONFIG_KEY_N/GIT_CONFIG_VALUE_N pairs
	 * first, to be overridden by GIT_CONFIG_PARAMETERS
	 * inherited from parent Git processes' "git -c var=val"
	 * later
	 */

before we check GIT_CONFIG_COUNT and loop over the new style
environment variables.

Thanks.

