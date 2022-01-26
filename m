Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBFC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 06:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiAZGDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 01:03:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56937 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiAZGD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 01:03:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED360171C22;
        Wed, 26 Jan 2022 01:03:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mYnZRaWT1UeVVKvdz9qb5SYbUT2P7JpuKDJOniSqD5A=; b=NGkC
        CGa8eQ+sDkNkyHAUKkx5NGTw5KmBQD8SKOXhTokqXsJew+iZeV8QS3zj7uHKf2+B
        qcGrhNAJXqahnbrYUzdBvbZaVAHU4tu+FgJ/lxnRiyA1xmy4WWJVfOUZBVeP9+T9
        5eCh8a8F3P5Uzm5UQ0EdHisUFShSkEx0zqdjRBo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E600E171C21;
        Wed, 26 Jan 2022 01:03:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61778171C20;
        Wed, 26 Jan 2022 01:03:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to submodules
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
        <xmqqsftgbkvm.fsf@gitster.g>
        <CABPp-BE2B9NkWG8bWft6m-UOg66aRpjwSRTWvAyrKCiwJCemHQ@mail.gmail.com>
Date:   Tue, 25 Jan 2022 22:03:25 -0800
Message-ID: <xmqqilu7t4nm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD354A12-7E6D-11EC-A3BF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But how would that interact with this patch?  There's a bit of a
> conflict.  There's a few ways out:
>   * Make your change be explicit rather than implicit: Based on
> Junio's first concern, you could modify this patch so that it requires
> a new flag like --filter-submodules-too (or some better name), and
> perhaps folks with a path filter just wouldn't use that.

I would very much prefer this, given that this is a change of
default proposed by those who want a different default than the
status quo, even without the "how would we know it is sensible to
just pass down any and all filters?" issue.

>   * Make these incompatible: Maybe a path filter is incompatible with
> --recurse-submodules, and we should throw an error if both are
> specified.

Perhaps.  Or automatically filter out such an incompatible ones, but
of course, that would mean submodules are made less filtered than
top-level which is usually the other way around.

>   * Attempt to marry the two options: Each submodule could perhaps
> extract the subset of paths with itself as a leading directory and
> remove that leading prefix and then use that as the path portion of
> the filter.  (And perhaps even taking this a step farther: each level
> of cloning will only recurse into submodules which match the specified
> paths).

Yup, for some filters, passing them down may have a "natural"
translation, similar to adding the prefix to a pathspec element.
It would probably depend on the filter if there is such a natural
translation even exists, though.
