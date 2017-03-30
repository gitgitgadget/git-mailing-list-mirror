Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5072420966
	for <e@80x24.org>; Thu, 30 Mar 2017 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbdC3NT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 09:19:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:52197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933490AbdC3NTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 09:19:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lcjgd-1cSWYv1e8V-00k5oa; Thu, 30
 Mar 2017 15:19:46 +0200
Date:   Thu, 30 Mar 2017 15:19:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] difftool: avoid strcpy
In-Reply-To: <20170330103550.vpjrurqho4oz3caa@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703301517260.4068@virtualbox>
References: <20170330103550.vpjrurqho4oz3caa@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Eq1jSIJtcLRXuQoSBAZ0Vs600vlU/FusOdz4Jwb+LbA0+WpUdXn
 LNWeaz+QJg6ujxnp3uE3Z/ATkp5p/7/7Js9b5LQWK7XLLpC5vxHQnbSCKd7+9QqTJvn94/q
 ao7eM8jtcnDY16cARZfN5eHYXDdnCS2i9eWFcKQoSa1tmm8qp/pGbVwTdX5yLG/n1yCGASr
 lsH4Lc1lBCCFOPlsUfLNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JMTfHrt9LuA=:cwntROBOjLrZeLqduXp+cb
 0Qk+1hsTYBlsHJc88mff4/S2vVVC3O9MN5jBZ7iD8g2HwK1UHvx5SlunX6Ci6iFMHXCn+4iIi
 cLVOYEyfvaOk6jSUqzVP7NuB0q1lWmCUalue0pb6XXE/MCLvJa0nQgWDYfZXBb/8Ii+8hYSlt
 mLQIm8WCmEX48MN8Xb2ZQ9dPXyr0bMF/c5RPTURMAryZARsGSS543xIOfJRPn2SAHhXRJK9HY
 MVze0SD6I8IaN3pD1PLKIupt8m8t47wX0qDyFRTVXds7kAmaChDoVSzfFQDRwCAC+7YOpZqsU
 Fl95ZRFCy71WqAf1CTmS+4Nwz4lPTkmrrrer9/O/ULw+ln7GGZ21DP4vcGY7n5PosI5Zr7gTY
 ur6/mOYgyBE3r6TB3IUSM47J7XyQVgtiL8BEG84WryHYMX3pFfgZJ24ior6+OGnyqYOVLw3xx
 MwRnAI1EOcgGy4vOelqILXAYR5MbYlI0h6vm5oPccVShZPJv8wAEq7AS5IpGAvYP5G61GHKhk
 DYRCd9WkX6auaE3z2CfcLFsgx4BHayahqMp4hVt+zOLz/wGPb3PYSwwUgv+DnmYsmO9UeL5db
 ccCj/1m777vmqWcqg+syzT0dqntCI7okFeUOGklkEovMDMWSTn+wACY7CDzCLlze4+0wByLIY
 yZKvpknwzn8qBJr9PS/bdTufQDfK/oI9pjhMwYOIgJT5c7c5DvNKqktUGAJR6FrND5SEy9eS4
 qBpEtlGRnjZhzqrcit99XzB6Ic2228rktx6ex+LOAvp/QHWFKAc2Ktlwv0DGnQX4XlWL0+h23
 cylAWox
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 30 Mar 2017, Jeff King wrote:

> In order to checkout files, difftool reads "diff --raw"
> output and feeds the names to checkout_entry(). That
> function requires us to have a "struct cache_entry". And
> because that struct uses a FLEX_ARRAY for the name field, we
> have to actually copy in our new name.
> 
> The current code allocates a single re-usable cache_entry
> that can hold a name up to PATH_MAX, and then copies
> filenames into it using strcpy(). But there's no guarantee
> that incoming names are smaller than PATH_MAX. They've come
> from "diff --raw" output which might be diffing between two
> trees (and hence we'd be subject to the PATH_MAX of some
> other system, or even none at all if they were created
> directly via "update-index").
> 
> We can fix this by using make_cache_entry() to create a
> correctly-sized cache_entry for each name. This incurs an
> extra allocation per file, but this is negligible compared
> to actually writing out the file contents.
> 
> To make this simpler, we can push this procedure into a new
> helper function. Note that we can also get rid of the "len"
> variables for src_path and dst_path (and in fact we must, as
> the compiler complains that they are unused).

Oh woops. Thanks for noticing and for patching it right away!

> I tested this with:
> 
>   git init
>   sha1=$(echo whatever | git hash-object -w --stdin)
>   git update-index --add --cacheinfo \
>     100644 $sha1 $(perl -e 'print join("/", 1..2048)')
>   git difftool -d HEAD
> 
> It fails anyway, of course, because we can't check out a filename of
> that length, but not until after it has overflowed the buffer.
> 
> I'm not sure if we'd want that in the test suite or not, since the
> outcome is unpredictable.

I'd leave it out. There is really no reliable way to test this.

>  builtin/difftool.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)

Nice! I would have thought that it adds to the total number of lines.
Instead, it removes many fiddly `*_len = *` assignments and makes the code
more robust.

ACK!
Dscho
