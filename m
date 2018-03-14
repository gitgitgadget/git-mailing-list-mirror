Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C9B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeCNWUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:20:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751362AbeCNWUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:20:31 -0400
Received: (qmail 9455 invoked by uid 109); 14 Mar 2018 22:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Mar 2018 22:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9766 invoked by uid 111); 14 Mar 2018 22:21:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Mar 2018 18:21:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2018 18:20:29 -0400
Date:   Wed, 14 Mar 2018 18:20:29 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to debug a "git merge"?
Message-ID: <20180314222028.GA20977@sigill.intra.peff.net>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 05:56:04PM +0100, Lars Schneider wrote:

> I am investigating a Git merge (a86dd40fe) in which an older version of 
> a file won over the newer version. I try to understand why this is the 
> case. I can reproduce the merge with the following commands:
> $ git checkout -b test a02fa3303
> $ GIT_MERGE_VERBOSITY=5 git merge --verbose c1b82995c
> 
> The merge actually generates a merge conflict but not for my
> problematic file. The common ancestor of the two parents (merge base) 
> is b91161554.
> 
> The merge graph is not pretty (the committers don't have a clean 
> branching scheme) but I cannot spot a problem between the merge commit
> and the common ancestor:
> $ git log --graph --oneline a86dd40fe
> 
> Can you give me a hint how to debug this merge further? How can I 
> understand why Git picked a certain version of a file in a merge?

Maybe a stupid question, but: did you make sure that the merge does
indeed pick the wrong version of the file? The other option is that
somebody mistakenly did a "checkout --ours" or similar while resolving
the conflict.

If the wrong file is indeed picked by the merge, then you may want to
try switching merge drivers. E.g., "-s resolve" is a bit simpler and
stupider than the default merge-recursive. If the problem goes away,
then we know it's a possible bug in merge-recursive (or maybe a
confusing implication of its strategy). If the problem is still there
with "resolve", then at least it may be easier to debug. ;)

-Peff
