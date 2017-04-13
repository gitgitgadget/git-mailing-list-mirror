Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FD320970
	for <e@80x24.org>; Thu, 13 Apr 2017 06:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756095AbdDMG2c (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 02:28:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64077 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755882AbdDMG2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 02:28:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CB137E821;
        Thu, 13 Apr 2017 02:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x3EjV1D+m1o9Fq+o36F5VoDjYrU=; b=xziQ8y
        dO3rE5Lgqgv9TG8eJM/x8F0lHp2o+VihGSVoNW00mOM+WHj1i1YZBxm5F7jI/aBI
        hZ+jVAdi9yrCRBelCwVAGkd23irINEnFkBD2ob16brjcH5S0I37zFT2Chw2QtuV5
        NACySImaG+J53sr5t50KYOFv2kh9nG1W6MiEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LIKi2vz7bR/hTzcYSLnRWDjLqhsHy5F9
        HX7lArPcowfu95L60e1aRULPU0j7KCyJp4DDYwiD3Nhh4Z2ZW0xDqhHfX7TuDjGB
        Q/rXqlAKydZoNFM8icuxJ8KwbGcyaHQQn443J8NF2J+GjcLusz1bOfJ0plnv7ri/
        Ev24PoQSMJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 225B57E820;
        Thu, 13 Apr 2017 02:28:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 823D87E81F;
        Thu, 13 Apr 2017 02:28:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
        <20170405130424.13803-1-tgc@jupiterrise.com>
        <20170405130424.13803-8-tgc@jupiterrise.com>
        <20170406091857.hl4ndn52kj2z4ujh@sigill.intra.peff.net>
Date:   Wed, 12 Apr 2017 23:28:28 -0700
In-Reply-To: <20170406091857.hl4ndn52kj2z4ujh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 6 Apr 2017 05:18:57 -0400")
Message-ID: <xmqqbms0q0s3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68A949B6-2012-11E7-BE4A-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 05, 2017 at 03:04:24PM +0200, Tom G. Christensen wrote:
> ...
> These kinds of interleaved conditionals make me nervous that we'll get
> something wrong (especially without braces, it's not immediately clear
> that both sides are a single statement).
>
> I wonder if it would be more readable to do something like:
>
>   #if LIBCURL_VERSION_NUM < 0x070c00
>   static const char *curl_easy_strerror(CURL *curl)
>   {
> 	return "[error code unavailable; curl version too old]";
>   }
>   #endif
>
> Then callers don't have to individually deal with the ifdef. It does
> mean that the user sees that kind-of ugly message, but maybe that is a
> good thing. They know they need to upgrade curl to see more details.

Yup, thanks for a very good suggestion.
