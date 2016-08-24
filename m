Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38A21F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbcHXVku (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:40:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:60772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754546AbcHXVku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:40:50 -0400
Received: (qmail 27986 invoked by uid 109); 24 Aug 2016 21:39:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 21:39:04 +0000
Received: (qmail 7266 invoked by uid 111); 24 Aug 2016 21:39:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:39:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 17:39:01 -0400
Date:   Wed, 24 Aug 2016 17:39:01 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Nauda <alex@alexnauda.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: on Amazon EFS (NFS): "Reference directory conflict: refs/heads/"
 with status code 128
Message-ID: <20160824213900.gcnwxu46zvgpjr5a@sigill.intra.peff.net>
References: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 04:52:33PM -0400, Alex Nauda wrote:

> Elastic File System (EFS) is Amazon's scalable filesystem product that
> is exposed to the OS as an NFS mount. We're using EFS to host the
> filesystem used by a Jenkins CI server. Sometimes when Jenkins tries
> to git fetch, we get this error:
> $ git -c core.askpass=true fetch --tags --progress
> git@github.com:mediasilo/dodo.git
> +refs/pull/*:refs/remotes/origin/pr/*
> fatal: Reference directory conflict: refs/heads/
> $ echo $? 128
> 
> Has anyone seen anything like this before? Any tips on how to troubleshoot it?

No, I haven't seen it before. That's an internal assertion in the refs
code that shouldn't ever happen. It looks like it happens when the loose
refs end up with duplicate directory entries. While a bug in git is an
obvious culprit, I wonder if it's possible that your filesystem might
expose the same name twice in one set of readdir() results.

+cc Michael, who added this assertion long ago (and since this is the
first report in all these years, it does make me suspect that the
filesystem is a critical part of reproducing).

-Peff
