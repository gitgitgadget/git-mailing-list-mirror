Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB4B1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHUXMf (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:12:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:50882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726861AbeHUXMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:12:35 -0400
Received: (qmail 8653 invoked by uid 109); 21 Aug 2018 19:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26530 invoked by uid 111); 21 Aug 2018 19:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:51:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:51:02 -0400
Date:   Tue, 21 Aug 2018 15:51:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/6] reuse on-disk deltas for fetches with bitmaps
Message-ID: <20180821195102.GB859@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
 <20180821190622.GA30301@sigill.intra.peff.net>
 <xmqqo9dv8qf9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9dv8qf9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 12:34:18PM -0700, Junio C Hamano wrote:

> > 1:  89fa0ec8d8 ! 1:  3e1b94d7d6 pack-bitmap: save "have" bitmap from walk
> >     @@ -69,6 +69,8 @@
> >      +
> >      +	if (!bitmap_git)
> >      +		return 0; /* no bitmap loaded */
> >     ++	if (!bitmap_git->result)
> >     ++		BUG("failed to perform bitmap walk before querying");
> >      +	if (!bitmap_git->haves)
> >      +		return 0; /* walk had no "haves" */
> >      +
> 
> The first four are unchanged, so this actually compares 5/6 of the
> previous and the current one.  Omitting the four identical ones
> makes sense, but I wonder if it makes it easier to see if we keep
> the number-label of the surviving patches.

Agreed, but I think this is user error, and not the tool.

I ran:

  git range-diff @{push}...HEAD

since I knew that I had not pushed since beginning my revisions today.
But of course "rebase -i" is clever enough not to change the commit id
on the earlier commits I did not touch, and thus the merge base is
actually patch 4.

I should instead be more explicit about the base, like:

  git range-diff origin @{push} HEAD

That shows much more sensible output (see below).

For my triangular setup, I could even do:

  git range-diff @{upstream} @{push} HEAD

but I'm not sure if that is generally applicable advice (I'm not sure
how many people have really bought into @{push} and using triangular
config -- traditionally I think many people treat @{upstream} as the
place they push to). It also needs adjusting if your revisions might
span several sessions; you'd really need @{push}@{yesterday} or similar.
The best thing to compare against is probably what got queued, so
something like:

  git range-diff origin..origin/jk/$branch_name origin..HEAD

though that also introduces sign-off noise.

-Peff

-- >8 --
1:  9665189d70 = 1:  9665189d70 t/perf: factor boilerplate out of test_perf
2:  fa1ad80e4e = 2:  fa1ad80e4e t/perf: factor out percent calculations
3:  abf0ddbb9f = 3:  abf0ddbb9f t/perf: add infrastructure for measuring sizes
4:  49981526ad = 4:  49981526ad t/perf: add perf tests for fetches from a bitmapped server
5:  89fa0ec8d8 ! 5:  3e1b94d7d6 pack-bitmap: save "have" bitmap from walk
    @@ -69,6 +69,8 @@
     +
     +	if (!bitmap_git)
     +		return 0; /* no bitmap loaded */
    ++	if (!bitmap_git->result)
    ++		BUG("failed to perform bitmap walk before querying");
     +	if (!bitmap_git->haves)
     +		return 0; /* walk had no "haves" */
     +
6:  f7ca0d59e3 ! 6:  b8b2416aac pack-objects: reuse on-disk deltas for thin "have" objects
    @@ -12,7 +12,7 @@
         However, this misses some opportunities. Modulo some special
         cases like shallow or partial clones, we know that every
         object reachable from the "haves" could be a preferred base.
    -    We don't use them all for two reasons:
    +    We don't use all of them for two reasons:
     
           1. It's expensive to traverse the whole history and
              enumerate all of the objects the other side has.
    @@ -100,15 +100,16 @@
     
         The second is that the rest of the code assumes that any
         reused delta will point to another "struct object_entry" as
    -    its base. But by definition, we don't have such an entry!
    +    its base. But of course the case we are interested in here
    +    is the one where don't have such an entry!
     
         I looked at a number of options that didn't quite work:
     
    -     - we could use a different flag for reused deltas. But it's
    -       not a single bit for "I'm being reused". We have to
    -       actually store the oid of the base, which is normally
    -       done by pointing to the existing object_entry. And we'd
    -       have to modify all the code which looks at deltas.
    +     - we could use a flag to signal a reused delta, but it's
    +       not a single bit. We have to actually store the oid of
    +       the base, which is normally done by pointing to the
    +       existing object_entry. And we'd have to modify all the
    +       code which looks at deltas.
     
          - we could add the reused bases to the end of the existing
            object_entry array. While this does create some extra
    @@ -173,7 +174,7 @@
      static int depth = 50;
      static int delta_search_threads;
      static int pack_to_stdout;
    -+static int thin = 0;
    ++static int thin;
      static int num_preferred_base;
      static struct progress *progress_state;
      


