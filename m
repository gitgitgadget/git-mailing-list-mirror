Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF5BC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ED764F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBXSOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:14:52 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:26886 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBXSOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 13:14:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614190464; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=cxgxxas+iswL0Y5OaZmV20u3+QVUoddZIWyOZMq/Xlw=; b=W41ODXlx/8MmCjOj2Fs5ZBWrxfQEfkTaAAnQUpJYEN81GxkohoAFt0YcDRD505/AKsvZd052
 CRqyRW5vYgKSK06IQdouIEJT2NmuaMmhSUfKXCQiTB8RXIFzUgP3SNO4H+bTC+bLlE85MrjH
 RAEfCqvkYPUTdrxnqXrnePEgyfc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60369763095efe181665255f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 18:13:55
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F1B0C43461; Wed, 24 Feb 2021 18:13:55 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C805C433CA;
        Wed, 24 Feb 2021 18:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C805C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric sequence
Date:   Wed, 24 Feb 2021 11:13:53 -0700
Message-ID: <4678947.aH8v75nzy7@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-154-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <YDV5UX6n2nZb9Tn2@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com> <8347289.KuArlTWdtP@mfick-lnx> <YDV5UX6n2nZb9Tn2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, February 23, 2021 4:53:21 PM MST Jeff King wrote:
> On Tue, Feb 23, 2021 at 02:41:09PM -0700, Martin Fick wrote:
> > > > Would it make sense to somehow detect all new packs since the last
> > > > rollup
> > > > and always include them in the rollup no matter what their size? That
> > > > is
> > > > one thing that my git-exproll script did. One of the main reasons to
> > > > do
> > > > this was because newer packs tended to look big (I was using bytes to
> > > > determine size), and newer packs were often bigger on disk compared to
> > > > other packs with similar objects in them (I think you suggested this
> > > > was
> > > > due to the thickening of packs on receipt). Maybe roll up all packs
> > > > with
> > > > a timestamp "new enough", no matter how big they are?
> > > 
> > > That works against the "geometric" part of the strategy, which is trying
> > > to roll up in a sequence that is amortized-linear. I.e., we are not
> > > always rolling up everything outside of the base pack, but trying to
> > > roll up little into medium, and then eventually medium into large. If
> > > you roll up things that are "too big", then you end up rewriting the
> > > bytes more often, and your amount of work becomes super-linear.
> > 
> > I'm not sure I follow, it would seem to me that it would stay linear, and
> > be at most rewriting each new packfile once more than previously? Are you
> > envisioning more work than that?
> 
> Maybe I don't understand what you're proposing.
> 
> The idea of the geometric repack is that by sorting by size and then
> finding a "cutoff" within the size array, we can make sure that we roll
> up a sufficiently small number of bytes in each roll-up that it ends up
> linear in the size of the repo in the long run. But if we roll up
> without regard to size, then our worst case is that the biggest pack is
> the newest (imagine a repo with 10 small pushes and then one gigantic
> one). So we roll that up with some small packs, doing effectively
> O(size_of_repo) work.

This isn't quite a fair evaluation, it should be O(size_of_push) I think?

> And then in the next roll up we do it again, and so on. 
 
I should have clarified that the intent is to prevent this by specifying an 
mtime after the last rollup so that this should only ever happen once for new 
packfiles. It also means you probably need special logic to ensure this roll-up 
doesn't happen if there would only be one file in the rollup, 

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

