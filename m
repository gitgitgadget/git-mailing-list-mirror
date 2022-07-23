Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E00C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiGWRpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiGWRpN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 13:45:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92E2BF2
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 10:45:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 642AF192700;
        Sat, 23 Jul 2022 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SLeZN7MpkGKt
        fwsWSu1S6qr5wGXmKjSUNJ0z2nFf3KU=; b=CJ5eRIgKqdPof1leiDxyJOP5NEpO
        z8FsaE6DMZ0skkOw4Ubn7SYwJLQvnPr/KsxzNI3WFuwVLveaPngydIj8GOAtgWGW
        hVM9dTns3fuGTDwx1IEpZZ7bgXFWkPgYFwy5d14kFGtdK22iZXpP0JgZjskqHe5L
        CDLe+Xw8ajlGTBU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C4B01926FF;
        Sat, 23 Jul 2022 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03CE41926FD;
        Sat, 23 Jul 2022 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
References: <cover.1658532524.git.me@ttaylorr.com>
        <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
        <220723.86leskqtej.gmgdl@evledraar.gmail.com>
Date:   Sat, 23 Jul 2022 10:45:05 -0700
In-Reply-To: <220723.86leskqtej.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Jul 2022 07:17:48 +0200")
Message-ID: <xmqqmtczafku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30A97B20-0AAF-11ED-BE5D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This doesn't apply to the rest of cat-file directly, but the origin of
> the recent --batch-command mode cdoe was to lift the same-ish code from
> builtin/update-ref.c, whose \n or \0 mode does exactly that:
>
> 	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
>
> I.e. it doesn't support \r\n, just \n or \0.
>
> Isn't that fine? I may be missing something, but why isn't it OK even o=
n
> platforms that use \r\n for their normal *.txt endings to only use \n o=
r
> \0 for this bit of protocol?
>
> So maybe we should just do something like that instead? I.e. declare
> that a mistake.

Good point.

> So isn't this just an accident in of us having used the strbuf_getline(=
)
> function to mean "\n", but actually it also does "\r\n".
>
> Which is a really unfortunately named function b.t.w., since it sneaks
> this bit of Windows portability into places that may not want it in the
> first place.

getline() is to read a single "logical" line, so it is fine for it
to strip CRLF on platforms with CRLF, and to leave CR at the end of
line on a LF platform.  If the "protocol" is defined to use LF on
any platform (and allow a payload that ends with CR to be passed),
you can argue that it is a wrong helper to call.

But does that result in a sensible behaviour?  I am not sure.  Some
editors that are popular on LF platforms can produce CRLF files when
the user asks (either on purpose or by mistake), and when not using
the "-z" mode of input, I suspect that most users would expect CR at
the end of the "line" (terminated with LF on their platform of
choice) would be thrown away even on their LF platform, simply
because it is unlikely that the kind of input they are preparing can
usefully and legitimately end with CR, as their colleagues on CRLF
platforms may also have to produce similar input.  IOW, the presence
of CRLF platforms makes text lines that end with CR much less useful
everywhere.

And from that point of view, "getline() or getwholeline(NUL)" may be
a pattern that is practically more useful than the old "use always
getwholeline(NUL or LF)" convention that I invented more than 10
years ago.
