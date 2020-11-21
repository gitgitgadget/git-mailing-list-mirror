Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DEC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D482158C
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+D8mVDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgKUWqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:46:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55353 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgKUWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 17:46:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 664C4110A27;
        Sat, 21 Nov 2020 17:46:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jFNBPIp3MpFY
        pIQEHS+rJJsVkUA=; b=W+D8mVDY+wMtGYIAekAi+QfBhBNRzQVJ+BZ34l8ifylv
        1OghZakRFArgPWcbMMWZ7rKo0NE/o3ZswOLF5IIBsT7vYyL2Chy1DXxiX6z6/p8D
        iSO6CxLWwH3mIYptH9Cj/tkQNtcBDgqRdJtZUgCCW8mX1Odnuufxy9Dabq0Mwz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pV51tr
        6Wnawkri0x9LDVIxgWGJSAYBSoA0ItL8NUjCa5fzP4RhajY/AdOhRK36oTGqX5oA
        rHKbPssT4j3o31h0LTHgIiMa/tQIAYVovme6XqJA2c7GlnrXMxaHsif9miitpXus
        ZjxG4x5QPPdUoSKydHvUaGmaJHSzxtrrcR5P8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F0A7110A26;
        Sat, 21 Nov 2020 17:46:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F78F110A25;
        Sat, 21 Nov 2020 17:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/4] grep: simplify color setup
References: <cover.1605972564.git.martin.agren@gmail.com>
        <d6e43bc540bc682bb46d54e579a7101d0d2c462d.1605972564.git.martin.agren@gmail.com>
        <20201121202310.GA972561@coredump.intra.peff.net>
Date:   Sat, 21 Nov 2020 14:46:14 -0800
In-Reply-To: <20201121202310.GA972561@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 21 Nov 2020 15:23:10 -0500")
Message-ID: <xmqq4klis4zt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D655100-2C4B-11EB-BE6E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Nov 21, 2020 at 07:31:09PM +0100, Martin =C3=85gren wrote:
>
>> The previous commit left us with only one user of the one-line wrapper
>> `color_set()`. We could inline it, but note how we're `xsnprintf()`-in=
g
>> all the entries in one array into another array of the same type. We
>> might as well just `memcpy()` everything into place.
>>=20
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  Cc-ing Peff, who initially introduced this helper. After having inlin=
ed
>>  the function into the for loop, it seemed better to just copy the who=
le
>>  array. Happy to hear arguments against.
>
> No, this is way better than the existing code. I introduced it to get
> away from strcpy(), but this is better still. But...

Yes, the copy in this patch looks eminently sensible.

>>  Come to think of it, I suppose we could copy the whole struct and not
>>  just the color array. Hmmm...
>
> Yes, this seems even better. If our goal is just to start our new
> grep_opt the same as grep_defaults, then a single-line struct copy
> (whether through assignment or memcpy) is even clearer and more
> maintainable.

... until such a time when typeof(grep_defaults) gains a field with
a non-const pointer value that we'd rather not to share amongst
instances of the type, at which point it no longer is clear win from
maintainability's point of view.
