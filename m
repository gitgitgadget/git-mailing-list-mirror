Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0FC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3284A60EE9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbhIXSbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:31:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:54606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344681AbhIXSbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:31:51 -0400
Received: (qmail 19039 invoked by uid 109); 24 Sep 2021 18:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:30:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10957 invoked by uid 111); 24 Sep 2021 18:30:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:30:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/16] enabling GIT_REF_PARANOIA by default
Message-ID: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently ran into a situation where dealing with a corrupted
repository was more confusing than necessary, because Git by default
ignores corrupted refs in many commands.

A while ago we introduced GIT_REF_PARANOIA, which works by including
broken refs in iteration, which then typically causes later operations
to fail (e.g., during repacking, you'd prefer to barf loudly when trying
to access the missing object rather than incorrectly assume the objects
from the broken ref aren't reachable).

I think this is a better default for Git to have in general, not just
for a few select operations (we turn it on by default for pruning and
some repacks). We shouldn't see corruptions in general, and complaining
loudly when we do is the safest option. The reason we held back when the
knob was introduced was mostly out of deference to the historical
behavior.

So this series started as a patch to just flip that default, but I found
some interesting things:

 - there are a couple of tests that get confused. IMHO this is
   vindicating the idea of flipping the default, beacuse in each case
   these tests were poorly written (either corruptions they didn't
   realize they had, or doing questionable operations on an incomplete
   set of refs)

 - the existing GIT_REF_PARANOIA is over-eager to complain about
   dangling symrefs, even though they're perfectly fine

 - as usual, there was some obvious cleanup along the way. ;)

Even if you don't buy the argument that we should flip the default, I
think everything up through patch 11 is a worthwhile cleanup on its own.

Note that this conflicts with jt/no-abuse-alternate-odb-for-submodules,
since it is touching the innards of DO_FOR_EACH_REF_INCLUDE_BROKEN, too.
I left a note on that series about how I think that could be reconciled
(i.e., the conflict is just around how the code is written, and not
inherent to the goals).

In the end I left GIT_REF_PARANOIA as a knob, just defaulting to "1". I
think it's possibly useful as an escape hatch when dealing with a
corrupt repo. But we _could_ go all the way and basically drop
DO_FOR_EACH_REF_INCLUDE_BROKEN's do-we-have-the-object check entirely.
That would totally sever the relationship between the ref store and the
object store, which would make things conceptually a lot simpler (and I
saw was discussed in some of those earlier threads).

Just a breakdown of the series:

  [01/16]: t7900: clean up some more broken refs
  [02/16]: t5516: don't use HEAD ref for invalid ref-deletion tests
  [03/16]: t5600: provide detached HEAD for corruption failures
  [04/16]: t5312: drop "verbose" helper
  [05/16]: t5312: create bogus ref as necessary
  [06/16]: t5312: test non-destructive repack
  [07/16]: t5312: be more assertive about command failure

     Test cleanups. Necessary for the default flip, but I think each
     stands on its own.

  [08/16]: refs-internal.h: move DO_FOR_EACH_* flags next to each other
  [09/16]: refs-internal.h: reorganize DO_FOR_EACH_* flag documentation

     Cleanup of existing features.

  [10/16]: refs: add DO_FOR_EACH_OMIT_DANGLING_SYMREFS flag
  [11/16]: refs: omit dangling symrefs when using GIT_REF_PARANOIA

     Fixing the current over-eager behavior of GIT_REF_PARANOIA.

  [12/16]: refs: turn on GIT_REF_PARANOIA by default

     The actual flip.

  [13/16]: repack, prune: drop GIT_REF_PARANOIA settings
  [14/16]: ref-filter: stop setting FILTER_REFS_INCLUDE_BROKEN
  [15/16]: ref-filter: drop broken-ref code entirely
  [16/16]: refs: drop "broken" flag from for_each_fullref_in()

     Some small cleanups we can do as a result.

 Documentation/git.txt         | 19 ++++++------
 builtin/branch.c              |  2 +-
 builtin/for-each-ref.c        |  2 +-
 builtin/prune.c               |  1 -
 builtin/repack.c              |  3 --
 builtin/rev-parse.c           |  4 +--
 cache.h                       |  8 -----
 environment.c                 |  1 -
 ls-refs.c                     |  2 +-
 ref-filter.c                  | 22 ++++++--------
 ref-filter.h                  |  1 -
 refs.c                        | 42 +++++++++++++-------------
 refs.h                        |  9 ++----
 refs/files-backend.c          |  5 ++++
 refs/refs-internal.h          | 56 ++++++++++++++++++++++-------------
 revision.c                    |  2 +-
 t/t1430-bad-ref-name.sh       |  2 +-
 t/t5312-prune-corruption.sh   | 48 ++++++++++++++++++++++--------
 t/t5516-fetch-push.sh         | 19 ++++++------
 t/t5600-clone-fail-cleanup.sh |  4 ++-
 t/t7900-maintenance.sh        |  6 +++-
 21 files changed, 142 insertions(+), 116 deletions(-)

-Peff
