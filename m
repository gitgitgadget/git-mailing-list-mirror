Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B60C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D294764E76
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSRFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:05:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:38800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSRFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 12:05:21 -0500
Received: (qmail 943 invoked by uid 109); 19 Feb 2021 17:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Feb 2021 17:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2184 invoked by uid 111); 19 Feb 2021 17:04:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Feb 2021 12:04:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Feb 2021 12:04:40 -0500
From:   Jeff King <peff@peff.net>
To:     John Ratliff <john@technoplaza.net>
Cc:     git@vger.kernel.org
Subject: Re: git credential cache timeout questions
Message-ID: <YC/vqJBSnDHoLIdJ@coredump.intra.peff.net>
References: <CAP8UukiL0niGSm3o7uYNBzL3FP-UEgfOuq-Tu=fksWJkerT5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UukiL0niGSm3o7uYNBzL3FP-UEgfOuq-Tu=fksWJkerT5fg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 19, 2021 at 10:46:48AM -0500, John Ratliff wrote:

> I have configured my git to cache my credentials for 12 hours using
> this section in my .gitconfig
> 
> [credential "https://mygithub.example.edu"]
>     username = myuser
>     helper = cache --timeout 43200
> 
> However, the credentials don’t always seem to expire after 12 hours.
> Sometimes I come back the next morning and the credentials still work.
> This is generally after leaving at 5:00 PM and coming back in the next
> day at 9:00 AM, well past the 12 hour timeout.
> 
> Is there any way to see the current timeout value? Is it a rolling
> timeout (i.e. any git action resets the timeout)?

It's the "rolling" thing, though the source is a bit subtle. The
credential-cache helper sets an absolute expiration when the value is
stored, and it doesn't update it on a "get" request.

However, Git's interaction with the helpers is generally:

  - when we need a credential ask for one

  - when a credential is rejected by a server, tell helpers to erase it

  - when a credential is accepted by a server, tell helpers to store it

And it's that last one that provides the rolling timeout, because we do
it even if the credential came from a helper in the first place!

I actually wrote a patch long ago to switch this behavior:

  https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.net/

But it turned out some people actually rely on it. :)

There's some discussion in that thread about paths forward, and I think
I even played around with it back then. But then it sat on my todo list,
and now it has been 9 years, so I don't remember if there were good
reasons not to push it forward, or if I simply never got around to it (I
suspect the latter; nobody had a pressing use case that was solved by
avoiding the rolling timeouts, it just seemed to me to be a bit less
surprising). I'd be happy if somebody wanted to revisit the topic.

(To your other question, "is there a way to see the timeout value", the
answer is "not really, without running it under gdb". I wouldn't be
opposed to adding more diagnostic output to the daemon. But you can also
see some of what's going on by setting GIT_TRACE=1 in the environment,
which will show the extra "store" operation being done by Git).

-Peff
