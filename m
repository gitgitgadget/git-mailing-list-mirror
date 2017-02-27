Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB01A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdB0Vss (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:48:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:62305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbdB0Vsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:48:33 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjrDd-1cBb5r0Vw1-00bruy; Mon, 27
 Feb 2017 22:30:22 +0100
Date:   Mon, 27 Feb 2017 22:30:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Use time_t
Message-ID: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2vUOEt26xG3QgmZnE67GrPjHR1RCikj9kgph+uB22LCQr1M2FCc
 aZpbslszAS4MJ6JoxSCoAm9/hFCaO0ts3TtGM2e9I0Qrk2D+jNUIkD9akHLEJzMfV6ig5Mn
 0QiDHD4lQ0Fe0M2trSynL7tffNmBqqoj6wj70cGh2SgW10kymcQWygQWUWFsvjk5c9GQzZs
 lN9/XxlY1Ml7jmXUs13QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hvn9+tpclag=:G0/4fo1MjUegTOWTskGgYK
 Ownz0VJV7WnXRwJ1dwaRDxekLA6rRA2hxat+Od8cONmyJ0ZDtPnCJKqtG9OgzasZUglDOeUhk
 WFXrb1vLb7Ts3dxn3mFgpxuIajlgQW6zrA8JDi1LO+JgS86I/kUiFRhDBP0eszh+qyTREkM/1
 cFuiqUgi4IcULMWh35lNDljkzJ5ghBBUg5qPGltDEsrBPdXNu5+ZF2ABy4EFbhzn57cjHKTpD
 zTS9TQq/mNoE8seVy7sXua5RVYCsuUESXyGfvUYtZT1NlWiVF6uJO5gH7O+Vc/WffPYs+zCO3
 g9j4JELOsS9fi9fzhgMAL0XSBGqM85XONLV/xRiBfJ61nRsJbq8PfYluOEfa7ZtTfaRDEx61u
 x+MsYis7NjE3V4nXNHIldltmL/sCBbe308vtKKwI8qIDxZKjcUa7XEaEZqObpAwFzOVAdgRu9
 FRPuBrFTDu6KF2pzGyN1ZghH+kdNbj8fti8SLMxs+OrH/k7BqbXM6p9XHOEZLm5SmtgEkkUNK
 dDAPMbWcqqLbCXhaEl0pOUMr607uUzJ+NZ3ad/2PeBAtGluAGmU48NsokuI0Myl3bzbhFFbqZ
 HVN3hDw+0SSU4RFPxF9e7beMNM2hjGwrq4LNZtoz9MeO/ej+z65E8pwyD6zce7n4fTfsfmvp2
 SkfgLtyFTT/MI7NMiRjmHDIsJXmrFH7UhWUptmkkyer+27sHvJcuSdHUWFll1JQpuKj1KKDii
 thrIoQKOD8IIB+BQk39fiSbLf3vT8B3ZV0um51R51UZKnySV/tzSdA1NnScG2S6CHcfzqxe7n
 94z5nveP3pJ4LKVvrVAsn3M4uiIVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.9.2 was released in a hurry to accomodate for platforms like
Windows, where the `unsigned long` data type is 32-bit even for 64-bit
setups.

The quick fix was to simply disable all the testing with "absurd" future
dates.

However, we can do much better than that, as `time_t` exists, and at
least on 64-bit Windows it is 64-bit. Meaning: we *can* support these
absurd future dates on those platforms.

So let's do this.

One notable fallout of this patch series is that on 64-bit Linux (and
other platforms where `unsigned long` is 64-bit), we now limit the range
of dates to LONG_MAX (i.e. the *signed* maximum value). This needs to be
done as `time_t` can be signed (and indeed is at least on my Ubuntu
setup).

Obviously, I think that we can live with that, and I hope that all
interested parties agree.


Johannes Schindelin (6):
  t0006 & t5000: prepare for 64-bit time_t
  Specify explicitly where we parse timestamps
  Introduce a new "printf format" for timestamps
  Prepare for timestamps to use 64-bit signed types
  ref-filter: avoid using `unsigned long` for catch-all data type
  Use time_t where appropriate

 Documentation/technical/api-parse-options.txt |  8 +--
 Makefile                                      |  4 ++
 archive-tar.c                                 |  5 +-
 builtin/am.c                                  |  4 +-
 builtin/blame.c                               | 14 ++---
 builtin/fsck.c                                |  6 +-
 builtin/gc.c                                  |  2 +-
 builtin/log.c                                 |  4 +-
 builtin/merge-base.c                          |  2 +-
 builtin/name-rev.c                            |  6 +-
 builtin/pack-objects.c                        |  4 +-
 builtin/prune.c                               |  4 +-
 builtin/receive-pack.c                        | 10 +--
 builtin/reflog.c                              | 24 +++----
 builtin/show-branch.c                         |  4 +-
 builtin/worktree.c                            |  4 +-
 bundle.c                                      |  4 +-
 cache.h                                       | 14 ++---
 commit.c                                      | 16 ++---
 commit.h                                      |  2 +-
 config.mak.uname                              |  2 +
 credential-cache--daemon.c                    | 12 ++--
 date.c                                        | 90 +++++++++++++--------------
 fetch-pack.c                                  |  8 +--
 fsck.c                                        |  2 +-
 git-compat-util.h                             | 10 +++
 http-backend.c                                |  4 +-
 parse-options-cb.c                            |  4 +-
 pretty.c                                      |  4 +-
 reachable.c                                   | 10 ++-
 reachable.h                                   |  4 +-
 ref-filter.c                                  | 22 +++----
 reflog-walk.c                                 |  8 +--
 refs.c                                        | 14 ++---
 refs.h                                        |  8 +--
 refs/files-backend.c                          |  4 +-
 revision.c                                    |  6 +-
 revision.h                                    |  4 +-
 sha1_name.c                                   |  6 +-
 t/helper/test-date.c                          | 11 ++--
 t/helper/test-parse-options.c                 |  4 +-
 t/t0006-date.sh                               |  4 +-
 t/t5000-tar-tree.sh                           |  6 +-
 t/test-lib.sh                                 |  2 +
 tag.c                                         |  4 +-
 tag.h                                         |  2 +-
 upload-pack.c                                 |  8 +--
 vcs-svn/fast_export.c                         |  8 +--
 vcs-svn/fast_export.h                         |  4 +-
 vcs-svn/svndump.c                             |  2 +-
 wt-status.c                                   |  2 +-
 51 files changed, 221 insertions(+), 199 deletions(-)


base-commit: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v1
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v1

-- 
2.11.1.windows.1.379.g44ae0bc

