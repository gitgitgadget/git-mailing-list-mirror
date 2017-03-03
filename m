Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7522013E
	for <e@80x24.org>; Fri,  3 Mar 2017 05:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbdCCFvL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 00:51:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:37684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdCCFvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 00:51:11 -0500
Received: (qmail 1590 invoked by uid 109); 3 Mar 2017 04:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:51:04 +0000
Received: (qmail 24701 invoked by uid 111); 3 Mar 2017 04:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 23:51:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 23:51:01 -0500
Date:   Thu, 2 Mar 2017 23:51:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/9] read_early_config(): special-case builtins that
 create a repository
Message-ID: <20170303045101.om7qtbcmtuw6kzvr@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <33e692918c8d41507de5ec2b2e2d55982678408e.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33e692918c8d41507de5ec2b2e2d55982678408e.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:24AM +0100, Johannes Schindelin wrote:

> When the command we are about to execute wants to create a repository
> (i.e. the command is `init` or `clone`), we *must not* look for a
> repository config.

Hmm. I'm not sure if this one is worth the hackery here.

Yes, it would be wrong for init or clone to read something like
core.sharedrepository from a repo it happens to be in. But I wonder if
it would be cleaner to consider calls to read_early_config their own
"pre-command" stage that may respect global config, or config in a repo
directory you happen to be sitting in.

Because I think for aliases, we're going to end up having to do that
anyway (you won't know that your alias is "clone" until you've resolved
it!). And I think the pager fits into this "pre-command" concept, too
(we already have "-p" as a pre-command option on the command-line).

I dunno. It probably doesn't matter _too much_ either way. But it's one
less hack to maintain going forward, and it also makes your "git-init
respects the pager" into the normal, consistent thing.

-Peff
