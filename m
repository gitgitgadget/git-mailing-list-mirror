Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3D7207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbdDSBrk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:47:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933191AbdDSBrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:47:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF1C6831CF;
        Tue, 18 Apr 2017 21:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qq/1uiPuUg/AZ5h1meDPvyuWhhE=; b=yfNcFf
        3qwzTNz2iHA6tZ1FJ3jek1sPaKZiDMnAWKP4aIlSxPlpAajJzwjcK/q/3VoxeBXq
        08SYloCZ7H0feGyHZmIfjDiHoQCuBgGn/JU6RZpaZ37XpCOunLQ6jFogHJpExeSv
        VryyPG9oOD8bZKWn0jBGhNh9vMK0f9o2KI3zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bYFnGTNaQdfTiLv7uVjG/7i5WQRDQZqR
        eK69d5ZxLTOtA/GghUfQeEw/JxiYw+jzCX2UUaXx5dg2LtC7ChharofX90Ni7cXQ
        VrIBH85efR5tFEZYXjSwk+CM6GrFjU1eazGu4Jp9GU1gf6NOlsuM7yzNVR/74iDy
        SDwFYTGkyOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A862D831CD;
        Tue, 18 Apr 2017 21:47:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D153831CC;
        Tue, 18 Apr 2017 21:47:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        jrnieder@gmail.com, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
References: <20170417161748.31231-1-dturner@twosigma.com>
        <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
        <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
        <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
        <20170418161734.pa665rqwdtbnsj7f@sigill.intra.peff.net>
Date:   Tue, 18 Apr 2017 18:47:34 -0700
In-Reply-To: <20170418161734.pa665rqwdtbnsj7f@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 18 Apr 2017 12:17:34 -0400")
Message-ID: <xmqqtw5lcgnd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29B84F74-24A2-11E7-A2AC-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I doubt that doing it in one call matters. It's not like stdio promises
> us any atomicity in the first place.
>
>> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
>> +			fscanf(fp, "%"SCNuMAX" ", &pid) == 1 &&
>> +			!strbuf_getwholeline(&locking_host, fp, '\0') &&
>
> I don't think there is anything wrong with using fscanf here, but it has
> enough pitfalls in general that I don't really like its use as a parser
> (and the general lack of it in Git's code base seems to agree).
>
> I wonder if this should just read a line (or the whole file) into a
> strbuf and parse it there. That would better match our usual style, I
> think.

Yeah, I think it would be a good change.
