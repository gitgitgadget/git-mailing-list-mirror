Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D701F42D
	for <e@80x24.org>; Wed, 23 May 2018 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbeEWRct (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 13:32:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:50382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932667AbeEWRcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 13:32:48 -0400
Received: (qmail 16643 invoked by uid 109); 23 May 2018 17:32:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 May 2018 17:32:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16844 invoked by uid 111); 23 May 2018 17:32:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 May 2018 13:32:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2018 13:32:46 -0400
Date:   Wed, 23 May 2018 13:32:46 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Kevin Bracey <kevin@bracey.fi>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Weird revision walk behaviour
Message-ID: <20180523173246.GA10299@sigill.intra.peff.net>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 07:10:58PM +0200, SZEDER Gábor wrote:

>   $ git log --oneline master..ba95710a3b -- ci/
>   ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2
> 
> But as far as I can tell, there are no changes in the 'ci/' directory
> on any of the merge's parents:
> 
>   $ git log --oneline master..ea44c0a594^1 -- ci/
>   # Nothing.
>   $ git log --oneline master..ea44c0a594^2 -- ci/
>   # Nothing!

Hmm. That commit does touch "ci/" with respect to one of its parents.
It should get simplified away because it completely matches the other
parent, so it does sound like a bug.

> This is not specific to the 'ci/' directory, it seems that any
> untouched directory does the trick:
> 
>   $ git log --oneline master..ea44c0a594 -- contrib/coccinelle/ t/lib-httpd/
>   ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2

Both of those directories also differ between one parent. If you try it
with "contrib/remote-helpers", which does not, then the commit does not
appear.

So it does seem like a bug where we should be simplifying away the merge
but are not (or I'm missing the corner case, too ;) ).

> I get the same behavior with Git built from current master and from
> past releases as well (tried it as far back as v2.0.0).

I keep some older builds around, and it does not reproduce with v1.6.6.3
(that's my usual goto for "old"). Bisecting turns up d0af663e42
(revision.c: Make --full-history consider more merges, 2013-05-16).  It
looks like an unintended change (the commit message claims that the
non-full-history case shouldn't be affected).

-Peff
