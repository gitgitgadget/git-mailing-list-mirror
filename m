Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A716C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 06:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F64D60FDA
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 06:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJOGCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 02:02:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53612 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJOGCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 02:02:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4173FE5C2E;
        Fri, 15 Oct 2021 02:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zDy/606qOWLR
        XkCGFE7Ata53p/0OqhLPRHW/+hoyiTs=; b=ouYzLol6Wpa5U1Gj0RxXjamI7X0Y
        HijduRnssZcyVckcVDhTgIhkkvZI3G7CjZT7cUA8VAfjAiV3eXwaCGHxRzkFQds6
        6+SGpoO3iIv2wP28Y/ren/yf5yPVpNmMIJEBDb2+dhSsCDdJjuIjYZmLU1IKQqot
        r4c9qAovRZSgM5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39DAEE5C2D;
        Fri, 15 Oct 2021 02:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DF17E5C2C;
        Fri, 15 Oct 2021 02:00:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        vagabon.xyz@gmail.com, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH RESEND] archive: rewrite description for compression
 level option
References: <20211014120233.7834-1-bagasdotme@gmail.com>
        <xmqqh7djczxr.fsf@gitster.g>
        <8e99fbef-32d0-9f19-4e57-1f28108c70cb@gmail.com>
        <87lf2vylj9.fsf@evledraar.gmail.com>
Date:   Thu, 14 Oct 2021 23:00:14 -0700
In-Reply-To: <87lf2vylj9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 15 Oct 2021 06:11:01 +0200")
Message-ID: <xmqqpms6akup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AF70F0E-2D7D-11EC-A217-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Whatever we do here maybe we'd do well to emulate what "man gzip" does,
> up to and including perhaps adding the --fast and --best synonyms to
> "git archive"?

This section of the documentation is not about describing .tar.gz
but about .zip, so emulating "man gzip" to replace the description
under discussion may not be an excellent idea.  FWIW, "zip -h" on a
system where "zip" is Info-ZIP gives

	$ zip -h
	...
	-0    store only                -9 compress better
	...

and the existing "-0 or -9" that hints intermediate numbers are
possible matches its spirit.

At the implementation level, the parsing of -<number> is shared
across archivers, but ARCHIVER_HIGH_COMPRESSION_LEVELS bit is only
enabled in archive-tar, and not in archive-zip, which means that
archive-tar can take -10 and higher compression levels while
archive-zip would not, I think.  If we are to add a separate
desciption for -<number> to .tar.gz format, it would work well, as
we would not want to say it is limited to '-9' there.

As to --fast/--best, I am not sure how well it would work with
either.  Would "tar" take "tar zcf - --fast ." or "tar zc9f - ."?
