Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392ED20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbdDMSIQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:08:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbdDMSIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:08:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ECC3260DA8; Thu, 13 Apr 2017 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1492106891;
        bh=ZiHtk6e2olpHOLW7c2LzwB+vzXFGNX2U260OGc57jYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrowbKvVFgNRFBAfrg+KyImJCO25pIHON76B7AJ98QXFAusQ7Akra9c+XZ6BrVKqQ
         79QIMSpYN4juxksq/ciCod4n1o9eF+v5d/eksw+Qn8NdLjQEpP68qt5NE6/wvRtVjK
         uzCLcnqyVRT9I82uPWtCiPgB45uxpHsTw1dFbfGQ=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84A3160BF7;
        Thu, 13 Apr 2017 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1492106891;
        bh=ZiHtk6e2olpHOLW7c2LzwB+vzXFGNX2U260OGc57jYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrowbKvVFgNRFBAfrg+KyImJCO25pIHON76B7AJ98QXFAusQ7Akra9c+XZ6BrVKqQ
         79QIMSpYN4juxksq/ciCod4n1o9eF+v5d/eksw+Qn8NdLjQEpP68qt5NE6/wvRtVjK
         uzCLcnqyVRT9I82uPWtCiPgB45uxpHsTw1dFbfGQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84A3160BF7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     David Turner <novalis@novalis.org>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Simultaneous gc and repack
Date:   Thu, 13 Apr 2017 12:08:10 -0600
Message-ID: <10832632.7AIzXehjUi@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CA+P7+xo4mwA8DMeObq_T9=P9m7tG1d6afDS_Md56_EnhuXLVgw@mail.gmail.com>
References: <1492104698.1527.79.camel@novalis.org> <CA+P7+xo4mwA8DMeObq_T9=P9m7tG1d6afDS_Md56_EnhuXLVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, April 13, 2017 11:03:14 AM Jacob Keller wrote:
> On Thu, Apr 13, 2017 at 10:31 AM, David Turner 
<novalis@novalis.org> wrote:
> > Git gc locks the repository (using a gc.pid file) so
> > that other gcs don't run concurrently. But git repack
> > doesn't respect this lock, so it's possible to have a
> > repack running at the same time as a gc.  This makes
> > the gc sad when its packs are deleted out from under it
> > with: "fatal: ./objects/pack/pack-$sha.pack cannot be
> > accessed".  Then it dies, leaving a large temp file
> > hanging around.
> > 
> > Does the following seem reasonable?
> > 
> > 1. Make git repack, by default, check for a gc.pid file
> > (using the same logic as git gc itself does).
> > 2. Provide a --force option to git repack to ignore said
> > check. 3. Make git gc provide that --force option when
> > it calls repack under its own lock.
> 
> What about just making the code that calls repack today
> just call gc instead? I guess it's more work if you don't
> strictly need it but..?

There are many scanerios where this does not achieve the 
same thing.  On the obvious side, gc does more than 
repacking, but on the other side, repacking has many 
switches that are not available via gc.

Would it make more sense to move the lock to repack instead 
of to gc?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

