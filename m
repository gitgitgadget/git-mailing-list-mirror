Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777251F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbcJEQQ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:16:27 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:52689 "EHLO
        3.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbcJEQQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:16:25 -0400
X-Greylist: delayed 169026 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2016 12:16:25 EDT
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0D9671D40B
        for <git@vger.kernel.org>; Wed,  5 Oct 2016 17:00:13 +0200 (CEST)
Received: from [192.168.1.10] (89-166-15-32.bb.dnainternet.fi [89.166.15.32])
        (Authenticated sender: kevin@bracey.fi)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 89F09840079;
        Wed,  5 Oct 2016 17:00:12 +0200 (CEST)
Message-ID: <57F51577.10709@bracey.fi>
Date:   Wed, 05 Oct 2016 18:00:07 +0300
From:   Kevin Bracey <kevin@bracey.fi>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
CC:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] add QSORT
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de> <xmqqponmcp07.fsf@gitster.mtv.corp.google.com> <83398160-555f-adab-6b1e-3283c533b5ff@web.de> <57F290DC.5080303@bracey.fi> <9ff725eb-3536-638b-1ec0-ff9130478abc@web.de> <57F33E12.4020900@bracey.fi> <29d3dde0-c527-3ab8-914c-6fbdc5e81e1c@web.de>
In-Reply-To: <29d3dde0-c527-3ab8-914c-6fbdc5e81e1c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1548393847937470690
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelvddrfedtgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/2016 23:31, René Scharfe wrote:

>
> So let's summarize; here's the effect of a raw qsort(3) call:
>
> array == NULL  nmemb  bug  QSORT  following NULL check
> -------------  -----  ---  -----  --------------------
>             0      0  no   qsort  is skipped
>             0     >0  no   qsort  is skipped
>             1      0  no   qsort  is skipped (bad!) ******
>             1     >0  yes  qsort  is skipped ******
>
Right - row 3 may not be a bug from the point of view of your internals, 
but it means you violate the API of qsort.Therefore a fix is required.

> With the micro-optimization removed (nmemb > 0) the matrix gets simpler:
>
> array == NULL  nmemb  bug  QSORT  following NULL check
> -------------  -----  ---  -----  --------------------
>             0      0  no   noop   is executed
>             0     >0  no   qsort  is skipped
>             1      0  no   noop   is executed
>             1     >0  yes  qsort  is skipped ******
>
> And with your NULL check (array != NULL) we'd get:
>
> array == NULL  nmemb  bug  QSORT  following NULL check
> -------------  -----  ---  -----  --------------------
>             0      0  no   qsort  reuses check result
>             0     >0  no   qsort  reuses check result
>             1      0  no   noop   reuses check result
>             1     >0  yes  noop   reuses check result
>
> Did I get it right?  AFAICS all variants (except raw qsort) are safe 
> -- no useful NULL checks are removed, and buggy code should be noticed 
> by segfaults in code accessing the sorted array.
I think your tables are correct.

But I disagree that you could ever call invoking the "****" lines safe. 
Unless you have documentation on what limit GCC (and your other 
compilers) are prepared to put on the undefined behaviour of violating 
that "non-null" constraint.

Up to now dereferencing a null pointer has been implicitly (or 
explicitly?) defined as simply generating SIGSEGV. And that has 
naturally extended into NULL passed to library implementations. But 
that's no longer true - it seems bets are somewhat off.

But, as long as you are confident you never invoke that line without a 
program bug - ie an API precondition of your own QSORT is that NULL is 
legal iff nmemb is zero, then I guess it's fine. Behaviour is defined, 
as long as you don't violate your internal preconditions.

Kevin


