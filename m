Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187C92018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbcFXTBV (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:01:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbcFXTBU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:01:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D26742507A;
	Fri, 24 Jun 2016 15:01:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aJSURX6aq6Ya9frOBq657YlI1aI=; b=MiBd+Q
	8jzTkMrY9EeeiaOsfrJ7D6jvu/6Xx9V5OK8aQ7ShObSOY1dui2shr0pzBu5faHVE
	NgbEBPw7wCXPJEduz+48sN15lMyqFaAfgCa8TmcdzIF5IeCwsd3pXvhTECgAlIgR
	N0pspreGoU6USgPiuNA879TUAASrCDie5aarw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3LYi4DFtdQOg7wpcCQjUasbldebIH1J
	cGdj8sB+4DlWingOz/t1ucQ/IgU6kFSCDUF3BbSFvXYRrpWehc5+SEPCoOrhfsA3
	fNgwPPO+Bv1VQgoA1CR/JDt3c1mIuOs9QzfBLHtw/uCqFOonajMF7kRpfA3YlIhY
	ve6tR3cfJY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA53D25079;
	Fri, 24 Jun 2016 15:01:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F90325078;
	Fri, 24 Jun 2016 15:01:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 2/4] archive-tar: write extended headers for file sizes >= 8GB
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232104.GB3668@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 12:01:16 -0700
In-Reply-To: <20160623232104.GB3668@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 19:21:05 -0400")
Message-ID: <xmqqwplefm2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 085BF604-3A3E-11E6-BE70-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the size was 64GB or greater, then we actually overflowed
> digits into the mtime field, meaning our value was was

was was

> effectively right-shifted by those lost octal digits. And
> this patch is again a strict improvement over that.

> diff --git a/archive-tar.c b/archive-tar.c
> index cb99df2..274bdfa 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -137,6 +137,20 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
>  	strbuf_addch(sb, '\n');
>  }
>  
> +/*
> + * Like strbuf_append_ext_header, but for numeric values.
> + */
> +static void strbuf_append_ext_header_uint(struct strbuf *sb,
> +					  const char *keyword,
> +					  uintmax_t value)
> +{
> +	char buf[40]; /* big enough for 2^128 in decimal, plus NUL */
> +	int len;
> +
> +	len = xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
> +	strbuf_append_ext_header(sb, keyword, buf, len);
> +}
> +
>  static unsigned int ustar_header_chksum(const struct ustar_header *header)
>  {
>  	const unsigned char *p = (const unsigned char *)header;
> @@ -208,7 +222,7 @@ static int write_tar_entry(struct archiver_args *args,
>  	struct ustar_header header;
>  	struct strbuf ext_header = STRBUF_INIT;
>  	unsigned int old_mode = mode;
> -	unsigned long size;
> +	unsigned long size, size_in_header;
>  	void *buffer;
>  	int err = 0;
>  
> @@ -267,7 +281,13 @@ static int write_tar_entry(struct archiver_args *args,
>  			memcpy(header.linkname, buffer, size);
>  	}
>  
> -	prepare_header(args, &header, mode, size);
> +	size_in_header = size;
> +	if (S_ISREG(mode) && size > 077777777777UL) {

Want a symbolic constant with a comment that says why you have
eleven 7's?

> +		size_in_header = 0;
> +		strbuf_append_ext_header_uint(&ext_header, "size", size);
> +	}
> +
> +	prepare_header(args, &header, mode, size_in_header);

The change itself makes sense.

Thanks.
