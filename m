Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A91F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 15:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeH3T03 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:26:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62697 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3T02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:26:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2506EFC777;
        Thu, 30 Aug 2018 11:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=rHgxVZHUgltz5cauKhjAsXlXR88=; b=D3aak7
        7B3+gT7vNBznXuS0L9Kae4piipH6onWw3LmrvThooIMiFvhraFirlD8CKQc6qeJO
        3I8THuQaR8FetGVhD58Tv849WWFTQaVI74wc4XA/sdz65rA24QKf7gXDjZCGPrmp
        WilAA7m39JK1kyvBduDHSTpxSCygqZSBFYghc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BEB2FC776;
        Thu, 30 Aug 2018 11:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Ozwqp74n8OEIif+j6Jx+gfW9XHC5NJ7kHwhkJE9ZCGg=; b=LSyJXhE0SBCenAOrPiZMzJJIvnVHjxm3vHcxsmGFgsxyyq7TkTVuZZuQ8H0r/kEv4laf5zO3FHmD5sxEFntRXnc7KXYiLvQivk0pBLThQv1ccbVifs2V1goLBG25XDhjWc7JmTU+Vq7mjx141X5gm0cPE6cVRyTxXgltX50k6M8=
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 997D9FC775;
        Thu, 30 Aug 2018 11:23:44 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5EC642DA018D;
        Thu, 30 Aug 2018 11:23:43 -0400 (EDT)
Date:   Thu, 30 Aug 2018 11:23:42 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jeff King <peff@peff.net>
cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        gitster@pobox.com,
        =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] handle corruption in patch-delta
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Message-ID: <nycvar.YSQ.7.76.1808301104520.1454@knanqh.ubzr>
References: <20180829205857.77340-1-jannh@google.com> <20180830070548.GA15081@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: AEF185EE-AC68-11E8-A24A-063AD72159A7-78420484!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Aug 2018, Jeff King wrote:

> On Wed, Aug 29, 2018 at 10:58:55PM +0200, Jann Horn wrote:
> 
> > If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
> > `memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
> > into `dst_buf`.
> > 
> > This is not an exploitable bug because triggering the bug increments the
> > `data` pointer beyond `top`, causing the `data != top` sanity check after
> > the loop to trigger and discard the destination buffer - which means that
> > the result of the out-of-bounds read is never used for anything.
> > 
> > Also, directly jump into the error handler instead of just breaking out of
> > the loop - otherwise, data corruption would be silently ignored if the
> > delta buffer ends with a command and the destination buffer is already
> > full.
> 
> Based on my earlier observations, here's a replacement patch series I
> came up with. It has:
> 
>   [1/5]: test-delta: read input into a heap buffer
> 
>     A simpler replacement for your patch 2 which avoids portability
>     issues.
> 
>   [2/5]: t5303: test some corrupt deltas
> 
>     A more complete set of boundary tests based on the 4 cases I laid
>     out, plus the cp_size problem I found.
> 
>   [3/5]: patch-delta: fix oob read
> 
>     Your actual fix.
> 
>   [4/5]: patch-delta: consistently report corruption
> 
>     Your related trailing-garbage fix. I split this into two in order to
>     better demonstrate the cases this part covers.
> 
>   [5/5]: patch-delta: handle truncated copy parameters
> 
>     My fix for the cp_size read.
> 
> I hope you don't mind me hacking up your patches a bit. Thanks again for
> your original report and patch.

Looks good to me (feels like traveling back in time).

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>



> 
> -Peff
> 
