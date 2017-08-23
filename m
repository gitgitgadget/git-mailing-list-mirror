Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC5720899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbdHWRY1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:24:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57632 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932271AbdHWRYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:24:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D846EA48E3;
        Wed, 23 Aug 2017 13:24:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n6RlCfbHhMMk
        qTaAYd3CrT0ddE8=; b=Oo+gARoRyv9XIMxeTznlLS+fXvbm/dNnCJzK2laU02Cq
        wlDDluPZEuOkG/eJbBLl9AsI9T17sbxamBLe8zf/s+2c4zfwJ8sSrewC9LDJN3Mn
        HSllJ+z4eePVTqWMTr8ucWoAYX/dqbrIQQETtqUB+wYMmCjceo2DO1flwLEN4y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FrWJ9G
        Tonbge9e/SNLA5R3fxPOOIIPlel4UlRnaxyNMOlhPBKqrDdX/295sWvbBcEemA+u
        iGGrq/Kw6FCpxXnvSZdTl+vwBH6+5EWHmdWT8QJ5ERMeHW4tUxCoEYmD/VFJGBI/
        iH9RVpuNbJMoCvFa8Iw3jtKhxQ0fHoJjj05VM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF0C4A48E2;
        Wed, 23 Aug 2017 13:24:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35EC1A48E0;
        Wed, 23 Aug 2017 13:24:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
References: <cover.1502780343.git.martin.agren@gmail.com>
        <cover.1503323390.git.martin.agren@gmail.com>
        <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
Date:   Wed, 23 Aug 2017 10:24:17 -0700
In-Reply-To: <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 21 Aug 2017 19:43:47
 +0200")
Message-ID: <xmqq378i19ku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4D53004-8827-11E7-B116-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> strbuf_setlen(., 0) writes '\0' to sb.buf[0], where buf is either
> allocated and unique to sb, or the global slopbuf. The slopbuf is meant
> to provide a guarantee that buf is not NULL and that a freshly
> initialized buffer contains the empty string, but it is not supposed to
> be written to. That strbuf_setlen writes to slopbuf has at least two
> implications:
>
> First, it's wrong in principle. Second, it might be hiding misuses whic=
h
> are just waiting to wreak havoc. Third, ThreadSanitizer detects a race
> when multiple threads write to slopbuf at roughly the same time, thus
> potentially making any more critical races harder to spot.

There are two hard things in computer science ;-).

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> v2: no "ifdef TSAN"; moved check from strbuf_reset into strbuf_setlen

Looks much better.  I have a mild objection to "suggested-by",
though.  It makes it sound as if this were my itch, but it is not.

All the credit for being motivate to fix the issue should go to you.
For what I did during the review of the previous one to lead to this
simpler version, if you want to document it, "helped-by" would be
more appropriate.

>  strbuf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index e705b94db..7496cb8ec 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *sb=
, size_t len)
>  	if (len > (sb->alloc ? sb->alloc - 1 : 0))
>  		die("BUG: strbuf_setlen() beyond buffer");
>  	sb->len =3D len;
> -	sb->buf[len] =3D '\0';
> +	if (sb->buf !=3D strbuf_slopbuf)
> +		sb->buf[len] =3D '\0';
> +	else
> +		assert(!strbuf_slopbuf[0]);
>  }
> =20
>  /**
