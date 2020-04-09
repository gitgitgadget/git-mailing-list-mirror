Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65783C2BB86
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C5420B1F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgDIOAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:00:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726940AbgDIOAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 10:00:00 -0400
Received: (qmail 19103 invoked by uid 109); 9 Apr 2020 14:00:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 14:00:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18324 invoked by uid 111); 9 Apr 2020 14:10:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 10:10:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 09:59:59 -0400
From:   Jeff King <peff@peff.net>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [git 2.26] stat counts reported by commit and log are different
Message-ID: <20200409135959.GB3494212@coredump.intra.peff.net>
References: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 07:04:02PM -0700, Norbert Kiesel wrote:

> % git commit -m 'major code cleanup for SCIMPatchOperationUtil'
> [nkiesel/nextrelease/SCIM_2 d4db6f6d83f] major code cleanup for
> SCIMPatchOperationUtil
>  1 file changed, 2106 insertions(+), 3367 deletions(-)
>  rewrite utils/SCIMPatchOperationUtil.java (74%)

The commit summary diff is done with the break-detection option on. You
can tell it kicked in here because of the "rewrite" line. What that
means is that the changes to the file were so extensive that Git decided
the file had been totally rewritten, and broke it into a separate
add/delete. That has two implications:

  - we'd consider it a candidate for rename detection; that didn't
    happen here because there were no other files added or deleted to
    serve as source/dest candidates

  - the diff will be reported as a complete removal of the old content
    and the addition of the new, _even for lines that were the same_

> % git log --stat -1
> commit d4db6f6d83f (HEAD -> nkiesel/nextrelease/SCIM_2)
> Author: Norbert Kiesel <nkiesel@metricstream.com>
> Date:   Wed Apr 8 18:49:27 2020 -0700
> 
>     major code cleanup for SCIMPatchOperationUtil
> 
>  utils/SCIMPatchOperationUtil.java | 3807
> +++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------
>  1 file changed, 1273 insertions(+), 2534 deletions(-)

But in git-log break-detection isn't on by default. Try adding "-B" and
you will get the other numbers.

Try also adding "-p" to see the whole-diff in action.

-Peff
