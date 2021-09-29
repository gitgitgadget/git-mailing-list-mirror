Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3244DC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB46140F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbhI2PQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:16:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58886 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhI2PQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 11:16:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D377151887;
        Wed, 29 Sep 2021 11:14:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M/sPthQ0FEs1
        iuOS0gq4zgDEAb/Y3axZ2kZpuTCeoDg=; b=iXRHNBaDz2ju5eVpEan1/1ltMxuf
        nY2wvl17W/XZHbzmEjywSAWdySNmkgrEsTBmPLk+CHBft55F7g9M+pbxhKqPQPFM
        zW04cxl8W1JpP6+N+mLqkuURaADRUCVvVg5cBp+vQ4e6PDOfsnHA+VSsDAfxmovS
        oXf6dzK5nUjHDJY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C38151886;
        Wed, 29 Sep 2021 11:14:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E71A2151885;
        Wed, 29 Sep 2021 11:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] parse-options.c: use exhaustive "case" arms for
 "enum parse_opt_type"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-04.10-624a19000e1-20210928T130905Z-avarab@gmail.com>
        <xmqq5yukgrlm.fsf@gitster.g> <87tui3vk8y.fsf@evledraar.gmail.com>
Date:   Wed, 29 Sep 2021 08:14:21 -0700
In-Reply-To: <87tui3vk8y.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 29 Sep 2021 10:48:52 +0200")
Message-ID: <xmqq7dezfm7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED4A46AE-2137-11EC-BFF3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think listing the remaining enum arms is a small price to pay for
> having that all moved to compile-time.

I can sympathize with that point of view, since I used to think the
same way, but I am not yet convinced.  An example like this from
your postimage, which doubles the size of a switch statement with
empty case arms, demonstrates that it is not a "small" price.

Admittedly, the original switch statement is particularly bad,
though ;-)

 		switch (opts->type) {
 		case OPTION_STRING:
 		case OPTION_FILENAME:
 		case OPTION_INTEGER:
 		case OPTION_MAGNITUDE:
 		case OPTION_CALLBACK:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_COUNTUP:
 		case OPTION_SET_INT:
 			has_unset_form =3D 1;
 			break;
-		default:
+		/* special types */
+		case OPTION_END:
+		case OPTION_GROUP:
+		case OPTION_NUMBER:
+		case OPTION_ALIAS:
+		/* options with no arguments */
+		case OPTION_BITOP:
+		/* options with arguments (usually) */
+		case OPTION_LOWLEVEL_CALLBACK:
 			break;
 		}
