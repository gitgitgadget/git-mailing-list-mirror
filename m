Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C201FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcF2Lgo (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:36:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:56558 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbcF2Lgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:43 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MCcOw-1b8psK1HzW-009TMw; Wed, 29 Jun 2016 13:36:38
 +0200
Date:	Wed, 29 Jun 2016 13:36:36 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Use merge_recursive() directly in the builtin am
Message-ID: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jMTZWhBS0Tem0D366ADH+YHha/QNA5nCU5M6lVf6Qwsn1piDBhP
 gGMJQL8k6YMoQm7hReR2rR2d4DkghyDRZO1hV0keP7Y8ag9ceCHZNwYL7zfXYJhQMB+WV/i
 mYBlwdXKy9pDI9Wzf6LwzlU7XOauBQJX4z0vL3rSB8vV7QydjHMVfmEF+3qLsEw0tV3/CeH
 YjHnnBf3Jd1r+sVFDpB8A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uMNb2Tilh2k=:ftdEnSAYgYqpV53Dk7xgi/
 R2GcD1pxVAKtZNZAUD7JDGaB26anCysg4vouVn2utvxOcct9COWjbYoQJVxS5J0G77W8SWZd2
 49T4S/oFAz/NHjpmaQBO8ucNmG38h+2gsIpFmpYPAV8l/v3OOSVy5xtvrACpzW2brtAS7Z5RQ
 pIye3lbNAyGTuzEb9ZPYP7DMZfidgZJkJ9AEHdzvKWR9An0HtgzbF/s1qtUPfyfFvTlfqqTUj
 7L34qVD40skaqbIcHNges/E6aDDZd/Pog0iot5UgMGzaCiQB7gKwfgyX4zdEUvcZK9ft9yDlL
 aXQXewWfaKrcVTGrNiUud/sGVSOKWaVx6W1YKm4mkEh32uHBmz3QYoc3Qf85UM4AyTWGSY1uT
 1zuNdfjLZypOpGprj6qghJGtFw0bTOcEXlA26wZPULiAd1+hYsGtEfD8oax7S95InPUURT8pA
 3zvHmqtULlA7nnvJkbRDR1A4X4X535dcH2f5ArIz80HJ937qpyTZhiKkTXsxQgzjH8bwxLDYp
 WEcddMZ0lB8wkD1UQQ5xPqZNCegsUVoTztxsIf19PNUZ6owfqQmhe51vsD+5UNOv7kDLjDwMT
 F1FJjxi09foMDjfrEtlZdSjdjDimRcGHHFkYN0baOr/JgfvvTWP8CZVEOIptIIKLssybh5Ply
 g9dwRLDQZJMdrAgAGsaSbmmp6kGTCOGj8WfvrNQWoa6wK6W9iiur7i67ko3AGTb96a4VAovGh
 alXjimL0Afd6QcMHSJ/HqoN5+YrhyNNlStfw4i/hw1r0r12UDy3MIFhXSF12vZAdDCARq5D+Q
 yj8k9Lr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the long-awaited re-roll of the attempt to avoid spawning
merge-recursive from the builtin am and use merge_recursive() directly
instead.

As indicated in the message of the final commit, the performance
improvement is modest, if noticable.

The *real* reason for the reroll is that I need a libified recursive
merge to accelerate the interactive rebase by teaching the sequencer to
do rebase -i's grunt work.

In other words, this is one of those 13 (now 14) patch series leading up
to a faster interactive rebase.

It did take quite a while to go through the code "with a fine-toothed
comb", and it did turn up a few surprises.

For example, the recursive merge calls remove_file() a couple of times
but actually does not always care about the return value, and rightfully
so. When updating a working tree, for example, where a file was
replaced by a directory, the code may create the directory first
(implicitly deleting the file) and only then attempt to remove the file,
failing because it is a directory already.

One might argue that this logic is flawed, then, and I would agree.
Right now my focus is on rebase -i and I want to avoid getting
side-tracked by the recursive merge logic. So the clean-up will need to
wait for another day (or week).

We also need to be extra careful to retain backwards-compatibility. The
test script t6022-merge-rename.sh, for example, verifies that `git pull`
exits with status 128 in case of a fatal error. To that end, we need to
make sure that fatal errors are handled by existing (builtin) users via
exit(128) (or die(), which calls exit(128) at the end). New users (such
as a builtin helper doing rebase -i's grunt work) may want to print some
helpful advice what happened and how to get out of this mess before
erroring out.

In contrast to the original attempt at libifying merge_recursive() (as
part of fixing a regression in the builtin am which wanted to print some
advice, but could not, because the merge machinery die()d before it
could), I no longer use the "gently" flag. Better to get it right to
begin with: fatal errors are indicated by a negative return value. No
dying without proper cause.

In an earlier iteration of this patch series which was not sent to the
mailing list, I used the special return vale -128 to indicate "real
fatal errors". This turned out to be unnecessary: returning -1 always,
to indicate that the operation could not complete successfully, is the
appropriate way to handle all errors.

As this patch series touches rather important code, I would really
appreciate thorough reviews, with a particular focus on what regressions
this patch series might introduce.


Johannes Schindelin (8):
  Report bugs consistently
  merge-recursive: clarify code in was_tracked()
  Prepare the builtins for a libified merge_recursive()
  merge_recursive: abort properly upon errors
  merge-recursive: avoid returning a wholesale struct
  merge-recursive: allow write_tree_from_memory() to error out
  merge-recursive: handle return values indicating errors
  merge-recursive: switch to returning errors instead of dying

Junio C Hamano (1):
  am: make a direct call to merge_recursive

 builtin/am.c           |  27 ++--
 builtin/checkout.c     |   4 +-
 builtin/ls-files.c     |   3 +-
 builtin/merge.c        |   4 +
 builtin/update-index.c |   2 +-
 grep.c                 |   8 +-
 imap-send.c            |   2 +-
 merge-recursive.c      | 397 ++++++++++++++++++++++++++++++-------------------
 sequencer.c            |   4 +
 sha1_file.c            |   4 +-
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 13 files changed, 279 insertions(+), 184 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v1
-- 
2.9.0.268.gcabc8b0

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
