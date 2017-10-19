Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CC81FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdJSFcJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:32:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdJSFcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E61AE94D77;
        Thu, 19 Oct 2017 01:32:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PbiexYyag67+R/2ui5v8gYEr2jc=; b=WfXLBJ
        rhqPK36yfr2L/yojQqHvGeAtymtDm3Q/ixSp9D8xM29pic+crYSmIrzCQTfcSPS2
        vl09Ylz7f0q4UD3YejuWNtEaDOfBxFUb1sR3y4NJbeMmCG4UOGokdpN+ObrGn5vQ
        iSBOQsX4XhTqGZ47adcPmWA1E3cFmUjdIWAUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QEcAFiBV2UgQfqK4pEIGKmdKoYia76Uk
        kuMp84/6AfkIolECIUZyKqxgTuIynRkH6FRgemMo4JV78xKAxR44y8wsZ5f271i9
        uamjG/+NujTq6Z6Y1DSBVdUqWOpk0j9yQ4iwJalO+xMp5b7vrj5bip5210Sg84cd
        hRYO0a9TeC0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD96594D76;
        Thu, 19 Oct 2017 01:32:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 516D594D74;
        Thu, 19 Oct 2017 01:32:06 -0400 (EDT)
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
        <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 19 Oct 2017 14:32:04 +0900
In-Reply-To: <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 19 Oct 2017 14:30:08 +0900")
Message-ID: <xmqqvajbityj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D82FF99A-B48E-11E7-9922-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> it does. It just adjusts our "end pointer" to point to the last valid
>> character in the string (rather than one past), which seems to be the
>> convention that those loops (and next_byte) expect.
>
> Yeah I am not sure if I like this comparison at the beginning of the
> function:
>
>         static int next_byte(const char **cp, const char **endp,
>                              const struct diff_options *diffopt)
>         {
>                 int retval;
>
>                 if (*cp > *endp)
>                         return -1;
>
> but it says endp _is_ part of valid input, contrary to my intuition.
>
> And your change to the initialization of ae/be in moved_entry_cmp()
> makes it consistent with it, I think.
>
> But doesn't it mean ae computation in get_string_hash() also needs a
> massaging?

Ah, forget the last two lines.  You do do the massaging in your
patch.

My preference actually is to fix next_byte to follow the usual "when
we end, it points one past the valid region", though.

Thanks for digging it through.



