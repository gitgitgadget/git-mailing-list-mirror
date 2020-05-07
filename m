Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9CC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6E208DB
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGTmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:42:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbgEGTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:42:25 -0400
Received: (qmail 2057 invoked by uid 109); 7 May 2020 19:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 19:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21273 invoked by uid 111); 7 May 2020 19:42:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 15:42:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 15:42:24 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: tags sorted by their depth, *committerdate, and taggerdate
Message-ID: <20200507194224.GB25306@coredump.intra.peff.net>
References: <CAGqZTUujRh-f-83A8NYokbxLGZ-bnvGrtguzJsMdg9EX04NsGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGqZTUujRh-f-83A8NYokbxLGZ-bnvGrtguzJsMdg9EX04NsGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 08:16:35PM +0200, clime wrote:

> I have some very specific requirements to get annotated tags sorted in
> a certain way. I would like them to be sorted:
> - primarily by their depth (i.e. how far they are from current HEAD
> and if they are not reachable then they should not be displayed).
> - secondarily by committerdate of the commit they are associated with
> - ternarily by taggerdate

There's no way to compute the depth with for-each-ref or similar. In
fact, I'm not even sure of a way to do it for all tags with a single
command. So I'd probably script something like:

  git for-each-ref \
    --format='%(*committerdate:unix) %(taggerdate:unix) %(refname)' \
    refs/tags |
  while read cdate tdate ref; do
    depth=$(git rev-list --count --ancestry-path $ref..HEAD)

    # if depth is 0, then either $ref isn't an ancestor of HEAD, or $ref
    # points to the same commit as HEAD. Not sure if you want to salvage
    # the latter case, but you could compare rev-parse output on the
    # two.
    if test "$depth" = 0; then
      continue
    fi

    echo "$depth $cdate $tdate $ref"
  done |
  sort -k 3rn -k 2rn -k 1n

But it's kind of expensive (we'd walk over the history near HEAD
multiple times, once per tag).

It seems like git-describe should be able to do a better job of the
traversal, but I had trouble convincing it to do so.

> Is something like that possible?
> Is something like that possible even with git 1.7.1?

You'd need v1.7.2 for --ancestry-path. You could just use "$ref..HEAD"
without it, and instead do:

  git merge-base --is-ancestor $ref HEAD

to cover the case where they aren't reachable from HEAD. But of course
that's an extra traversal per tag.

I'm not sure why you need to use such an antique version of Git.

> If this isn't possible, I am thinking I could write some simple
> utility in C to do it but can I rely on certain binary format of
> commit and tag objects? Has the format changed at some point since git
> 1.7.1? Is there a git library I could use for it? Or is the format
> documented somewhere?

Doing better would require a custom traversal of the commits. You could
look something with libgit2 (which is in C, but has bindings to some
other languages).

-Peff
