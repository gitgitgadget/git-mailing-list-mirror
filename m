Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777E81F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeJMQTp (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 12:19:45 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:26804 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeJMQTp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 12:19:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42XJBj4X4Mz5tlb;
        Sat, 13 Oct 2018 10:43:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 14D1B256;
        Sat, 13 Oct 2018 10:43:25 +0200 (CEST)
Subject: Re: [PATCH] zlib.c: use size_t for size
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Martin Koegler <martin.koegler@chello.at>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181013023845.GA15595@sigill.intra.peff.net>
 <20181013024624.GB15595@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2e7b2f4b-92c3-a583-5985-38090cc78c64@kdbg.org>
Date:   Sat, 13 Oct 2018 10:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181013024624.GB15595@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.18 um 04:46 schrieb Jeff King:
> But no, right before that we have this line:
> 
>            offset -= win->offset;
> 
> So offset is in fact no longer its original meaning of "offset into the
> packfile", but is now an offset of the specific request into the window
> we found.
> 
> So I think it's correct, but it sure confused me. I wonder if another
> variable might help, like:
> 
>    size_t offset_in_window;
>    ...
> 
>    /*
>     * We know this difference will fit in a size_t, because our mmap
>     * window by * definition can be no larger than a size_t.
>     */
>    offset_in_window = xsize_t(offset - win->offset);
>    if (left)
> 	*left = win->len - offset_in_window;
>    return win->base + offset_in_window;
> 
> I dunno. Maybe it is overkill.

Thank you for your analysis. No, I don't think that such a new variable 
would be overkill. It is important to make such knowledge of value 
magnitudes explicit precisely because it reduces confusion and helps 
reviewers of the code verify correctness.

-- Hannes
