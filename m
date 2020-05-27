Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A2AC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA93D208C3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgE0XD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:03:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:58254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0XD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:03:58 -0400
Received: (qmail 24606 invoked by uid 109); 27 May 2020 23:03:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 23:03:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9137 invoked by uid 111); 27 May 2020 23:03:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 19:03:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 19:03:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Merlin =?utf-8?B?QsO8Z2U=?= <toni@bluenox07.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout -p: handle new files correctly
Message-ID: <20200527230357.GB546534@coredump.intra.peff.net>
References: <pull.646.git.1590613746507.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.646.git.1590613746507.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 09:09:06PM +0000, Johannes Schindelin via GitGitGadget wrote:

> However, since the same machinery was used for `git checkout -p` &
> friends, we can see new files.
> 
> Handle this case specifically, adding a new prompt for it that is
> modeled after the `deleted file` case.

Thanks! I was planning to dig further into this topic today, and here it
is all wrapped up with a bow. :)

>  add-patch.c                | 30 +++++++++++++++++++++++-------
>  git-add--interactive.perl  | 21 +++++++++++++++++++--

Ooh, you even fixed the perl version, too. I was just going to leave it
in the dust and add a test that set GIT_TEST_ADD_I_USE_BUILTIN.

Both versions look good, and are similar to what I expected from looking
at it last night.

> The original patch selection code was written for `git add -p`, and the
> fundamental unit on which it works is a hunk.
> 
> We hacked around that to handle deletions back in 24ab81ae4d
> (add-interactive: handle deletion of empty files, 2009-10-27). But `git
> add -p` would never see a new file, since we only consider the set of
> tracked files in the index.

I lied a little with "would never see a new file". There _is_ a related
case with "add -p" that might be worth thinking about: intent-to-add
files.

  $ git init
  $ >empty
  $ echo content >not-empty
  $ git add -N .
  $ git add -p
  diff --git a/not-empty b/not-empty
  index e69de29..d95f3ad 100644
  --- a/not-empty
  +++ b/not-empty
  @@ -0,0 +1 @@
  +content
  (1/1) Stage this hunk [y,n,q,a,d,e,?]? n

  [no mention of empty file!]

I think the culprit here is diff-files, though, which doesn't show a
patch for intent-to-add:

  $ git diff-files
  :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	empty
  :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	not-empty

  $ git diff-files -p
  diff --git a/not-empty b/not-empty
  index e69de29..d95f3ad 100644
  --- a/not-empty
  +++ b/not-empty
  @@ -0,0 +1 @@
  +content

I don't think this really intersects with the patch here at all, because
diff-files is not producing "new file" lines for these entries (even for
the non-empty one).

The solution _might_ be to convince diff-files to treat i-t-a entries as
creations. And then with your patch here, we'd naturally do the right
thing. So I don't think this needs to hold up your patch in any way, nor
do we necessarily need to deal with i-t-a now. I was mostly curious how
they worked, since we don't support added files. The answer is just that
they don't always. ;)

-Peff
