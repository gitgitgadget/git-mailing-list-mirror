Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613ABC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D34661262
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbhI2AWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:22:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhI2AWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:22:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 845AF14C4AB;
        Tue, 28 Sep 2021 20:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5i9DnNG/dv3d
        uCRiN+MCWX7lp2tLTXsCvtrM1NUH4/Q=; b=fT8FqaMJ5NHphkRwFZChfGyfKa7a
        mGEBHEVwsWhuezkwakiTEJpxsVhl/K1CvVQN+uTk9g1kFgGk1BKtErOIeGN3umSN
        Cc+apAAOzwHxrEPCgQYidgbjxLw/xjHw91kWH5RdOPw9ZZjlIfZZsJdFLM9a5laG
        ogml11qIRIq+tW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C7E014C4AA;
        Tue, 28 Sep 2021 20:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E38B714C4A8;
        Tue, 28 Sep 2021 20:20:22 -0400 (EDT)
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
Date:   Tue, 28 Sep 2021 17:20:21 -0700
In-Reply-To: <patch-04.10-624a19000e1-20210928T130905Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:14:25
        +0200")
Message-ID: <xmqq5yukgrlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0959731A-20BB-11EC-B575-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code in get_value(), parse_options_check() etc. to do away with
> the "default" case in favor of exhaustively checking the relevant
> fields.

I am not sure if this is a good idea in the bigger picture.

If we know that unlisted cases should not happen, having "default:
BUG()" without explicitly listing them is just as expressive as the
result of this patch with much shorter code.

When a new enum member is added without adding corresponding
processing of the new value, either way it will be caught as a
BUG().  Removing "default: BUG()" does allow you to catch such an
error at compilation time, and keeping it may prevent you from doing
so, but in practice, you'd be adding test coverage for the new case,
which means that, even if your compiler is not cooperating, your
test suite addition will hit "default: BUG();" in such a case.

So ...

> -	default:
> +	/* special types */
> +	case OPTION_END:
> +	case OPTION_GROUP:
> +	case OPTION_NUMBER:
> +	case OPTION_ALIAS:
>  		BUG("opt->type %d should not happen", opt->type);
>  	}
> +	return -1; /* gcc 10.2.1-6's -Werror=3Dreturn-type */
>  }
