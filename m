Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3CE2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdITFkg (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:40:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750859AbdITFkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDD8996874;
        Wed, 20 Sep 2017 01:40:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cwTjwzZ1PPbiTFtawn3zbp1R3hU=; b=nthy5l
        6fpTesCaEPnkcTwoDx8asM7BPQDLe5xMsPP8E5DlzmZH6q5e0O+ciK5RGbw7URPg
        N7Ga6Ns3ZzpQC+FWBT28I9/AW7qf9uwhHQHMHZ4CTw3qyHlZymqcOkK7er5RPmLB
        jCBtWOOWLA2nJPsdf50Sxf77rji3V5yU2vH10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfX5w80BTvfUunAYj1d3oxrCOGHE3mD0
        HmnZDM/0utbockBoPwDtWXGQTnkCucxbffV47yWQ8AxzJPQDz0CzYFp/Kl2/QAqo
        gow0PQnLPtTNq7fUfDTWVO1SVBO13Xk/0ZM5fD1j2BXAAHxMJc0Yy8XIha4/F1zw
        ZgYwZa99GM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5EF896873;
        Wed, 20 Sep 2017 01:40:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 314DE96871;
        Wed, 20 Sep 2017 01:40:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <20170920023008.GB126984@aiede.mtv.corp.google.com>
        <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
        <20170920052705.GC126984@aiede.mtv.corp.google.com>
Date:   Wed, 20 Sep 2017 14:40:32 +0900
In-Reply-To: <20170920052705.GC126984@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Sep 2017 22:27:05 -0700")
Message-ID: <xmqqbmm6nd0v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38EC5F06-9DC6-11E7-A797-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> D. Eliminate for_each_string_list_item and let callers just do
>
> 	unsigned int i;
> 	for (i = 0; i < list->nr; i++) {
> 		struct string_list_item *item = list->items[i];
> 		...
> 	}
>
>    Having to declare item is unnecessarily verbose, decreasing the
>    appeal of this option.  I think I like it anyway, but I wasn't able
>    to convince coccinelle to do it.

When using the macro, item still needs to be declared outside by the
user, so it's not all that unpleasant, though.

> E. Use subtraction instead of addition:
>    #define for_each_string_list_item(item, list) \
>    	for (item = ...; \
> 	     (item == list->items ? 0 : item - list->items) < nr; \
> 	     item++)
>
>    I expected the compiler to figure out that this is a long way of writing
>    (item - list->items), but at least with gcc 4.8.4 -O2, no such
>    luck.  This generates uglier assembly than the NULL check.

Yuck.  You cannot easily unsee such an ugliness X-<.

The patch and explanation above --- looked quite nicely written.
Will queue.

Thanks.

> diff --git a/string-list.h b/string-list.h
> index 29bfb7ae45..79ae567cbc 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -32,8 +32,10 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t, void *cb_data);
> -#define for_each_string_list_item(item,list) \
> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> +#define for_each_string_list_item(item,list)            \
> +	for (item = (list)->items;                      \
> +	     item && item < (list)->items + (list)->nr; \
> +	     ++item)
>  
>  /*
>   * Apply want to each item in list, retaining only the ones for which
