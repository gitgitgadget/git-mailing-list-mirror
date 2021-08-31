Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C0C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9A460F12
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhHaSOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:14:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50419 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhHaSOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:14:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53A2915652B;
        Tue, 31 Aug 2021 14:13:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Us3bbT8puCulBXnuKeXUWpSLXSc7qqf3krv1v
        ZpvD4=; b=WQUpoyoUuvdYG7FapUDx2uWSLZ5i8OY7DzOwL2J8XVHRA3LAZGmlla
        u5zjQDSCHNt23Jso0uKV8hbMloA9OIwaHA8RO57nz/MQU1Mg5zHBYncQTDS9uLAK
        H880FV0qWpW6ilPz59Z+sXi8DWRBnY54QYhODkRmMw/Noy6HRgCRg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C7D115652A;
        Tue, 31 Aug 2021 14:13:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26C8D156529;
        Tue, 31 Aug 2021 14:13:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 1/2] pkt-line: add stdio packet write functions
References: <xmqqbl5ic19t.fsf@gitster.g>
        <20210831093444.28199-1-jacob@gitlab.com>
        <20210831093444.28199-2-jacob@gitlab.com>
Date:   Tue, 31 Aug 2021 11:13:45 -0700
In-Reply-To: <20210831093444.28199-2-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Tue, 31 Aug 2021 11:34:43 +0200")
Message-ID: <xmqqy28htrc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F47B37E-0A87-11EC-93E0-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> +/*
> + * Stdio versions of packet_write functions. When mixing these with fd
> + * based functions, take care to call fflush or packet_fflush before
> + * doing fd writes or closing the fd.
> + */

You may have wanted to say that fflush() is not needed immediately
after packet_fflush() (because the latter calls fflush()), but I
find the "or packet_fflush" in the above comment highly misleading.

It's not like you can randomly call packet_fflush() where you would
call fflush(), as the former will insert a FLUSH packet to the
output stream.  "... take care to call fflush(3) before doihng fd
writes or closing the fd" would be more appropriate.  After all, if
you make fflush() even after calling packet_fflush(), nothing will
break.

> +void packet_fwrite(FILE *f, const char *buf, size_t size);
> +void packet_fwrite_fmt(FILE *f, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +
> +/* packet_fflush writes a flush packet and flushes the stdio buffer of f */
> +void packet_fflush(FILE *f);
> +
>  /*
>   * Read a packetized line into the buffer, which must be at least size bytes
>   * long. The return value specifies the number of bytes read into the buffer.
> diff --git a/write-or-die.c b/write-or-die.c
> index d33e68f6ab..7a2f84e2ee 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -70,3 +70,15 @@ void write_or_die(int fd, const void *buf, size_t count)
>  		die_errno("write error");
>  	}
>  }
> +
> +void fwrite_or_die(FILE *f, const void *buf, size_t count)
> +{
> +	if (fwrite(buf, count, 1, f) != 1)

This counts the size of the buffer the wrong way.

fwrite() gives the size of each element to be written out first, and
then number of elements that are written, which is the same as
fread() but unfortunately the other way around from calloc() where
count comes first X-<.

Other than that, nicely done.

Thanks.

> +		die_errno("fwrite error");
> +}
> +
> +void fflush_or_die(FILE *f)
> +{
> +	if (fflush(f))
> +		die_errno("fflush error");
> +}
