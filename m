Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809B01F4C1
	for <e@80x24.org>; Sat, 12 Oct 2019 01:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfJLB50 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:57:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60841 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfJLB50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:57:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 811DBA120C;
        Fri, 11 Oct 2019 21:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PTVM6jhjQYUMViKaXvt+fi5sS+g=; b=VrYA2q
        i9bzKwIWDXAKhnt0BM5s77uQzUTo9PHUBMl62ZANmYIod/Zr5zJCLZuQEhP9kkxA
        1rOhEs0JiJjzmH4aV3k3E/1ZDy4Zli4PVUlX9x5mEw52YEdY2VLUvo+LwmxYu/8R
        f/alpDeTAdSbHk2fL8aHk9ajHQ0Ku+nJf9y6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IPpwgWE3mlpAvEFVFS/Ueezneerf51/Y
        ePGI2WY4MbNY+QRKLWU+kusyPCeuWsECvojTuplb3PjAt5LMlhjjr4vzQ+Z8sd8R
        MwwFno9ewAaGkqdxvP+SnJKfHVJZgUPHqZiLkhJDmMe6toIvZ7n+XHuzf0JnJSnV
        a9bljoGG3LI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 781BDA120B;
        Fri, 11 Oct 2019 21:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BB8BA120A;
        Fri, 11 Oct 2019 21:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: use ARRAY_SIZE() in git_wcwidth()
References: <20191011182448.11420-1-dev+git@drbeat.li>
        <20191011184123.17376-1-dev+git@drbeat.li>
Date:   Sat, 12 Oct 2019 10:57:18 +0900
In-Reply-To: <20191011184123.17376-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Fri, 11 Oct 2019 20:41:23 +0200")
Message-ID: <xmqqo8ymenep.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A02E5FDE-EC93-11E9-823D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> diff --git a/utf8.c b/utf8.c
> index 3b42fadffd..5c8f151f75 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -95,13 +95,11 @@ static int git_wcwidth(ucs_char_t ch)
>  		return -1;
>  
>  	/* binary search in table of non-spacing characters */
> -	if (bisearch(ch, zero_width, sizeof(zero_width)
> -				/ sizeof(struct interval) - 1))
> +	if (bisearch(ch, zero_width, ARRAY_SIZE(zero_width) - 1))

I wondered if we want a wrapper similar to QSORT() macro so that we
do not have to repeat zero_width (and double_width below) like this,
but bisearch() itself is local to this file and there are only these
two callers, so it probably is not worth it.

The original is waiting for a bug when zero_width changes its type,
by not dividing with sizeof(*zero_width).  The use of ARRAY_SIZE()
is quite appropriate here.

Thanks.

>  		return 0;
>  
>  	/* binary search in table of double width characters */
> -	if (bisearch(ch, double_width, sizeof(double_width)
> -				/ sizeof(struct interval) - 1))
> +	if (bisearch(ch, double_width, ARRAY_SIZE(double_width) - 1))
>  		return 2;
>  
>  	return 1;
