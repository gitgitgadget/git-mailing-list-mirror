Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07EC433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5105F611CE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhIPGYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:24:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58052 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhIPGYy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7B07154A7D;
        Thu, 16 Sep 2021 02:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3/yZ3V2/FixLwuVSLPBxBgVN0oYoDU+6cOfjs
        E/Jps=; b=hbpHElZS2LWCDaIOHyDdbEwwH4M+SpO1WysuQPNawdvalhea/+sgiR
        zkEz3MVY5EEe4snZmBQ07Lnr5/R5E/3BPnGUJ0Wvb6iz5dQSWoYj3G3cmdQij2D1
        XCDqy4I6W59QPSBseT5PDOvDnYjkORUhHTfDic7QXT6j1Z5A72gN8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C19AE154A7C;
        Thu, 16 Sep 2021 02:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC35D154A7A;
        Thu, 16 Sep 2021 02:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/2] t0000: avoid masking git exit value through pipes
References: <20210916023706.55760-1-carenas@gmail.com>
        <20210916023706.55760-3-carenas@gmail.com>
        <YULUS3kYkB4RXv2K@nand.local>
Date:   Wed, 15 Sep 2021 23:23:28 -0700
In-Reply-To: <YULUS3kYkB4RXv2K@nand.local> (Taylor Blau's message of "Thu, 16
        Sep 2021 01:21:15 -0400")
Message-ID: <xmqq8rzxujhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C068C16-16B6-11EC-BA11-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +	tree=$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&
>
> In this and the below tests which had a similar transformation, the
> first invocation does not mask its error, since it's on the right-hand
> side of a pipe.
>
> But piping "git show" to sed will mask the exit code of the former. So
> that makes sense. But I would like to see us avoid an unnecessary
> cat-into-pipe and instead redirect out into sed, like "sed -n -e ...
> <out".

Good eyes.  There is no reason why we want to cat a single file into
pipe (unless we are testing the pipe mechanism of the underlying OS,
that is)---the downstream command can be fed the file from its
standard input, or for commands like "sed" that takes its input from
files listed on the command line, you should be able to write it
without the input "<" redirection.

Thanks.
