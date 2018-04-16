Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBA01F404
	for <e@80x24.org>; Mon, 16 Apr 2018 05:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDPF44 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 01:56:56 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:29299 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751205AbeDPF44 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 01:56:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 40Pd1f0VrYz5tlH;
        Mon, 16 Apr 2018 07:56:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 772CD10B;
        Mon, 16 Apr 2018 07:56:53 +0200 (CEST)
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <xmqq7ep817bq.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <06c5bd54-f1b0-7fe5-6aa8-870e0ae4487d@kdbg.org>
Date:   Mon, 16 Apr 2018 07:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ep817bq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.2018 um 23:35 schrieb Junio C Hamano:
> Ah, do you mean we have an internal sequence like this, when "rebase
> --continue" wants to conclude an edit/reword?

Yes, it's only 'reword' that is affected, because then subsequent picks 
are processed by the original process.

>   - we figure out the committer ident, which grabs a timestamp and
>     cache it;
> 
>   - we spawn "commit" to conclude the stopped step, letting it record
>     its beginning time (which is a bit older than the above) or its
>     ending time (which is much older due to human typing speed);

Younger in both cases, of course. According to my tests, we seem to pick 
the beginning time, because the first 'reword'ed commit typically has 
the same timestamp as the preceding picks. Later 'reword'ed commits have 
noticably younger timestamps.

>   - subsequent "picks" are made in the same process, and share the
>     timestamp we grabbed in the first step, which is older than the
>     second one.
> 
> I guess we'd want a mechanism to tell ident.c layer "discard the
> cached one, as we are no longer in the same automated sequence", and
> use that whenever we spawn an editor (or otherwise go interactive).

Frankly, I think that this caching is overengineered (or prematurly 
optimized). If the design requires that different callers of datestamp() 
must see the same time, then the design is broken. In a fixed design, 
there would be a single call of datestamp() in advance, and then the 
timestamp, which then obviously is a very important piece of data, would 
be passed along as required.

-- Hannes
