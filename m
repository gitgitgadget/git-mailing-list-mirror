Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3183C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380973AbiAaR2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:28:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52913 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380963AbiAaR2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:28:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F02CE162CA5;
        Mon, 31 Jan 2022 12:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eFZr9lXI0kotFV8LC/t1zFya83dBrPjqSOJ5M7
        9ZB9o=; b=bnKP9rkooGmBe8Y2NNErXm/CntdkkEDH87Y17Dl6+ozGSEaVomhbQ6
        aaoyCy2vhS6perjZyVMEVg/E+TuhqFx8IsKnIc5F5MrPPmkWoSic0YFfb40joIkO
        mkZ3sOq7dO4n59p0G7jhOjLSfOcUKVMWmhv/lZszdsZWmof3Dy5eo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E95AD162CA4;
        Mon, 31 Jan 2022 12:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61C19162CA3;
        Mon, 31 Jan 2022 12:28:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git ML <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: BUG: Various "advice.*" config doesn't work
References: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
        <YfgLeVw0rrk7Q5/+@nand.local>
Date:   Mon, 31 Jan 2022 09:28:02 -0800
In-Reply-To: <YfgLeVw0rrk7Q5/+@nand.local> (Taylor Blau's message of "Mon, 31
        Jan 2022 11:16:57 -0500")
Message-ID: <xmqq1r0nke71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25135032-82BB-11EC-A7E4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But having something like (in builtin/add.c:add_files()):
>
>     if (advice_enabled(ADVICE_ADD_IGNORED_FILES))
>         advise(_("..."));
>
> feels like it opens the door to call advise() by default if we happened
> to forget to read the configuration.

True.

> I think that is a good candidate to
> be replaced with advice_if_enabled().

Meaning advice_enabled() will lazily load the configuration?  If so,
then what you saw in builtin/add.c::add_files() would automatically
become just as safe as advice_if_enabled(), no?

> I'm not sure if that is true in general, though. Take a look at this
> example (from branch.c:create_branch()):
>
>     if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
>         error(_(upstream_missing), start_name);
>         advise(_(upstream_advice));
>         exit(1);
>     }
>     die(_(upstream_missing), start_name);
>
> This also makes it possible to call advise() when we shouldn't have. But
> how should we rewrite this code? Wanting to either error() (and then
> call exit(1)) or die() based on whether or not we're going to print the
> advice makes it tricky.

I am puzzled why you think the above "check, do things, give a
piece of advice, and do even more things" needs to be rewritten.

Everything you are showing above becomes a problem only when
advice_enabled() does not work reliably, due to a bug that fails to
read the configuration.

> Maybe, though I still think BUG() is a bit extreme, and we could
> accomplish the same by having the advice API just read the config if it
> hasn't done so already before emitting advice.

Calling things like git_config(git_default_config) with side-effects
on other global variables are definitely a no-no, but as long as it
reacts to configuration variables only under advice.* namespace,
that might be OK.

Thanks.
