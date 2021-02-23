Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EAC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B3764E57
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBWTzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:55:49 -0500
Received: from z11.mailgun.us ([104.130.96.11]:31808 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhBWTzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:55:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614110128; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=75pK4pgjXuA7BZeMQ+QsplLJhYrzT+NJpQ6MsZNa92o=; b=c/g7SbnlqOxsK8XUAWlVLYIh4Euqfxj5FRXVCSKAHrjp31j0lCru6R2fO5eoLv2VzBwk0zec
 tu10d8MjSo9cGHlHkFizbMjOZ6a9bSeYC4DcBZcEMA5kQO5ym9JkY+mvn0S/yPwfuWy3UYCA
 Vt4mebwgggzG+brUuMgNMeaxF4Y=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60355d934511108a81bfb3b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 19:54:59
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60D58C433CA; Tue, 23 Feb 2021 19:54:58 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD6B5C433C6;
        Tue, 23 Feb 2021 19:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD6B5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric sequence
Date:   Tue, 23 Feb 2021 12:54:56 -0700
Message-ID: <1724378.IzK8VI2DXP@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-154-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <YDVM9U7zLstNBVq2@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com> <xmqq7dmz5iw5.fsf@gitster.g> <YDVM9U7zLstNBVq2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, February 23, 2021 1:44:05 PM MST Jeff King wrote:
> On Mon, Feb 22, 2021 at 11:43:22PM -0800, Junio C Hamano wrote:
> > >     ++	/*
> > >     ++	 * order packs by descending mtime so that objects are laid out
> > >     ++	 * roughly as newest-to-oldest
> > >     ++	 */
> > >     
> > >      +	if (a->mtime < b->mtime)
> > >      +		return 1;
> > >     
> > >     ++	else if (b->mtime < a->mtime)
> > >     ++		return -1;
> > >     
> > >      +	else
> > >      +		return 0;
> > 
> > I think this strategy makes sense when this repack using this new
> > feature is run for the first time in a repository that acquired many
> > packs over time.  I am not sure what happens after the feature is
> > used a few times---it won't always be the newest sets of packs that
> > will be rewritten, but sometimes older ones are also coalesced, and
> > when that happens the resulting pack that consists primarily of older
> > objects would end up having a more recent timestamp, no?
> 
> Yeah, this is definitely a heuristic that can get out of sync with
> reality. I think in general if you have base pack A and somebody pushes
> up B, C, and D in sequence, we're likely to roll up a single DBC (in
> that order) pack. Further pushes E, F, G would have newer mtimes. So we
> might get GFEDBC directly. Or we might get GFE and DBC, but the former
> would still have a newer mtime, so we'd create GFEDBC on the next run.
> 
> The issues come from:
> 
>   - we are deciding what to roll up based on size. A big push might not
>     get rolled up immediately, putting it out-of-sync with the rest of
>     the rollups.

Would it make sense to somehow detect all new packs since the last rollup and 
always include them in the rollup no matter what their size? That is one thing 
that my git-exproll script did. One of the main reasons to do this was because 
newer packs tended to look big (I was using bytes to determine size), and 
newer packs were often bigger on disk compared to other packs with similar 
objects in them (I think you suggested this was due to the thickening of packs 
on receipt). Maybe roll up all packs with a timestamp "new enough", no matter 
how big they are?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

