Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C202C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbiA1SFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:05:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65401 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbiA1SFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 13:05:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB3C71848CC;
        Fri, 28 Jan 2022 13:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E6drF2aBtIN2UgmJrYbM/DUbiqJF0m4DtHqneJ
        C9VZc=; b=EbCdRgfMspE29hWjsfUDScHSKuF1PE9L1fsP4mDTvzfe6zPMy+clmt
        o59gmJZB+LkBnrMWR7DiG4k9W4/SiUmz+Wul2mQlm2bHLZPL0rtSeUcginN9/Gcn
        +ehSTkJupU1vphYZGspbPbWpmJW7OFuDXC0VsPiZCRSj3qcdOa914=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D33741848CB;
        Fri, 28 Jan 2022 13:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DE401848CA;
        Fri, 28 Jan 2022 13:05:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
        <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
        <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
Date:   Fri, 28 Jan 2022 10:05:31 -0800
In-Reply-To: <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com> (Derrick
        Stolee's message of "Thu, 27 Jan 2022 09:46:55 -0500")
Message-ID: <xmqqv8y3wxas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E24BD9E8-8064-11EC-85FE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My understanding was that this was ejected so we could find the right time
> to lib-ify handle_options() (as Taylor suggested), but we didn't want to do
> that while Scalar was still in a tentative state (in contrib/ with a plan
> to move it out after more is implemented).
>
> The biggest benefits of using handle_options() is for other pre-command
> options such as --exec-path, which I use on a regular basis when testing
> new functionality.
>
> There are other options in handle_options() that might not be appropriate,
> or might be incorrect if we just make handle_options() non-static. For
> example, `scalar --list-cmds=parseopt` wouldn't show the scalar commands
> and would instead show the git commands.
>
> So my feeling is that we should continue to delay this functionality until
> Scalar is more stable, perhaps even until after it moves out of contrib/.
> The need to change handle_options() to work with a new top-level command
> is novel enough to be worth careful scrutiny, but that effort is only
> valuable if the Git community is more committed to having Scalar in the
> tree for the long term.

The usual caveat that little things tend to accumulate and you can
die from thousands of paper cuts aside, if "run in that directory"
and "pretend these configuration variables are set" are useful
enough features to Scalar, I think that the straight-forward option
parser this patch adds is very much acceptable.

If we need more options (i.e. when we need to add the third thing),
that would be the best time to see how handle_options() can be
restructured to serve the different set of options git and Scaler
need.

And this loop, which is too small to be even called "duplicated
implementation", should suffice in the meantime.


