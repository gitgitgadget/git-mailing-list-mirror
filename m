Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E5C20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbdDMSgY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:36:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdDMSgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:36:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5FA560DBB; Thu, 13 Apr 2017 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1492108581;
        bh=jVpo80kp5CmDbAO438cxYjUC2jb3AunVGRptPOJodfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH0ddYvwLN+X/SdajZ5Gy4BWnULmHiMPjEdUXN8g5xDI9vjNfA45wKkBrx2AWeTZN
         SikwLcO9V0qCTHS8dXj0iSubPecmhIH94Tx2UMA4TTp11CvDW3zEZMQI4vRunnTPJ0
         Y2NT1fy+QRxMlYgMEn0O4SjZAJYmhLfs0HyNTFOQ=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48DF5607ED;
        Thu, 13 Apr 2017 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1492108581;
        bh=jVpo80kp5CmDbAO438cxYjUC2jb3AunVGRptPOJodfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH0ddYvwLN+X/SdajZ5Gy4BWnULmHiMPjEdUXN8g5xDI9vjNfA45wKkBrx2AWeTZN
         SikwLcO9V0qCTHS8dXj0iSubPecmhIH94Tx2UMA4TTp11CvDW3zEZMQI4vRunnTPJ0
         Y2NT1fy+QRxMlYgMEn0O4SjZAJYmhLfs0HyNTFOQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48DF5607ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     David Turner <novalis@novalis.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Simultaneous gc and repack
Date:   Thu, 13 Apr 2017 12:36:20 -0600
Message-ID: <1553777.vJallt5N6j@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <1492108087.1527.82.camel@novalis.org>
References: <1492104698.1527.79.camel@novalis.org> <10832632.7AIzXehjUi@mfick1-lnx> <1492108087.1527.82.camel@novalis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, April 13, 2017 02:28:07 PM David Turner wrote:
> On Thu, 2017-04-13 at 12:08 -0600, Martin Fick wrote:
> > On Thursday, April 13, 2017 11:03:14 AM Jacob Keller 
wrote:
> > > On Thu, Apr 13, 2017 at 10:31 AM, David Turner 
> > 
> > <novalis@novalis.org> wrote:
> > > > Git gc locks the repository (using a gc.pid file) so
> > > > that other gcs don't run concurrently. But git
> > > > repack
> > > > doesn't respect this lock, so it's possible to have
> > > > a
> > > > repack running at the same time as a gc.  This makes
> > > > the gc sad when its packs are deleted out from under
> > > > it
> > > > with: "fatal: ./objects/pack/pack-$sha.pack cannot
> > > > be
> > > > accessed".  Then it dies, leaving a large temp file
> > > > hanging around.
> > > > 
> > > > Does the following seem reasonable?
> > > > 
> > > > 1. Make git repack, by default, check for a gc.pid
> > > > file
> > > > (using the same logic as git gc itself does).
> > > > 2. Provide a --force option to git repack to ignore
> > > > said
> > > > check. 3. Make git gc provide that --force option
> > > > when
> > > > it calls repack under its own lock.
> > > 
> > > What about just making the code that calls repack
> > > today
> > > just call gc instead? I guess it's more work if you
> > > don't
> > > strictly need it but..?
> > 
> > There are many scanerios where this does not achieve
> > the 
> > same thing.  On the obvious side, gc does more than 
> > repacking, but on the other side, repacking has many 
> > switches that are not available via gc.
> > 
> > Would it make more sense to move the lock to repack
> > instead  of to gc?
> 
> Other gc operations might step on each other too (e.g.
> packing refs). That would be less bad (and less common),
> but it still seems worth avoiding.

Yes, but all of thsoe operations need to be self protected 
already, or they risk the same issue.

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

