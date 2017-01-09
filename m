Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0181D1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163351AbdAIQW4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 11:22:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163330AbdAIQWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 11:22:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FEA961382; Mon,  9 Jan 2017 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483978971;
        bh=TfiFh6OgPkTvI8nDfyxD9WMFWbkSLBIvCJ2V2IWn8lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a10UtKYZcXPkYLyMj/JyciUypkgeNBRnd5+6PhxJGIKTk2liQik6pUtBo/46gmo7Q
         kwOarMCJYbfGo31CD0JIdxSOxXYiUC+kz3dBe9k3Y6VSdFoTqxsy2NpJsIIMBekNpn
         UntCiKVCeeTZhaL+Iz/6Rq8uvEi+WVMrpieJpQ84=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2109D612F2;
        Mon,  9 Jan 2017 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483978971;
        bh=TfiFh6OgPkTvI8nDfyxD9WMFWbkSLBIvCJ2V2IWn8lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a10UtKYZcXPkYLyMj/JyciUypkgeNBRnd5+6PhxJGIKTk2liQik6pUtBo/46gmo7Q
         kwOarMCJYbfGo31CD0JIdxSOxXYiUC+kz3dBe9k3Y6VSdFoTqxsy2NpJsIIMBekNpn
         UntCiKVCeeTZhaL+Iz/6Rq8uvEi+WVMrpieJpQ84=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 2109D612F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Date:   Mon, 09 Jan 2017 09:20:05 -0700
Message-ID: <3341131.K6hMDMB8iT@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <20170109105545.gchfklcuzwhlfbtf@sigill.intra.peff.net>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org> <20170109070119.lite2o7k3t2wuvtt@glandium.org> <20170109105545.gchfklcuzwhlfbtf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, January 09, 2017 05:55:45 AM Jeff King wrote:
> On Mon, Jan 09, 2017 at 04:01:19PM +0900, Mike Hommey 
wrote:
> > > That's _way_ more complicated than your problem, and
> > > as I said, I do not have a finished solution. But it
> > > seems like they touch on a similar concept (a
> > > post-delete holding area for objects). So I thought
> > > I'd mention it in case if spurs any brilliance.
> > 
> > Something that is kind-of in the same family of problems
> > is the "loosening" or objects on repacks, before they
> > can be pruned.
...
> Yes, this can be a problem. The repack is smart enough not
> to write out objects which would just get pruned
> immediately, but since the grace period is 2 weeks, that
> can include a lot of objects (especially with history
> rewriting as you note). It would be possible to write
> those loose objects to a "cruft" pack, but there are some
> management issues around the cruft pack. You do not want
> to keep repacking them into a new cruft pack at each
> repack, since then they would never expire. So you need
> some way of marking the pack as cruft, letting it age
> out, and then deleting it after the grace period expires.
> 
> I don't think it would be _that_ hard, but AFAIK nobody
> has ever made patches.

FYI, jgit does this,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

