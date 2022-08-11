Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B7C19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 05:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiHKFUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 01:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKFUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 01:20:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF660550B1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 22:20:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A97F5138260;
        Thu, 11 Aug 2022 01:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LODkkGj4WuCkkXOt3FGLl2Yj7N9m6aSmMr21Bu
        qihEg=; b=aqyDsXzMBI9s8MxHB4Z20IevIqL2M0xSi855ZJDagB51BRgycu9oCw
        Od8iImuRyrnjFgJwqZQL6vLOwnIFhT8gePCH+bKgrDBYBg7Ksw/apYH2Ws0R2vGy
        zInDvMBG599B0afct/y/Ciy7EYUGA/mlZUJtR1Y1JaMImO4/S9wDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F41713825E;
        Thu, 11 Aug 2022 01:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E572713825D;
        Thu, 11 Aug 2022 01:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v4] rev-list: support human-readable output for
 `--disk-usage`
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
        <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
        <xmqqlerwm28n.fsf@gitster.g>
        <YvQhHOkjZatIqlFr@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 22:20:14 -0700
In-Reply-To: <YvQhHOkjZatIqlFr@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Aug 2022 17:20:28 -0400")
Message-ID: <xmqqy1vvgxv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 488DDD96-1935-11ED-A9D4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't care much between "printf directly vs strbuf" for the non-human
> case, but it was an earlier review suggestion to connect them. I do
> think the result is a little easier to follow, but mostly I want to make
> it clear that the author is getting stuck between warring review
> comments here. ;)

The function does look like it can later be called millions of
times, at which time we may want to measure, but as the only use of
this helper function is to get called just once at the end with a
single number and print it (as opposed to getting called once per
each object), I do not care too much about the normal case being
made unnecessarily more expensive, either.

I still do not see the point of changing it to print to a strbuf and
puts() the result, though.  It does not make the code shorter, more
efficient, or more readable.  Once "if (we are producing humanize
format)" condition is hit, both of its branches can either be (1)
responsible to print the number to the standard output stream, using
whatever implementation, or (2) responsible to print the number to a
strbuf, so that somebody outside the if statement will be
respohnsible for printing that string to the standard output stream.

The patch chooses (2), which is more complex, for no good reason.  A
good thing about (1) is that the non-human codepath can STAY to be
the same as before, which is one fewer chance to introduce
unnecessary bugs.

Anyway...
