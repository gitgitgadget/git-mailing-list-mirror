Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10CA5207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbcJCR31 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:29:27 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:34413 "EHLO
        1.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcJCR30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:29:26 -0400
X-Greylist: delayed 2566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2016 13:29:25 EDT
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id DF930FF972C
        for <git@vger.kernel.org>; Mon,  3 Oct 2016 19:09:51 +0200 (CEST)
Received: from [192.168.1.10] (89-166-15-32.bb.dnainternet.fi [89.166.15.32])
        (Authenticated sender: kevin@bracey.fi)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id 9E9044E00A3;
        Mon,  3 Oct 2016 19:09:50 +0200 (CEST)
Message-ID: <57F290DC.5080303@bracey.fi>
Date:   Mon, 03 Oct 2016 20:09:48 +0300
From:   Kevin Bracey <kevin@bracey.fi>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     GIT Mailing-list <git@vger.kernel.org>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/3] add QSORT
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de> <xmqqponmcp07.fsf@gitster.mtv.corp.google.com> <83398160-555f-adab-6b1e-3283c533b5ff@web.de>
In-Reply-To: <83398160-555f-adab-6b1e-3283c533b5ff@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10439062465299583197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelvddrvdehgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/2016 19:19, René Scharfe wrote:
>
> It's hard to imagine an implementation of qsort(3) that can't handle
> zero elements.  QSORT's safety feature is that it prevents the compiler
> from removing NULL checks for the array pointer.  E.g. the last two
> lines in the following example could be optimized away:
>
> 	qsort(ptr, n, sizeof(*ptr), fn);
> 	if (!ptr)
> 		do_stuff();
>
> You can see that on https://godbolt.org/g/JwS99b -- an awesome website
> for exploring compilation results for small snippets, by the way.
>
Ah, second attempt. Originally misread the original code, and didn't 
understand what it was doing.

I get it now.

A nasty trap I hadn't been aware of - I was under the impression NULL + 
zero length was generally legal, but the C standard does indeed not give 
you a specific out for NULL to library functions in that case.

As such, NULL checks can still be elided even with your change. If you 
effectively change your example to:

     if (nmemb > 1)
         qsort(array, nmemb, size, cmp);
     if (!array)
         printf("array is NULL\n");

array may only be checked for NULL if nmemb <= 1. You can see GCC doing 
that in the compiler explorer - it effectively turns that into "else 
if".  To make that check really work, you have to do:

     if (array)
         qsort(array, nmemb, size, cmp);
     else
         printf("array is NULL\n");

So maybe your "sane_qsort" should be checking array, not nmemb.

Kevin

