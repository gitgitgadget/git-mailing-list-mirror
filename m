Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E611F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfHOWSg (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:18:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52996 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfHOWSg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:18:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A3787B4E;
        Thu, 15 Aug 2019 18:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0Ybm8d1QdMw+
        aubPXcrF5Qf5tBw=; b=CyHn4ouLEfbMlDS4bxZ/t1Qbvf0LuQdQ4L7h5pq0Dwl7
        sKt1tNeyXU/wjIOqp+EfrA9nTbkDLwYcCeefu1CXn8d88jVpx/T9Uy6BVmWFr+UR
        75vk+R4Z+ZZkZe5DqzYrV/hpVHj/H3N7O3eSlRbEeG01iieSWbcmnrkl58XfPRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p93O57
        pZHs6BQiAQi7gOIRIPYj6Ie/WDujcqVr6+2MisfnO2MRolmHhKLuiFwMsWIb4uJS
        /UINCrfMR4+DQPn/DWI1E7hThr3luTIkM+8/JYu8bcST1R2siSvEJ/T7aTjVfGdS
        ZoSKGqg7Nngrmj5XuVJZiLOhgSWeEGc+CevCs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BC0F87B4D;
        Thu, 15 Aug 2019 18:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56AC487B4B;
        Thu, 15 Aug 2019 18:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, daniel@haxx.se,
        peff@peff.net
Subject: Re: [PATCH v3] http: use xmalloc with cURL
References: <xmqqo90q2pfw.fsf@gitster-ct.c.googlers.com>
        <20190815214429.28048-1-carenas@gmail.com>
Date:   Thu, 15 Aug 2019 15:18:29 -0700
In-Reply-To: <20190815214429.28048-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 15 Aug 2019 14:44:29 -0700")
Message-ID: <xmqqblwq2hu2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D2B09C4-BFAA-11E9-ACD2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

>  #if LIBCURL_VERSION_NUM < 0x070800
>  #define curl_global_init(a) do { /* nothing */ } while (0)
> +#elif LIBCURL_VERSION_NUM >=3D 0x070c00
> +#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
> +						xrealloc, xstrdup, xcalloc)
>  #endif

Yup.  That looks better.

If your curl version is recent enough (which presumably is true for
most people these days), the entire #if/#endif block is skipped
while scanning for #else or #elif and #elseif willq be silently
ignored; it is unfortunate that #elseif won't be flagged by CPP as a
potential error X-<.
