Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BA11F404
	for <e@80x24.org>; Fri, 23 Mar 2018 16:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCWQBy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 12:01:54 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55117 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeCWQBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 12:01:53 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id zP8Yei5gcsD7bzP8ZeB4fi; Fri, 23 Mar 2018 16:01:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=atuuPTaa6FTDEbNp9bAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
 <20180323024609.GA12229@sigill.intra.peff.net>
 <20180323055027.GA30227@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4395a668-845e-a66f-2a14-f6a4474c3d4b@ramsayjones.plus.com>
Date:   Fri, 23 Mar 2018 16:01:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323055027.GA30227@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOOESyDNCAaFBpbohbKsMEUaek7sVnLyiUs6CxUpL3T0caO3arrrmpXg3lysUlPRVk3Mo64zXbFagflxkxfu0RzGeIiBnF0CoVu/yQg3GY7q5rj3dUYa
 qxR3Jxk/hjRrlzd++eIkBYB50Lb6uAm6RDoVSTK9nw6v+OQ3+CfzUndg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/03/18 05:50, Jeff King wrote:
> On Thu, Mar 22, 2018 at 10:46:09PM -0400, Jeff King wrote:
[snip]
> I was curious whether my hand-waving there was true. It turns out that
> it is: the radix sort has stayed about the same speed but the comparison
> sort has gotten even slower. Here are best-of-five timings for "git
> cat-file --batch-check='%(objectsize:disk)'", which does very little
> besides generate the rev-index:

Not that it matters, but I assume this was something like:

  $ time (echo HEAD | git cat-file --batch-check="%(objectsize:disk)")

... and I suspect it was on the linux.git repo, yes?

I used to have a copy of the linux repo on disk, but I had to
delete it a while ago to recover some disk space (no matter how
big disks get, they never seem big enough)!

If I do this on my biggest repo (ffmpeg), I get:

  $ cd ../ffmpeg/

  $ time (echo HEAD | git cat-file --batch-check="%(objectsize:disk)")
  227

  real	0m0.037s
  user	0m0.020s
  sys	0m0.004s

  $ time (echo HEAD | ../git/git-cat-file --batch-check="%(objectsize:disk)")
  227

  real	0m0.146s
  user	0m0.112s
  sys	0m0.012s

  $ 

Where I'm using a version with my patch applied, rather than
reverting commit 8b8dfd5132. A 395% slowdown is bad enough, but
not as bad as a factor of 11! I bet you have a much more modern
system (with a fast SSD) than my old laptop. :-D

>   [current master, using radix sort]
>   real	0m0.104s
>   user	0m0.088s
>   sys	0m0.016s
> 
>   [reverting 8b8dfd5132, going back to qsort]
>   real	0m1.193s
>   user	0m1.176s
>   sys	0m0.016s
> 
> So it's now a factor of 11. Yikes.

Thanks for looking into this, even if it was a wild
goose chase. :)

ATB,
Ramsay Jones

