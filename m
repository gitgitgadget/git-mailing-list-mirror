Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B310C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8AA6101E
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2UUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:20:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52857 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2UUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:20:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A529716AF16;
        Fri, 29 Oct 2021 16:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bbOa6ETJvbjz
        XSaLtpfFCzkxMK+PM7sc3IshVJE1uXA=; b=S3Sd/xgEs+Z4iWcnugUISgrdYSsz
        vCIurTl8Hw8AQRdzUHTxPLusTU6XvRl5vZeIZLyatisPn0Sv679x9dCH7ULGNQtG
        G1Yb5draaPFfuqrNyhd87LdKCJZCaPclA0sBAQYsd4egmpwWeOGWGd+tHHVb3BM3
        AaZnh6hM8lZGQc0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED5916AF15;
        Fri, 29 Oct 2021 16:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E8B616AF14;
        Fri, 29 Oct 2021 16:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
        <20211029184512.1568017-1-eschwartz@archlinux.org>
        <20211029184512.1568017-3-eschwartz@archlinux.org>
Date:   Fri, 29 Oct 2021 13:18:14 -0700
In-Reply-To: <20211029184512.1568017-3-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Fri, 29 Oct 2021 14:45:11 -0400")
Message-ID: <xmqqy26bk2k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5976DDB8-38F5-11EC-8991-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

>  +
> +** 'tags[=3D<BOOL>]': Instead of only considering annotated tags,
> +   consider lightweight tags as well.

This part contradicts what Jean-No=C3=ABl's df34a41f is trying to
achieve, which can be seen in these hunks from it:

    @@ -273,12 +273,12 @@ endif::git-rev-list[]
                              If any option is provided multiple times th=
e
                              last occurrence wins.
     +
    -The boolean options accept an optional value `[=3D<BOOL>]`. The valu=
es
    +The boolean options accept an optional value `[=3D<value>]`. The val=
ues
     `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean=
"
     sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
     option is given with no value, it's enabled.
     +
    -** 'key=3D<K>': only show trailers with specified key. Matching is d=
one
    +** 'key=3D<key>': only show trailers with specified <key>. Matching =
is done
        case-insensitively and trailing colon is optional. If option is
        given multiple times trailer lines matching any of the keys are
        shown. This option automatically enables the `only` option so tha=
t
    @@ -286,25 +286,25 @@ option is given with no value, it's enabled.
        desired it can be disabled with `only=3Dfalse`.  E.g.,
        `%(trailers:key=3DReviewed-by)` shows trailer lines with key
        `Reviewed-by`.
    -** 'only[=3D<BOOL>]': select whether non-trailer lines from the trai=
ler
    +** 'only[=3D<bool-value>]': select whether non-trailer lines from th=
e trailer
        block should be included.
    -** 'separator=3D<SEP>': specify a separator inserted between trailer
    +** 'separator=3D<sep>': specify a separator inserted between trailer
     ...


So, let's instead use

    tags[=3D<bool-value>]: Instead of only considering ...

i.e. lowercase, with -value suffix.

Thanks.
