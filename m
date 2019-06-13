Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E6A1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfFMRnh (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:43:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727259AbfFMRnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:43:35 -0400
Received: (qmail 3563 invoked by uid 109); 13 Jun 2019 17:43:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 17:43:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20495 invoked by uid 111); 13 Jun 2019 17:44:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 13:44:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 13:43:32 -0400
Date:   Thu, 13 Jun 2019 13:43:32 -0400
From:   Jeff King <peff@peff.net>
To:     Nasser Grainawi <nasser@codeaurora.org>
Cc:     git@vger.kernel.org
Subject: Re: git receive-pack deletes refs one at a time?
Message-ID: <20190613174331.GA19795@sigill.intra.peff.net>
References: <E203B539-3481-435F-8D08-9C405DF42923@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E203B539-3481-435F-8D08-9C405DF42923@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 11:33:40AM -0600, Nasser Grainawi wrote:

> I have a situation where I need to delete 100k+ refs on 15+ separate
> hosts/disks. This setup is using Gerrit replication, so I can trigger
> it all on one host and it will push the deletes to the rest (all
> running git-daemon v2.18.0 with receive-pack enabled). All the refs
> being deleted on the receiving ends are packed.
> 
> What I see is the packed-refs file getting locked/updated over and
> over for each ref. I had assumed it would do something more like
> 'update-ref --stdin' and do a bulk removal of refs. Am I seeing the
> correct behavior? If yes, is there a specific reason it works this way
> or is "bulk delete through push" just a feature that hasn't been
> implemented yet?

The underlying ref code is smart enough to coalesce all of the deletions
in a single transaction into a single write of the packed-refs file.

But historically, pushes do not do a single ref transaction because we
would allow the push for one ref to succeed while others failed. Later,
we added an "atomic" mode that does it all in a single transaction.

Try with "git push --atomic", which should be able to do it in a single
write.

-Peff
