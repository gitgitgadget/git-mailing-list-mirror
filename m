Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732ACC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3561283
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355551AbhJAVrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:47:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60041 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355450AbhJAVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:47:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 023511647A1;
        Fri,  1 Oct 2021 17:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bBeSwAojPpvo
        nrtFWTquslDNL6afSfBCyl6wuH0FP1w=; b=g+Q+dLOHzUKXhAyq7LvgN5Up7kBO
        6PgpnMoBN7w+gseIktHCy/XdAFMyGu5GQWee43CXQE+zXP4sg2oJJDJizL+mi46Z
        wfeE1JLGPTyNlPlRfbH1KlHdLkgOoFqjMS2LgxTxzC5X9Ed9CLF5dAgTZve7XXsg
        FtA/C0CAGl8fStc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1D601647A0;
        Fri,  1 Oct 2021 17:45:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40E7E16479F;
        Fri,  1 Oct 2021 17:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 02/11] parse-options.[ch]: consistently use "enum
 parse_opt_flags"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
        <patch-v2-02.11-99f5251c557-20211001T142631Z-avarab@gmail.com>
Date:   Fri, 01 Oct 2021 14:45:17 -0700
In-Reply-To: <patch-v2-02.11-99f5251c557-20211001T142631Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Oct
 2021 16:29:08
        +0200")
Message-ID: <xmqq7dew4dxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE9349C4-2300-11EC-9A9A-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the "enum parse_opt_flags" instead of an "int flags" as arguments
> to the various functions in parse-options.c.

OK.

> In C enums aren't first-class types, and the "enum
> parse_opt_option_flag" uses a enum-as-bitfield pattern. So unlike
> exhaustively enumerated "case" arms we're not going to get validation
> that we used the "right" enum labels.
>
> I.e. this won't catch the sort of bug that was fixed with
> "PARSE_OPT_SHELL_EVAL" in the preceding commit.

Drop the two paragraphs above.  You do not sell a patch by saying
what benefit it does *not* give us.  We do buy a patch by what
benefit it does give us, which you describe well below.

> But there's still a benefit to doing this when it comes to the wider C
> ecosystem. E.g. the GNU debugger (gdb) will helpfully detect and print
> out meaningful enum labels in this case. Here's the output before and
> after when breaking in "parse_options()" after invoking "git stash
> show":
>
> Before:
>
>     (gdb) p flags
>     $1 =3D 9
>
> After:
>
>     (gdb) p flags
>     $1 =3D (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN)
