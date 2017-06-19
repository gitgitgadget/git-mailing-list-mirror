Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83D61FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbdFSRBd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:01:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:44642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750828AbdFSRBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:01:31 -0400
Received: (qmail 12947 invoked by uid 109); 19 Jun 2017 16:55:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 16:55:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29382 invoked by uid 111); 19 Jun 2017 17:01:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 13:01:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 13:01:24 -0400
Date:   Mon, 19 Jun 2017 13:01:24 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Git Mailinglist <git@vger.kernel.org>
Subject: Re: Restoring detached HEADs after Git operations
Message-ID: <20170619170124.6oj6stoojds4srci@sigill.intra.peff.net>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 08:46:45AM +0000, Patrick Lehmann wrote:

>   for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do
>     if [[ "$(git rev-parse "$Branch")" == $REF ]]; then
>       echo -e "  \e[36mCheckout $Branch...\e[0m"
>       git checkout $Branch
>       FOUND=1
>       break
>     fi
>   done

I see Lars pointed you at for-each-ref, which is the preferred way for
scripts to enumerate branches. But you can also use --points-at to skip
the inner part of your loop entirely, like:

  git for-each-ref --points-at=HEAD --format='%(refname:short)' refs/heads

That should run much faster, as it only has to spawn one process rather
than one for each branch (it will print all of them, of course. You can
pipe through head -n 1 to get the first, and check out --sort if you
want to prioritize by recency or similar).

-Peff
