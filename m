Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68357C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A5225AB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAKA3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:29:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54540 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAKA3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 19:29:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7220B99337;
        Sun, 10 Jan 2021 19:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LZqcApdS3tXHVVjsnq88TvoeGUw=; b=fe6Tl6
        dsQlX3A/ysbzU5gAPQSQp+Ej/zNw4cYrZR2D5IorjChiWvsgyOBUqNgjKmqnEkAU
        PbcgElblsuOe0Newdegi5gHRZ4sqQpqzqQ2AXBPTLcdfbrYJ+YGe/5sqzTCcTQ8u
        dHHTB12o94uvXFJi65kHxNMcGaQxBa4yy/fVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hVfqsAQHGJEAa+7+Fcp9yfhtxixvwMAK
        ki/xcHpQdzPUjkNX+FRq8E0hTqax5vdsBtaYtiGCki3ot52BGP5g1bGmJ/vpNas1
        w3MynI+8aRnD8cNQz5cIKiHJhVSJMBHMsf4rNAnvsL9D5mcoBtVK6exJi1olb3AI
        0pmeoD+A4g0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 676DD99336;
        Sun, 10 Jan 2021 19:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC04A99335;
        Sun, 10 Jan 2021 19:29:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v6 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im> <cover.1610001187.git.ps@pks.im>
        <9b8461010e641369316d00e2fc58c16e0e191f42.1610001187.git.ps@pks.im>
        <X/tjtVGRKRhX0ZvU@ruderich.org>
Date:   Sun, 10 Jan 2021 16:29:01 -0800
In-Reply-To: <X/tjtVGRKRhX0ZvU@ruderich.org> (Simon Ruderich's message of
        "Sun, 10 Jan 2021 21:29:41 +0100")
Message-ID: <xmqqr1ms8gfm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00DE4CC2-53A4-11EB-9896-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Thu, Jan 07, 2021 at 07:36:52AM +0100, Patrick Steinhardt wrote:
>> [snip]
>>
>> +void git_config_push_env(const char *spec)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *env_name;
>> +	const char *env_value;
>> +
>> +	env_name = strrchr(spec, '=');
>> +	if (!env_name)
>> +		die("invalid config format: %s", spec);
>> +	env_name++;
>> +
>> +	env_value = getenv(env_name);
>> +	if (!env_value)
>> +		die("config variable missing for '%s'", env_name);
>
> I think "environment variable" should be mentioned in the error
> message to make it clear what kind of "variable" is missing.

Good observation.  This parses foo=bar and complains about bar
missing in the environment; It is not a "config variable" that is
missing.

It is "'bar', which is supposed to be there whose value is going to
be used as the value of configuration variable 'foo', is missing."

I wonder if we should also talk about 'foo' at the same time as a
hint for what went wrong?  E.g.

	die(_("missing environment variable '%s' for configuration '%.*s'"),
            env_name, (int)((env_name-1) - spec), spec);

I don't offhand know if that is too much info that may not be all
that useful, though.

> Btw. shouldn't these strings get translated (or does die() do
> that automatically)?

The format string given to die/error/warn should be marked with _().

Thanks.
