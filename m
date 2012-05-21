From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/7] Fix some sequencer leaks
Date: Mon, 21 May 2012 16:56:02 +0200
Message-ID: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUFe-0002wg-P4
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2EUPKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:21 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38825 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2EUPKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:20 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 931D5A62B6;
	Mon, 21 May 2012 17:10:12 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198107>

Here is another iteration of a series to fix some leaks in the cherry-pick,
revert and sequencer code.

The previous iteration only had patch 1 and 2. They haven't changed.
I just added the last 5 patches.

Maybe the last 2 patches are a bit overkill. But with this series, the
valgrind output with --leak-check=full is much cleaner.

There most important leaks are still there though. One of them is
related to ce_entries, like this: 

==2015== 522 bytes in 6 blocks are definitely lost in loss record 51 of 54
==2015==    at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2015==    by 0x53113B: xcalloc (wrapper.c:119)
==2015==    by 0x52BBE9: create_ce_entry (unpack-trees.c:559)
==2015==    by 0x52BDC6: unpack_nondirectories (unpack-trees.c:609)
==2015==    by 0x52C45B: unpack_callback (unpack-trees.c:799)
==2015==    by 0x529B9B: traverse_trees (tree-walk.c:407)
==2015==    by 0x52CE53: unpack_trees (unpack-trees.c:1091)
==2015==    by 0x4D1B89: git_merge_trees (merge-recursive.c:241)
==2015==    by 0x4D673A: merge_trees (merge-recursive.c:1819)
==2015==    by 0x509521: do_recursive_merge (sequencer.c:225)
==2015==    by 0x509F5B: do_pick_commit (sequencer.c:457)
==2015==    by 0x50B3B4: pick_commits (sequencer.c:878)

The other one is related to the index:

==2015== 574 (400 direct, 174 indirect) bytes in 2 blocks are definitely lost in loss record 52 of 54
==2015==    at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2015==    by 0x53113B: xcalloc (wrapper.c:119)
==2015==    by 0x4EF8CF: read_index_from (read-cache.c:1441)
==2015==    by 0x4EF316: read_index (read-cache.c:1282)
==2015==    by 0x50940B: do_recursive_merge (sequencer.c:211)
==2015==    by 0x509F5B: do_pick_commit (sequencer.c:457)
==2015==    by 0x50B3B4: pick_commits (sequencer.c:878)
==2015==    by 0x50B7C6: sequencer_pick_revisions (sequencer.c:994)
==2015==    by 0x47A6D5: cmd_cherry_pick (revert.c:237)
==2015==    by 0x404FEE: run_builtin (git.c:308)
==2015==    by 0x405181: handle_internal_command (git.c:468)
==2015==    by 0x40529B: run_argv (git.c:514)

Christian Couder (7):
  sequencer: fix leaked todo_list memory
  sequencer: release a strbuf used in save_head()
  merge-recursive: free some string lists
  revert: free opts.revs to do a bit of cleanup
  revert: free revs->cmdline.rev
  unpack-trees: record which unpack error messages should be freed
  Properly free unpack trees error messages

 builtin/checkout.c |  1 +
 builtin/merge.c    |  6 ++++--
 builtin/revert.c   |  6 ++++++
 merge-recursive.c  |  5 ++++-
 sequencer.c        | 16 +++++++++++++---
 unpack-trees.c     | 50 +++++++++++++++++++++++++++++++++++---------------
 unpack-trees.h     |  3 +++
 7 files changed, 66 insertions(+), 21 deletions(-)

-- 
1.7.10.2.555.g6528037
