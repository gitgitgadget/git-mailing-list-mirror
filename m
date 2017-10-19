Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17751FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdJSFaN (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:30:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57265 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdJSFaM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:30:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77113B6E3A;
        Thu, 19 Oct 2017 01:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6UKcdiuI0PrPihAw6mWgxgQEnw=; b=S4uZRA
        QzYRgSSYJ8ZMwcfLcNvGBCRTXy+89ExlrA3+r0y2CQCGeQydaUlOCXysFPuCUsEu
        vv6g6Z2Cmrr61Ei/9U2r9QRfR33LUQsRSAjt8i/Aoqp/7Q3w0NPDV19aDS/WVMlQ
        sXPelKGUpI2Zde0k3LZTtmOEqAi0Za5fKhiZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XunOIfcRqmXgj5veuM16N2T4wb5LMFTg
        lSfKoJea+3JyUqY0M/IZy9lUq3AoTwJsuEBs0reNnfuMjQ5TT67jxOf4U8uE6Q5d
        UCY1LJssMgqSU5mb5JGBCFfN+j++7QMqZUiCnjDF/qd5vgggVpt4j0zPcCbyGAAR
        QO8Mmzz2s54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68897B6E39;
        Thu, 19 Oct 2017 01:30:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD136B6E35;
        Thu, 19 Oct 2017 01:30:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
        <20171012233322.31203-1-sbeller@google.com>
        <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
        <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
        <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
        <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
Date:   Thu, 19 Oct 2017 14:30:08 +0900
In-Reply-To: <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Oct 2017 01:24:57 -0400")
Message-ID: <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92C15318-B48E-11E7-A0B6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> it does. It just adjusts our "end pointer" to point to the last valid
> character in the string (rather than one past), which seems to be the
> convention that those loops (and next_byte) expect.

Yeah I am not sure if I like this comparison at the beginning of the
function:

        static int next_byte(const char **cp, const char **endp,
                             const struct diff_options *diffopt)
        {
                int retval;

                if (*cp > *endp)
                        return -1;

but it says endp _is_ part of valid input, contrary to my intuition.

And your change to the initialization of ae/be in moved_entry_cmp()
makes it consistent with it, I think.

But doesn't it mean ae computation in get_string_hash() also needs a
massaging?
