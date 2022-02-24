Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6719C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiBXRRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBXRRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 12:17:18 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2DE396B1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:16:43 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B548F126655;
        Thu, 24 Feb 2022 12:16:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OBRbAX0uQkbW4dCvjsRE7ufy6Jri9sLlaEd1Wa
        Hj5Ok=; b=ILTCCWR+fq7PPyQTEcUzq74dc8sSUaUE/7j42ppNKh1bxkFkShkG8E
        BHpLdki7kt6eAQjhnux2sLRBM+rLhbRAsY9uz3jgu+7MSzxKdi/DS6ZvBF4lC1sn
        H5mlkeJNJLqbPXuHbDAH+mP/Twf6s6eSU/tpRrr2OyUrQ23Gy5mqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD75C126654;
        Thu, 24 Feb 2022 12:16:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25D8A126653;
        Thu, 24 Feb 2022 12:16:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
        <xmqqpmnl8evc.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2202241646430.11118@tvgsbejvaqbjf.bet>
Date:   Thu, 24 Feb 2022 09:16:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202241646430.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 24 Feb 2022 16:47:17 +0100
        (CET)")
Message-ID: <xmqqo82wnq14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87BECCA6-9595-11EC-A7D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Just to make sure: I did not intend to insult anyone (and in hindsight I
> wish that I had made that clearer).

It is OK that you are wiser in hindsight.  We all are, and we try to
do better the next time ;-)

Thanks for reminding of the topic.

As a general principle, when introducing a new feature that achieves
the same goal in a new and improved way, it is safer to introduce it
in such a way that users of older implementations that lack the
feature cannot choose it by mistake.

One way to do so is to we reuse the same configuration knob by
adding a new settings value that older implementations would choke
on, the users will be forced to ensure that the older and proven way
is used consistently everywhere, until every tool the user uses are
ready.

For this instance, I think it is OK to split and allow two to
operate on the same data at the same time, because I believe that
both old and new implementation will leave a permanent difference to
the on-disk data that cannot later be reused by the other [*].

But it is an exception than a norm when adding a new thing that
extends an existing feature (as opposed to inventing totally a new
thing that won't overlap with any existing one).  As a general
principle, it is much safer to make sure it breaks (and have users
hold off) when the new setting is given to an old implementation.

    * Side note.  For example, if we introduce the index-v5 feature
    by not reusing the index.version but with index.usev5 variable,
    new implementations that know about the knob would write out v5
    data that existing implementations will not work with.

Also, from the point of view of the longer-term maintenance, of
course not having to deal with orthogonal looking different
configuration variables where newer ones override the older ones
will induce more pain over time.
