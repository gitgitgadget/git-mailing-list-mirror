From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 00/14] New hash table implementation
Date: Thu, 07 Nov 2013 15:32:35 +0100
Message-ID: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQdS-0008Mn-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab3KGOcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:32:35 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:62935 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3KGOcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:32:33 -0500
Received: by mail-ee0-f48.google.com with SMTP id d49so350586eek.35
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=pBFdvKVMjz8D+W9sKWgI5htVrga6H4mWhwOTmE0R/ew=;
        b=UIDLUqhM2irGGfAT2XyayxA2knzv7Xq3v/4iYNy/TvUm1jyveWINc5duW9ZLI2Bg3V
         w1UeMvbpuyVsTY7u+d6eJsZW+CUB2nzCt1aoWHg0ZgBDGURZgrbAbzk4o7S3pkf6YRxD
         gJMr4pBc6qfssFygCS29x7JVY25rO4MBsJJ3AI5CeRynJ/NQTVT9MFXexbW1rIk+eESg
         a5/ZBMIXR47A+jizFkwzO78iFhRBnQIRWPIxhNa+Ar2kFKvKWBGGMk24uHKV67lR3scg
         PlE4W8kGLJbc/QyhE4csjRot4+mLAff2dQI81aXoPHmzwR/BxQvPtdWHbZpih3dqHePA
         yrGA==
X-Received: by 10.14.127.4 with SMTP id c4mr58315eei.144.1383834752221;
        Thu, 07 Nov 2013 06:32:32 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 8sm9867409eem.15.2013.11.07.06.32.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:32:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237395>

Also here:
https://github.com/kblees/git/commits/kb/hashmap-v4

Sorry for the delay, but the promised static use-after-free analysis [1] turned out to be much more involved than I had anticipated.

The Good News is that the static analysis independently found the four use-after-free issues that we already knew about (two fixed in my initial patch 10, and two more found by Thomas' valgrind tests). These are all fixed in this round.

Valgrind tests ran over night and only reported a single unrelated problem (glibc strlen() working in 4-byte chunks and thus exceeding the malloced space in builtin/fetch.c:462).

The Bad News is that I'm a bit clueless regarding unpack-trees.c, so I'd welcome if someone more familiar with that part of git could have a look (see analysis below).


The first 11 patches in this version are exactly as currently in pu, just rebased to next. The problematic memory-leaks patch is at the very end, so we could merge the rest and cook this one a bit longer...

Changes since v3:
- included Jens Lehmann's submodule use-after-free fix [2] (#01)
- added minor fix for 'git update-index --verbose' output (#12)
- added minor cleanup patch for builtin/update-index.c (#13)
- moved the problematic 'fix memory leaks' patch to the end (#14)
- included fix for first valgrind breakage [3] (already in pu) (#14)
- added fix for second valgrind breakage reported in [4] (#14)

[1] http://article.gmane.org/gmane.comp.version-control.git/236467
[2] http://article.gmane.org/gmane.comp.version-control.git/236370
[3] http://article.gmane.org/gmane.comp.version-control.git/236468
[4] http://article.gmane.org/gmane.comp.version-control.git/236869

Jens Lehmann (1):
  submodule: don't access the .gitmodules cache entry after removing it

Karsten Blees (13):
  add a hashtable implementation that supports O(1) removal
  buitin/describe.c: use new hash map implementation
  diffcore-rename.c: move code around to prepare for the next patch
  diffcore-rename.c: simplify finding exact renames
  diffcore-rename.c: use new hash map implementation
  name-hash.c: use new hash map implementation for directories
  name-hash.c: remove unreferenced directory entries
  name-hash.c: use new hash map implementation for cache entries
  name-hash.c: remove cache entries instead of marking them CE_UNHASHED
  remove old hash.[ch] implementation
  fix 'git update-index --verbose --again' output
  builtin/update-index.c: cleanup update_one
  read-cache.c: fix memory leaks caused by removed cache entries

 Documentation/technical/api-hash.txt    |  52 -------
 Documentation/technical/api-hashmap.txt | 237 +++++++++++++++++++++++++++++
 Makefile                                |   5 +-
 builtin/describe.c                      |  53 +++----
 builtin/rm.c                            |   2 +-
 builtin/update-index.c                  |  39 +++--
 cache.h                                 |  18 +--
 diffcore-rename.c                       | 185 ++++++++---------------
 hash.c                                  | 110 --------------
 hash.h                                  |  50 -------
 hashmap.c                               | 212 ++++++++++++++++++++++++++
 hashmap.h                               |  72 +++++++++
 name-hash.c                             | 156 +++++++------------
 read-cache.c                            |  10 +-
 resolve-undo.c                          |   7 +-
 submodule.c                             |  25 +---
 t/t0011-hashmap.sh                      | 236 +++++++++++++++++++++++++++++
 test-hashmap.c                          | 256 ++++++++++++++++++++++++++++++++
 unpack-trees.c                          |   3 +-
 19 files changed, 1199 insertions(+), 529 deletions(-)
 delete mode 100644 Documentation/technical/api-hash.txt
 create mode 100644 Documentation/technical/api-hashmap.txt
 delete mode 100644 hash.c
 delete mode 100644 hash.h
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c

===

Potential use-after-free problems in unpack-trees.c:
----------------------------------------------------

Basic analysis of unpack-trees.c is that most callers go through add_entry or merged_entry, which both add a copy of the cache_entry to a separate index_state (unpack_trees_options.result). This may replace and free entries in unpack_trees_options.result, which is (mostly) ok because unpack_trees_options.result is (mostly) not used otherwise. Adding copies to a separate index is completely safe, so we don't even have to look at most of the other functions in unpack-trees.c.

The two call hierarchies that I'm worried about are as follows:

1.  unpack_callback may pass a cache_entry from unpack_trees_options.src_index
    to unpack_nondirectories (as src[0]), which _may_ add it to
    unpack_trees_options.result without making a copy.
1a. adding a cache_entry from src_index to result without making a copy
    destroys hashtable chaining in src_index (do_add_entry clears ce->next).
1b. if this cache_entry is later replaced and freed in result, it will
    implicitly free an entry that's still in src_index.

  read-cache.c::add_index_entry
    unpack-trees.c::do_add_entry
      unpack-trees.c::unpack_nondirectories
        unpack-trees.c::unpack_callback

2. unpack_trees iterates over unpack_trees_options.result and uses the
   cache_entry after calling verify_absent / apply_sparse_checkout, which in
   turn _may_ replace and free that cache_entry

  read-cache.c::add_index_entry
    unpack-trees.c::do_add_entry
      unpack-trees.c::add_entry
        unpack-trees.c::verify_clean_subdirectory
          unpack-trees.c::check_ok_to_remove
            unpack-trees.c::verify_absent_1
              unpack-trees.c::verify_absent_sparse
                unpack-trees.c::apply_sparse_checkout
                  unpack-trees.c::unpack_trees
              unpack-trees.c::verify_absent
                unpack-trees.c::unpack_trees


Static use-after-free analysis:
-------------------------------

What I did so far is this:

1. Get the reverse call hierarchy for remove_name_hash, up to cmd_* (thanks
   to Eclipse) - results in ~180 functions.
2. Get functions that reference struct cache_entry - results in ~200
   functions.
3. Intersect the two lists - results in 54 functions that _may_ use
   cache_entry after removing / freeing it:

ok builtin/apply.c::add_conflicted_stages_file
ok builtin/apply.c::add_index_file
ok builtin/apply.c::build_fake_ancestor
ok builtin/blame.c::fake_working_tree_commit
ok builtin/checkout.c::checkout_paths
ok builtin/checkout.c::update_some
ok builtin/commit.c::list_paths
ok builtin/ls-files.c::overlay_tree_on_cache
ok builtin/merge.c::suggest_conflicts
ok builtin/reset.c::update_index_from_diff
not-ok builtin/rm.c::cmd_rm (ce->name added to list without strdup)
ok builtin/update-index.c::add_cacheinfo
ok builtin/update-index.c::add_one_path
not-ok builtin/update-index.c::do_reupdate (ce->name passed to update_one,
   which uses it after remove_file_from_cache)
ok builtin/update-index.c::process_directory
ok builtin/update-index.c::process_path
ok builtin/update-index.c::unresolve_one
ok merge-recursive.c::add_cacheinfo
ok read-cache.c::add_index_entry
ok read-cache.c::add_index_entry_with_check
ok read-cache.c::add_to_index
ok read-cache.c::check_file_directory_conflict (called from add_index_entry,
   so ce is not yet in the index)
ok read-cache.c::has_dir_name (called from add_index_entry, so ce is not yet
   in the index)
ok read-cache.c::has_file_name (called from add_index_entry, so ce is not yet
   in the index)
not-ok read-cache.c::read_index_unmerged (uses old ce after replacing
   it with new_ce)
ok read-cache.c::refresh_index
ok read-cache.c::rename_index_entry_at
ok resolve-undo.c::unmerge_index
not-ok resolve-undo.c::unmerge_index_entry_at (uses ce->name after
   remove_index_entry_at)
ok resolve-undo.c::unmerge_marked_index
ok sequencer.c::do_recursive_merge
ok tree.c::read_one_entry_opt
ok tree.c::read_tree
ok unpack-trees.c::add_entry (adds a copy to unpack_trees_options.result)
-- unpack-trees.c::add_same_unmerged
?? unpack-trees.c::apply_sparse_checkout
-- unpack-trees.c::bind_merge
?? unpack-trees.c::check_ok_to_remove
ok unpack-trees.c::check_updates (ok - holds no cache_entry references
   while calling remove_marked_cache_entries)
-- unpack-trees.c::deleted_entry
ok unpack-trees.c::do_add_entry (adds ce to unpack_trees_options.result)
-- unpack-trees.c::keep_entry
ok unpack-trees.c::merged_entry (adds a copy to unpack_trees_options.result)
-- unpack-trees.c::oneway_merge
-- unpack-trees.c::threeway_merge
-- unpack-trees.c::twoway_merge
?? unpack-trees.c::unpack_callback (see unpack_nondirectories)
-- unpack-trees.c::unpack_index_entry
?? unpack-trees.c::unpack_nondirectories (may call do_add_entry without
   copying src[0])
?? unpack-trees.c::unpack_trees (may replace entries in
   unpack_trees_options.result while iterating over it)
?? unpack-trees.c::verify_absent (see unpack_trees)
?? unpack-trees.c::verify_absent_1 (see unpack_trees)
?? unpack-trees.c::verify_absent_sparse (see unpack_trees)
?? unpack-trees.c::verify_clean_subdirectory (see unpack_trees)
