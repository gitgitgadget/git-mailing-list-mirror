Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A081F404
	for <e@80x24.org>; Thu, 13 Sep 2018 10:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeIMPXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 11:23:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37435 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeIMPXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 11:23:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so4793176qtl.4
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 03:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbY01+xWGnRmAVk4SHXPI9SRkssNDJLd926KsNU/GkM=;
        b=PWjDgXFQfVvB9xp0u13mW+UzlZKKF3ODDXTYNjXH1qmFoBDFJm2WUNWDCHedgYPa+F
         dx4YOuuEl7jrfum5siDPzXRoQMo3+MVHID5k2WmuN7uWA0IupGbruffv+sGqF0MJyU8W
         8fg7zae9v830+GCam2TmOSeKSjVSZ2rY3f6x7gCCQNGWS65B/slBrMgBuHZ0BpenRsaQ
         J5j9rnZnS2TXUYXM07SYCdgUhULw0ybm3XiEVFDMMxRNm+2J26Q5E3IBttbt3X1vYDt8
         2M3JlZXwNBhnWIyaCzYOAHn6u2x27g38OHhsZu2Uepac/Sk87ZvWBsAa3oMkjFqJFl1M
         yf4g==
X-Gm-Message-State: APzg51Dq5XvQfujEcXE8cZlvB8a+q69QVssa909tDSuMv6w/iKssvW2w
        /SgXtUhxCAAufcytF06z1012908B1GNs9tDF5F0=
X-Google-Smtp-Source: ANB0VdakpGA/FwpTtIqB/cVKPSnQ8cjE4ZtK199+TW1XzLhn9/tBCOxvz+QqWtgCrx7AO+wLg5yv+Bn5cRO/Gnv7IrU=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr4651561qtd.101.1536833663457;
 Thu, 13 Sep 2018 03:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com> <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com> <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com> <20180912190108.GE4865@hank.intra.tgummerer.com>
In-Reply-To: <20180912190108.GE4865@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Sep 2018 06:14:12 -0400
Message-ID: <CAPig+cRZm6iznBzBF1pwj1v12XX=Q_jzLxSLjWpEMja73r_juw@mail.gmail.com>
Subject: Re: [PATCH] linear-assignment: fix potential out of bounds memory
 access (was: Re: Git 2.19 Segmentation fault 11 on macOS)
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, ryenus@gmail.com,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 3:01 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Subject: [PATCH] linear-assignment: fix potential out of bounds memory access
>
> Currently the 'compute_assignment()' function can may read memory out

"can may"?

> of bounds, even if used correctly.  Namely this happens when we only
> have one column.  In that case we try to calculate the initial
> minimum cost using '!j1' as column in the reduction transfer code.
> That in turn causes us to try and get the cost from column 1 in the
> cost matrix, which does not exist, and thus results in an out of
> bounds memory read.
