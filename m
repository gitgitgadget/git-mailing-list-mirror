Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF131F667
	for <e@80x24.org>; Sun, 13 Aug 2017 18:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdHMS0A (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 14:26:00 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:21651 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750898AbdHMS0A (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Aug 2017 14:26:00 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgxaI-0005Yq-UA
        for git@vger.kernel.org; Sun, 13 Aug 2017 20:25:58 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id wiRs1v00k5BuuEg01iRtil; Sun, 13 Aug 2017 20:25:53 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 78A4D45D4512; Sun, 13 Aug 2017 20:25:52 +0200 (CEST)
Date:   Sun, 13 Aug 2017 20:25:52 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Martin Koegler <martin.koegler@chello.at>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 3/9] Convert unpack-objects to size_t
Message-ID: <20170813182552.GA31079@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <1502527643-21944-3-git-send-email-martin@mail.zuhause>
 <CAN0heSpViT-Nz8OO7Bww3Fbm=mzA6wvm0EfgfRjsz+cVfvu3Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpViT-Nz8OO7Bww3Fbm=mzA6wvm0EfgfRjsz+cVfvu3Yw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 04:07:50PM +0200, Martin Ågren wrote:
> On 12 August 2017 at 10:47, Martin Koegler <martin.koegler@chello.at> wrote:
> "size" is handed over to a "git_zstream" and goes through zlib.c,
> eventually ending up in zlib, which is outside Git's control, and which
> seems to work with "uLong"s. How do these kind of changes interact with
> zlib? For example, I wonder about this line further down in get_data:
> 
> if (stream.total_out == size && ret == Z_STREAM_END)
> 
> If total_out isn't converted, I guess this would never hit if "size" is
> too large. And if total_out /is/ converted, I guess we'd risk truncation

I posted a patch changing git_zstream.

> in zlib_pre_call in zlib.c. Maybe that might cause Git and zlib to have
> different ideas about how much data is available and/or should be
> processed. Maybe we could then hit things like this in git.c:
> 
> if (s->z.total_out != s->total_out + bytes_produced)
>         die("BUG: total_out mismatch");
> 
> I am not very familiar with zlib, so apologies if this is just noise...

You are right, if sizeof(size_t) != sizeof(unsigned long), there can be truncations.

Currently, an object size is read/passed as ulong including to the memory allocation functions.
(x)malloc & Co take a length - so the whole GIT code might assume a larger object size than the
memory allocation functions.
Migrating everything to size_t means, that we move the truncation locations to places, where values 
enter/leave GIT.

My patches are just a starting point to fix the size handling. They concentrate of fixing data types - 
not avoiding any possible overflow.  Merging them will already be a challenging task, because they 
touch many functions and will likely conflict with other changes (eg. moving functions).

Regards,
Martin

