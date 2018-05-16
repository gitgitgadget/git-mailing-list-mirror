Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402781F406
	for <e@80x24.org>; Wed, 16 May 2018 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeEPS02 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 14:26:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPS01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 14:26:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06D9160B23; Wed, 16 May 2018 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526495187;
        bh=aaV2wSKTNJwcRB5oCRv7OuLGkLTcRZCyIEcykysMzPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be/HvA8Hlox5jgrYPysthN+Zeo80qdTgeANK58H8A+vzjzC+Lx5umJ8liknRH3TeU
         kx/T3wJubgfv5OWpMryhxKXnkQR2xrxiHc8lW+SGU3N84JaaOTpIyWPsRpOI+1T1e4
         FlOxk5PuBUyUKuQYeYQFeIRgVYRpJpXvHT/ygGu0=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C46F605A8;
        Wed, 16 May 2018 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526495186;
        bh=aaV2wSKTNJwcRB5oCRv7OuLGkLTcRZCyIEcykysMzPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgyC2M3+NRTQvKTpJwonbv+kqKIn/F2pgS/IJtybKLMsZgw8SKhbCp75+gKjen5BL
         8dUXEJoYrBJZ5Ic/Rd75HWsRn7QnQekbvido85ZikJKgsDTqpjazxvrYXFXuqFMWd/
         nyntX0GbIxJSVUZNT3K8IdaL2j+1reh10QT/5nE0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C46F605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Date:   Wed, 16 May 2018 12:26:25 -0600
Message-ID: <1950199.Z2x8tXoTfI@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <87h8n7bhro.fsf@evledraar.gmail.com> <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 02:12:24 PM Konstantin Ryabitsev 
wrote:
> The loose objects I'm thinking of are those that are
> generated when we do "git repack -Ad" -- this takes all
> unreachable objects and loosens them (see man git-repack
> for more info). Normally, these would be pruned after a
> certain period, but we're deliberately keeping them
> around forever just in case another repo relies on them
> via alternates. I want those repos to "claim" these loose
> objects via hardlinks, such that we can run git-prune on
> the mother repo instead of dragging all the unreachable
> objects on forever just in case.

If you are going to keep the unreferenced objects around 
forever, it might be better to keep them around in packed 
form?  We currently do that because we don't think there is 
a safe way to prune objects yet on a running server (which 
is why I am teaching jgit to be able to recover from a racy 
pruning error),

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

