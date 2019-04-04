Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3893420248
	for <e@80x24.org>; Thu,  4 Apr 2019 12:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDDMBN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 08:01:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:46596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726269AbfDDMBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 08:01:12 -0400
Received: (qmail 26771 invoked by uid 109); 4 Apr 2019 12:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 12:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16035 invoked by uid 111); 4 Apr 2019 12:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 08:01:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 08:01:08 -0400
Date:   Thu, 4 Apr 2019 08:01:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190404120108.GA22324@sigill.intra.peff.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net>
 <xmqqo95mf80j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo95mf80j.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 06:13:16PM +0900, Junio C Hamano wrote:

> >> Similar to git commit, it would be nice to have a --no-edit option for
> >> git tag. Use case is when I force-recreate a tag:
> >> 
> >> $ git tag -af 1.0 123abc
> >> 
> >> An editor will be prompted with the previous annotated tag message. I
> >> would like to add --no-edit to instruct it to use any previously
> >> provided message and without prompting the editor:
> >> 
> >> $ git tag --no-edit -af 1.0 123abc
> >
> > Yeah, that sounds like a good idea.
> 
> I am not so sure this is a good idea, especially if the plan is to
> do this alone without necessary associated change to make things
> consistent.

I think I may have misunderstood the request.

I thought it was "we already do this re-use the tag message thing, but
--no-edit is broken". And the proposal was to fix --no-edit. Which is
definitely broken, and it seems like a no-brainer to fix.

But looking at the code, yeah, I see that we do not do that. The
proposal is to implement both halves. And...

> The part that bothers me most is use of "-f".  The mentalitly behind
> "-f" is "I am creating a new and tag that is totally unrelated to
> any existing tag, but since the command refuses to reuse the ref to
> point at my new tag, I am giving an '-f' to force (1) unpointing the
> existing unrelated tag and (2) pointing the enwly created tag with
> that tagname".
> 
> The proposed change still uses "-f" but wants to somehow take the
> tag message from the unrelated tag that happens to sit at the same
> place as the new tag wants to go.  That breaks the mental model a
> big way.
> 
> If this were a new option that is spelled "--amend", I won't
> be complaining, though.

Yes, I agree with all of this. Calling it "--amend" is much better
(and/or adding the equivalent of "commit -c" to pick up the message from
an existing tag, though maybe "--amend existing-name new-target" would
be enough to repoint a tag with the same name).

-Peff
