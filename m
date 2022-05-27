Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86732C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiE0RRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiE0RRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:17:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9F387B9
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:17:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B4AF19A938;
        Fri, 27 May 2022 13:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4b0imGemDDst
        CaRC5QXyWpUgK+uXd+85Qar5FA36hVQ=; b=e6v+tJ1hVZuO9Qbn1Y8TBQ3YveUx
        inHRNGugMmXjVnbnCvmj1x/JgZoD/W6aZ/fbGSwDjQIpurgaWG7p3uygYo7KT3Y4
        UKuhgaE12sXTE1ziB3nfkTkNue7Gd5kiwUpmqDvV91FEUKX13FTnOQ4D4MqFaQOP
        GrRij5dRVVvQ5lw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0402A19A937;
        Fri, 27 May 2022 13:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9811519A934;
        Fri, 27 May 2022 13:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
Date:   Fri, 27 May 2022 10:17:01 -0700
In-Reply-To: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 27 May
 2022 11:14:29
        +0200")
Message-ID: <xmqqa6b2520i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D323CA14-DDE0-11EC-8C94-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A re-roll of [1] which aims to address the concerns about the previous
> 8-part series being too large to fix a release regression. "If it
> isn't bolted down, throw it overboard!".
>
> The main change here is:
>
>  * The new "ungroup" parameter is now passed via an "extern" parameter.
>  * Tests for existing run-command.c behavior (not narrowly needed for
>    the regression fix) are gone.
>  * Adding an INIT macro is gone, instead we explicitly  initialize to N=
ULL.
>  * Stray bugfix for existing hook test is gone.
>
> etc. I think all of those still make sense, but they're something I
> can rebase on this topic once it (hopefully) lands. In the meantime
> the updated commit messages for the remaining two (see start of the
> range-diff below) argue for this being a a safe API change, even if
> the interface is a bit nasty.

So the approach taken here is that we assume the reported one is the
only regression and keep going with run_process_parallel() API.

I still share the sentiment with Dscho that it is generally a bad
idea, when dealing with a regression, to double-down and dig in
your heels to keep the change that caused a regression with paper
over patches, but too much time has passed since the release, and a
patch or two on top does look like a quicker way forward.

I left a few comments on the implementation, but modulo these small
details, the code looks OK (provided that the assumption holds true,
that is, of course).

Thanks.

