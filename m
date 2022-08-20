Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B0C28D13
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiHTASo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHTASm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 20:18:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DAF61D48
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:18:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F55D1B0764;
        Fri, 19 Aug 2022 20:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fSz1TzeH5HUzEw8j0rIGL34FvEyCkmY0OfEMdwBRV5I=; b=G1+M
        nXIHGlVohrafn63fZCOm/fDNi2AAzXvlMjodXXifSr/cv59ZiD8LEJFhkDLZtNAU
        ek2AatYFjJXYE5yHnDZe3FMpUALzCay56I6X9Ap38twIVDuvXrLA5kNVMkbNv4Cz
        HK/4iSD32TCzRWPEEKFIuLP7SxjcHnL3bVxReZk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06B071B0763;
        Fri, 19 Aug 2022 20:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEC951B075F;
        Fri, 19 Aug 2022 20:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2022, #02; Fri, 5)
References: <xmqqa68ixcrf.fsf@gitster.g>
        <CAPig+cSz9RKj43_kwQFDQpN2Ggrimrw_DcOFnxGS+nBCPqDK5Q@mail.gmail.com>
        <xmqqa68evodq.fsf@gitster.g>
        <o5340r34-027q-4ops-93o1-8368s4qropo5@tzk.qr>
        <CAPig+cRp4N=6EktoisKAH09aVAPkPgZfHJYcB5pJFJ-CUpBHFA@mail.gmail.com>
Date:   Fri, 19 Aug 2022 17:18:34 -0700
Message-ID: <xmqqo7wfix7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1B1E6EE-201D-11ED-BF48-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Unfortunately, I'm not going to be much help here since I don't grok
> "creation factor" well enough to put an explanation into words, even
> after having read the "algorithm" section multiple times[1]. The
> situation is further confused (at least to me) by the "algorithm"
> section in the `git range-diff` documentation stating that the "fudge
> factor ... should be smaller than 100%", yet your position in this
> discussion is that the creation factor can be greater than 100%.
>
> FOOTNOTES
>
> [1]: I likewise didn't understand it well enough when submitting[2]
> which added --creation-factor to `git format-patch`, which is why I
> punted at that time and simply referred the reader to the `git
> range-diff` documentation.

So it wasn't just me or other folks who were confused in the
original discussion thread that lead to

https://lore.kernel.org/git/xmqqa68nlfiz.fsf@gitster.g/

where I said

    ... The former helps the readers guess what a reasonable value
    they want to specify is (e.g. "I can afford to dedicate yMB"), and
    the latter is essential for the readers to decide how exactly they
    express what they chose (e.g. "I want to give yMB, but it is
    measured in bytes, so I'll write y * 10^20 here").  We need both.

    So _after_ they decide that 1.20 is the right number they want to
    give to --creation-factor, the knowledge that the number is
    expressed as percent does help them to write --creation-factor=120
    correctly (not --creation-factor=1.20).

    But for readers to come up with the number 1.20, there needs a
    better explanation of what the number means in the first place.  "Go
    read the algorithm section" is better than having nothing there, but
    we should be able to do better by having a simple-to-understand
    single paragraph description.

i.e. out of the current documentation, it is hard for readers to
extract information they need to decide what value they want to
specify.  The part of it that talks about <percent> may tell them to
spell "120" when they want to specify 1.20, but that is not all that
helpful when they do not know what criteria they want to use to
choose between 0.60 and 1.20 in the first place X-<.
