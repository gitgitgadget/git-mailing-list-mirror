Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E25C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiHQPyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiHQPy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 11:54:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE39AFE5
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 08:54:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE87B1B03A4;
        Wed, 17 Aug 2022 11:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FJ8u2ThAETOjLQcvoIA1WKpRLqX50d969GThxbSGndo=; b=givN
        W5DdVGiyJlLCdVho65QzHlv6AUFd1+/mmc4Z16J1NxuAhIeI20p91ASCIn2pl//C
        2jXzR68WWoT8utdR3ZSU4hDexDerdS3ckSiUrG4B8NUQOIZ8rRZ9PV1iKoSEcVb/
        m1eOqojNJWQexAqGZjis8L/dBta2BVYI9xZAb2k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A70DF1B03A3;
        Wed, 17 Aug 2022 11:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55C391B039E;
        Wed, 17 Aug 2022 11:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
        <f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com>
Date:   Wed, 17 Aug 2022 08:54:22 -0700
Message-ID: <xmqq5yiqzx01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD0E6440-1E44-11ED-818B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/16/2022 7:58 PM, Matthew John Cheetham via GitGitGadget wrote:
>
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +		/*
>> +		 * Enable the built-in FSMonitor on supported platforms.
>> +		 */
>> +		{ "core.fsmonitor", "true" },
>> +#endif
>> +	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
>> +		return error(_("could not start the FSMonitor daemon"));
>> +
>
> I initially worried if fsmonitor_ipc__is_supported() could use some
> run-time information to detect if FS Monitor is supported (say, existence
> of a network share or something). However, that implementation is
> currently defined as a constant depending on
> HAVE_FSMONITOR_DAEMON_BACKEND.
>
> The reason I was worried is that we could enable core.fsmonitor=true based
> on the compile-time macro, but then avoid starting the daemon based on the
> run-time results. If we get into this state, would the user's 'git status'
> calls start complaining about the core.fsmonitor=true config because it is
> not supported?

Ah, I didn't consider the possibility where the user uses the
configuration to say "enable it if you are able, but it is OK if you
cannot".  Whether the "is supported" is dynamic or compiled-in, that
may be a valid issue to consider.  An easy way out may be to declare
that the value "true" for "core.fsmonitor" variable means exactly
that, i.e. the user asks to run it, but it is not an error if it
cannot run.

A variant that may need slightly more work would be to introduce a
separate value (perhaps "when-able") that means that, while keeping
the "true" to mean "run the built-in one, or error out to let me
know otherwise" as before.

Thanks.
