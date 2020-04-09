Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA5C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA42074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgDIWrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:47:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:38752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726897AbgDIWrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:47:48 -0400
Received: (qmail 22134 invoked by uid 109); 9 Apr 2020 22:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 22:47:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23621 invoked by uid 111); 9 Apr 2020 22:58:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 18:58:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 18:47:47 -0400
From:   Jeff King <peff@peff.net>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [git 2.26] stat counts reported by commit and log are different
Message-ID: <20200409224747.GA4173825@coredump.intra.peff.net>
References: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
 <20200409135959.GB3494212@coredump.intra.peff.net>
 <CAM+g_NuZ3pKAd80+HoR8-_0=N9wV28L-yyb1VhJhTbYH+RS0og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_NuZ3pKAd80+HoR8-_0=N9wV28L-yyb1VhJhTbYH+RS0og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 02:58:25PM -0700, Norbert Kiesel wrote:

> Thanks for the explanation. I still wonder why break-detection is by
> default enabled for commit but disabled for log.  Is there any
> rationale for this?

It's enabled for commit, because it was enable for git-status, via
3eb2a15eb3 (builtin-commit: make summary output consistent with status,
2007-12-16). It was enabled for status because it makes rename detection
more accurate; see the discussion at the end of this thread:

  https://lore.kernel.org/git/20071121171235.GA32233@sigill.intra.peff.net/

That tells us why it _is_ enable for commit, but not why it's not for
log. Traditionally rename detection was _not_ enabled by default there.
Because it can be expensive, we were quicker to enable it for
single-diff commands like commit (as opposed to log, which is doing a
bunch of diffs).

Much later, in 5404c116aa (diff: activate diff.renames by default,
2016-02-25), we turned on renames by default for git-log. But as far as
I recall, nobody gave much thought to turning on break detection at the
same time.

It might make sense to do so (and/or to make it possible to enable it by
config like we did for years with diff.renames). But it definitely is
way more expensive. For a tree-only diff, we don't usually have to look
at most blobs at all. Even with rename detection, we only have to look
at inexact rename candidates. But break detection must look at every
single modified file (timings are on git.git):

  [no renames at all, pretty fast]
  $ time git log --no-renames --raw >/dev/null
  real	0m2.231s
  user	0m2.203s
  sys	0m0.028s

  [adding in renames isn't very expensive]
  $ time git log -M --raw >/dev/null
  real	0m2.284s
  user	0m2.224s
  sys	0m0.060s

  [but break detection is]
  $ git log -B -M --raw >/dev/null
  real	0m33.377s
  user	0m32.942s
  sys	0m0.424s

A more fair comparison would actually generate content-level diffs,
which need to look in the blobs, like:

  $ time git log -M -p >/dev/null
  real	0m23.287s
  user	0m22.854s
  sys	0m0.432s

  $ time git log -B -M -p >/dev/null
  real	0m49.763s
  user	0m49.282s
  sys	0m0.480s

So not quite as bad percentage-wise, but still pretty expensive. And for
not a huge benefit. There are ~261 impacted commits. You can see a
recent example with:

  git show -B -M --stat --summary ce6521e44

where we find that most of builtin/fmt-merge-msg.c was moved to
fmt-merge-msg.c. It's nice, but it's expensive enough that it probably
shouldn't be the default.

-Peff
