Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F0F1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757005AbcIUUJn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:09:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756958AbcIUUJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:09:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92ADD3E669;
        Wed, 21 Sep 2016 16:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gTohXjkm+WoJmaHjf/uAU+yVag=; b=octd7M
        Ma7emR1QNDWMbKZuWTi61AtqmAoSqu1haK/+chkOZw9EjJT8hxz2ZCLvhMWUC4/7
        puaeHVDRYVyob/Kw8lHg5Ond0D3uUc3SEn/1+v11NqmkvZyzgSZ2ACBUce7Sj+uS
        Cna5MdopzPxLcn1RFrb69Y/lIr/gjU0/Z6e7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLv129ns2IbT5108ZguvPQh/g5O7wZqA
        eeI3gB+F1CEz1PfkxO+3n2SXP0pO/HmUHAynvAWJzw1cc8wHN2nYFON9bI409KDQ
        ev0jv6P+u0DRTAQjo4WatiBoxwJXICHhBVA+sh7GkmJKfMhkoxOXHQMmo1jT2+NY
        ZnTq34YQU1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1BC3E668;
        Wed, 21 Sep 2016 16:09:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 156883E667;
        Wed, 21 Sep 2016 16:09:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 3/3] regex: use regexec_buf()
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
        <cover.1474482164.git.johannes.schindelin@gmx.de>
        <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de>
        <xmqqmvj16p06.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Sep 2016 13:09:35 -0700
In-Reply-To: <xmqqmvj16p06.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Sep 2016 12:18:01 -0700")
Message-ID: <xmqqintp6mm8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52BC37F6-8037-11E6-B59C-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> The new regexec_buf() function operates on buffers with an explicitly
>> specified length, rather than NUL-terminated strings.
>>
>> We need to use this function whenever the buffer we want to pass to
>> regexec() may have been mmap()ed (and is hence not NUL-terminated).
>>
>> Note: the original motivation for this patch was to fix a bug where
>> `git diff -G <regex>` would crash. This patch converts more callers,
>> though, some of which explicitly allocated and constructed
>> NUL-terminated strings (or worse: modified read-only buffers to insert
>> NULs).

Also, I think there is nobody that modified read-only buffer.
diffgrep_consume() does say "Yuck -- line ought to be const",
but its "line" parameter is actually a non-const exactly for
this yuckiness (iow, it knew what it was doing).

Perhaps like so?

    regex: use regexec_buf()
    
    The new regexec_buf() function operates on buffers with an explicitly
    specified length, rather than NUL-terminated strings.
    
    We need to use this function whenever the buffer we want to pass to
    regexec(3) may have been mmap(2)ed (and is hence not NUL-terminated).
    
    Note: the original motivation for this patch was to fix a bug where
    `git diff -G <regex>` would crash. This patch converts more callers,
    though, some of which allocated to construct NUL-terminated strings,
    or worse, modified buffers to temporarily insert NULs while calling
    regexec(3).  By converting them to use regexec_buf() they have become
    much cleaner.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

The patch text looked good to me.

Thanks.
