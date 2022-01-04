Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4AFC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiADTdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:33:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62424 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiADTdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:33:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A37D3F93F4;
        Tue,  4 Jan 2022 14:33:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+DJ/g9v/STS7n52oVHHLC6nScJg2prgQWZr2Q
        keBt0=; b=VcYi4gLVnkN3sN3jFiS3/AQ/9m76fGxlafO3r3jwJf9ZFEADRcr6Lz
        AtC0i+miLzgoJoFzgG/O62YpPP0xOlbamxxAOw88bOnMF16Q8FkNOxURaciwAp14
        PXDp/9X7feFYHkEq3URhAghdj1pLnsLLna1HRF3wo/oPv5rdKmleo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 951F6F93F3;
        Tue,  4 Jan 2022 14:33:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6DF5F93F2;
        Tue,  4 Jan 2022 14:33:37 -0500 (EST)
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
        <20220104125534.wznwbkyxfcmyfqhb@fs>
Date:   Tue, 04 Jan 2022 11:33:36 -0800
In-Reply-To: <20220104125534.wznwbkyxfcmyfqhb@fs> (Fabian Stelzer's message of
        "Tue, 4 Jan 2022 13:55:34 +0100")
Message-ID: <xmqqo84rcn3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36D2AEA2-6D95-11EC-A989-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> I guess we need a bit more context for this patch to make sense:
>
> for (line = ssh_principals_out.buf; *line;
>      line = strchrnul(line + 1, '\n')) {
> 	while (*line == '\n')
> 		line++;
> 	if (!*line)
> 		break;
>
> 	trust_size = strcspn(line, "\n"); /* truncate at LF */
> 	if (trust_size && trust_size != strlen(line) &&
> 	    line[trust_size - 1] == '\r')
> 		trust_size--; /* the LF was part of CRLF at the end */
> 	principal = xmemdupz(line, trust_size);
>
> ssh_principals_out contains the result of the find-principals call
> which contains one found principal per line (normally LF, CRLF in some
> cygwin setup).

Ahh, OK.  Sorry for being ultra lazy for not visiting the actual
source but just responding after reading only somebody else's
comments.

So, the code skips over one or more LFs (but users of platforms that
use CRLF line termination are screwed here already) to find the
beginning of a non-empty line.  Then it wants to find the end of
that non-empty line (if there is still LF there in the buffer).
Since strcspn() may not find any LF (i.e. it is an incomplete line),
strlen(line) is used to see if we found a LF or if we hit the
terminating NUL.  If the line ended with CR, we do not want to strip
it.

OK, so I was completely missing the idea.  And I agree that it may
be a good idea to check how strcspn() returned to deal with an
incomplete line, although as you hint later in the message I am
responding to, checking line[trust_size] would be a more obvious
implementation.

In any case, I think the earlier part of the loop is more confusing,
and I think fixing that would naturally fix the trust_size
computation.  For example, wouldn't this easier to grok?

	const char *next;

	for (line = ssh_principals_out.buf;
	     *line;
	     line = next) {
		const char *end_of_text;

                /* Find the terminating LF */
               	next = end_of_text = strchrnul(line, '\n');

		/* Did we find a LF, and did we have CR before it? */
		if (*end_of_text &&
                    line < end_of_text &&
		    end_of_text[-1] == '\r')
			end_of_text--;

		/* Unless we hit NUL, skip over the LF we found */
		if (*next)
			next++;

		/* Not all lines are data.  Skip empty ones */
		if (line == end_of_text)
			/* 
                         * You may want to allow skipping more than just
			 * lines with 0-byte on them (e.g. comments?)
			 * depending on the format you are reading.
			 */
			continue;

		/* We now know we have an non-empty line. Process it */
		principal = xmemdupz(line, end_of_text - line);
		...
	}
		
The idea is to make sure that the place where the line ending
convention is taken care of is very isolated at the beginning of the
loop.

Hmm?
