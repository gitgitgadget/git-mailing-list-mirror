Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278A01F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeKMA45 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:56:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57852 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbeKMA44 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:56:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7DB51A198;
        Mon, 12 Nov 2018 10:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQhdYjqDpztDLgeXiyKIGZz956Q=; b=qaWCiz
        WNd0Ny4C6QKITaX+TSSI3Nog6ByveOwMcwSEe4rP0NZSu24zd4TgbwPgJxz4lpFM
        extaEzjXYTxqzopi6pssKEnLRYOl0KY71jSb4JKWV8iHsmNEGCJho2X/jTjjeAby
        sPl7GieulqkHI5LZydTitb0TZDerJCd0pM+GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eGCVnusasprA8D/LJfilmM6GjJ9Z68x9
        jMQDmJB8/hR1IiQOjTGxODKjaKlMX1r01TlonLuUPM5IsQ4HWAmWHXooiBXMxSUw
        /11a/SYEMZywo5aVwtbNj17lQB3qp7SQwSzdOlfHDNsN8ZnJVYKUrEi0CpdCAplj
        nxIpyeE7OCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A07CC1A197;
        Mon, 12 Nov 2018 10:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B08581A196;
        Mon, 12 Nov 2018 10:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
References: <20181112084031.11769-1-carenas@gmail.com>
        <20181112084031.11769-3-carenas@gmail.com>
        <xmqqftw61sa0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121554060.39@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Nov 2018 00:03:12 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811121554060.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Nov 2018 15:54:41 +0100 (STD)")
Message-ID: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 146DD26C-E68C-11E8-9B7E-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Given that the function returns the value obtained from
>> approxidate(), which is approxidate_careful() in disguise, time_t is
>> not as appropriate as timestamp_t, no?
>> 
>> IOW, what if time_t were narrower than timestamp_t?
>
> Riiiight. From the patch, I had assumed that the return type of
> `approxidate()` is `time_t`, but it is `timestamp_t`.

Yes, but if we dig a bit deeper, it turns out that the return value
of this function is used at only one place, to be compared with the
.st_mtime field.

So for this change to truly be consisent, not just the function
needs to return timestamp_t, but also its sole caller needs to check
if its return value exceeds the maximum span that is expressible
with the platform's time_t (and if so, treat the expiration to be
"infinity- never expire"), or something like that.
