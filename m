Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbiHITJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiHITJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B41C3
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l4so15268603wrm.13
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=p11MPRiPI2wE54NR5EkUWKTtIm4/W7BRi1D8uTf0XE4=;
        b=brTXG2YzoQNJ6+MNXMSb8RDkBxaS2M3AcHmP1K5WxDwNUSOidZy/0M0T35Asx8+vPU
         XtLuX5jHpbTzqrDHn6upmLZEKLD1vV8g6LkXdWJxX6stAUpz8gCYBNsS3H43z7a8GUVs
         WcwK0LgOyZUtICWvIn8mZ6fOk17ZtuB7/WjqvaQODrlDiQcI4m/+r82Fz94UjgFG1JUg
         WWkL7C1JT6EReK+XVC0qXIBqWNkln4nPKz8sLmVaJpRoRwLRdsw4598rBmf3hGHZwIR+
         R1bLXDSkJvUVyukR9rWf8fIwimntFXe6WEqt65uTm41QivDd8MOedISkycWSDm9fUaMN
         OCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p11MPRiPI2wE54NR5EkUWKTtIm4/W7BRi1D8uTf0XE4=;
        b=KFFQ03/6i+KeuKggZlEMLuDJd5Frdmrc7knraK1naOfovH3yDblcGr1New2GPfmkHS
         isWutdEjMCyVK7LHMxSevYaDaGT3wMg2mYF8fGFVblKqvDiYe3aKfJ8Qsh/z7T1YViTZ
         WGygLyx1CJath38z2oh43xKXzG408OOooaudMgVcHygWWqYUyJEw6Rd87tIx8Jft9GZj
         W9Tuz3GfWYHfAOd4qXZYd5/QHpyd7aTuFHyshoU3uTfivNK96aPimfEaztowadAxJYGU
         kIobrIng82hQ/r5ctUtRT7z6i56gzPXt72P4TaPkogS6eNTcElS1CW7ViptpmGQ0DVot
         8F3g==
X-Gm-Message-State: ACgBeo1rrjn/ahpjVW/j8RhGPySWrODTfVrYo/cGNV30BdGsAt3qgHqo
        31zL8/DQf5eWuEEr2++lr3IUmNUIZ8g=
X-Google-Smtp-Source: AA6agR6PTi9N30yN9L8pSRo9133aIjbP4+dq4/geguEM54eHs6czgff5LNc4gvqmEZGNvsej7xbz/w==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr5540797wri.16.1660071324040;
        Tue, 09 Aug 2022 11:55:24 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 00/14] Rewrite the remaining merge strategies from shell to C
Date:   Tue,  9 Aug 2022 20:54:15 +0200
Message-Id: <20220809185429.20098-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to reduce the number of shell scripts in git's codebase, I
propose this patch series converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

This series keeps the commands `git merge-one-file', `git
merge-resolve', and `git merge-octopus', so any script depending on them
should keep working without changes.

This series is based on c50926e1f4 (The eleventh batch, 2022-08-08).
The tip is tagged as "rewrite-merge-strategies-v8" at
https://github.com/agrn/git.

Changes since v7:

 - The series has been rebased.

 - The first commit has been dropped, since t6407 was modernized by
   8127a2b1f5 (merge tests: use "test_must_fail" instead of ad-hoc
   pattern, 2022-03-07).

 - The `quiet' parameter of merge_entry() has been removed.  Merge
   program failures are now reported by merge_index_path() and
   merge_all_index().

 - merge_all_index() now reports merge program failures in oneshot mode,
   as merge-index did.

 - In the `merge-index' builtin, the change removing the default value
   of `merge_action' was reverted, as suggested by Johannes Schindelin.

 - The argument parsing and error handling in merge-one-file.c has been
   cleaned up, as suggested by Johannes.

 - Parameters checking of the merge strategies were moved from the
   builtins to merge_strategy_resolve() and merge_strategy_octopus(), as
   suggested by Johannes.

 - Both strategies were modified to lock the index only once at the
   start, and release the lock once at the end.  Calls to
   write_index_as_tree() were replaced to a new internal function,
   write_tree(), that do not lock the index.

   In the v7, write_tree() also called lookup_tree() on the result of
   write_index_as_tree().  As the result was only used by the octopus,
   this call was moved to merge_strategy_octopus().

   This change was suggested by Johannes.

 - 24ba8b70c9 (merge-resolve: abort if index does not match HEAD,
   2022-07-23) added a check in git-merge-resolve.sh that makes the
   strategy exit if there is changes in the worktree.  This change was
   brought along.  Since the same check was made in merge-octopus, it
   has been factored as a function in merge-strategies.c:
   check_index_is_head().  merge_strategy_octopus() was modified to use
   this new function, too.

 - In merge_strategies.c, fast_forward() was renamed to merge_trees().

 - Fixed the parameters to a call to merge_all_index() in octopus_do_merge().

 - The changes to merge_strategy_octopus() suggested by Johannes [0] were
   applied.

 - Some commit messages were clarified.

[0] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103232323330.50@tvgsbejvaqbjf.bet/

Alban Gruin (14):
  t6060: modify multiple files to expose a possible issue with
    merge-index
  t6060: add tests for removed files
  merge-index: libify merge_one_path() and merge_all()
  merge-index: drop the index
  merge-index: add a new way to invoke `git-merge-one-file'
  update-index: move add_cacheinfo() to read-cache.c
  merge-one-file: rewrite in C
  merge-resolve: rewrite in C
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" strategy without forking

 Documentation/git-merge-index.txt |   7 +-
 Makefile                          |   7 +-
 builtin.h                         |   3 +
 builtin/merge-index.c             | 122 +++---
 builtin/merge-octopus.c           |  63 ++++
 builtin/merge-one-file.c          |  92 +++++
 builtin/merge-recursive.c         |  16 +-
 builtin/merge-resolve.c           |  63 ++++
 builtin/merge.c                   |   7 +
 builtin/update-index.c            |  25 +-
 cache.h                           |  10 +-
 git-merge-octopus.sh              | 112 ------
 git-merge-one-file.sh             | 167 ---------
 git-merge-resolve.sh              |  64 ----
 git.c                             |   3 +
 merge-strategies.c                | 590 ++++++++++++++++++++++++++++++
 merge-strategies.h                |  39 ++
 merge.c                           |  12 +
 read-cache.c                      |  35 ++
 sequencer.c                       |  17 +-
 t/t6060-merge-index.sh            |  23 +-
 t/t6415-merge-dir-to-symlink.sh   |   2 +-
 t/t7607-merge-state.sh            |   2 +-
 23 files changed, 1022 insertions(+), 459 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v7:
 1:  dfe230bfce <  -:  ---------- t6407: modernise tests
 2:  575e24685d !  1:  2e23e45435 t6060: modify multiple files to expose a possible issue with merge-index
    @@ Commit message
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## t/t6060-merge-index.sh ##
    -@@ t/t6060-merge-index.sh: test_expect_success 'setup diverging branches' '
    - 	for i in 1 2 3 4 5 6 7 8 9 10; do
    - 		echo $i
    - 	done >file &&
    +@@ t/t6060-merge-index.sh: test_description='basic git merge-index / git-merge-one-file tests'
    + 
    + test_expect_success 'setup diverging branches' '
    + 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
     -	git add file &&
     +	cp file file2 &&
     +	git add file file2 &&
 3:  4f366ff363 !  2:  f48f2f7c3c t6060: add tests for removed files
    @@ Metadata
      ## Commit message ##
         t6060: add tests for removed files
     
    -    Until now, t6060 did not not check git-mere-one-file's behaviour when a
    +    Until now, t6060 did not not check git-merge-one-file's behaviour when a
         file is deleted in a branch.  To avoid regressions on this during the
    -    conversion, this adds a new file, `file3', in the commit tagged as`base', and
    -    deletes it in the commit tagged as `two'.
    +    conversion from shell to C, this adds a new file, `file3', in the commit
    +    tagged as `base', and deletes it in the commit tagged as `two'.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## t/t6060-merge-index.sh ##
    -@@ t/t6060-merge-index.sh: test_expect_success 'setup diverging branches' '
    - 		echo $i
    - 	done >file &&
    +@@ t/t6060-merge-index.sh: test_description='basic git merge-index / git-merge-one-file tests'
    + test_expect_success 'setup diverging branches' '
    + 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
      	cp file file2 &&
     -	git add file file2 &&
     +	cp file file3 &&
 4:  6af79a6b2d !  3:  331141f0cb merge-index: libify merge_one_path() and merge_all()
    @@ Makefile: LIB_OBJS += merge-blobs.o
      LIB_OBJS += merge-recursive.o
     +LIB_OBJS += merge-strategies.o
      LIB_OBJS += merge.o
    - LIB_OBJS += mergesort.o
      LIB_OBJS += midx.o
    + LIB_OBJS += name-hash.o
     
      ## builtin/merge-index.c ##
     @@
    @@ builtin/merge-index.c
     -static void merge_all(void)
     -{
     -	int i;
    +-	/* TODO: audit for interaction with sparse-index. */
    +-	ensure_full_index(&the_index);
     -	for (i = 0; i < active_nr; i++) {
     -		const struct cache_entry *ce = active_cache[i];
     -		if (!ce_stage(ce))
    @@ merge-strategies.c (new)
     +#include "cache.h"
     +#include "merge-strategies.h"
     +
    -+static int merge_entry(struct index_state *istate, int quiet, unsigned int pos,
    ++static int merge_entry(struct index_state *istate, unsigned int pos,
     +		       const char *path, int *err, merge_fn fn, void *data)
     +{
     +	int found = 0;
    @@ merge-strategies.c (new)
     +		return error(_("%s is not in the cache"), path);
     +
     +	if (fn(istate, oids[0], oids[1], oids[2], path,
    -+	       modes[0], modes[1], modes[2], data)) {
    -+		if (!quiet)
    -+			error(_("Merge program failed"));
    ++	       modes[0], modes[1], modes[2], data))
     +		(*err)++;
    -+	}
     +
     +	return found;
     +}
    @@ merge-strategies.c (new)
     +	 * already merged and there is nothing to do.
     +	 */
     +	if (pos < 0) {
    -+		ret = merge_entry(istate, quiet || oneshot, -pos - 1, path, &err, fn, data);
    ++		ret = merge_entry(istate, -pos - 1, path, &err, fn, data);
     +		if (ret == -1)
     +			return -1;
    -+		else if (err)
    ++		else if (err) {
    ++			if (!quiet && !oneshot)
    ++				error(_("merge program failed"));
     +			return 1;
    ++		}
     +	}
     +	return 0;
     +}
    @@ merge-strategies.c (new)
     +	int err = 0, ret;
     +	unsigned int i;
     +
    ++	/* TODO: audit for interaction with sparse-index. */
    ++	ensure_full_index(istate);
     +	for (i = 0; i < istate->cache_nr; i++) {
     +		const struct cache_entry *ce = istate->cache[i];
     +		if (!ce_stage(ce))
     +			continue;
     +
    -+		ret = merge_entry(istate, quiet || oneshot, i, ce->name, &err, fn, data);
    ++		ret = merge_entry(istate, i, ce->name, &err, fn, data);
     +		if (ret > 0)
     +			i += ret - 1;
     +		else if (ret == -1)
     +			return -1;
     +
    -+		if (err && !oneshot)
    ++		if (err && !oneshot) {
    ++			if (!quiet)
    ++				error(_("merge program failed"));
     +			return 1;
    ++		}
     +	}
     +
    ++	if (err && !quiet)
    ++		error(_("merge program failed"));
     +	return err;
     +}
     
    @@ merge-strategies.h (new)
     +		    merge_fn fn, void *data);
     +
     +#endif /* MERGE_STRATEGIES_H */
    +
    + ## t/t7607-merge-state.sh ##
    +@@ t/t7607-merge-state.sh: test_expect_success 'Ensure we restore original state if no merge strategy handl
    + 	# just hit conflicts, it completely fails and says that it cannot
    + 	# handle this type of merge.
    + 	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
    +-	grep "fatal: merge program failed" output &&
    ++	grep "error: merge program failed" output &&
    + 	grep "Should not be doing an octopus" output &&
    + 
    + 	# Make sure we did not leave stray changes around when no appropriate
 5:  909ed66114 !  4:  a3c0815fc1 merge-index: drop the index
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     +	if (repo_read_index(r) < 0)
     +		die("invalid index");
      
    + 	/* TODO: audit for interaction with sparse-index. */
    +-	ensure_full_index(&the_index);
    ++	ensure_full_index(r->index);
    + 
      	i = 1;
      	if (!strcmp(argv[i], "-o")) {
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
 6:  1a8aba05bd !  5:  558e65e39b merge-index: add a new way to invoke `git-merge-one-file'
    @@ Documentation/git-merge-index.txt: git-merge-index - Run a merge for files needi
      SYNOPSIS
      --------
      [verse]
    --'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
    -+'git merge-index' [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | [--] <file>*)
    +-'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
    ++'git merge-index' [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | ( [--] <file>...) )
      
      DESCRIPTION
      -----------
 7:  1f6635512c !  6:  94edebfb69 update-index: move add_cacheinfo() to read-cache.c
    @@ Commit message
         This moves the function add_cacheinfo() that already exists in
         update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
         and adds an `istate' parameter.  The new cache entry is returned through
    -    a pointer passed in the parameters.  The return value is either 0
    -    (success), -1 (invalid path), or -2 (failed to add the file in the
    -    index).
    +    a pointer passed in the parameters.  This function can return three
    +    values:
    +
    +     - 0, when the file has been successfully added to the index;
    +     - ADD_TO_INDEX_CACHEINFO_INVALID_PATH, when the file does not exists;
    +     - ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD, when the file could not be
    +       added to the index.
     
         This will become useful in the next commit, when the three-way merge
         will need to call this function.
 8:  8755608f6d !  7:  123d299df7 merge-one-file: rewrite in C
    @@ builtin.h: int cmd_merge_base(int argc, const char **argv, const char *prefix);
      int cmd_mktag(int argc, const char **argv, const char *prefix);
     
      ## builtin/merge-index.c ##
    -@@ builtin/merge-index.c: static int merge_one_file_spawn(struct index_state *istate,
    - int cmd_merge_index(int argc, const char **argv, const char *prefix)
    - {
    - 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
    --	merge_fn merge_action = merge_one_file_spawn;
    -+	merge_fn merge_action;
    - 	struct lock_file lock = LOCK_INIT;
    - 	struct repository *r = the_repository;
    - 	const char *use_internal = NULL;
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
      
      	if (skip_prefix(pgm, "--use=", &use_internal)) {
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     +			merge_action = merge_one_file_func;
      		else
      			die(_("git merge-index: unknown internal program %s"), use_internal);
    --	}
     +
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+	} else
    -+		merge_action = merge_one_file_spawn;
    + 	}
      
      	for (; i < argc; i++) {
    - 		const char *arg = argv[i];
     
      ## builtin/merge-one-file.c (new) ##
     @@
    @@ builtin/merge-one-file.c (new)
     +	"<orig mode> <our mode> <their mode>\n\n"
     +	"Blob ids and modes should be empty for missing files.";
     +
    -+static int read_mode(const char *name, const char *arg, unsigned int *mode)
    ++static int read_param(const char *name, const char *arg_blob, const char *arg_mode,
    ++		      struct object_id *blob, struct object_id **p_blob, unsigned int *mode)
     +{
    -+	char *last;
    -+	int ret = 0;
    ++	if (*arg_blob && !get_oid_hex(arg_blob, blob)) {
    ++		char *last;
     +
    -+	*mode = strtol(arg, &last, 8);
    ++		*p_blob = blob;
    ++		*mode = strtol(arg_mode, &last, 8);
     +
    -+	if (*last)
    -+		ret = error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
    -+	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
    -+		ret = error(_("invalid '%s' mode: %o"), name, *mode);
    ++		if (*last)
    ++			return error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
    ++		else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
    ++			return error(_("invalid '%s' mode: %o"), name, *mode);
    ++	} else if (!*arg_blob && *arg_mode)
    ++		return error(_("no '%s' object id given, but a mode was still given."), name);
     +
    -+	return ret;
    ++	return 0;
     +}
     +
     +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
    @@ builtin/merge-one-file.c (new)
     +
     +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
     +
    -+	if (!get_oid_hex(argv[1], &orig_blob)) {
    -+		p_orig_blob = &orig_blob;
    -+		ret = read_mode("orig", argv[5], &orig_mode);
    -+	} else if (!*argv[1] && *argv[5])
    -+		ret = error(_("no 'orig' object id given, but a mode was still given."));
    ++	if (read_param("orig", argv[1], argv[5], &orig_blob,
    ++		       &p_orig_blob, &orig_mode))
    ++		ret = -1;
     +
    -+	if (!get_oid_hex(argv[2], &our_blob)) {
    -+		p_our_blob = &our_blob;
    -+		ret = read_mode("our", argv[6], &our_mode);
    -+	} else if (!*argv[2] && *argv[6])
    -+		ret = error(_("no 'our' object id given, but a mode was still given."));
    ++	if (read_param("our", argv[2], argv[6], &our_blob,
    ++		       &p_our_blob, &our_mode))
    ++		ret = -1;
     +
    -+	if (!get_oid_hex(argv[3], &their_blob)) {
    -+		p_their_blob = &their_blob;
    -+		ret = read_mode("their", argv[7], &their_mode);
    -+	} else if (!*argv[3] && *argv[7])
    -+		ret = error(_("no 'their' object id given, but a mode was still given."));
    ++	if (read_param("their", argv[3], argv[7], &their_blob,
    ++		       &p_their_blob, &their_mode))
    ++		ret = -1;
     +
     +	if (ret)
     +		return ret;
    @@ merge-strategies.c
     @@
      #include "cache.h"
     +#include "dir.h"
    ++#include "entry.h"
      #include "merge-strategies.h"
     +#include "xdiff-interface.h"
     +
    @@ merge-strategies.c
     +		read_mmblob(mmfs + 0, orig_blob);
     +	} else {
     +		printf(_("Added %s in both, but differently.\n"), path);
    -+		read_mmblob(mmfs + 0, &null_oid);
    ++		read_mmblob(mmfs + 0, null_oid());
     +	}
     +
     +	read_mmblob(mmfs + 1, our_blob);
    @@ merge-strategies.c
     +			       orig_mode, our_mode, their_mode);
     +}
      
    - static int merge_entry(struct index_state *istate, int quiet, unsigned int pos,
    + static int merge_entry(struct index_state *istate, unsigned int pos,
      		       const char *path, int *err, merge_fn fn, void *data)
     @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
      		    merge_fn fn, void *data)
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     -	unsigned int i;
     +	unsigned int i, prev_nr;
      
    - 	for (i = 0; i < istate->cache_nr; i++) {
    - 		const struct cache_entry *ce = istate->cache[i];
    + 	/* TODO: audit for interaction with sparse-index. */
    + 	ensure_full_index(istate);
    +@@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
      		if (!ce_stage(ce))
      			continue;
      
     +		prev_nr = istate->cache_nr;
    - 		ret = merge_entry(istate, quiet || oneshot, i, ce->name, &err, fn, data);
    + 		ret = merge_entry(istate, i, ce->name, &err, fn, data);
     -		if (ret > 0)
     -			i += ret - 1;
     -		else if (ret == -1)
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +		} else if (ret == -1)
      			return -1;
      
    - 		if (err && !oneshot)
    + 		if (err && !oneshot) {
     
      ## merge-strategies.h ##
     @@
 9:  3ecf49a8ac !  8:  f181cef10b merge-resolve: rewrite in C
    @@ Commit message
            all the setup needed).
     
          - The call to `write-tree' is replaced by a call to
    -       write_index_as_tree().
    +       cache_tree_update().  This call is wrapped in a new function,
    +       write_tree().  It is made to mimick write_index_as_tree() with
    +       WRITE_TREE_SILENT flag, but without locking the index; this is taken
    +       care directly in merge_strategies_resolve().
    +
    +     - The call to `diff-index ...' is replaced by a call to
    +       repo_index_has_changes().
     
          - The call to `merge-index', needed to invoke `git merge-one-file', is
            replaced by a call to the new merge_all_index() function.
     
         The index is read in cmd_merge_resolve(), and is wrote back by
    -    merge_strategies_resolve().
    +    merge_strategies_resolve().  This is to accomodate future applications:
    +    in `git-merge', the index has already been read when the merge strategy
    +    is called, so it would be redundant to read it again when the builtin
    +    will be able to use merge_strategies_resolve() directly.
     
         The parameters of merge_strategies_resolve() will be surprising at first
         glance: why using a commit list for `bases' and `remote', where we could
    @@ Commit message
         frictions later, merge_strategies_resolve() takes the same types of
         parameters.
     
    +    merge_strategies_resolve() locks the index only once, at the beginning
    +    of the merge, and releases it when the merge has been completed.
    +
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## Makefile ##
    @@ builtin/merge-resolve.c (new)
     +		}
     +	}
     +
    -+	/*
    -+	 * Give up if we are given two or more remotes.  Not handling
    -+	 * octopus.
    -+	 */
    -+	if (remote && remote->next)
    -+		return 2;
    -+
    -+	/* Give up if this is a baseless merge. */
    -+	if (!bases)
    -+		return 2;
    -+
     +	return merge_strategies_resolve(r, bases, head, remote);
     +}
     
    @@ git-merge-resolve.sh (deleted)
     -#
     -# Resolve two trees, using enhanced multi-base read-tree.
     -
    +-. git-sh-setup
    +-
    +-# Abort if index does not match HEAD
    +-if ! git diff-index --quiet --cached HEAD --
    +-then
    +-    gettextln "Error: Your local changes to the following files would be overwritten by merge"
    +-    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
    +-    exit 2
    +-fi
    +-
     -# The first parameters up to -- are merge bases; the rest are heads.
     -bases= head= remotes= sep_seen=
     -for arg
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
     +	{ "merge-resolve", cmd_merge_resolve, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
      	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
    - 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
    + 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
      	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
     
      ## merge-strategies.c ##
    @@ merge-strategies.c
      #include "cache.h"
     +#include "cache-tree.h"
      #include "dir.h"
    + #include "entry.h"
     +#include "lockfile.h"
      #include "merge-strategies.h"
     +#include "unpack-trees.h"
      #include "xdiff-interface.h"
      
    ++static int check_index_is_head(struct repository *r, const char *head_arg)
    ++{
    ++	struct commit *head_commit;
    ++	struct tree *head_tree;
    ++	struct object_id head;
    ++	struct strbuf sb = STRBUF_INIT;
    ++
    ++	get_oid(head_arg, &head);
    ++	head_commit = lookup_commit_reference(r, &head);
    ++	head_tree = repo_get_commit_tree(r, head_commit);
    ++
    ++	if (repo_index_has_changes(r, head_tree, &sb)) {
    ++		error(_("Your local changes to the following files "
    ++			"would be overwritten by merge:\n  %s"),
    ++		      sb.buf);
    ++		strbuf_release(&sb);
    ++		return 1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
      static int add_merge_result_to_index(struct index_state *istate, unsigned int mode,
    + 				     const struct object_id *oid, const char *path,
    + 				     int checkout)
     @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    - 
    + 		error(_("merge program failed"));
      	return err;
      }
     +
    -+static int fast_forward(struct repository *r, struct tree_desc *t,
    -+			int nr, int aggressive)
    ++static int merge_trees(struct repository *r, struct tree_desc *t,
    ++		       int nr, int aggressive)
     +{
     +	struct unpack_trees_options opts;
    -+	struct lock_file lock = LOCK_INIT;
     +
     +	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
    -+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
     +
     +	memset(&opts, 0, sizeof(opts));
     +	opts.head_idx = 1;
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +
     +	if (unpack_trees(nr, t, &opts))
     +		return -1;
    -+
    -+	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
    -+		return error(_("unable to write new index file"));
    -+
     +	return 0;
     +}
     +
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +	return 0;
     +}
     +
    ++static int write_tree(struct repository *r)
    ++{
    ++	int was_valid;
    ++	was_valid = r->index->cache_tree &&
    ++		cache_tree_fully_valid(r->index->cache_tree);
    ++
    ++	if (!was_valid && cache_tree_update(r->index, WRITE_TREE_SILENT) < 0)
    ++		return WRITE_TREE_UNMERGED_INDEX;
    ++	return 0;
    ++}
    ++
     +int merge_strategies_resolve(struct repository *r,
     +			     struct commit_list *bases, const char *head_arg,
     +			     struct commit_list *remote)
     +{
     +	struct tree_desc t[MAX_UNPACK_TREES];
    -+	struct object_id head, oid;
     +	struct commit_list *i;
    -+	int nr = 0;
    ++	struct lock_file lock = LOCK_INIT;
    ++	int nr = 0, ret = 0;
     +
    -+	if (head_arg)
    -+		get_oid(head_arg, &head);
    ++	/* Abort if index does not match head */
    ++	if (check_index_is_head(r, head_arg))
    ++		return 2;
    ++
    ++	/*
    ++	 * Give up if we are given two or more remotes.  Not handling
    ++	 * octopus.
    ++	 */
    ++	if (remote && remote->next)
    ++		return 2;
    ++
    ++	/* Give up if this is a baseless merge. */
    ++	if (!bases)
    ++		return 2;
     +
     +	puts(_("Trying simple merge."));
     +
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +	}
     +
     +	if (head_arg) {
    -+		struct tree *tree = parse_tree_indirect(&head);
    ++		struct object_id head;
    ++		struct tree *tree;
    ++
    ++		get_oid(head_arg, &head);
    ++		tree = parse_tree_indirect(&head);
    ++
     +		if (add_tree(tree, t + (nr++)))
     +			return 2;
     +	}
    @@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot,
     +	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
     +		return 2;
     +
    -+	if (fast_forward(r, t, nr, 1))
    ++	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    ++
    ++	if (merge_trees(r, t, nr, 1)) {
    ++		rollback_lock_file(&lock);
     +		return 2;
    ++	}
     +
    -+	if (write_index_as_tree(&oid, r->index, r->index_file,
    -+				WRITE_TREE_SILENT, NULL)) {
    -+		int ret;
    -+		struct lock_file lock = LOCK_INIT;
    -+
    ++	if (write_tree(r)) {
     +		puts(_("Simple merge failed, trying Automatic merge."));
    -+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
     +		ret = merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
    -+
    -+		write_locked_index(r->index, &lock, COMMIT_LOCK);
    -+		return !!ret;
     +	}
     +
    -+	return 0;
    ++	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
    ++		return !!error(_("unable to write new index file"));
    ++	return !!ret;
     +}
     
      ## merge-strategies.h ##
10:  615b04d417 =  9:  cc1ba1acc9 merge-recursive: move better_branch_name() to merge.c
11:  a6ece04f3d ! 10:  c48e2de914 merge-octopus: rewrite in C
    @@ Commit message
          - Calls to `read-tree -u -m (--aggressive)?' are replaced by calls to
            unpack_trees().
     
    -     - The call to `write-tree' is replaced by a call to
    -       write_index_as_tree().
    +     - The call to `write-tree' is replaced by a call to write_tree().
     
          - The call to `diff-index ...' is replaced by a call to
            repo_index_has_changes().
    @@ Commit message
          - The call to `merge-index', needed to invoke `git merge-one-file', is
            replaced by a call to merge_all_index().
     
    -    The index is read in cmd_merge_octopus(), and is wrote back by
    -    merge_strategies_octopus().
    +    The index is read in cmd_merge_octopus(), and is written back by
    +    merge_strategies_octopus(), for the same reason as merge-resolve.
     
    -    Here to, merge_strategies_octopus() takes two commit lists and a string
    -    to reduce frictions when try_merge_strategies() will be modified to call
    -    it directly.
    +    Here too, merge_strategies_octopus() takes two commit lists and a string
    +    to reduce friction when try_merge_strategies() will be modified to call
    +    it directly.  It also locks the index at the start of the merge, and
    +    releases it at the end.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    @@ builtin/merge-octopus.c (new)
     +		}
     +	}
     +
    -+	/*
    -+	 * Reject if this is not an octopus -- resolve should be used
    -+	 * instead.
    -+	 */
    -+	if (commit_list_count(remotes) < 2)
    -+		return 2;
    -+
     +	return merge_strategies_octopus(r, bases, head_arg, remotes);
     +}
     
    @@ merge-strategies.c
      #include "cache-tree.h"
     +#include "commit-reach.h"
      #include "dir.h"
    + #include "entry.h"
      #include "lockfile.h"
    - #include "merge-strategies.h"
     @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
    - 
    - 	return 0;
    + 		return !!error(_("unable to write new index file"));
    + 	return !!ret;
      }
     +
    -+static int write_tree(struct repository *r, struct tree **reference_tree)
    -+{
    -+	struct object_id oid;
    -+	int ret;
    -+
    -+	if (!(ret = write_index_as_tree(&oid, r->index, r->index_file,
    -+					WRITE_TREE_SILENT, NULL)))
    -+		*reference_tree = lookup_tree(r, &oid);
    -+
    -+	return ret;
    -+}
    -+
     +static int octopus_fast_forward(struct repository *r, const char *branch_name,
    -+				struct tree *tree_head, struct tree *current_tree,
    -+				struct tree **reference_tree)
    ++				struct tree *tree_head, struct tree *current_tree)
     +{
     +	/*
     +	 * The first head being merged was a fast-forward.  Advance the
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +	init_tree_desc(t, tree_head->buffer, tree_head->size);
     +	if (add_tree(current_tree, t + 1))
     +		return -1;
    -+	if (fast_forward(r, t, 2, 0))
    ++	if (merge_trees(r, t, 2, 0))
     +		return -1;
    -+	if (write_tree(r, reference_tree))
    ++	if (write_tree(r))
     +		return -1;
     +
     +	return 0;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +
     +static int octopus_do_merge(struct repository *r, const char *branch_name,
     +			    struct commit_list *common, struct tree *current_tree,
    -+			    struct tree **reference_tree)
    ++			    struct tree *reference_tree)
     +{
     +	struct tree_desc t[MAX_UNPACK_TREES];
     +	struct commit_list *i;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			return -1;
     +	}
     +
    -+	if (add_tree(*reference_tree, t + (nr++)))
    ++	if (add_tree(reference_tree, t + (nr++)))
     +		return -1;
     +	if (add_tree(current_tree, t + (nr++)))
     +		return -1;
    -+	if (fast_forward(r, t, nr, 1))
    ++	if (merge_trees(r, t, nr, 1))
     +		return 2;
     +
    -+	if (write_tree(r, reference_tree)) {
    -+		struct lock_file lock = LOCK_INIT;
    -+
    ++	if (write_tree(r)) {
     +		puts(_("Simple merge did not work, trying automatic merge."));
    -+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = !!merge_all_index(r->index, 0, 0, merge_one_file_func, NULL);
    -+		write_locked_index(r->index, &lock, COMMIT_LOCK);
    -+
    -+		write_tree(r, reference_tree);
    ++		ret = !!merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
    ++		write_tree(r);
     +	}
     +
     +	return ret;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +	struct tree *reference_tree, *head_tree;
     +	struct commit_list *i;
     +	struct object_id head;
    -+	struct strbuf sb = STRBUF_INIT;
    ++	struct lock_file lock = LOCK_INIT;
    ++
    ++	/*
    ++	 * Reject if this is not an octopus -- resolve should be used
    ++	 * instead.
    ++	 */
    ++	if (commit_list_count(remotes) < 2)
    ++		return 2;
    ++
    ++	/* Abort if index does not match head */
    ++	if (check_index_is_head(r, head_arg))
    ++		return 2;
     +
     +	get_oid(head_arg, &head);
     +	head_commit = lookup_commit_reference(r, &head);
     +	head_tree = repo_get_commit_tree(r, head_commit);
     +
    -+	if (parse_tree(head_tree))
    -+		return 2;
    -+
    -+	if (repo_index_has_changes(r, head_tree, &sb)) {
    -+		error(_("Your local changes to the following files "
    -+			"would be overwritten by merge:\n  %s"),
    -+		      sb.buf);
    -+		strbuf_release(&sb);
    -+		return 2;
    -+	}
    -+
     +	CALLOC_ARRAY(reference_commits, commit_list_count(remotes) + 1);
     +	reference_commits[0] = head_commit;
     +	reference_tree = head_tree;
     +
    ++	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    ++
     +	for (i = remotes; i && i->item; i = i->next) {
     +		struct commit *c = i->item;
     +		struct object_id *oid = &c->object.oid;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +
     +			free(branch_name);
     +			free_commit_list(common);
    -+			free(reference_commits);
     +
    -+			return 2;
    ++			ret = 2;
    ++			break;
     +		}
     +
    -+		for (j = common; j && !up_to_date && ff_merge; j = j->next) {
    -+			up_to_date |= oideq(&j->item->object.oid, oid);
    -+
    -+			if (!j->next &&
    -+			    !oideq(&j->item->object.oid,
    -+				   &reference_commits[nr_references - 1]->object.oid))
    -+				ff_merge = 0;
    ++		/*
    ++		 * If `oid' is reachable from `HEAD', we're already up
    ++		 * to date.
    ++		 */
    ++		for (j = common; j; j = j->next) {
    ++			if (oideq(&j->item->object.oid, oid)) {
    ++				up_to_date = 1;
    ++				break;
    ++			}
     +		}
     +
     +		if (up_to_date) {
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			continue;
     +		}
     +
    -+		if (ff_merge) {
    -+			ret = octopus_fast_forward(r, branch_name, head_tree,
    -+						   current_tree, &reference_tree);
    ++		/*
    ++		 * If we could fast-forward so far and `HEAD' is the
    ++		 * single merge base with the current `remote' revision,
    ++		 * keep fast-forwarding.
    ++		 */
    ++		if (ff_merge && common && !common->next && nr_references == 1 &&
    ++		    oideq(&common->item->object.oid,
    ++			  &reference_commits[0]->object.oid)) {
    ++			ret = octopus_fast_forward(r, branch_name, head_tree, current_tree);
     +			nr_references = 0;
     +		} else {
     +			ret = octopus_do_merge(r, branch_name, common,
    -+					       current_tree, &reference_tree);
    ++					       current_tree, reference_tree);
    ++			ff_merge = 0;
     +		}
     +
     +		free(branch_name);
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			puts(_("Automated merge did not work."));
     +			puts(_("Should not be doing an octopus."));
     +
    -+			free(reference_commits);
    -+			return 2;
    ++			ret = 2;
    ++			break;
     +		}
     +
     +		reference_commits[nr_references++] = c;
    ++		reference_tree = lookup_tree(r, &r->index->cache_tree->oid);
     +	}
     +
     +	free(reference_commits);
    ++	write_locked_index(r->index, &lock, COMMIT_LOCK);
    ++
     +	return ret;
     +}
     
12:  cc1500147b = 11:  bcc7b851ef merge: use the "resolve" strategy without forking
13:  ec3dc3b81e = 12:  9ba13186ed merge: use the "octopus" strategy without forking
14:  e7dc4a15d4 ! 13:  a815a16f33 sequencer: use the "resolve" strategy without forking
    @@ Commit message
     
      ## sequencer.c ##
     @@
    - #include "commit-reach.h"
    - #include "rebase-interactive.h"
      #include "reset.h"
    + #include "branch.h"
    + #include "log-tree.h"
     +#include "merge-strategies.h"
      
      #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
15:  34280dd82d ! 14:  5a11fd0e71 sequencer: use the "octopus" merge strategy without forking
    @@ Metadata
     Author: Alban Gruin <alban.gruin@gmail.com>
     
      ## Commit message ##
    -    sequencer: use the "octopus" merge strategy without forking
    +    sequencer: use the "octopus" strategy without forking
     
         This teaches the sequencer to invoke the "octopus" strategy with a
         function call instead of forking.
-- 
2.37.1.412.gcfdce49ffd

