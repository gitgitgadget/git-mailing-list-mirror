Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D3C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FF924685
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WpVMJcN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgA1Pg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:36:59 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:18988 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgA1Pg7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jan 2020 10:36:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580225818; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=onyOZYEX79uj9EQDOZ8BFHScpHy+votlAXqDVODWGak=; b=WpVMJcN15ehvDo+eEETxLV04dWDpGaKtTGy4Er6YPfz3Ppupo5BJrNl/PdsZLGKFLfx990rM
 YQ3GYKf36zq1acCzTuhy8Q0Mt4oTAjyCxT7Bf71nh03QuAy9yyNYqbXB3Yb4OOiOmnrb3sO3
 tm+OyI1jiMTx3nrzWkSUhscsyV8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e305519.7fc688b13ae8-smtp-out-n01;
 Tue, 28 Jan 2020 15:36:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AC3DC447A2; Tue, 28 Jan 2020 15:36:56 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D577AC433CB;
        Tue, 28 Jan 2020 15:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D577AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Date:   Tue, 28 Jan 2020 08:36:53 -0700
Message-ID: <2215899.n3y15ba4yI@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-154-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20200128073100.GA563058@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com> <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com> <20200128073100.GA563058@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, January 28, 2020 2:31:00 AM MST Jeff King wrote:
> Some thoughts on compatibility:
> 
> The idea of the config changes is that older versions of Git will either
> complain about repositoryformatversion (if very old), or will complain
> that they don't know about extensions.refFormat. But the changes you
> made in patch 1 indicate that existing versions of Git won't consider it
> to be a Git repository at all!
> 
> I think this is slightly non-ideal, in that we'd continue walking up the
> tree looking for a Git repo. And either:
> 
>   - we'd find one, which would be confusing and possibly wrong
> 
>   - we wouldn't, in which case the error would be something like "no git
>     repository", and not "your git repository is too new"
> 
> So it would be really nice if we continued to have a HEAD file (just
> with some sentinel value in it) and a refs/ directory, so that existing
> versions of Git realize "there's a repository here, but it's too new for
> me".
> 
> There's a slight downside in that tools which _aren't_ careful about
> repositoryformatversion might try to operate on the repository, writing
> into refs/ or whatever. But such tools are broken, and I'm not sure we
> should be catering to them (besides which, the packed-refs ship sailed
> long ago, so they're already potentially dangerous).

Could you elaborate on this a bit because it seems on the surface that these 
tools aren't very dangerous, and therefore likely many of them exist?

What are the dangers today of tools that understand/operate on loose and 
packed refs without reading repositoryformatversion?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
