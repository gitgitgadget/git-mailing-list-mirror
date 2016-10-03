Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265F6207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 18:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbcJCSEU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 14:04:20 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:50875 "EHLO
        3.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcJCSES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 14:04:18 -0400
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2016 14:04:18 EDT
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7CBF6FF9E1F
        for <git@vger.kernel.org>; Mon,  3 Oct 2016 18:46:37 +0200 (CEST)
Received: from [192.168.1.10] (89-166-15-32.bb.dnainternet.fi [89.166.15.32])
        (Authenticated sender: kevin@bracey.fi)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id 301F44E006C
        for <git@vger.kernel.org>; Mon,  3 Oct 2016 18:46:37 +0200 (CEST)
Message-ID: <57F28B6B.1010204@bracey.fi>
Date:   Mon, 03 Oct 2016 19:46:35 +0300
From:   Kevin Bracey <kevin@bracey.fi>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] add QSORT
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de> <xmqqponmcp07.fsf@gitster.mtv.corp.google.com> <83398160-555f-adab-6b1e-3283c533b5ff@web.de>
In-Reply-To: <83398160-555f-adab-6b1e-3283c533b5ff@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10046686344681853149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelvddrvdehgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/2016 19:19, René Scharfe wrote:
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
> This optimization is dangerous when combined with the convention of
> using a NULL pointer for empty arrays.  Diagnosing an affected NULL
> check is probably quite hard -- it's right there in the code after all
> and not all compilers remove it.

Hang on, hang on. This is either a compiler bug, or you're wrong on your 
assumption about the specification of qsort.

Either way, the extra layer of indirection is not proper protection. The 
unwanted compiler optimisation you're inadvertently triggering could 
still be triggered through the inline.

Now, looking at the C standard, this isn't actually clear to me. The 
standard says that if you call qsort with nmemb zero, the pointer still 
has to be "valid". Not totally clear to me if NULL is valid, by their 
definition in C99 7.1.4. Googling hasn't given me a concrete answer.

The compiler seems to think that NULL wouldn't be valid, so because 
you've called qsort on it, you've invoked undefined behaviour if it's 
NULL, so it's free to elide the NULL check.

Kevin

