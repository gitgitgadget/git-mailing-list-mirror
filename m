Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3FB1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfFMTqH (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:46:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfFMTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:46:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9018E607F1; Thu, 13 Jun 2019 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560455166;
        bh=L6c7mxinEOhzdTvi7I16AxnfX5CjBbd0ycVN/M4FYfM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=jvgkkYRQU2GmdAQHxSOlU6u5iHJfmmt4Ao8+rbcXuNEjKGqVyAGma5g6Dg6DYeTte
         Oio/XBrw0kguRd+goy9wTKOC5k2J3PCwGRdACtNu8X9Q5fvt7r3VG8lf2Ecn5oj0GA
         iBnS5Zb7eI2BsAuaCkZTyQZxhLyUzVIXtuuNrOlY=
Received: from nasserg1-mac.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nasser@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A85F6074C;
        Thu, 13 Jun 2019 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560455166;
        bh=L6c7mxinEOhzdTvi7I16AxnfX5CjBbd0ycVN/M4FYfM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=jvgkkYRQU2GmdAQHxSOlU6u5iHJfmmt4Ao8+rbcXuNEjKGqVyAGma5g6Dg6DYeTte
         Oio/XBrw0kguRd+goy9wTKOC5k2J3PCwGRdACtNu8X9Q5fvt7r3VG8lf2Ecn5oj0GA
         iBnS5Zb7eI2BsAuaCkZTyQZxhLyUzVIXtuuNrOlY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A85F6074C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=nasser@codeaurora.org
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: git receive-pack deletes refs one at a time?
From:   Nasser Grainawi <nasser@codeaurora.org>
In-Reply-To: <20190613174331.GA19795@sigill.intra.peff.net>
Date:   Thu, 13 Jun 2019 13:46:05 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <34FD9B2B-D53A-4CD2-AEF0-3AFAF1586EB7@codeaurora.org>
References: <E203B539-3481-435F-8D08-9C405DF42923@codeaurora.org>
 <20190613174331.GA19795@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jun 13, 2019, at 11:43 AM, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Jun 13, 2019 at 11:33:40AM -0600, Nasser Grainawi wrote:
> 
>> I have a situation where I need to delete 100k+ refs on 15+ separate
>> hosts/disks. This setup is using Gerrit replication, so I can trigger
>> it all on one host and it will push the deletes to the rest (all
>> running git-daemon v2.18.0 with receive-pack enabled). All the refs
>> being deleted on the receiving ends are packed.
>> 
>> What I see is the packed-refs file getting locked/updated over and
>> over for each ref. I had assumed it would do something more like
>> 'update-ref --stdin' and do a bulk removal of refs. Am I seeing the
>> correct behavior? If yes, is there a specific reason it works this way
>> or is "bulk delete through push" just a feature that hasn't been
>> implemented yet?
> 
> The underlying ref code is smart enough to coalesce all of the deletions
> in a single transaction into a single write of the packed-refs file.
> 
> But historically, pushes do not do a single ref transaction because we
> would allow the push for one ref to succeed while others failed. Later,
> we added an "atomic" mode that does it all in a single transaction.
> 
> Try with "git push --atomic", which should be able to do it in a single
> write.

Thanks!

Is there a way to get the bulk behavior without the all-or-nothing behavior?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project

