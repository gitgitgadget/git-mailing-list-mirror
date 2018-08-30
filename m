Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DB41F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH3LGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:06:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3LGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:06:31 -0400
Received: (qmail 11537 invoked by uid 109); 30 Aug 2018 07:05:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:05:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24189 invoked by uid 111); 30 Aug 2018 07:05:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:05:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:05:48 -0400
Date:   Thu, 30 Aug 2018 03:05:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 0/5] handle corruption in patch-delta
Message-ID: <20180830070548.GA15081@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829205857.77340-1-jannh@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:58:55PM +0200, Jann Horn wrote:

> If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
> `memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
> into `dst_buf`.
> 
> This is not an exploitable bug because triggering the bug increments the
> `data` pointer beyond `top`, causing the `data != top` sanity check after
> the loop to trigger and discard the destination buffer - which means that
> the result of the out-of-bounds read is never used for anything.
> 
> Also, directly jump into the error handler instead of just breaking out of
> the loop - otherwise, data corruption would be silently ignored if the
> delta buffer ends with a command and the destination buffer is already
> full.

Based on my earlier observations, here's a replacement patch series I
came up with. It has:

  [1/5]: test-delta: read input into a heap buffer

    A simpler replacement for your patch 2 which avoids portability
    issues.

  [2/5]: t5303: test some corrupt deltas

    A more complete set of boundary tests based on the 4 cases I laid
    out, plus the cp_size problem I found.

  [3/5]: patch-delta: fix oob read

    Your actual fix.

  [4/5]: patch-delta: consistently report corruption

    Your related trailing-garbage fix. I split this into two in order to
    better demonstrate the cases this part covers.

  [5/5]: patch-delta: handle truncated copy parameters

    My fix for the cp_size read.

I hope you don't mind me hacking up your patches a bit. Thanks again for
your original report and patch.

-Peff
