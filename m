Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CEFC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1099610E8
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 22:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhDNWK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 18:10:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57210 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhDNWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 18:10:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67004B87BE;
        Wed, 14 Apr 2021 18:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGFQUghkBLdCU23z02vZyEHJCDw=; b=IdV498
        ob5mEMQpfc2KSNry8qNFiGWCXore8Tzs/FUtOmT+QMsFDPN33Vbr4bDclZ32CEV4
        abC10m1vZbReTE/VaybuUME1M0nYSHi8kzf2Efd3bjYiwg8I+JWiTgC98gY0H/Io
        0GAogfkJ4tciU4Q7+50dWdV/TdPcnFucTQcWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vmywwfqo6bqgVtFk0FVfRsM/7cz29FHF
        0TkVagGZHkjcXjhQKjMlDCwqmMZneTTCBGDif/Rn7CwvxbWIN8+5r5LzYdQrMDHW
        kHwbnoCu8qZ1J/TLyonXkkEf4FsMjY2kRN1MX128MtzumhXTI0WNjRYDHPHeyh12
        pBvZjVS448E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F887B87BD;
        Wed, 14 Apr 2021 18:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B5BCB87BC;
        Wed, 14 Apr 2021 18:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/2] prevent `repack` to unpack and delete promisor objects
References: <20210403090412.GH2271@szeder.dev>
        <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
Date:   Wed, 14 Apr 2021 15:10:29 -0700
In-Reply-To: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Wed, 14 Apr 2021 21:14:01 +0200")
Message-ID: <xmqqr1jcwm96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39C3062C-9D6E-11EB-81F6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> This series is built on top of jk/promisor-optim. It conflicts with
> changes on p5600 otherwise.
>
> The following patches fixes the issue where we unnecessarily turn loose
> all the promisor objects and deletes them right after when running
> `repack -A -d ..` (via `git gc) for a partial repository. 
>
> Special thanks to Peff, for proposing a better approach for managing
> the situation and for Jonathan Tan for earlier interaction on the
> solution. Previously, I thought we should skip the promisor objects
> by just adding a check in loosened_object_can_be_discarded(). However,
> Peff pointed out that we can do better by realizing much sooner that
> we should not even consider loosening the objects for the _old_ promisor
> packs.
>
> It took me a bit to come up with the test because it seems `repack`
> doesn't offer an option to skip the "deletion of unpacked objects",
> so this series adds a new option to `repack` for skip the
> `git prune-packed` execution thus allowing us to easily inspect the
> unpacked objects before they are removed and simplification of our
> test suite. Furthermore, The test will now test the `repack` code
> path instead of performing the operations by calling
> `pack-objects`.

Beautiful.  Thanks for working so well together, all of you.


> Rafael Silva (2):
>   repack: teach --no-prune-packed to skip `git prune-packed`
>   repack: avoid loosening promisor pack objects in partial clones
>
>  Documentation/git-repack.txt  |  5 +++++
>  builtin/repack.c              | 15 ++++++++++++---
>  t/perf/p5600-partial-clone.sh |  4 ++++
>  t/t5616-partial-clone.sh      |  9 +++++++++
>  t/t7700-repack.sh             | 23 +++++++++++------------
>  5 files changed, 41 insertions(+), 15 deletions(-)
