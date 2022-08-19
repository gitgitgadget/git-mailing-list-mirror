Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E4C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbiHSKHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:07:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21D2B257
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:07:03 -0700 (PDT)
Received: (qmail 17648 invoked by uid 109); 19 Aug 2022 10:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 906 invoked by uid 111); 19 Aug 2022 10:07:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:07:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:07:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/11] annotating unused function parameters
Message-ID: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been carrying a bunch of patches (for almost 4 years now!) that get
the code base compiling cleanly with -Wunused-parameter. This is a
useful warning in my opinion; it found real bugs[1] when applied to the
whole code base. So it would be nice to be able to turn it on all the
time and get the same protection going forward.

Unfortunately, there's a catch: some functions really do need to have
unused parameters, because they're conforming to a specific interface.
Some reasons might be:

  - they're passed as callback function pointers

  - they're virtual functions called as pointers via a struct

  - they're compat functions that implement a well-known interface (this
    is especially true for "trivial" wrappers that are noops, or return
    ENOSYS, etc)

So we need some way to annotate the acceptable cases. This series
introduces a macro to do so. That's in the first patch. The other ten
apply it in various situations, with the end goal being that we could
flip the warning on for DEVELOPER=1 builds. This series doesn't get us
all the way there! I have ~100 more patches adding similar annotations.
My goal here is to give a taste of the direction and make sure it's
where we want to go.

I've grouped related annotations into a single patch. They should be
fairly easy to review. The annotation macro is written in such a way
that the compiler will complain if it's wrong. So really what you care
about in each is:

  - is this a case where we really want to be annotating and not
    removing unused parameters (or using them)? Each commit should
    explain this, and it's usually obvious (e.g., a specific type of
    callback)

  - does each hunk in the patch match the group

  - did I introduce any formatting problems along the way :)

  - (optional) are there other cases that should be in the group. This
    is probably not worth your time to go digging for. The other ~100
    patches aren't carefully organized and written up yet, so it's quite
    possible that I've mistakenly left a related case there that _could_
    be folded in. But those shake out much easier as the number of cases
    is reduced, and you can ask -Wunused-parameter to find them for you.

And of course the most important question is: do we like this direction
overall. This mass-annotation is a one-time pain. Going forward, the
only work would be requiring people to annotate new functions they add
(which again, is mostly going to be callbacks). IMHO it's worth it. In
addition to possibly finding errors, I think the annotations serve as an
extra clue for people reading the code about what the author intended.

So without further ado, the patches are:

  [01/11]: git-compat-util: add UNUSED macro
  [02/11]: refs: mark unused each_ref_fn parameters
  [03/11]: refs: mark unused reflog callback parameters
  [04/11]: refs: mark unused virtual method parameters
  [05/11]: transport: mark bundle transport_options as unused
  [06/11]: streaming: mark unused virtual method parameters
  [07/11]: config: mark unused callback parameters
  [08/11]: hashmap: mark unused callback parameters
  [09/11]: mark unused read_tree_recursive() callback parameters
  [10/11]: run-command: mark unused async callback parameters
  [11/11]: is_path_owned_by_current_uid(): mark "report" parameter as unused

 add-interactive.c           |  2 +-
 archive-tar.c               |  5 +++--
 archive-zip.c               |  5 +++--
 archive.c                   |  3 ++-
 attr.c                      |  4 ++--
 bisect.c                    |  7 ++++---
 bloom.c                     |  4 ++--
 builtin/am.c                |  2 +-
 builtin/bisect--helper.c    | 12 +++++++-----
 builtin/checkout.c          |  4 ++--
 builtin/commit-graph.c      |  2 +-
 builtin/config.c            |  8 +++++---
 builtin/describe.c          |  5 +++--
 builtin/difftool.c          | 10 +++++-----
 builtin/fast-export.c       |  2 +-
 builtin/fast-import.c       |  2 +-
 builtin/fetch.c             |  9 +++++----
 builtin/fsck.c              | 12 +++++++-----
 builtin/gc.c                |  5 +++--
 builtin/log.c               |  7 ++++---
 builtin/ls-tree.c           | 13 ++++++++-----
 builtin/multi-pack-index.c  |  2 +-
 builtin/name-rev.c          |  3 ++-
 builtin/pack-objects.c      | 12 +++++++-----
 builtin/receive-pack.c      |  4 ++--
 builtin/reflog.c            |  3 ++-
 builtin/remote.c            | 14 +++++++++-----
 builtin/repack.c            |  4 ++--
 builtin/rev-parse.c         |  6 ++++--
 builtin/show-branch.c       |  6 +++---
 builtin/show-ref.c          |  7 ++++---
 builtin/stash.c             |  9 ++++++---
 builtin/submodule--helper.c |  5 +++--
 color.c                     |  2 +-
 commit-graph.c              |  4 ++--
 commit.c                    |  5 +++--
 compat/terminal.c           |  2 +-
 config.c                    |  7 ++++---
 convert.c                   |  4 ++--
 delta-islands.c             |  4 ++--
 diff.c                      |  5 +++--
 dir.c                       |  4 ++--
 environment.c               |  4 ++--
 fetch-pack.c                | 14 +++++++++-----
 git-compat-util.h           | 13 +++++++++++--
 gpg-interface.c             |  2 +-
 hashmap.c                   | 10 +++++-----
 help.c                      |  5 +++--
 http-backend.c              |  2 +-
 ident.c                     |  2 +-
 ll-merge.c                  |  3 ++-
 log-tree.c                  |  3 ++-
 ls-refs.c                   |  3 ++-
 merge-recursive.c           | 12 ++++++------
 name-hash.c                 |  4 ++--
 negotiator/default.c        |  3 ++-
 negotiator/skipping.c       |  3 ++-
 notes.c                     |  5 +++--
 object-name.c               | 10 +++++++---
 object-store.h              |  2 +-
 oidmap.c                    |  2 +-
 packfile.c                  |  2 +-
 pager.c                     |  3 ++-
 patch-ids.c                 |  2 +-
 pretty.c                    |  3 ++-
 range-diff.c                |  6 ++++--
 ref-filter.c                |  2 +-
 reflog.c                    | 16 ++++++++++------
 refs.c                      | 23 ++++++++++++++---------
 refs/files-backend.c        | 14 ++++++++------
 refs/iterator.c             |  6 +++---
 refs/packed-backend.c       | 14 ++++++++------
 remote.c                    | 22 +++++++++++++---------
 replace-object.c            |  3 ++-
 revision.c                  | 18 +++++++++++-------
 send-pack.c                 |  2 +-
 sequencer.c                 |  5 +++--
 server-info.c               |  3 ++-
 shallow.c                   | 12 ++++++++----
 streaming.c                 |  6 +++---
 strmap.c                    |  4 ++--
 sub-process.c               |  4 ++--
 submodule-config.c          |  8 ++++----
 submodule.c                 | 13 ++++++++-----
 t/helper/test-config.c      |  2 +-
 t/helper/test-ref-store.c   |  4 ++--
 t/helper/test-userdiff.c    |  2 +-
 trailer.c                   |  6 ++++--
 transport.c                 |  2 +-
 upload-pack.c               |  7 ++++---
 walker.c                    |  6 ++++--
 wt-status.c                 | 14 +++++++++-----
 92 files changed, 337 insertions(+), 234 deletions(-)

-Peff

[1] Here are some examples of bugs found by -Wunused-parameter:

     - https://lore.kernel.org/git/20181102063156.GA30252@sigill.intra.peff.net/
     - https://lore.kernel.org/git/20181102052239.GA19162@sigill.intra.peff.net/

