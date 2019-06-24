Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042E31F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfFXS6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:58:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:49028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727984AbfFXS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:58:37 -0400
Received: (qmail 17009 invoked by uid 109); 24 Jun 2019 18:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jun 2019 18:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13545 invoked by uid 111); 24 Jun 2019 18:59:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Jun 2019 14:59:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jun 2019 14:58:35 -0400
Date:   Mon, 24 Jun 2019 14:58:35 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] Symbolic links break "git fast-export"?
Message-ID: <20190624185835.GA11720@sigill.intra.peff.net>
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 06:33:38AM -0600, Elijah Newren wrote:

> We should probably also make a corresponding improvement to
> fast-import; it also makes some attempts to be smart about handling
> order of modifies and deletes, but misses this case.  See commit
> 253fb5f8897d ("fast-import: Improve robustness when D->F changes
> provided in wrong order", 2010-07-09).  It'd be nice if fast-import
> could go through the list of changes, apply the deletes first, then
> the modifies -- although I'm not sure where renames go in the order
> off the top of my head.

You'd have to split the renames into separate delete/adds, since they
can have a circular dependency. E.g. renaming "foo" to "bar" and "bar"
to "foo", you must remove "foo" and "bar" both, and then add them back
in.

-Peff
