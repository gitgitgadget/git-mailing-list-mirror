Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4355EE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 04:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjHVEgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 00:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHVEge (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 00:36:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC56184
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 21:36:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 849FC1AB32;
        Tue, 22 Aug 2023 00:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IJoD6bvUEhs0Fy7NVZA8kIH49mmG2/2IhsQcen
        n2U94=; b=pxIjHidG8k0QRXJeAPORvEgTVTgI9PeqF62qMRdcm7jIMPv2t8EYY7
        bLcvqd0oAUAcAy61q7SBdnppw4TELYWWwKvN7+yAaGjF0AHly50pmoxfmtaTgYUe
        RtauR35K890HdWgnkonMYbWwDJBACdOLm4kNETdoeeOEUmWZlIqXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C5E41AB31;
        Tue, 22 Aug 2023 00:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15C921AB2F;
        Tue, 22 Aug 2023 00:36:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid building from the same commit in parallel
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
        <xmqq350kjfk8.fsf@gitster.g>
        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
        <ZNv5PQlkn6tbUcH7@nand.local>
        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
        <xmqqo7j5uqza.fsf@gitster.g>
        <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de>
        <xmqqttssqsj5.fsf@gitster.g> <xmqq1qfvor35.fsf_-_@gitster.g>
Date:   Mon, 21 Aug 2023 21:36:24 -0700
In-Reply-To: <xmqq1qfvor35.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Mon, 21 Aug 2023 17:31:26 -0700")
Message-ID: <xmqqpm3fn16f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 745C6B02-40A5-11EE-9095-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * There are tons of concurrency groups defined, but as a trial
>    change, here is to cover the "regular" matrix that consumes the
>    most resources (linux-asan-ubsan is the worst culprit, it seems).

Unfortunately, this did not work.

https://github.com/git/git/actions/runs/5933451874
https://github.com/git/git/actions/runs/5933451805

are trial runs that had the same commit with this patch pushed to
'seen' and 'pu'.  While one of them started the "regular" matrix,
the other one indeed went into paused state and waited.  But that is
way too late.  What happened was that their "config" (which everything
else depends on) started in parallel before the serialization at the
"regular" matrix kicked in.

So, one did wait before doing the "regular" matrix, until the other
one finished everything, and then kept going and did its own
"regular" matrix for the same commit.  It is because the avoidance
of "redundant build" was done at the "config" phase, which both of
them had already done X-<.

If we wanted to do this, I suspect that we need to serialize the
entire thing, not at the individual level where we currently define
the "concurrency" thing.
