Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A8AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7015A6528A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCHWch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:32:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64550 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHWc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 17:32:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D46E2A2A3B;
        Mon,  8 Mar 2021 17:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YL56KyJIX0qjqOp3FGnZGe3bKHQ=; b=VUUsKO
        D2Q7vVx6CVw4DzMMPF3NerUsDuxcUKcXP6pM0vmDXXvsI4td++BSOntlgtW4JHZG
        TLOEatWTtFW3gr8rGCjM7dVftJHHQQHDTaU6bz64u+USuPNimL8sm3hSbeUOZ7fP
        6s210BlpvGBItXXEfxYSbdNmHJedxV0oTH3rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oEkyPRUKdpSUw+nnEgRFGpSWYQo7dfcw
        Q/JAKZkqlgMRCJeczC6O0LrE1n9fsjfX49+Eor4FzR7N0lLms8QD3EWM2iw4Cv4D
        MRqjefgJE596zVj17vpHOMVRQ4dqSKsfz6ndLPnWqhG8DENzs+uXOepMvYzeUliR
        0zqWXno+vSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBB73A2A3A;
        Mon,  8 Mar 2021 17:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BFC3A2A39;
        Mon,  8 Mar 2021 17:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/7] oid_object_info(): return "enum object_type"
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
        <20210308200426.21824-4-avarab@gmail.com>
        <xmqqwnuh48gd.fsf@gitster.c.googlers.com>
Date:   Mon, 08 Mar 2021 14:32:27 -0800
In-Reply-To: <xmqqwnuh48gd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Mar 2021 13:54:58 -0800")
Message-ID: <xmqqo8ft46pw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29F273FE-805E-11EB-956D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And the issue is the same for all the other explicit comparison with
> OBJ_BAD.  If we do it the other way around, i.e. leave these callers
> as they are and add new negative return values to the function first,
> and then convert "if negative, say error" to "if OBJ_BAD, say so,
> else if we have this new type of error, say so", then the risk of
> mistake becomes smaller.
>
> But hopefully any such potential issue will be resolved by the end
> of this short series, so as long as it won't be left as technical
> debt, I am OK.

And after reading through the topic to the end, it turns out that
the code did not add new error return value.  So while it probably
is a good idea to make oid_object_info() to return the enum, I am
not convinced that the updates to the caller that used to check for
the negativeness is an improvement.  Rewriting the ones that used to
compare with -1 for equality to instead compare with OBJ_BAD would
be very much welcome, though.

