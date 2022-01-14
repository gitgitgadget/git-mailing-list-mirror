Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A2C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 23:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiANXMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:12:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56471 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiANXMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 18:12:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FB6616844E;
        Fri, 14 Jan 2022 18:12:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekJaQp5r4HhsjYrYg4uw/FbxZoSoTnQZK8Ceaf
        mT/iw=; b=fXzYWKRjgahdBDnEk7sNJ3i3GsqqSL4phKokMdXfFxeUYZnCZAzmAn
        9gwAJ9S4DZFmfwJOIZYRpd/K/OI4RAut5WB71iX8ETpXs6b5kTCyZT5CuRJfAjjl
        BkabzEoJfZd+9JrxO+U3cHgC3TrNRhISf5JDhETNblx3AOi7Sk8vA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47A9416844D;
        Fri, 14 Jan 2022 18:12:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B385216844C;
        Fri, 14 Jan 2022 18:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
References: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
        <220114.86wnj2se41.gmgdl@evledraar.gmail.com>
        <xmqqzgnyb03z.fsf@gitster.g>
Date:   Fri, 14 Jan 2022 15:12:37 -0800
In-Reply-To: <xmqqzgnyb03z.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 11:14:56 -0800")
Message-ID: <xmqqv8yl9aje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 778311C4-758F-11EC-ADAD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, if oid_array is used to produce a de-duplicated list of object
> names in the current code, it is very likely that oid_array is
> sorted (perhaps the objects are fed in sorted order), and the
> callers depend on the order of the objects they find in the array.
> Throwing sorted list of object names at oidset and then iterating
> over what is in the oidset would likely to destroy the original
> ordering.  I do not offhand know if the callers are broken by such a
> change (either correctness-wise or performance-wise).

Since I had a bit of downtime waiting for CI, I took a look.

It seems that the list of objects collected in the oidset/oid_array
is fed to "git fetch --stdin" for lazy fetching, so I would be
surprised if the order of objects matter.  So I would stop worrying
about correctness or performance due to ordering change.

>> But most importantly is it worth it? What's the rationale for the
>> change? Less CPU/memory use? Getting e.g. "hyperfine" or "/usr/bin/time
>> -v" output for those (if so) would be valuable.

But I still agree with this.  How much duplication would a typical
request for a lazy fetch involve?  Would it cause duplicate "want"
to make the protocol exchange noticeably larger?

Having said all that, the change makes the code smaller, and
possibly easier to follow.

The primary reason why promisor-remote.c::remove_fetched_oids()
shrinks so much is because we used to scan the array and copied
the surviving ones into a new array, while the new code just
iterates over the oidset and removes the ones that were fetched.
I am assuming that mucking with the oidset's contents while you
are iterating over it is safe, but if that is not the case, then
the advantage of the smaller code disappears.

