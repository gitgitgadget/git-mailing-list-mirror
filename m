Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C1C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE722065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG1UV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:21:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:40184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgG1UV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:21:27 -0400
Received: (qmail 29695 invoked by uid 109); 28 Jul 2020 20:21:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:21:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28444 invoked by uid 111); 28 Jul 2020 20:21:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:21:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:21:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/11] renaming argv_array
Message-ID: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argv_array data type has turned out to be useful in our code base,
but the name isn't very good. From patch 2 of this series:

  The name "argv-array" isn't very good, because it describes what the
  data type can be used for (program argument arrays), not what it
  actually is (a dynamically-growing string array that maintains a
  NULL-terminator invariant). This leads to people being hesitant to use
  it for other cases where it would actually be a good fit. The existing
  name is also clunky to use. It's overly long, and the name often leads
  to saying things like "argv.argv" (i.e., the field names overlap with
  variable names, since they're describing the use, not the type). Let's
  give it a more neutral name.

This has bugged me for a while, so I decided to finally fix it. It
wasn't _too_ painful, though I'm sure there will be a little fallout
with topics in flight.

I tried to split out the mechanical bits into their own patches to make
reviewing easier. Patches 5-7 really could be a single patch, but
they're too big for the mailing list. I'm OK to leave them separate, or
they could be squashed together.

We could stop at patch 9 for now and allow topics in flight to catch up
before removing the compat layers. But the struct field renaming has to
happen as a single step, so it will be a pain whenever we do it. If
we're going to go this route, I'd just as soon do it all now and deal
with other topics as they get merged.

  [01/11]: argv-array: use size_t for count and alloc
  [02/11]: argv-array: rename to strvec
  [03/11]: strvec: rename files from argv-array to strvec
  [04/11]: quote: rename sq_dequote_to_argv_array to mention strvec
  [05/11]: strvec: convert builtin/ callers away from argv_array name
  [06/11]: strvec: convert more callers away from argv_array name
  [07/11]: strvec: convert remaining callers away from argv_array name
  [08/11]: strvec: fix indentation in renamed calls
  [09/11]: strvec: update documention to avoid argv_array
  [10/11]: strvec: drop argv_array compatibility layer
  [11/11]: strvec: rename struct fields

 Documentation/technical/api-parse-options.txt |   4 +-
 Makefile                                      |   2 +-
 add-interactive.c                             |  28 +--
 add-patch.c                                   |  48 ++--
 argv-array.c                                  | 109 ---------
 bisect.c                                      |  20 +-
 builtin/add.c                                 |  18 +-
 builtin/am.c                                  |  80 +++----
 builtin/annotate.c                            |  10 +-
 builtin/bisect--helper.c                      |  20 +-
 builtin/bundle.c                              |  14 +-
 builtin/clone.c                               |  38 +--
 builtin/commit.c                              |   8 +-
 builtin/describe.c                            |  44 ++--
 builtin/difftool.c                            |  30 +--
 builtin/fetch.c                               |  64 ++---
 builtin/gc.c                                  |  78 +++----
 builtin/grep.c                                |   2 +-
 builtin/log.c                                 |  12 +-
 builtin/ls-remote.c                           |   6 +-
 builtin/pack-objects.c                        |  26 +--
 builtin/pull.c                                | 160 ++++++-------
 builtin/range-diff.c                          |   4 +-
 builtin/rebase.c                              |  90 ++++----
 builtin/receive-pack.c                        | 126 +++++-----
 builtin/remote-ext.c                          |   4 +-
 builtin/remote.c                              |  26 +--
 builtin/repack.c                              |  72 +++---
 builtin/replace.c                             |  18 +-
 builtin/show-branch.c                         |  16 +-
 builtin/stash.c                               | 162 ++++++-------
 builtin/submodule--helper.c                   | 144 ++++++------
 builtin/update-ref.c                          |   2 +-
 builtin/upload-archive.c                      |  12 +-
 builtin/worktree.c                            |  68 +++---
 bundle.c                                      |  24 +-
 bundle.h                                      |   4 +-
 column.c                                      |  12 +-
 commit.c                                      |  10 +-
 compat/mingw.c                                |   4 +-
 compat/terminal.c                             |  18 +-
 connect.c                                     |  69 +++---
 connected.c                                   |  24 +-
 daemon.c                                      |  60 ++---
 diff.c                                        |  32 +--
 environment.c                                 |  12 +-
 exec-cmd.c                                    |  18 +-
 exec-cmd.h                                    |   4 +-
 fast-import.c                                 |   4 +-
 fetch-pack.c                                  |  46 ++--
 fsmonitor.c                                   |   6 +-
 git.c                                         |  32 +--
 gpg-interface.c                               |  22 +-
 graph.c                                       |  16 +-
 http-backend.c                                |   8 +-
 http-push.c                                   |  18 +-
 http.c                                        |   8 +-
 imap-send.c                                   |   2 +-
 line-log.c                                    |   8 +-
 list-objects-filter-options.c                 |   2 +-
 ls-refs.c                                     |  18 +-
 ls-refs.h                                     |   4 +-
 merge.c                                       |  18 +-
 midx.c                                        |  12 +-
 pager.c                                       |   8 +-
 parse-options-cb.c                            |   8 +-
 pathspec.c                                    |  10 +-
 quote.c                                       |   8 +-
 quote.h                                       |   8 +-
 range-diff.c                                  |  40 ++--
 range-diff.h                                  |   4 +-
 ref-filter.c                                  |  12 +-
 refs.c                                        |   8 +-
 refs.h                                        |   4 +-
 refspec.c                                     |  10 +-
 refspec.h                                     |   4 +-
 remote-curl.c                                 | 102 ++++----
 remote-testsvn.c                              |  10 +-
 remote.c                                      |  20 +-
 remote.h                                      |   4 +-
 revision.c                                    |  20 +-
 run-command.c                                 |  72 +++---
 run-command.h                                 |  12 +-
 send-pack.c                                   |  18 +-
 sequencer.c                                   | 126 +++++-----
 serve.c                                       |  20 +-
 serve.h                                       |   4 +-
 sha1-file.c                                   |  14 +-
 strvec.c                                      | 109 +++++++++
 argv-array.h => strvec.h                      |  58 ++---
 sub-process.c                                 |   2 +-
 submodule.c                                   | 218 +++++++++---------
 submodule.h                                   |   6 +-
 t/helper/test-run-command.c                   |  52 ++---
 t/helper/test-trace2.c                        |   2 +-
 tmp-objdir.c                                  |  20 +-
 transport-helper.c                            |  36 +--
 transport-internal.h                          |   4 +-
 transport.c                                   |  12 +-
 transport.h                                   |   2 +-
 unpack-trees.c                                |  12 +-
 unpack-trees.h                                |   4 +-
 upload-pack.c                                 |  53 +++--
 upload-pack.h                                 |   4 +-
 wt-status.c                                   |  19 +-
 105 files changed, 1619 insertions(+), 1620 deletions(-)
 delete mode 100644 argv-array.c
 create mode 100644 strvec.c
 rename argv-array.h => strvec.h (50%)

