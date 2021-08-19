Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC36C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F1E60462
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhHSWjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:39:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61387 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbhHSWjt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 18:39:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4D3D139340;
        Thu, 19 Aug 2021 18:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d39iYzDWHXvMgz55bqynt3GaltPO8mYb8vpaAV
        O/L38=; b=DXpYS1ZOKZQ3pHRf7ABEf8yu+6rRsotiUTh8C9bPeXd6pLBCHrf8mh
        Dyy2IQKqKvDKLoGpNUnt7ei+6iPlhuuBACy9moKdVsLrTc2BnDdVIrhn3M6viLQo
        2mCQm4/4KZpn4Ao+OHPxLMhwPHg426wm9skEgMl6Nn3+in1ZyJnZQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD2FE13933D;
        Thu, 19 Aug 2021 18:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0ED7713933A;
        Thu, 19 Aug 2021 18:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] hook: include hooks from the config
References: <20210819033450.3382652-1-emilyshaffer@google.com>
        <20210819033450.3382652-6-emilyshaffer@google.com>
Date:   Thu, 19 Aug 2021 15:39:06 -0700
In-Reply-To: <20210819033450.3382652-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 18 Aug 2021 20:34:49 -0700")
Message-ID: <xmqqo89txdo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43EB7FA6-013E-11EC-B993-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> index 96d3d6572c..c394756328 100644
> --- a/Documentation/config/hook.txt
> +++ b/Documentation/config/hook.txt
> @@ -1,3 +1,21 @@
> +hook.<name>.command::
> +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
> +	be a unique "friendly" name which you can use to identify this hook
> +	command. (You can specify when to invoke this command with
> +	`hook.<name>.event`.) The value can be an executable on your device or a
> +	oneliner for your shell. If more than one value is specified for the
> +	same `<name>`, the last value parsed will be the only command executed.
> +	See linkgit:git-hook[1].
> +
> +hook.<name>.event::
> +	The hook events which should invoke `hook.<name>`. `<name>` should be a
> +	unique "friendly" name which you can use to identify this hook. The
> +	value should be the name of a hook event, like "pre-commit" or "update".
> +	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
> +	On the specified event, the associated `hook.<name>.command` will be
> +	executed. More than one event can be specified if you wish for
> +	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].

Looking much better.  It now gives enough information to readers to
understand (if not enough to convince that it is a good idea) why an
indirection with "friendly name" between the event and command is
there.  In short, <name> names the command to be run and without
indirection, you'd end up having to write:

    [hook "check-whitespace && spellcheck-log-message"]
	event = pre-commit
    [hook "check-whitespace && spellcheck-log-message"]
	event = another-hookable-event

which may give the same expressiveness (and may even be workable if
the configuration were machine generated) but it is typo-prone, and
a single typo, or even an insignificant whitespace change in the
command, would destroy the grouping of "this command fires upon
these events".

It becomes much less typo prone with the indirection, i.e.

    [hook "logcheck"]
	command = check-whitespace && spellcheck-log-message

    [hook "logcheck"]
	event = pre-commit

    [hook "logcheck"]
	event = another-hookable-event

using the "friendly name", especially if these entries are spread
across different configuration files.

My original question was primarily because I thought the
second-level <name> corresponded to <event>.  If that were the case,
it can trivially be made simpler without making it typo-prone, i.e.

    [hook "pre-commit"]
	command = check-whitespace && spellcheck-log-message

    [hook "another-hookable-event"]
	command = check-whitespace && spellcheck-log-message

since the name of the event would be much shorter than the command
line.  But since we are not grouping per hookable event (to apply
the "last one wins" rule to determine which single command is the
one that gets to run).

Thanks.


