Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B66C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14012073A
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgGUQGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:06:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:34320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgGUQGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 12:06:44 -0400
Received: (qmail 474 invoked by uid 109); 21 Jul 2020 16:06:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jul 2020 16:06:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23322 invoked by uid 111); 21 Jul 2020 16:06:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jul 2020 12:06:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Jul 2020 12:06:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [BUG?] shallow-since can't handle merges
Message-ID: <20200721160643.GA3288097@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came across an interesting case where the shallow code doesn't do do
the right thing. From my reading, it doesn't look like it could possibly
work, but I also don't understand the shallow feature very well, so here
we are. :)

To reproduce:

  # make a copy of the "upstream" repo; you can also fetch directly from
  # it, but having it locally lets you poke at both sides of the
  # conversation
  git clone --bare https://github.com/DefinitelyTyped/DefinitelyTyped upstream.git

  # now make a local copy of a related repo
  git clone --bare --depth=1 https://github.com/Maxim-Mazurok/DefinitelyTyped --no-single-branch repo.git
  cd repo.git

  # and then try to deepen down to this date. This is early morning on
  # May 9 2020.
  git remote add upstream ../upstream.git
  git fetch upstream master --shallow-since=1589000000

The resulting history you get is cut off at May 12, even though there
are parent commits between May 9 and May 12 that should be included.

Here's what the graph in upstream.git looks like:

  $ git log --all --graph --format='%cd %h' --date=iso-local
  * 2020-07-21 13:31:19 +0000 3e7ef84b0a
  * 2020-07-21 02:15:25 +0000 97f6a9df78
  [...]
  * 2020-05-12 23:57:33 +0000 9a0645f52a
  *   2020-05-12 23:55:43 +0000 c7883f4581
  |\
  | * 2020-04-28 17:17:56 +0000 a4b68cbe3a
  * |   2020-05-12 23:50:34 +0000 9d282b0d7d
  |\ \
  | * | 2020-05-05 23:53:20 +0000 daf04e0dcb
  | * | 2020-05-05 23:53:18 +0000 4b2129de54
  * | | 2020-05-12 22:56:55 +0000 c599db54c9
  * | | 2020-05-12 22:04:29 +0000 5bf87114a9
  [...]
  * | | 2020-05-09 09:25:35 +0000 f258742372
  * | | 2020-05-09 08:55:55 +0000 9c96a1cd72
  * | | 2020-05-08 19:55:36 +0000 77f55bc175
  [...]

So the actual "bottom" that we should send is 9c96a1cd72. But the
history we get only goes down to c7883f4581. The tricky thing, though,
is that that commit is a merge. The first parent is still something we
want to send, but the second parent is too old. And then the merge at
9d282b0d7d has the same thing. The first parent is recent, but the
second parent is old.

I walked through upload-pack in a debugger, and its procedure looks
sane. It does a revision walk with --max-age to come up with a list of
"not shallow" commits, which include all three of those, as well as the
commits in between. And then for each not-shallow commit, it sees if any
parents weren't visited, in which case we know we have a boundary. So
that commit gets marked as "shallow", to indicate that it will have its
parents truncated. In this case, all three of the commits I mentioned
get this. And indeed, if we use GIT_TRACE_PACKET, we can see that it
mentions them (and only them):

  packet:  upload-pack> shallow c7883f4581688909baf65c1219a8e842e369150b
  packet:  upload-pack> shallow 9d282b0d7d2e05d7324e70afa66c4ff1306e67b7
  packet:  upload-pack> shallow 9c96a1cd729d0209ba696f225b42d8aafd27295b

But here's the thing. We _don't_ want to mark those first two merges as
fully shallow. We only want to ignore their second parents, but let them
continue to traverse the first parents.

I'm not sure if the shallow mechanism or protocol is even capable of
representing a partial graft like that. Maybe somebody who's more
familiar with the shallow system can comment?

-Peff
