Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C14C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiAaWPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:15:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiAaWPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:15:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D17D01656F2;
        Mon, 31 Jan 2022 17:15:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QP+MhnJCRCkJS2emIwZUigRJD9DZf/jP41KFab
        mv3ZM=; b=wT3j2rw0PQEOn7ldOWAj+WMKSHPPrSUEsDxqE8rhuOQoYMYVqKImqK
        LhvfCgK7AazXnbR5Qd3oMU/WDSl6QI2W4FR04MOI8ZX7u4OqC4Ecaka095LDy+ot
        3WBhVwX9SPKjEt0R0aDQB34zph6hmQCS2/rRvkqvKwpUDHNpdvC3U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9B6A1656F1;
        Mon, 31 Jan 2022 17:15:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B12CB1656EE;
        Mon, 31 Jan 2022 17:15:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local>
Date:   Mon, 31 Jan 2022 14:15:00 -0800
In-Reply-To: <YfhUIJuO70va6gr8@nand.local> (Taylor Blau's message of "Mon, 31
        Jan 2022 16:26:56 -0500")
Message-ID: <xmqqzgnbh7rv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BFFE13E-82E3-11EC-B378-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jan 31, 2022 at 05:50:19PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
>> From: Han-Wen Nienhuys <hanwen@google.com>
>>
>> The reftable backend doesn't support mere existence of reflogs.
>
> Perhaps I'm missing something obvious, but this and the previous patch
> seem to be conflicting each other.
>
> My understanding of the previous change is that you wanted a reflog
> entry when the REFFILES prerequisite isn't met. But this patch says what
> matches my understanding is that reftable and reflogs do not play
> together.
>
> If reflogs do not interact with the reftable backend, then what does
> this patch do?

One difference between the files and the reftable backend is that
with the files backend, you can say "I am not adding any entry yet,
but remember that reflog is enabled for this ref, while all other
refs reflog is not enabled", and the way to do so is to touch the
"$GIT_DIR/logs/refs/heads/frotz" file---this enables reflog for the
"frotz" branch, even if core.logAllRefUpdates is not set.

Because there is no generic reflog API that says "enable log for
this ref", a test that checks this feature with files backend would
do "touch .git/refs/heads/frotz".

I didn't look at "this patch", but it is understandable if such a
test needs to be skipped via REFFILES prerequisite, because the
reftable backend lacks this feature.
