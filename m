Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F6C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D14A610A2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhETNaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 09:30:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:60412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhETN35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 09:29:57 -0400
Received: (qmail 27410 invoked by uid 109); 20 May 2021 13:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 13:28:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31478 invoked by uid 111); 20 May 2021 13:28:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 09:28:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 09:28:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKZj/s/9dp4Oo7aB@coredump.intra.peff.net>
References: <YKWggLGDhTOY+lcy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKWggLGDhTOY+lcy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 04:34:24PM -0700, Jonathan Nieder wrote:

> One kind of signal we haven't been able to make good use of is error
> rates.  The problem is that a die() call can be an indication of
> 
>  a. the user asked to do something that isn't sensible, and we kindly
>     rebuked the user
> 
>  b. we contacted a server, and the server was not happy with our
>     request
> 
>  c. the local Git repository is corrupt
> 
>  d. we ran out of resources (e.g., disk space)
> 
>  e. we encountered an internal error in handling the user's
>     legitimate request

I've run into this problem, too. If you run a website that runs Git
commands on behalf of users and try to get metrics on failing exit
codes, it's hard to tell the difference between "the repo is broken",
"Git has a bug", "the user (or other caller) asked for something
stupid", and "some transient error occurred".

But I'm not sure that even Git can always tell the difference between
those things. Some real-world examples I've run into:

  - "rev-list $oid" can't find object $oid. Is the repo corrupt? Or is
    the caller unreasonable to ask for that object? Or was there a race
    or other transient error which made the object invisible?

  - upload-pack is writing out a packfile, but gets EPIPE. Did the
    network drop out? Or is a Git bug causing one side to break
    protocol?

Some rough categorization may help, but a lot of those need to propagate
the specific errors back to the caller. For instance, the rev-list
example could be FAILED_PRECONDITION in your terminology. But really, we
want to tell the caller "the object you asked for doesn't exist". And
then it can decide if that was user error (somebody hitting a URL for an
object that we have no reason to think exists), or a sign of problems
elsewhere in the system (if we just got $oid from Git, we expect it to
be there).

So it seems like the most useful thing is specific error codes for
specific cases. And that gets very daunting to think about annotating
and communicating about each such case (we don't even pass that level of
detailed information inside the program in a machine-readable way;
scraping stderr is the best way to figure this stuff out now).

I dunno. Maybe a rougher categorization would help your case, but not
mine. But I'm a bit skeptical that we'll have enough coverage of various
conditions to be useful, and that it won't turn into a headache trying
to categorize everything.

-Peff
