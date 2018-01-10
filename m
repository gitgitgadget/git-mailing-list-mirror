Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E001F404
	for <e@80x24.org>; Wed, 10 Jan 2018 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeAJSZv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 13:25:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeAJSZu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 13:25:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9DE0A60B1B; Wed, 10 Jan 2018 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515608749;
        bh=B6WoWD9gPj9/0+CmmaDTjcp1WqxmVVMKKAgg2ixN0Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=errHdfUyk6K66QTD7oHYx/tQY5NgjuHbcpBh69ZQ1B0tghalsJH7kZdldT6uZ1MBW
         sEGCsGcFBMIn8RyYuF3s+ZzDI8IaQTYliObSSC4LFQpKqzUY+maj+KTesRGDetRsJ7
         KC3N+bDhKnE+LjSedNgiUtCPJlkrMZP+NluUq5J0=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D78D960724;
        Wed, 10 Jan 2018 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515608749;
        bh=B6WoWD9gPj9/0+CmmaDTjcp1WqxmVVMKKAgg2ixN0Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=errHdfUyk6K66QTD7oHYx/tQY5NgjuHbcpBh69ZQ1B0tghalsJH7kZdldT6uZ1MBW
         sEGCsGcFBMIn8RyYuF3s+ZzDI8IaQTYliObSSC4LFQpKqzUY+maj+KTesRGDetRsJ7
         KC3N+bDhKnE+LjSedNgiUtCPJlkrMZP+NluUq5J0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D78D960724
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Date:   Wed, 10 Jan 2018 11:25:47 -0700
Message-ID: <2648064.NJaMxHkljU@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, January 07, 2018 01:14:41 PM Derrick Stolee 
wrote:
> This RFC includes a new way to index the objects in
> multiple packs using one file, called the multi-pack
> index (MIDX).
...
> The main goals of this RFC are:
> 
> * Determine interest in this feature.
> 
> * Find other use cases for the MIDX feature.

My interest in this feature would be to speed up fetches 
when there is more than one large pack-file with many of the 
same objects that are in other pack-files.   What does your 
MIDX design do when it encounters multiple copies of the 
same object in different pack files?  Does it index them all, 
or does it keep a single copy?

In our Gerrit instance (Gerrit uses jgit), we have multiple 
copies of the linux kernel repos linked together via the 
alternatives file mechanism.  These repos have many different 
references (mostly Gerrit change references), but they share 
most of the common objects from the mainline.  I have found 
that during a large fetch such as a clone, jgit spends a 
significant amount of extra time by having the extra large 
pack-files from the other repos visible to it, usually around 
an extra minute per instance of these (without them, the 
clone takes around 7mins).  This adds up easily with a few 
repos extra repos, it can almost double the time.

My investigations have shown that this is due to jgit 
searching each of these pack files to decide which version of 
each object to send.  I don't fully understand its selection 
criteria, however if I shortcut it to just pick the first 
copy of an object that it finds, I regain my lost time.  I 
don't know if git suffers from a similar problem?  If git 
doesn't suffer from this then it likely just uses the first 
copy of an object it finds (which may not be the best object 
to send?)

It would be nice if this use case could be improved with 
MIDX.  To do so, it seems that it would either require that 
MIDX either only put "the best" version of an object (i.e. 
pre-select which one to use), or include the extra 
information to help make the selection process of which copy 
to use (perhaps based on the operation being performed) 
fast.

This also leads me to ask, what other additional information 
(bitmaps?) for other operations, besides object location, 
might suddenly be valuable in an index that potentially 
points to multiple copies of objects?  Would such 
information be appropriate in MIDX, or would it be better in 
another index?

Thanks,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

