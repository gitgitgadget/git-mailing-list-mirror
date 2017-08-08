Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA13020899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbdHHWnW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:43:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51698 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752461AbdHHWnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:43:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 772DCA11A2;
        Tue,  8 Aug 2017 18:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dtQs4ljA72PS
        h5xW4xS8UDwCgoI=; b=fjxLHjnA3LNWTbULU0psLlNdVyj3Oh9W8y2G2XbbFPHm
        7SPfwzyuVG01h9S/P+Z2UV8Knt0tH6avaf3fDS3nWzlW6KLzcAUiPWN20uQP4Jh2
        HgQL1ADRf/hDklgZYgGLxKQ+8xCNkVtbTCWu4etDdS9b8V+dW0ZPORJARe0oHG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hqorJB
        4232wx81OoKXwzKYd9V4SIj+ZbMXwqj74APM/hLbaCq02YD1ajK9HxilBtNxFJpH
        aM7WqDBbJstqp0WlCaW8d7INq6B+H5Qs2nMSXh5z12I4vi9fJH7w83pgBMic1piJ
        VF/L/zC5EEjvZj+gxucmxLM4UaOm7WdYK6siE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F7FFA11A1;
        Tue,  8 Aug 2017 18:43:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE78FA11A0;
        Tue,  8 Aug 2017 18:43:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches the first byte
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
Date:   Tue, 08 Aug 2017 15:43:13 -0700
In-Reply-To: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Aug 2017 00:07:30 +0200")
Message-ID: <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6F43AA8-7C8A-11E7-A76A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> find_pack_entry_one() uses the fan-out table of pack indexes to find ou=
t
> which entries match the first byte of the searched hash and does a
> binary search on this subset of the main index table.
>
> If there are no matching entries then lo and hi will have the same
> value.  The binary search still starts and compares the hash of the
> following entry (which has a non-matching first byte, so won't cause an=
y
> trouble), or whatever comes after the sorted list of entries.
>
> The probability of that stray comparison matching by mistake is low, bu=
t
> let's not take any chances and check when entering the binary search
> loop if we're actually done already.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sha1_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15f70..11ee69a99d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2799,7 +2799,7 @@ off_t find_pack_entry_one(const unsigned char *sh=
a1,
>  		return nth_packed_object_offset(p, pos);
>  	}
> =20
> -	do {
> +	while (lo < hi) {
>  		unsigned mi =3D (lo + hi) / 2;
>  		int cmp =3D hashcmp(index + mi * stride, sha1);
> =20
> @@ -2812,7 +2812,7 @@ off_t find_pack_entry_one(const unsigned char *sh=
a1,
>  			hi =3D mi;
>  		else
>  			lo =3D mi+1;
> -	} while (lo < hi);
> +	}
>  	return 0;
>  }

Interesting.  I see that we still have the conditional code to call
out to sha1-lookup.c::sha1_entry_pos().  Do we need a similar change
over there, I wonder?  Alternatively, as we have had the experimental
sha1-lookup.c::sha1_entry_pos() long enough without anybody using it,
perhaps we should write it off as a failed experiment and retire it?

