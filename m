Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E25C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F3E611CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbhDLRFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:05:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbhDLREn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:04:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E38D7AA433;
        Mon, 12 Apr 2021 13:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kbuEWhzRnKBN8s8lnr8L+z6ji3U=; b=JKBCp2
        2HqXbxb1reJgWU+uXDODNcP8zvqo5thJ6zuLMf4F2R96+C0MIDDgm7nzHDJo1Nts
        JenYebKvNzv+/dZAJu1s2cf6cgy7xSeyrIXR627NrSDc69IdLdHftvQdXz0D5zFV
        q8FzhMcskdDZEA2MN/KJ8Mw4hguAmwr+Uhz4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PXcbHegRjmiULDcZpRLiNcu7IPnSbphX
        3SjJzdrnsYzNb9wCAzMWm6840p+7ahSqanRPsyRdliI9LWgWV6iilqJ4XOmZnsUd
        hogmvVaw6Sw+Mf2bFe6hnRbSVvDCZHLS8gXYDt4Or4Bgl29nMgxjwOl6RpCdJyca
        Uh86aFIlLmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA62EAA431;
        Mon, 12 Apr 2021 13:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 525DFAA430;
        Mon, 12 Apr 2021 13:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] config: allow overriding of global and system
 configuration
References: <cover.1617975637.git.ps@pks.im> <cover.1618238567.git.ps@pks.im>
        <af663640ae25a95fa56adf32baf4c2e197f3eea2.1618238567.git.ps@pks.im>
Date:   Mon, 12 Apr 2021 10:04:23 -0700
In-Reply-To: <af663640ae25a95fa56adf32baf4c2e197f3eea2.1618238567.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 12 Apr 2021 16:46:54 +0200")
Message-ID: <xmqq4kgbfn8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21CE0D6E-9BB1-11EB-B6A6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>  char *git_system_config(void)
>  {
> +	char *system_config = xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
> +	if (system_config) {
> +		if (!strcmp(system_config, "/dev/null"))
> +			FREE_AND_NULL(system_config);
> +		return system_config;
> +	}

I am not sure if returning NULL from this function will always be
the same as returning /dev/null on a system with functioning
/dev/null.  For example, when use_system_config is enabled,
builtin/config.c::cmd_config() assigns the NULL returned by this
function to given_config_source.file and then calls
config.c::config_with_options(), which notices that none of
use_stdin, file, or blob member of the config_source exists and
falls back to the config_sequence().

So, for the purpose of special casing "/dev/null" textually, the
above is not sufficient, I am afraid.

Let's rescind the "/dev/null gets turned into NULL" in the above
change for now.  If we truly want to cater to an installation where
open("/dev/null") fails and emulate, that needs to be done at a much
lower layer, but we do not have to go there for the purpose of this
series.

Thanks.
