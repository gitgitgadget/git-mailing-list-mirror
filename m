Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41762C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFDE6142E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFOJpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:55794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhFOJpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:45:21 -0400
Received: (qmail 7230 invoked by uid 109); 15 Jun 2021 09:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 09:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12272 invoked by uid 111); 15 Jun 2021 09:43:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 05:43:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 05:43:15 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
Message-ID: <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 05:16:08AM +0000, Elijah Newren via GitGitGadget wrote:

> Implement a zealous diff3, or "zdiff3". This new mode is identical to
> ordinary diff3 except that it allows compaction of common lines between the
> two sides of history, if those common lines occur at the beginning or end of
> a conflict hunk.
> 
> This is just RFC, because I need to add tests. Also, while I've remerged
> every merge, revert, or duly marked cherry-pick from both git.git and
> linux.git with this patch using the new zdiff3 mode, that only shows it
> doesn't segfault. (Though I also reran 10% of the linux remerges with zdiff3
> under valgrind without issues.) I looked through some differences between
> --remerge-diff with diff3 and --remerge-diff with zdiff3, but those are
> essentially diffs of a diff of a diff, which I found hard to read. I'd like
> to look through more examples, and use it for a while before submitting the
> patches without the RFC tag.

I did something similar (but I wasn't smart enough to try your
remerge-diff, and just re-ran a bunch of merges).

Skimming over the results, I didn't see anything that looked incorrect.
Many of them are pretty non-exciting, though. A common case seems to be
ones like 01a2a03c56 (Merge branch 'jc/diff-filter-negation',
2013-09-09), where two sides both add functions in the same place, and
the common lines are just the closing "}" followed by a blank line.

Removing those shared lines actually makes things less readable, IMHO,
but I don't think it's the wrong thing to do. The usual "merge" zealous
minimization likewise produces the same unreadability. If we want to
address that, I think the best way would be by teaching the minimization
some heuristics about which lines are trivial.

Here's another interesting one. In 0c52457b7c (Merge branch
'nd/daemon-informative-errors-typofix', 2014-01-10), the diff3 looks
like:

  <<<<<<< ours
                  if (starts_with(arg, "--informative-errors")) {
  ||||||| base
                  if (!prefixcmp(arg, "--informative-errors")) {
  =======
                  if (!strcmp(arg, "--informative-errors")) {
  >>>>>>> theirs
                          informative_errors = 1;
                          continue;
                  }
  <<<<<<< ours
                  if (starts_with(arg, "--no-informative-errors")) {
  ||||||| base
                  if (!prefixcmp(arg, "--no-informative-errors")) {
  =======
                  if (!strcmp(arg, "--no-informative-errors")) {
  >>>>>>> theirs

A little clunky, but it's easy-ish to see what's going on. With zdiff3,
the context between the two hunks is rolled into a single hunk:

  <<<<<<< ours
                  if (starts_with(arg, "--informative-errors")) {
                          informative_errors = 1;
                          continue;
                  }
                  if (starts_with(arg, "--no-informative-errors")) {
  ||||||| base
                  if (!prefixcmp(arg, "--informative-errors")) {
  =======
                  if (!strcmp(arg, "--informative-errors")) {
                          informative_errors = 1;
                          continue;
                  }
                  if (!strcmp(arg, "--no-informative-errors")) {
  >>>>>>> theirs

which seems worse. I haven't dug/thought carefully enough into your
change yet to know if this is expected, or if there's a bug.

-Peff
