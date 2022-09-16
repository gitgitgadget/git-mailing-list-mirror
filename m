Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A98ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIPPzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiIPPzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:55:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72530E93
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:55:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C94811351B4;
        Fri, 16 Sep 2022 11:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BgHCKYPyyvyN
        ogXRCZQy+NotWpP4i1VGz33fOTgr0r4=; b=wJWvS0gQHEVPy4rqbJdgIzS3zIAH
        FW9rb4SjyB52wOGtYYlIqT9jXVqmZkjo74LtAIxIlxs79hRuAN5lrLm/1ZN6ZC31
        h+JIQnIfHHuIIldRbNdj8BfSPrXmBwVIHmtj0uQu1DvlIvAeYBH1cdcdDhz3D20I
        XoLjTC5/XxQoryU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBCA21351B3;
        Fri, 16 Sep 2022 11:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F57C1351B2;
        Fri, 16 Sep 2022 11:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 6/6] revision: add parents after child for ^!
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
        <84018532-169f-dc9b-f894-3d19bb7b4245@web.de>
        <xmqq5yhoo76m.fsf@gitster.g>
        <29d50baa-1923-38e1-6ecb-73840376d28e@web.de>
Date:   Fri, 16 Sep 2022 08:55:45 -0700
In-Reply-To: <29d50baa-1923-38e1-6ecb-73840376d28e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 16 Sep 2022 11:02:01 +0200")
Message-ID: <xmqqh717jou6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06CA0F96-35D8-11ED-A4B4-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> "git diff A B", "git diff A..B", "git diff ^A B" and "git diff "B ^A"
> all produce the same output.  So I suspect we could reverse the order
> for A..B as well without ill effect if we wanted.

Yup.

>> Can't we "fix" it at the consumer end, perhaps by checking where
>> these commits came from by looking at rev.cmdline?
>
> We could.

Yeah, doing so may be more in line with how two-tree comparison is
parsed (your observation above on four combinations).

> --- >8 ---
> Subject: [PATCH] diff: support ^! for merges
>
> revision.c::handle_revision_arg_1() resolves <rev>^! by first adding th=
e
> negated parents and then <rev> itself.  builtin_diff_combined() expects
> the first tree to be the merge and the remaining ones to be the parents=
,
> though.  This mismatch results in bogus diff output.
>
> Remember the first tree that doesn't belong to a parent and use it
> instead of blindly picking the first one.  This makes "git diff <rev>^!=
"
> consistent with "git show <rev>^!".
>
> Reported-by: Tim Jaacks <tim.jaacks@garz-fricke.com>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> The check "i < rev.cmdline.nr" is necessary to avoid segfaults e.g.
> in t0005.  I wonder why.  Shouldn't rev.pending.objects and
> rev.cmdline.rev always have the same number of entries?

Things that did not come from command line can go into pending,
can't they?  E.g. add_head_to_pending(), when lack of rev defaults
to "HEAD", touches pending without touching cmdline?
