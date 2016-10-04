Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D5C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754498AbcJDVId (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:08:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62192 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754368AbcJDVIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:08:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BFC241AD9;
        Tue,  4 Oct 2016 17:08:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hr+WAaHbGZUwGPq3djLWa/VOeUA=; b=ZFdLB/
        sOrU2WuZSPOCm6IHQaDAGyoC4KiTDJ/d3bjCgd7TGlTHk5mIP8FawdVaAY+psyQC
        ELLBMKo15xqlY7tXaaeIuPNtDkmW4/sKyPt+QuqBpVV9PSFjnYDJ/V10eAFrPx+3
        6fvYylC086Z/ByKgWCJtoIxZ8gUGl1fjUv8SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g72ewnM/mIXGTqcv5sLULSXfOdjS5dF6
        VNI/eyc21IUN0Ve2+ym2U65xUHv11JGuKqqA0swmqMGnvMqm4rBRMKhjHWnCjBfe
        cLoYHq72xEvtY9rEyanJlO/Ry4VpwUZEvk3R5ZmmwTt/3jmDeVCKPuljP0tI28ST
        YeWPDMLrsKI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8471A41AD7;
        Tue,  4 Oct 2016 17:08:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13BF441AD6;
        Tue,  4 Oct 2016 17:08:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:08:27 -0700
In-Reply-To: <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:34:17 -0400")
Message-ID: <xmqqshsbstys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2BDB564-8A76-11E6-BF24-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +int strbuf_normalize_path(struct strbuf *src)
> +{
> +	struct strbuf dst = STRBUF_INIT;
> +
> +	strbuf_grow(&dst, src->len);
> +	if (normalize_path_copy(dst.buf, src->buf) < 0) {
> +		strbuf_release(&dst);
> +		return -1;
> +	}
> +
> +	/*
> +	 * normalize_path does not tell us the new length, so we have to
> +	 * compute it by looking for the new NUL it placed
> +	 */
> +	strbuf_setlen(&dst, strlen(dst.buf));
> +	strbuf_swap(src, &dst);
> +	strbuf_release(&dst);
> +	return 0;
> +}

Makes sense.

