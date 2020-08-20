Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7961C433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B04208E4
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHTS1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:27:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgHTS1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 14:27:22 -0400
Received: (qmail 9052 invoked by uid 109); 20 Aug 2020 18:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2020 18:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18360 invoked by uid 111); 20 Aug 2020 18:27:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2020 14:27:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Aug 2020 14:27:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Possible bug with git restore
Message-ID: <20200820182720.GA2537643@coredump.intra.peff.net>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
 <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 20, 2020 at 07:48:48PM +0200, René Scharfe wrote:

> >   - shouldn't that wildcard pathspec match those files? I've confirmed
> >     that the glob characters make it into Git's pathspec machinery, and
> >     since it doesn't have slashes, I think we'd match a basename (and
> >     certainly "git ls-files *test_file.*" does what I expect).
> 
> No, because restore doesn't interpret pathspecs recursively.  I don't
> know why that causes files to disappear, though.  But here's a fix.

I think it's because of this comment from bc96cc87dbb:

  When pathspec.recursive == 0, the behavior depends on match functions:
  non-recursive for tree_entry_interesting() and recursive for
  match_pathspec{,_depth}

So when we read the tree, we don't match recursively, and those entries
don't appear. But then we correlate that with the index:

          /*
           * Make sure all pathspecs participated in locating the paths
           * to be checked out.
           */
          for (pos = 0; pos < active_nr; pos++)
                  if (opts->overlay_mode)
                          mark_ce_for_checkout_overlay(active_cache[pos],
                                                       ps_matched,
                                                       opts);
                  else
                          mark_ce_for_checkout_no_overlay(active_cache[pos],
                                                          ps_matched,
                                                          opts);

And in no-overlay mode (the default for restore), we do:

  
  static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
                                              char *ps_matched,
                                              const struct checkout_opts *opts)
  {
          ce->ce_flags &= ~CE_MATCHED;
          if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
                  return;
          if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
                  ce->ce_flags |= CE_MATCHED;
                  if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
                          /*
                           * In overlay mode, but the path is not in
                           * tree-ish, which means we should remove it
                           * from the index and the working tree.
                           */
                          ce->ce_flags |= CE_REMOVE | CE_WT_REMOVE;
          }
  }

And that ce_path_match() _does_ treat the pathspec recursively. So we
say "yes, it matches in the index but wasn't in the tree, and therefore
we must delete it".

So the fundamental issue is treating the pathspec in two different ways,
and then correlating the results. We need to either do a recursive match
for the tree match (as your patch does), or do non-recursive for this
index match (which I don't think is trivial, because of the way the
recursive flag works).

> No sign-off because I don't understand why pathspec recursiveness is a
> thing that can be turned off -- I'd expect pathspec syntax to be
> consistent for all commands.  So there might be a good reason why it was
> not enabled for restore (and switch and checkout).

I think it was originally done this way for compatibility of some
commands as we unified the pathspec code. But I'm having trouble digging
up the exact details.

However, it seems particularly egregious in checkout/restore, because we
may also be using the index as a source, in which case the pathspecs
_would_ be recursive by default. E.g., in the test repo we've been
discussing:

  [make the index and working tree differ]
  $ git reset HEAD^
  Unstaged changes after reset:
  M	incl/test_file.hpp
  M	src/test_file.cpp

  [restore using a wildcard, but out of the index rather than a tree]
  $ git restore -- '*.hpp'

  [and check that we did indeed match]
  $ git status
  On branch master
  Changes not staged for commit:
	modified:   src/test_file.cpp

So I think this inconsistency in pathspec matching between trees and the
index has probably existed in git-checkout for ages (and I guess people
don't do wildcards with trees often enough for anybody to have noticed).
But it didn't cause the index-deletion problem, because that only
appeared more recently with the --no-overlay mode. That's the default
for restore, but you can trigger the problem with checkout, too:

  $ git reset --hard
  $ git checkout --no-overlay HEAD^ '*.hpp'
  Updated 0 paths from 2668463
  $ git status
  On branch master
  Changes to be committed:
	deleted:    incl/test_file.hpp

-Peff
