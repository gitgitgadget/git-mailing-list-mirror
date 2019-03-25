Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD9420248
	for <e@80x24.org>; Mon, 25 Mar 2019 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfCYOtd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 10:49:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:35042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726128AbfCYOtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 10:49:33 -0400
Received: (qmail 320 invoked by uid 109); 25 Mar 2019 14:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 14:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8250 invoked by uid 111); 25 Mar 2019 14:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 10:49:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 10:49:31 -0400
Date:   Mon, 25 Mar 2019 10:49:31 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
Message-ID: <20190325144930.GA19929@sigill.intra.peff.net>
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net>
 <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 08:50:14AM -0500, Robert Dailey wrote:

> On Thu, Mar 21, 2019 at 2:29 PM Jeff King <peff@peff.net> wrote:
> > Tags can point to any object, including another tag. It looks like
> > somebody made an annotated tag of an annotated tag (probably by
> > mistake, given that they have the same tag-name).
> [..]
> Thanks for explaining. This is very helpful. Am I naive to think that
> this should be an error? I haven't seen a valid _pragmatic_ use for
> tags pointing to tags. In 100% of cases (including this one), it is
> done out of error. As per your example, users try to "correct" an
> annotated tag pointing at a wrong tag or commit. What they expect is
> the tag to point to the other tag's commit, but that's not what they
> get.

I don't think I've ever seen a tag-to-a-tag in the wild, but I wouldn't
be surprised if somebody has found a use for it. For example, because
tags can be signed, I can make a signature of your signature, showing a
cryptographic chain of custody.

And at any rate, it has been allowed in the data model for almost 15
years, so I think disallowing it now would be a bad idea. It might be
acceptable to introduce a safety valve into the porcelain, though.

> From a high-level, pragmatic perspective, doesn't it make more sense
> to change the git behavior so that annotated tags may only point to
> commit objects? And in the `git tag -f -m outer mytag mytag` case in
> your example, this would automatically perform `mytag^{}` to ensure
> that the behavior the user expects is the behavior they get?

I think "just commits" is too restrictive. linux.git contains a tag of a
tree, for example (we also have tags pointing to blobs in git.git, but
they are not annotated).

However, I could see an argument for the git-tag porcelain to notice a
tag-of-tag and complain. Probably peeling the tag automatically is a bad
idea, just because it behaved differently for so long. But something
like might be OK:

  $ git tag -a mytag
  error: refusing to make a recursive tag
  hint: The object 'mytag' referred to by your new tag is already a tag.
  hint:
  hint: If you meant to create a tag of a tag, use:
  hint:
  hint:  git tag -a -f mytag
  hint:
  hint: If you meant to tag the object that it points to, use:
  hint:
  hint:  git tag -a mytag^{}

It would be a minor annoyance to somebody who frequently makes
tags-of-tags, but it leaves them with an escape hatch.

-Peff
