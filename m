Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064FC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4767F61106
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhDIWL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:11:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65071 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhDIWLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:11:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ADD1AEE0B;
        Fri,  9 Apr 2021 18:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H7QBXCQYjVJFfY3vlA4VJA6EXdk=; b=j5yAlH
        oGhG4mLAg5UucIrVD67B3l5lE+cAg0pEOy+6XO0ytDQ74qbRkt2J6+vuiO6vXGbh
        +1aT3QcJDiNkT5bBkkVIDWBIB3gMkqid4533o6Bjwr0kG4SzI983X8wV6EWDnC58
        TbQMpJwYZvCpyHHKenI6xs9rYmQKQ43Ip5spA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tdE3x+/SDwZn3C+T9nlGlmXk1D3iNUSq
        RaLgWWFsNFXUJHcmjoCT7/xvM95oTEY1AxVun92axvteKx8zy4Q7cfzwkP+12yLB
        BOTV1/2gss94Ej77dJNIkS1fbOojtEeCf69uW6zIervHmYmiCSWG3GpdprEeRk0s
        v0OVld1WHRk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6269EAEE0A;
        Fri,  9 Apr 2021 18:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E716AAEE08;
        Fri,  9 Apr 2021 18:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
        <xmqqa6q8tymu.fsf@gitster.g>
        <YHCzhcBkqdeEMrWA@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 15:11:10 -0700
In-Reply-To: <YHCzhcBkqdeEMrWA@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 16:05:25 -0400")
Message-ID: <xmqqv98vm7lt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DC1A0D2-9980-11EB-9A42-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It seems like it would be more convenient if you could pass it a bool
> value to turn the "auto" into. E.g., if you could do:
>
>   b = git_parse_maybe_tristate(value, 1); /* default to "1" */
>   if (b < 0)
>           do_error();
>   if (b)
>           do_true(); /* true, or maybe "auto" */
>   else
>           do_false();
>
> I dunno. That would probably be hard to represent via "git config
> --type". And some callers probably do care about "auto" versus "true".

It would work well for codepaths where computing the default value
is cheap (or even possible).

I think the point of using "auto" is to delay the decision as late
as possible.  E.g. in-core parsed config and attribute may still
want to stay "auto", until we actually get our hands on the blob
contents to see if it is binary, until we know how heavily loaded
the system is, until we know isatty(1), etc.  Some are cheap to
compute in advance, some are expensive and impossible until we meet
the data.

So I still think the canonical use pattern for the "auto" thing is

	is_frotz = git_parse_bool_or_auto(value);

	... arbitrary number of things can happen here
	... the above may even be done in a git_config()
	... callback, and is_frotz may not even be used.

	if (is_frotz == AUTO)
		is_frotz = auto_detect_frotz();

	if (is_frotz)
		...; /* do the frotz thing */
	else
		...; /* do the non-frotz thing */

> It also feels funny calling this "tristate". Aren't there other
> tristates we could have besides "auto"? The command-line option is
> bool-or-auto, which is descriptive. Should this use a similar name?

I like that bool-or-auto name very much.
