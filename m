From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2 00/19] Multiparent diff tree-walker + combine-diff speedup
Date: Mon, 24 Feb 2014 20:21:32 +0400
Message-ID: <cover.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:20:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyGh-0002ya-8h
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaBXQU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:20:28 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33995 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbaBXQU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:20:27 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyGS-0003z9-6E; Mon, 24 Feb 2014 20:20:20 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyI6-00079Q-Vm; Mon, 24 Feb 2014 20:22:03 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242589>

Hello up there.

Here go combine-diff speedup patches in form of first reworking diff
tree-walker to work in general case - when a commit have several parents, not
only one - we are traversing all 1+nparent trees in parallel.

Then we are taking advantage of the new diff tree-walker for speeding up
combine-diff, which for linux.git results in ~14 times speedup.

This is the second posting for the whole series - sent here patches should go
instead of already-in-pu ks/diff-tree-more and ks/tree-diff-nway into
ks/tree-diff-nway - patches are related and seeing them all at once is more
logical to me.

I've tried to do my homework based on review feedback and the changes compared
to v1 are:

- fixed last-minute thinko/bug last time introduced on my side (sorry) with
  opt->pathchange manipulation in __diff_tree_sha1() - we were forgetting to
  restore opt->pathchange, which led to incorrect log -c (merges _and_ plain
  diff-tree) output;

  This time, I've verified several times, log output stays really the same.

- direct use of alloca() changed to portability wrappers xalloca/xalloca_free
  which gracefully degrade to xmalloc/free on systems, where alloca is not
  available (see new patch 17).

- "i = 0; do { ... } while (++i < nparent)" is back to usual looping
  "for (i = 0; i < nparent; ++)", as I've re-measured timings and the
  difference is negligible.

  ( Initially, when I was fighting for every cycle it made sense, but real
    no-slowdown turned out to be related to avoiding mallocs, load trees in correct
    order and reducing register pressure. )

- S_IFXMIN_NEQ definition moved out to cache.h, to have all modes registry in one place;


- diff_tree() becomes static (new patch 13), as nobody is using it outside
  tree-diff.c (and is later renamed to __diff_tree_sha1);

- p0 -> first_parent; corrected comments about how emit_diff_first_parent_only
  behaves;


not changed:

- low-level helpers are still named with "__" prefix as, imho, that is the best
  convention to name such helpers, without sacrificing signal/noise ratio. All
  of them are now static though.


Signoffs were left intact, if a patch was already applied to pu with one, and
had not changed.

Please apply and thanks,
Kirill

P.S. Sorry for the delay - I was very busy.


Kirill Smelkov (19):
  combine-diff: move show_log_first logic/action out of paths scanning
  combine-diff: move changed-paths scanning logic into its own function
  tree-diff: no need to manually verify that there is no mode change for a path
  tree-diff: no need to pass match to skip_uninteresting()
  tree-diff: show_tree() is not needed
  tree-diff: consolidate code for emitting diffs and recursion in one place
  tree-diff: don't assume compare_tree_entry() returns -1,0,1
  tree-diff: move all action-taking code out of compare_tree_entry()
  tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
  tree-diff: show_path prototype is not needed anymore
  tree-diff: simplify tree_entry_pathcmp
  tree-diff: remove special-case diff-emitting code for empty-tree cases
  tree-diff: diff_tree() should now be static
  tree-diff: rework diff_tree interface to be sha1 based
  tree-diff: no need to call "full" diff_tree_sha1 from show_path()
  tree-diff: reuse base str(buf) memory on sub-tree recursion
  Portable alloca for Git
  tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
  combine-diff: speed it up, by using multiparent diff tree-walker directly

 Makefile          |   6 +
 cache.h           |  15 ++
 combine-diff.c    | 170 +++++++++++---
 config.mak.uname  |  10 +-
 configure.ac      |   8 +
 diff.c            |   2 +
 diff.h            |  12 +-
 git-compat-util.h |   8 +
 tree-diff.c       | 666 +++++++++++++++++++++++++++++++++++++++++++-----------
 9 files changed, 724 insertions(+), 173 deletions(-)

-- 
1.9.rc1.181.g641f458
