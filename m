Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F25020A26
	for <e@80x24.org>; Sun, 17 Sep 2017 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdIQA7b (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 20:59:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751198AbdIQA7b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 20:59:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88EB198321;
        Sat, 16 Sep 2017 20:59:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3T0q6Qf2khsBqo2+W/jAuRr8Xu8=; b=ElnuZb
        ZFAKG0Z4cmz1t4LqgA2bSzA8fZ2dhsvLBOl1WbfVUkGdbpyow8w55cKvu8fvBFQE
        b7isN73NFHZRnmJFmQnQ9cB46iK5A2yYBKCuPlXbKpzeLr2v4SKkpbuKGsBx6JW5
        vV7gJYp2BctFFqRwteYkAl0/KzTyT8AzvwIQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fXq7iXxJB5wxG4qqGMf8kS1OtRWNNvBy
        g21CRUoIlzJFSaeb7h/leRpy4hOIs+TW//79zhm+3LkRACgtMasIfMQ6uraHIwLU
        u5LaaYKKInsVdmN6qYnrghNP2NiAVcxdUNuYvkVe+mAli9xboAnq+YQ7viDwjTGZ
        krFVq+tVELA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F35598320;
        Sat, 16 Sep 2017 20:59:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB9FA9831F;
        Sat, 16 Sep 2017 20:59:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
Date:   Sun, 17 Sep 2017 09:59:28 +0900
In-Reply-To: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Fri, 15 Sep 2017 18:00:38 +0200")
Message-ID: <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75C6C89C-9B43-11E7-8B9E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If you pass a newly-initialized or newly-cleared `string_list` to
> `for_each_string_list_item()`, then the latter does
>
>     for (
>             item = (list)->items; /* note, this is NULL */
>             item < (list)->items + (list)->nr; /* note: NULL + 0 */
>             ++item)
>
> Even though this probably works almost everywhere, it is undefined
> behavior, and it could plausibly cause highly-optimizing compilers to
> misbehave.
> ...
> It would be a pain to have to change the signature of this macro, and
> we'd prefer not to add overhead to each iteration of the loop. So
> instead, whenever `list->items` is NULL, initialize `item` to point at
> a dummy `string_list_item` created for the purpose.
> ...
> -#define for_each_string_list_item(item,list) \
> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> +extern struct string_list_item dummy_string_list_item;
> +#define for_each_string_list_item(item,list)                                 \
> +	for (item = (list)->items ? (list)->items : &dummy_string_list_item; \
> +	     item < (list)->items + (list)->nr;                              \
> +	     ++item)

Sorry, but I am confused.

So when (list)->items is NULL, the loop termination condition that
used to be

	NULL < NULL + 0

that was problematic because NULL + 0 is problematic now becomes

	&dummy < NULL + 0

in the new code?  What made NULL + 0 not problematic now?
