Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF35C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA66650F2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCJAIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 19:08:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhCJAI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 19:08:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5618311BEFC;
        Tue,  9 Mar 2021 19:08:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cVme8U4YzPIqORggG9iekavGV80=; b=vPTCS5
        RfupZbJSvKrOOscYodKjnLNWwg0II5lkMU3GksC+5HR95V7Oq2aN53LBhxtINq1w
        uvyMzdHf1ebq3P47FNOTvsATXByvgokHpEEg5EHP1xrW3vyliTm3iXhNqe7TooV4
        fdJCtFwdLjqBPHZ8tSYAHW5LcXVyhdBq82NyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=taeVPz56sRbX3H4/TWNJ1uXih+n39hOD
        BSVUnxzWlghXu9w3YzE+owmigYIw73cwvGDdmoSX3wHBxAaaX67soOHvWPFq72SM
        Ou7Gyko1eM4DBF7wY486J7CJhEoTpUA8Wdrf/wIU0GOvW+64W/IBUltKhqkY2nUP
        PjJQPn9nAAA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E24D11BEFB;
        Tue,  9 Mar 2021 19:08:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9256811BEF7;
        Tue,  9 Mar 2021 19:08:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 11/12] simple-ipc: add Unix domain socket implementation
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <f2e3b046cc8f8ad5662f65262810c7414cc1569d.1615302157.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 16:08:21 -0800
In-Reply-To: <f2e3b046cc8f8ad5662f65262810c7414cc1569d.1615302157.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 09 Mar 2021
        15:02:36 +0000")
Message-ID: <xmqq7dmfzx8q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BABD30F0-8134-11EB-9113-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * This value was chosen at random.
> + */
> +#define WAIT_STEP_MS (50)

... and never used.  Is this supposed to be used as the hardcoded
value 50 below ...

> +
> +/*
> + * Try to connect to the server.  If the server is just starting up or
> + * is very busy, we may not get a connection the first time.
> + */
> +static enum ipc_active_state connect_to_server(
> +	const char *path,
> +	int timeout_ms,
> +	const struct ipc_client_connect_options *options,
> +	int *pfd)
> +{
> +	int wait_ms = 50;

... here?

> +	int k;
> +
> +	*pfd = -1;
> +
> +	for (k = 0; k < timeout_ms; k += wait_ms) {
> +		int fd = unix_stream_connect(path, options->uds_disallow_chdir);
> +
> +		if (fd != -1) {
> +			*pfd = fd;
> +			return IPC_STATE__LISTENING;
> +		}
> +
> +		if (errno == ENOENT) {
> +			if (!options->wait_if_not_found)
> +				return IPC_STATE__PATH_NOT_FOUND;
> +
> +			goto sleep_and_try_again;
> +		}
> + ...
> +		return IPC_STATE__OTHER_ERROR;
> +
> +	sleep_and_try_again:
> +		sleep_millisec(wait_ms);

Or, since there is nothing like exponential back-off implemented
here which may want to modify wait_ms variable, perhaps use the
constant directly here and where k is incremented?

> +/*
> + * A randomly chosen timeout value.
> + */
> +#define MY_CONNECTION_TIMEOUT_MS (1000)

Even if it may have been "randomly chosen", there should be some
criteria to judge if the value is sensible, right?  IOW, I have a
suspicion that I would regret if I randomly chose 5 (or 3600000)
instead of 1000.  How would we figure that 1000 acceptable but not
5?

Perhaps explain that criterion here, e.g. "... value that ought to
be long enough to establish connection locally as long as the box is
not loaded unusably heavily" or something?

