Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1591C433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbiAEUkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:40:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54925 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbiAEUkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:40:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64DBFFDB95;
        Wed,  5 Jan 2022 15:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7J8FKihKxIxCtZPAHKBoAV089wEw2BAXnaVorW
        SeT8M=; b=OZJlgayaTXGbLg0ybSwZFGH7Y9PzHYu9sRWvDbDwgOLAMNEWDX1bZZ
        CBTxR4OTuPSEgrlBfs5m4qdiFio2e8I/trm50xybQY5aqmSD879yMCGz09nGIaSi
        K9qryGXKYdLwMEYAMFklyWmZLDymGQbbcXFxPbs4tmaXGeJM82yI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 319B3FDB94;
        Wed,  5 Jan 2022 15:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6051FDB93;
        Wed,  5 Jan 2022 15:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
        <20220103095337.600536-1-fs@gigacodes.de>
        <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
        <xmqqee5oieb2.fsf@gitster.g>
        <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
        <xmqqmtkcguvm.fsf@gitster.g>
        <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
        <20220104125534.wznwbkyxfcmyfqhb@fs> <xmqqo84rcn3j.fsf@gitster.g>
        <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
        <20220105103611.upfmcrudw6n3ymx6@fs>
Date:   Wed, 05 Jan 2022 12:40:06 -0800
In-Reply-To: <20220105103611.upfmcrudw6n3ymx6@fs> (Fabian Stelzer's message of
        "Wed, 5 Jan 2022 11:36:11 +0100")
Message-ID: <xmqqsfu1hq6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABF4ED94-6E67-11EC-9A79-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> How about something like this:
>
> int string_find_line(char **line, size_t *len) {
> 	const char *eol = NULL;
>
> 	if (*len > 0) {
> 		*line = *line + *len;
> 		if (**line && **line == '\r')
> 			(*line)++;
> 		if (**line && **line == '\n')
> 			(*line)++;
> 	}
>
> 	if (!**line)
> 		return 0;
>
> 	eol = strchrnul(*line, '\n');
>
> 	/* Trim trailing CR from length */
> 	if (eol > *line && eol[-1] == '\r')
> 		eol--;
>
> 	*len = eol - *line;
> 	return 1;
> }

It is a confusing piece of "we handle one line at a time" helper.
It is not obvious what the loop invariants are.

It would be most natural to readers if *line points at the very
beginning of the buffer, i.e. the beginning of the first line,
and *len points at the very first character of that line, i.e. 0.

But then the first thing this function worries about is a case where
*len is not 0.  I obviously am biased, but sorry, I find what I gave
you 100 times simpler to understand.

>
> Its use would then simply be:
>
> char *line = strbuf.buf;
> size_t len = 0;
> while(string_find_line(&line,&len)) {
> 	if (!len)
> 		continue; /* Skip over empty lines */
> 	principal = xmemdupz(line, len);
> }
>
> Not sure about the name though.
> Maybe string_find_line() / _iterate_line / foreach_line ?
