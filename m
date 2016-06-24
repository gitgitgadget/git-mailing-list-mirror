Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD732018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcFXTHF (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:07:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbcFXTHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 15:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47C4325141;
	Fri, 24 Jun 2016 15:07:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4b1SAX4Of7lZ
	mcainkF6XVZEgh4=; b=yU58Jd5vRUVOFj4XVRS1Aeojq33ZQmoj99EipXxqy8t7
	PDD0XW7Q8jKsOIN2J490wZDHULecTmaihSge33/6yv9rf1Pq3yWMtcIRkp1kHRCa
	2bPoaiNht+pfAFhedkOrzFJZDKD+Pn1QR5lyzQYvr345vXGhOP8cNcrbCul3Kf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OGYc0V
	aTjF36DcriynwaopwpeOivGrD0NdPNEK7R6iIcGKJRV8oN0WgZlzTz4jrZ6Wvzss
	cstDRfT0avHyu4/wsCOl7s1yUq6WaK9tRNwNv10JVB6VHr1lc9+4G6YqUVdwjQOs
	PkiVwIWIAFi9yhS5tZV4x1Rf8MAmjP7ELe1Bs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 409E225140;
	Fri, 24 Jun 2016 15:07:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B535E2513F;
	Fri, 24 Jun 2016 15:07:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 3/4] archive-tar: write extended headers for far-future mtime
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232112.GC3668@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 12:06:59 -0700
In-Reply-To: <20160623232112.GC3668@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 19:21:13 -0400")
Message-ID: <xmqqshw2flt8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D503C7FE-3A3E-11E6-9EE8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's a slight bit of trickiness there. We may already be
> ...
> After writing the extended header, we munge the timestamp in
> the ustar headers to the maximum-allowable size. This is
> wrong, but it's the least-wrong thing we can provide to a
> tar implementation that doesn't understand pax headers (it's
> also what GNU tar does).

The above looks very sensible design, and its implementation is
surprisingly compact.  Very nicely done.

> Helped-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  archive-tar.c       | 16 +++++++++++++---
>  t/t5000-tar-tree.sh |  4 ++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 274bdfa..0bb164c 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -317,7 +317,18 @@ static int write_global_extended_header(struct archiver_args *args)
>  	unsigned int mode;
>  	int err = 0;
>  
> -	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
> +	if (sha1)
> +		strbuf_append_ext_header(&ext_header, "comment",
> +					 sha1_to_hex(sha1), 40);
> +	if (args->time > 077777777777UL) {
> +		strbuf_append_ext_header_uint(&ext_header, "mtime",
> +					      args->time);
> +		args->time = 077777777777UL;
> +	}
> +
> +	if (!ext_header.len)
> +		return 0;

Another symbolic constant to explain this, e.g. TAR_TIME_LIMIT, may
want to exist.

Thanks.


