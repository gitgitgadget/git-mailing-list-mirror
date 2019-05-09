Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D52A1F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfEIV0B (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:26:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726608AbfEIV0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:26:01 -0400
Received: (qmail 9993 invoked by uid 109); 9 May 2019 21:26:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:26:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6372 invoked by uid 111); 9 May 2019 21:26:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:26:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:25:59 -0400
Date:   Thu, 9 May 2019 17:25:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/14] "final" batch of unused parameter cleanups
Message-ID: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of my efforts to get us compiling with
-Wunused-parameter.  This round finishes most of the cleanups and fixes
I intend to do (though I have a handful of cleanup cases that I'm still
poking at to make sure they're not in fact bugs). After that, I have
some patches to annotate unused parameters we can't get rid of (e.g.,
for cases where we're conforming to a callback interface), and then we
can finally flip the warning on for developer-mode.

This series has two small conflicts with what's in "pu":

  - there's a minor textual conflict in upload-pack

  - it changes cmd_rebase__interactive(), which moved into
    builtin/rebase.c in pw/rebase-i-internal. Because the old file went
    away, this results in a delete/modified conflict, and you have to
    manually fix up the result, like so:

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
deleted file mode 100644
index 72fd4b53a8..0000000000
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8c2cbc72f6..cc1e1a997d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -508,7 +508,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	if (argc == 1)
 		usage_with_options(builtin_rebase_interactive_usage, options);
 
-	argc = parse_options(argc, argv, NULL, options,
+	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
 	if (!is_null_oid(&squash_onto))

Most of the patches are pretty straightforward and won't have any
behavior change (the thing to review in them is confirming that not
using the parameter is the right thing to do; I've tried to make a case
for each in the commit message). The trickiest one is patch 14.

  [01/14]: cmd_{read,write}_tree: rename "unused" variable that is used
  [02/14]: submodule: drop unused prefix parameter from some functions
  [03/14]: builtin: consistently pass cmd_* prefix to parse_options
  [04/14]: clone: drop dest parameter from copy_alternates()
  [05/14]: read-cache: drop unused parameter from threaded load
  [06/14]: wt-status: drop unused status parameter
  [07/14]: mktree: drop unused length parameter
  [08/14]: name-rev: drop unused parameters from is_better_name()
  [09/14]: pack-objects: drop unused rev_info parameters
  [10/14]: receive-pack: drop unused "commands" from prepare_shallow_update()
  [11/14]: remove_all_fetch_refspecs(): drop unused "remote" parameter
  [12/14]: rev-list: drop unused void pointer from finish_commit()
  [13/14]: show-branch: drop unused parameter from show_independent()
  [14/14]: verify-commit: simplify parameters to run_gpg_verify()

 builtin/clone.c               |  5 ++---
 builtin/column.c              |  2 +-
 builtin/hash-object.c         |  2 +-
 builtin/mktree.c              |  4 ++--
 builtin/name-rev.c            |  5 +----
 builtin/pack-objects.c        |  8 ++++----
 builtin/range-diff.c          |  2 +-
 builtin/read-tree.c           |  4 ++--
 builtin/rebase--interactive.c |  2 +-
 builtin/receive-pack.c        |  5 ++---
 builtin/remote.c              |  4 ++--
 builtin/rev-list.c            | 10 +++++-----
 builtin/rm.c                  |  6 +++---
 builtin/show-branch.c         |  3 +--
 builtin/submodule--helper.c   |  3 +--
 builtin/upload-pack.c         |  2 +-
 builtin/verify-commit.c       | 23 ++++++++---------------
 builtin/write-tree.c          | 12 ++++++------
 read-cache.c                  |  4 ++--
 submodule.c                   | 10 ++++------
 submodule.h                   |  3 +--
 wt-status.c                   |  6 ++----
 22 files changed, 53 insertions(+), 72 deletions(-)

