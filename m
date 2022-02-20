Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71369C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 07:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiBTHtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 02:49:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiBTHtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 02:49:41 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EB46177
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 23:49:20 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1D3E18F64B;
        Sun, 20 Feb 2022 02:49:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=03tQGSMlMMJg
        9H2zUg/zJsyLAh2dpjtC3BjYv6XMTQk=; b=A76yz5YHQimoAm4B8jcGyijw11+T
        nni8LZBv9IKeQMjUyCG4Ub8eLmnouZVwwlAIIEzyj/NhxaFx3JnMHhMkjafLPE62
        boEd+SKgSs0nuZG1JK+qyfoNq7+olL3brXOl11O3RYga4lM3vStLmcDoEF0oMkBK
        w5QLVNInpIkuAxQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB82118F64A;
        Sun, 20 Feb 2022 02:49:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42ECD18F649;
        Sun, 20 Feb 2022 02:49:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
        <xmqqpmnkymfn.fsf@gitster.g>
        <220219.86h78vftsa.gmgdl@evledraar.gmail.com>
Date:   Sat, 19 Feb 2022 23:49:16 -0800
In-Reply-To: <220219.86h78vftsa.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 19 Feb 2022 03:53:14 +0100")
Message-ID: <xmqqo832vuyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9AF41B9A-9221-11EC-846C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Perhaps prefix them with REFLOG_ or something?
>>
>> Or, do we even NEED to expose these bits outside the implementation
>> of reflog.c?  If these three constants are used ONLY by reflog.c and
>> not by builtin/reflog.c (or builtin/stash.c), then moving them to
>> where they are used, i.e. in reflog.c, without exposing them to
>> others in reflog.h, would be a far better thing to do.  That way,
>> they can stay with their original name, without having to add a
>> differentiating prefix.
>
> No objection to this, but FWIW the general pattern for these object.h
> flags is to use these un-prefixed names:
>
>      git grep -A20 'Remember to update object flag allocation' | grep d=
efine
>
> To be fair the only one that's really comparable is the revision.h ones=
,
> but those are very non-namespace-y, with names like SEEN, ADDED, SHOWN
> etc.

Yes, but I consider that revision.h owns the flag bits, and all
others that are local to a single *.c files borrow leftover bits
(and that is why the allocations can be overlapping).

And that is why my preference is to keep these within reflog.c if we
are separating it out of builtin/reflog.c to make sure they do not
pollute global namespace.
