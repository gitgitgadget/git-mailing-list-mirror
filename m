Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873FD20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbcJJUTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:19:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63644 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751154AbcJJUTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:19:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2444681B;
        Mon, 10 Oct 2016 16:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lSDnryQNWLscrUbw6bGhLHsJjDg=; b=MXL7HN
        OP2OLeHUVuacQg5GguSXIUp3GvEtmvlEQ1vHYT2KNN1qKXgHKzahUvzh6mHZ0JYu
        u8RkuPrzbOW/seSm0YMmSpTQbstEHvxOuh0GZdDUshxhodY914lvCqlBvu+B3kmv
        Hh467JModRZeF1MfTSoF9+vDDoAhAZq0wcUwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QHAfTKiOXWy/6iTVS3N0BnD37+CibvF3
        7sIWKa5J/PWmc4Sc9HjmuYz1qZcUwmlbAGcsLp2r18X4EMYKf/3l12C2aX8hBMj6
        8VNfnJ7rUHOPMkNHEt8MkiAqu0vs3akvB53pz5vKgwaDPBF72YkTVAaiLeCANE08
        IeQ2suJJ068=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81DEC4681A;
        Mon, 10 Oct 2016 16:19:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F22E646819;
        Mon, 10 Oct 2016 16:19:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] convert.c: stream and early out
References: <20161009095654.1964-1-tboegi@web.de>
Date:   Mon, 10 Oct 2016 13:19:12 -0700
In-Reply-To: <20161009095654.1964-1-tboegi@web.de> (tboegi@web.de's message of
        "Sun, 9 Oct 2016 11:56:54 +0200")
Message-ID: <xmqqd1j8dkjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D072063C-8F26-11E6-B2EB-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> -static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
> +static void gather_stats_partly(const char *buf, unsigned long len,
> +				struct text_stat *stats, unsigned earlyout)
>  {

I think it is OK not to rename the function (you'd be passing earlyout=0
for callers that want exact stat, right?).

>  	unsigned long i;
>  
> -	memset(stats, 0, sizeof(*stats));
> -
> -	for (i = 0; i < size; i++) {
> +	if (!buf || !len)
> +		return;
> +	for (i = 0; i < len; i++) {
>  		unsigned char c = buf[i];
>  		if (c == '\r') {
> -			if (i+1 < size && buf[i+1] == '\n') {
> +			stats->stat_bits |= CONVERT_STAT_BITS_ANY_CR;
> +			if (i+1 < len && buf[i+1] == '\n') {
>  				stats->crlf++;
>  				i++;
> -			} else
> +				stats->stat_bits |= CONVERT_STAT_BITS_TXT_CRLF;
> +			} else {
>  				stats->lonecr++;
> +				stats->stat_bits |= CONVERT_STAT_BITS_BIN;
> +			}
>  			continue;
>  		}
>  		if (c == '\n') {
>  			stats->lonelf++;
> +			stats->stat_bits |= CONVERT_STAT_BITS_TXT_LF;
>  			continue;
>  		}
>  		if (c == 127)
> @@ -67,7 +74,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
>  				stats->printable++;
>  				break;
>  			case 0:
> -				stats->nul++;
> +				stats->stat_bits |= CONVERT_STAT_BITS_BIN;
>  				/* fall through */
>  			default:
>  				stats->nonprintable++;


So depending on the distribution of the bytes in the file, the
bitfields in stats->stat_bits will be filled one bit at a time in
random order.

> @@ -75,10 +82,12 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
>  		}
>  		else
>  			stats->printable++;
> +		if (stats->stat_bits & earlyout)
> +			break; /* We found what we have been searching for */

But an "earlyout" says that if "any" of the earlyout bit is seen, we
can return.

It somehow felt a bit too limited to me in my initial reading, but I
guess I shouldn't be surprised to see that such a limited interface
is sufficient for a file-local helper function ;-).  

The only caller that the semantics of this exit condition matters is
the one that wants to know "do we have NUL or CR anywhere?", so I
guess this should be sufficient.

>  	}
>  
>  	/* If file ends with EOF then don't count this EOF as non-printable. */
> -	if (size >= 1 && buf[size-1] == '\032')
> +	if (len >= 1 && buf[len-1] == '\032')
>  		stats->nonprintable--;

This noise is somewhat irritating.  Was there a reason why size was
a bad name for the variable?

> +static const char *convert_stats_ascii(unsigned convert_stats)
>  {
> -	unsigned int convert_stats = gather_convert_stats(data, size);
> -
> +	const unsigned mask = CONVERT_STAT_BITS_TXT_LF |
> +		CONVERT_STAT_BITS_TXT_CRLF;
>  	if (convert_stats & CONVERT_STAT_BITS_BIN)
>  		return "-text";
> -	switch (convert_stats) {
> +	switch (convert_stats & mask) {
>  	case CONVERT_STAT_BITS_TXT_LF:
>  		return "lf";
>  	case CONVERT_STAT_BITS_TXT_CRLF:

Subtle.  The caller runs the stat colllection with early-out set to
BITS_BIN, so that this can set "-text" early.  It knows that without
BITS_BIN, the stat was taken for the whole contents and the check lf
or crlf can be reliable.

I wonder if we can/need to do something to remove this subtleness
out of this callchain, which could be a source of confusion.

> @@ -132,24 +162,45 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
>  	}
>  }
>  
> +static unsigned get_convert_stats_wt(const char *path)
> +{
> +	struct text_stat stats;
> +	unsigned earlyout = CONVERT_STAT_BITS_BIN;
> +	int fd;
> +	memset(&stats, 0, sizeof(stats));
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return 0;
> +	for (;;) {
> +		char buf[2*1024];

Where is this 2kB come from?  Out of thin air?

