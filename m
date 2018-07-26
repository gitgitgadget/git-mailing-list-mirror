Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5982D1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 08:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeGZJ2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 05:28:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:34855 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbeGZJ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 05:28:25 -0400
Received: from [192.168.1.181] (unknown [185.39.175.184])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41blFk0JQxz5tlT;
        Thu, 26 Jul 2018 10:12:41 +0200 (CEST)
Subject: Re: [PATCH v2] pack-objects: fix performance issues on packing large
 deltas
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <20180720153943.575-1-pclouds@gmail.com>
 <20180722080421.12887-1-pclouds@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c872c664-a078-853d-4ce9-631dfd110c94@kdbg.org>
Date:   Thu, 26 Jul 2018 10:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180722080421.12887-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.07.2018 um 10:04 schrieb Nguyễn Thái Ngọc Duy:
> +	if (size < pack->oe_delta_size_limit) {
> +		e->delta_size_ = size;
> +		e->delta_size_valid = 1;
> +	} else {
> +		packing_data_lock(pack);
> +		if (!pack->delta_size)
> +			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
> +		packing_data_unlock(pack);
> +
> +		pack->delta_size[e - pack->objects] = size;

My first thought was that this is wrong (falling prey to the same 
mistake as the double-checked locking pattern). But after thinking twice 
over it again, I think that this unprotected access of pack->delta_size 
is thread-safe.

Of course, I'm assuming that different threads never assign to the same 
array index.

> +		e->delta_size_valid = 0;
> +	}
>   }

-- Hannes
