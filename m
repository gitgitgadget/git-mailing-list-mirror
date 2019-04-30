Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33FA1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfD3WIG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:08:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WIF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:08:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF0096079C; Tue, 30 Apr 2019 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556662084;
        bh=ZAQvZ1sxD2zuY0XlLG2YNI4qXYMHUqsGDrMWvni27s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db3v1rOxxoEXrttQRMPb9X92juUyn6fH11K5R1OK6ZxooKhgzDjRm9A/P8M2tDoUg
         Pu1tdGH3syXyfd5DaHr/3FMIn4IM0jUSYS4RolWkqEXha8Uv2sFW9YhokXRfe/39tq
         stsn7dadQCvu9IYB05T33Q22AGH/Qc7bVrXcr+s8=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFF1260247;
        Tue, 30 Apr 2019 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556662083;
        bh=ZAQvZ1sxD2zuY0XlLG2YNI4qXYMHUqsGDrMWvni27s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8sYKnWjgmpGbJIULVD7jbT4vwrGVDUmk6ad1alNvncyfZzdBszYzia3pdxOP6EgU
         oIsiX3NrEVvFBITVqaPpb8DE3nEOYUt3QYXOl2m+d2HvKyemxfs2tPut415cS0edci
         vXIAK7OD7CzZEZQJcJTP51u6FRWuqUGXqEomElok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFF1260247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Date:   Tue, 30 Apr 2019 16:08:02 -0600
Message-ID: <7252129.tRx6dl7m8I@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-137-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20190430180231.GC16729@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx> <3329645.KIYB9vJKXd@mfick-lnx> <20190430180231.GC16729@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, April 30, 2019 2:02:32 PM MDT Jeff King wrote:
> On Tue, Apr 23, 2019 at 02:09:31PM -0600, Martin Fick wrote:
> > I think that if there were no default limit during a clone it could have
> > disastrous effects on people using the repo tool from the android project,
> > or any other "submodule like" tool that might clone many projects in
> > parallel. With the repo tool, people often use a large -j number such as
> > 24 which means they end up cloning around 24 projects at a time, and they
> > may do this for around 1000 projects. If git clone suddenly started as
> > many threads as there are CPUs for each clone, this would likely paralyze
> > the machine.
> 
> IMHO this is already a problem, because none of those 24 gits knows
> about the others. So they're already using 24*3 cores, though of course
> at any given moment some of those 24 may be bottle-necked on the
> network.

I think this is very different. In the first case this is a linear constraint 
that someone can use to intelligently adjust the number of clones they are 
doing at the same time. The second case cannot be accounted for in any 
intelligent way by the person running the clones, it is almost unconstrained.

...
> > I do suspect it would be nice to have a switch though that repo could use
> > to adjust this intelligently, is there some way to adjust threads from a
> > clone, I don't see one? I tried using 'GIT_FORCE_THREADS=28 git clone
> > ...' and it didn't seem to make a difference?
> 
> I think I led you astray earlier by mentioning GIT_FORCE_THREADS. It's
> actually just a boolean for "use threads even if we're only
> single-threaded". What you actually want is probably:
> 
>   git clone -c pack.threads=28 ...
> 
> (though I didn't test it to be sure).

Thanks, I will test this!

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

