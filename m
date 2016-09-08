Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2102C1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbcIHVHv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:07:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58606 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753524AbcIHVHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:07:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 196E83BBC3;
        Thu,  8 Sep 2016 17:07:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6SRgGeJLGKvDWy4M1CB5vktec8c=; b=efxLSr
        Didd9cFjo5XGPQ5Ybr4OsUK3HEii8nm2dgwmklcY7ZMz96J0VRFm5Oa8Abcn/pus
        kJClwCqpLetaKfesj0+DrhAlEG7AxKYSiZA/zJQXwCwqfz+cO+3nxEhDCqv3Kffh
        GYuVfNkVB5zVEi7glBSXO4kYGBATsc8gwi+L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VejrZ8CAdWYp3azHZsOvbVqU/DPJg0JO
        lkbhmOGCASi2MLI6/N0qso5u7jvVNnP/DMwxL6wdv/mCS9c5kRUhLfO4JcAauZ5I
        ircDUW9O7nnhMa9Z6gS/9cQxMGtRmBMsTlgvhLjpBSkT94VSDBXjRNc196Y8YZgx
        aznO/MmF2w4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 113C73BBC1;
        Thu,  8 Sep 2016 17:07:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 878E83BBBF;
        Thu,  8 Sep 2016 17:07:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: remove dead code
References: <20160907233648.5162-1-sbeller@google.com>
        <20160907233648.5162-6-sbeller@google.com>
Date:   Thu, 08 Sep 2016 14:07:45 -0700
In-Reply-To: <20160907233648.5162-6-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Sep 2016 16:36:48 -0700")
Message-ID: <xmqqlgz2f6ce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BD8DA5E-7608-11E6-92EF-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When `len < 1`, len has to be 0 or negative, emit_line will then remove the
> first character and by then `len` would be negative. As this doesn't
> happen, it is safe to assume it is dead code.
>
> This continues to simplify the code, which was started in b8d9c1a66b
> (2009-09-03,  diff.c: the builtin_diff() deals with only two-file
> comparison).

We look at line[0] to see if it is '@' before this check, which
would have been wrong if "len < 1" were ever true.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 79ad91d..c143019 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1251,14 +1251,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		return;
>  	}
>  
> -	if (len < 1) {
> -		emit_line(o, reset, reset, line, len);
> -		if (ecbdata->diff_words
> -		    && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
> -			fputs("~\n", o->file);
> -		return;
> -	}
> -
>  	if (ecbdata->diff_words) {
>  		if (line[0] == '-') {
>  			diff_words_append(line, len,
