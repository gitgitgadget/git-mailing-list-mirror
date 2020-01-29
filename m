Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A23C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5835320732
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="I3zjOM1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgA2QtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:49:17 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23881 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgA2QtR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jan 2020 11:49:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580316556; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=7Jd75fo8L013aUrTZsxiB8ASCAY0rjhcwOxG+o4OByk=; b=I3zjOM1Y9XBvVXpYdeU+n7eH+Q0AvMLWOmK2kq2yXr9/R3kq9ljFrdKKQy8k5KFjfIFtzGXW
 vChYByuT5iKAf/XC1gDf14Dn8eRZfLDwn4iWzYDJlj3d1mVwmowUToVRG4FT+3JsbT58fBzA
 ignezMgxNKXk3/HbDPNjHMJTx48=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e31b784.7fe0595ddf10-smtp-out-n01;
 Wed, 29 Jan 2020 16:49:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2D80C4479F; Wed, 29 Jan 2020 16:49:07 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EDE6C43383;
        Wed, 29 Jan 2020 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EDE6C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Date:   Wed, 29 Jan 2020 09:49:04 -0700
Message-ID: <9138554.c73hJVQVja@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-154-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20200129081259.GB601903@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com> <2215899.n3y15ba4yI@mfick-lnx> <20200129081259.GB601903@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, January 29, 2020 3:12:59 AM MST Jeff King wrote:
> On Tue, Jan 28, 2020 at 08:36:53AM -0700, Martin Fick wrote:
> > > There's a slight downside in that tools which _aren't_ careful about
> > > repositoryformatversion might try to operate on the repository, writing
> > > into refs/ or whatever. But such tools are broken, and I'm not sure we
> > > should be catering to them (besides which, the packed-refs ship sailed
> > > long ago, so they're already potentially dangerous).
> > 
> > Could you elaborate on this a bit because it seems on the surface that
> > these tools aren't very dangerous, and therefore likely many of them
> > exist?
> > 
> > What are the dangers today of tools that understand/operate on loose and
> > packed refs without reading repositoryformatversion?
> 
> I was mostly thinking of hacky scripts that tried to touch .git/refs
> directly. And there are a few levels of dangerous there:
> 
>   - if you're doing "echo $sha1 >.git/refs/heads/master", then you're
>     not locking properly. But it would probably work most of the time.
> 
>   - if you're properly taking a lock on ".git/refs/heads/master.lock"
>     and renaming into place but not looking at packed-refs, then you
>     might overwrite somebody else's update which is in the packed file
> 
>   - if you're trying to read refs and not reading packed-refs, obviously
>     you might miss some values
> 
> If you're actually doing the correct locking and packed-refs read (which
> "real" implementations like libgit2 do) then no, I don't think that's
> dangerous. And I think libgit2 properly complains when it sees a
> repositoryformatversion above 0. I don't know offhand about JGit, or any
> of the lesser-used ones like dulwich or go-git.

Today, some of these sound like shortcuts that are very likely taken quite a 
bit by cleanup and other maintenance scripts (not necessarily formal git 
tools), and the impact of these shortcuts is likely low with the current 
model. However, I suspect these tools/scripts could be seriously disruptive if 
we leave the refs dir around when using reftable,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
