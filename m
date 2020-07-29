Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F866C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A1920658
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgG2UKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:10:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:41458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG2UKE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:10:04 -0400
Received: (qmail 8765 invoked by uid 109); 29 Jul 2020 20:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:10:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7760 invoked by uid 111); 29 Jul 2020 20:10:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:10:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:10:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200729201002.GA2989059@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728163617.GA2649887@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 12:36:18PM -0400, Jeff King wrote:

> This series just makes --first-parent imply -m. That doesn't change any
> output by itself, but does mean that diff options like "-p", "-S", etc,
> behave sensibly.

Here's a re-roll taking into account the discussion so far:

  - the escape hatch option name is flipped to "--no-diff-merges" (with
    "--diff-merges" matching "-m")

  - the documentation now discusses the change as well as the existing
    handling of merges; this involved a few extra cleanups. Try
    "doc-diff" for a better view of the actual rendered changes.

    I do think longer term we'd be better off to stop having this maze
    of ifdef'd inclusions, and just have gitdiff(7) which covers all of
    the possibilities in human-readable text (so yes, you might see a
    mention of diff-files while you're looking for info on git-log, but
    that would also broaden your mind about how the different commands
    work). But that's clearly outside the scope of this series. I think
    what's here is a strict improvement.

Patches:

  [1/7]: log: drop "--cc implies -m" logic
  [2/7]: revision: add "--no-diff-merges" option to counteract "-m"
  [3/7]: log: enable "-m" automatically with "--first-parent"
  [4/7]: doc/git-log: move "Diff Formatting" from rev-list-options
  [5/7]: doc/git-log: drop "-r" diff option
  [6/7]: doc/git-log: move "-t" into diff-options list
  [7/7]: doc/git-log: clarify handling of merge commit diffs

 Documentation/diff-options.txt                |  5 ++
 Documentation/git-log.txt                     | 43 +++++++++-
 Documentation/rev-list-options.txt            | 45 -----------
 builtin/log.c                                 |  7 +-
 revision.c                                    | 10 ++-
 revision.h                                    |  2 +-
 t/t4013-diff-various.sh                       |  1 +
 ..._--no-diff-merges_-p_--first-parent_master | 78 +++++++++++++++++++
 t/t4013/diff.log_-p_--first-parent_master     | 22 ++++++
 9 files changed, 158 insertions(+), 55 deletions(-)
 create mode 100644 t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master

Range diff from v1:

1:  518deab41f = 1:  4277d82c0c log: drop "--cc implies -m" logic
2:  836553f54e ! 2:  78750f9054 revision: add "--ignore-merges" option to counteract "-m"
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    revision: add "--ignore-merges" option to counteract "-m"
    +    revision: add "--no-diff-merges" option to counteract "-m"
     
         The "-m" option sets revs->ignore_merges to "0", but there's no way to
         undo it. This probably isn't something anybody overly cares about, since
    @@ Commit message
             functions, as well as setup_revisions() itself, avoid clobbering the
             user's preference (which until now they couldn't actually express).
     
    -      - since we now have --ignore-merges, let's add the matching
    -        --no-ignore-merges, which is just a synonym for "-m". In fact, it's
    -        simpler to just document --no-ignore-merges alongside "-m", and
    -        leave it implied that its opposite countermands it.
    +      - since we now have --no-diff-merges, let's add the matching
    +        --diff-merges, which is just a synonym for "-m". Then we don't even
    +        need to document --no-diff-merges separately; it countermands the
    +        long form of "-m" in the usual way.
     
         The new test shows that this behaves just the same as the current
         behavior without "-m".
    @@ Documentation/rev-list-options.txt: options may be given. See linkgit:git-diff-f
      	rename or copy detection have been requested).
      
      -m::
    -+--no-ignore-merges::
    ++--diff-merges::
      	This flag makes the merge commits show the full diff like
      	regular commits; for each merge parent, a separate log entry
      	and diff is generated. An exception is that only diff against
    @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
      		revs->diffopt.flags.recursive = 1;
      		revs->diffopt.flags.tree_in_recursive = 1;
     -	} else if (!strcmp(arg, "-m")) {
    -+	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--no-ignore-merges")) {
    ++	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
      		revs->ignore_merges = 0;
    -+	} else if (!strcmp(arg, "--ignore-merges")) {
    ++	} else if (!strcmp(arg, "--no-diff-merges")) {
     +		revs->ignore_merges = 1;
      	} else if (!strcmp(arg, "-c")) {
      		revs->diff = 1;
    @@ t/t4013-diff-various.sh: log --root --patch-with-stat --summary master
      log --root -c --patch-with-stat --summary master
      # improved by Timo's patch
      log --root --cc --patch-with-stat --summary master
    -+log --ignore-merges -p --first-parent master
    ++log --no-diff-merges -p --first-parent master
      log -p --first-parent master
      log -m -p --first-parent master
      log -m -p master
     
    - ## t/t4013/diff.log_--ignore-merges_-p_--first-parent_master (new) ##
    + ## t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master (new) ##
     @@
    -+$ git log --ignore-merges -p --first-parent master
    ++$ git log --no-diff-merges -p --first-parent master
     +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
     +Merge: 9a6d494 c7a2ab9
     +Author: A U Thor <author@example.com>
3:  3381fefeeb ! 3:  512b230003 log: enable "-m" automatically with "--first-parent"
    @@ Commit message
     
         No new test is needed; we'll tweak the output of the existing
         "--first-parent -p" test, which now matches the "-m --first-parent -p"
    -    test. The unchanged existing test for "--ignore-merges" confirms that
    +    test. The unchanged existing test for "--no-diff-merges" confirms that
         the user can get the old behavior if they want.
     
      ## builtin/log.c ##
-:  ---------- > 4:  2310dd62a6 doc/git-log: move "Diff Formatting" from rev-list-options
-:  ---------- > 5:  7a9a6b2d94 doc/git-log: drop "-r" diff option
-:  ---------- > 6:  e369e0ac50 doc/git-log: move "-t" into diff-options list
-:  ---------- > 7:  c1e769448c doc/git-log: clarify handling of merge commit diffs
