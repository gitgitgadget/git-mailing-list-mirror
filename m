Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D167C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA28264DEC
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhA1T67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 14:58:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62126 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhA1T61 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 14:58:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A6ED96950;
        Thu, 28 Jan 2021 14:52:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Dk2x3TkbNSI8PVtkbJIIOrSof0=; b=OPyWVq
        eoKcPmx5Sz1p6HDzDYD5f0+nybcB+bbnmYswbKS0OddeTcTGkMhYEuTSu8epfFxa
        7nR8ONXa9mOFlxM1cl9XM/nPgFt9Zi6AUT6Yk9xE3tRbIQm0UKxUq3BTlrJbWPzT
        9tUetQUYKGH4FO458DAUeHOBmBxsjcO+MAfUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ifZn523VXlMmYdzw6oPGJA0hrRdS+1nF
        JMGdb9MO+PSJLiXjF/eTJe66Pz5j/tZM7qMZymPkaR7fgVi2NlJliCHfnaqHQDWn
        QupWXcur3Jo5bckbVQ8kRXhRUd6neEudEUB+j4rMNtTorbBom48rPShyRxAodFxp
        SKfkMwmHpJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 828C99694E;
        Thu, 28 Jan 2021 14:52:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13B179694D;
        Thu, 28 Jan 2021 14:52:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] rerere: use strmap to store rerere directories
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
        <YBJXYMFu8dhOabDv@coredump.intra.peff.net>
        <YBJa98B1a6mP/Bsx@coredump.intra.peff.net>
Date:   Thu, 28 Jan 2021 11:52:20 -0800
In-Reply-To: <YBJa98B1a6mP/Bsx@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Jan 2021 01:34:31 -0500")
Message-ID: <xmqq8s8cx2iz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5570321C-61A2-11EB-954E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] rerere: use strmap to store rerere directories
>
> We store a struct for each directory we access under .git/rr-cache. The
> structs are kept in an array sorted by the binary hash associated with
> their name (and we do lookups with a binary search).
>
> This works OK, but there are a few small downsides:
>
>  - the amount of code isn't huge, but it's more than we'd need using one
>    of our other stock data structures
>
>  - the insertion into a sorted array is quadratic (though in practice
>    it's unlikely anybody has enough conflicts for this to matter)
>
>  - it's intimately tied to the representation of an object hash. This
>    isn't a big deal, as the conflict ids we generate use the same hash,
>    but it produces a few awkward bits (e.g., we are the only user of
>    hash_pos() that is not using object_id).
>
> Let's instead just treat the directory names as strings, and store them
> in a strmap. This is less code, and removes the use of hash_pos().

Nice.  I didn't realize that this part is so well isolated that
another table implementation can easily be dropped in (it was a long
time since I stared at this part of the system, back when I was
extending it to handle <preimage,postimage> pairs that share the
same conflict IDs, which was quite tricky to get right).

> This one might be controversial, or at least considered unnecessary
> churn. Because the benefits I listed above are pretty negligible, and
> really my ulterior motive is getting rid of the call to hash_pos().

No objection from me.  Thanks.
