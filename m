Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9003BC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C9864DF5
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBWVmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:42:06 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:33729 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhBWVmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:42:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614116501; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=smxN+58pd3O8iEkM9p0gxf3vbjFAczslN2BdovLeYfw=; b=oONgc/51AuJVQ/1VnS18gzJypyzDqL8PnCnZL4cSvzmah5XMzNDUqDEVwC80CByzkxAkYKjA
 OMFJwS+/RIuLUqCsxhEB6TJytS2UYX7e5SXCs9h/KtzvO45TkKlaDdIQDRLo42Ot+lFZXxXm
 jl7R/lRvAkjPMhPFV+H+NpI4gR8=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 603576774511108a8121e366 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 21:41:11
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3A08C43463; Tue, 23 Feb 2021 21:41:10 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D7E4C433C6;
        Tue, 23 Feb 2021 21:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D7E4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric sequence
Date:   Tue, 23 Feb 2021 14:41:09 -0700
Message-ID: <8347289.KuArlTWdtP@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-154-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <YDViUPT4JhGJLjji@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com> <1724378.IzK8VI2DXP@mfick-lnx> <YDViUPT4JhGJLjji@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, February 23, 2021 3:15:12 PM MST Jeff King wrote:
> On Tue, Feb 23, 2021 at 12:54:56PM -0700, Martin Fick wrote:
> > > Yeah, this is definitely a heuristic that can get out of sync with
> > > reality. I think in general if you have base pack A and somebody pushes
> > > up B, C, and D in sequence, we're likely to roll up a single DBC (in
> > > that order) pack. Further pushes E, F, G would have newer mtimes. So we
> > > might get GFEDBC directly. Or we might get GFE and DBC, but the former
> > > would still have a newer mtime, so we'd create GFEDBC on the next run.
> > > 
> > > The issues come from:
> > >   - we are deciding what to roll up based on size. A big push might not
> > >   
> > >     get rolled up immediately, putting it out-of-sync with the rest of
> > >     the rollups.
> > 
> > Would it make sense to somehow detect all new packs since the last rollup
> > and always include them in the rollup no matter what their size? That is
> > one thing that my git-exproll script did. One of the main reasons to do
> > this was because newer packs tended to look big (I was using bytes to
> > determine size), and newer packs were often bigger on disk compared to
> > other packs with similar objects in them (I think you suggested this was
> > due to the thickening of packs on receipt). Maybe roll up all packs with
> > a timestamp "new enough", no matter how big they are?
> 
> That works against the "geometric" part of the strategy, which is trying
> to roll up in a sequence that is amortized-linear. I.e., we are not
> always rolling up everything outside of the base pack, but trying to
> roll up little into medium, and then eventually medium into large. If
> you roll up things that are "too big", then you end up rewriting the
> bytes more often, and your amount of work becomes super-linear.

I'm not sure I follow, it would seem to me that it would stay linear, and be 
at most rewriting each new packfile once more than previously? Are you 
envisioning more work than that?

> Now whether that matters all that much or not is perhaps another
> discussion. The current strategy is mostly to repack all-into-one with
> no base, which is the worst possible case. So just about any rollup
> strategy will be an improvement. ;)

+1 Yes, while anything would be an improvement, this series' approach is very 
good! Thanks for doing this!!

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

