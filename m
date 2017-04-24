Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92424207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164437AbdDXDQn (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:16:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53224 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164457AbdDXDQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:16:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00C078121E;
        Sun, 23 Apr 2017 23:16:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ICFch0+a3cUpK1qaJ1C9f68hqR0=; b=AmFuez
        N3EpSJGuYrDzeZNv0BDHKrUD1FXH7punOsARjsKeo+04XsTtjPa7gRBfiMuAvu3E
        1fh8denJgQKFkh6DbDS6RSUCkZ+hBYM/LBzySChFvTFxL2QH42nUpVcuWI2sz4fC
        qR3R68TpJrbi8pB//6fU/bRcsaruxFTrt223s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLMXjWVwBbHoLsL2puXO5drjgSsXiaAk
        ygrBE7325GYRwzhdMxuJz5omJGK+l0qehe8WYjtIbBGc75PowqwfjfE5VW55rKyj
        2YhsYrzp0ofhAvfeRyHy/SCeQOL8aUA3GJWYhzvrh6PVL7qLTS03v3UszGebOGDt
        JQAb43qw/pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC6618121D;
        Sun, 23 Apr 2017 23:16:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 480ED8121C;
        Sun, 23 Apr 2017 23:16:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 7/9] Abort if the system time cannot handle one of our timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
Date:   Sun, 23 Apr 2017 20:16:30 -0700
In-Reply-To: <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 21 Apr 2017 12:45:53 +0200
        (CEST)")
Message-ID: <xmqqr30i1omp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69CC8CBC-289C-11E7-AE9F-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We are about to switch to a new data type for time stamps that is
> definitely not smaller or equal, but larger or equal to time_t.
>
> So before using the system functions to process or format timestamps,
> let's make extra certain that they can handle what we feed them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  date.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/date.c b/date.c
> index 92ab31aa441..75f6335cd09 100644
> --- a/date.c
> +++ b/date.c
> @@ -46,7 +46,10 @@ static time_t gm_time_t(timestamp_t time, int tz)
>  	minutes = tz < 0 ? -tz : tz;
>  	minutes = (minutes / 100)*60 + (minutes % 100);
>  	minutes = tz < 0 ? -minutes : minutes;
> -	return time + minutes * 60;
> +
> +	if (date_overflows(time + minutes * 60))
> +		die("Timestamp too large for this system: %"PRItime, time);
> +	return (time_t)time + minutes * 60;
>  }

All the other calls to date_overflows() take a variable that holds
timestamp_t and presumably they are checking for integer wraparound
when the values are computed, but this one is not.  Perhaps we want
to make it a bit more careful here?  I wonder if something like this 
is a good approach:

    #define date_overflows(time) date_overflows_add(time, 0)

    int date_overflows_add(timestamp_t base, timestamp_t minutes)
    {
	timestamp_t t;
	if (unsigned_add_overflows(base, minutes))
	    return 1;
	t = base + minutes;
	if ((uintmax_t) t >= TIME_MAX)
            return 1;
	... what you have in date_overflows() ...
    }

