Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693EE201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdB1NxS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 08:53:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:35637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbdB1NxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 08:53:17 -0500
Received: (qmail 21948 invoked by uid 109); 28 Feb 2017 12:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:06:35 +0000
Received: (qmail 25302 invoked by uid 111); 28 Feb 2017 12:06:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:06:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:06:33 -0500
Date:   Tue, 28 Feb 2017 07:06:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
 <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
 <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com>
 <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 07:53:02PM -0500, Jeff King wrote:

> On Mon, Feb 27, 2017 at 04:33:36PM -0800, Junio C Hamano wrote:
> 
> > A flag to affect the behaviour (as opposed to &flag as a secondary
> > return value, like Peff's patch does) can be made to work.  Perhaps
> > a flag that says "keep the input as is if the result is not a local
> > branch name" would pass an input "@" intact and that may be
> > sufficient to allow "git branch -m @" to rename the current branch
> > to "@" (I do not think it is a sensible rename, though ;-).  But
> > probably some callers need to keep the original input and compare
> > with the result to see if we expanded anything if we go that route.
> > At that point, I am not sure if there are much differences in the
> > ease of use between the two approaches.
> 
> I just went into more detail in my reply to Jacob, but I do think this
> is a workable approach (and fortunately we seem to have banned bare "@"
> as a name, along with anything containing "@{}", so I think we would end
> up rejecting these nonsense names).
> 
> I'll see if I can work up a patch. We'll still need to pass the flag
> around through the various functions, but at least it will be a flag and
> not a confusing negated out-parameter.

OK, I have a series which fixes this (diffstat below). When I audited
the other callers of interpret_branch_name() and strbuf_branchname(), it
turned out to be even more complicated. The callers basically fall into
a few buckets:

  1. Callers like get_sha1() and merge_name() pass the result to
     dwim_ref(), and are prepared to handle anything.

  2. Some callers stick "refs/heads/" in front of the result, and
     obviously only want local names. Most of git-branch and
     git-checkout fall into this boat.

  3. "git branch -d" can delete local _or_ remote branches, depending on
     the "-r" flag. So the expansion it wants varies, and we need to
     handle "just local" or "just remote".

So I converted the "only_branch" flag to an "allowed" bit-field. No
callers actually ask for more than a single type at once, but it was
easy to do it that way. It serves all of the callers, and will easily
adapt for the future (e.g., if "git branch -a -d" were ever allowed).

  [1/8]: interpret_branch_name: move docstring to header file
  [2/8]: strbuf_branchname: drop return value
  [3/8]: strbuf_branchname: add docstring
  [4/8]: interpret_branch_name: allow callers to restrict expansions
  [5/8]: t3204: test git-branch @-expansion corner cases
  [6/8]: branch: restrict @-expansions when deleting
  [7/8]: strbuf_check_ref_format(): expand only local branches
  [8/8]: checkout: restrict @-expansions when finding branch

 builtin/branch.c                      |   5 +-
 builtin/checkout.c                    |   2 +-
 builtin/merge.c                       |   2 +-
 cache.h                               |  32 ++++++++-
 refs.c                                |   2 +-
 revision.c                            |   2 +-
 sha1_name.c                           |  76 ++++++++++-----------
 strbuf.h                              |  21 +++++-
 t/t3204-branch-name-interpretation.sh | 122 ++++++++++++++++++++++++++++++++++
 9 files changed, 220 insertions(+), 44 deletions(-)
 create mode 100755 t/t3204-branch-name-interpretation.sh

-Peff
