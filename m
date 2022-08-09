Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E5C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbiHITJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbiHITJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8B2251E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j1so15343868wrw.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fAVmtMNvs0oHXnGRsrKnKiTOAYJxorsy23H2Q85JteI=;
        b=ol/55fpX7QWaO0vOAvWle6znzF9bxcMwde2NskzdGJqM12rzTvGVhYB4fL4oV+8Due
         1eAArHunrs4tvGSbn4nU5zoxF7FE0XvZYHYUI2uOEhiLQnYtFdWAjF81C9n4/B3SZWxp
         umMWcD8YA2qwW55UHOnl9CNf57DGfqGieB0vw3lAp+jpJ7w6wqQ18nHd0yJ8mGGH06eC
         z5QWT6W99K3Rf32gb3TNMG2wWrATltvwOf5Up6WxzColSd3mIzmhBnpgic5THJWw/iZY
         AJnwaoClBCEMSlVY8G7cPVaDZP4euz+bms1vdgJiud03Ib2VDdGRY7nhDfbBq43WT0Ae
         T0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fAVmtMNvs0oHXnGRsrKnKiTOAYJxorsy23H2Q85JteI=;
        b=F7ly9dPAnrx5SswAp7Gc/gfGASo8+nbhPx14vUNo7SnVRnfRt0qWjigd/5S4MA59nH
         kNFPASBBdFkRDGfkJgBKt7K9kwqJw8UcjYfQM8brWF/3oLaaXOH2jAG24l4TExZrIEmd
         j2bE2srJWZWSDfOCg/Ur8Bwz2rkpOVpo9y5T2EuPjbaAeuls748uzya4kZXN7l3nTRR0
         T9pCwdaOwrcfA2IRnDCA5sPnSrILqSzqtoGUVIkNk/MdBQWpnuRzBsvYInHSDTnuj8t3
         JlqBfYmlageeyAMXKD+yipmc6E4X348R7nNKrUcUoU8CasTN5KPs/AH0hI/Hykn61KlR
         GYzQ==
X-Gm-Message-State: ACgBeo1/BTkilY4hTrQhicSyO6lglYiCHv6N7YC2WvmMwW+R0a6JjbWa
        1rC1aQ0927ZM6y05eyq9WT7x/q9DOLw=
X-Google-Smtp-Source: AA6agR7ihduE4jUhqd0PeBOM8+PTj4j4Tql/sOgAE/e5TT1k3C7IZ3FvulLgyykOn1oRdbeHyCIp/A==
X-Received: by 2002:a05:6000:1446:b0:222:c466:58a0 with SMTP id v6-20020a056000144600b00222c46658a0mr9095914wrx.53.1660071331143;
        Tue, 09 Aug 2022 11:55:31 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 08/14] merge-resolve: rewrite in C
Date:   Tue,  9 Aug 2022 20:54:23 +0200
Message-Id: <20220809185429.20098-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-resolve' from shell to C.  As for `git
merge-one-file', this port is not completely straightforward and removes
calls to external processes to avoid reading and writing the index over
and over again.

 - The call to `update-index -q --refresh' is replaced by a call to
   refresh_index().

 - The call to `read-tree' is replaced by a call to unpack_trees() (and
   all the setup needed).

 - The call to `write-tree' is replaced by a call to
   cache_tree_update().  This call is wrapped in a new function,
   write_tree().  It is made to mimick write_index_as_tree() with
   WRITE_TREE_SILENT flag, but without locking the index; this is taken
   care directly in merge_strategies_resolve().

 - The call to `diff-index ...' is replaced by a call to
   repo_index_has_changes().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to the new merge_all_index() function.

The index is read in cmd_merge_resolve(), and is wrote back by
merge_strategies_resolve().  This is to accomodate future applications:
in `git-merge', the index has already been read when the merge strategy
is called, so it would be redundant to read it again when the builtin
will be able to use merge_strategies_resolve() directly.

The parameters of merge_strategies_resolve() will be surprising at first
glance: why using a commit list for `bases' and `remote', where we could
use an oid array, and a pointer to an oid?  Because, in a later commit,
try_merge_strategy() will be able to call merge_strategies_resolve()
directly, and it already uses a commit list for `bases' (`common') and
`remote' (`remoteheads'), and a string for `head_arg'.  To reduce
frictions later, merge_strategies_resolve() takes the same types of
parameters.

merge_strategies_resolve() locks the index only once, at the beginning
of the merge, and releases it when the merge has been completed.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |   2 +-
 builtin.h               |   1 +
 builtin/merge-resolve.c |  63 ++++++++++++++++++
 git-merge-resolve.sh    |  64 -------------------
 git.c                   |   1 +
 merge-strategies.c      | 137 ++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |   5 ++
 7 files changed, 208 insertions(+), 65 deletions(-)
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-resolve.sh

diff --git a/Makefile b/Makefile
index e2e6cbbb41..0c18acb979 100644
--- a/Makefile
+++ b/Makefile
@@ -631,7 +631,6 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1188,6 +1187,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-resolve.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
diff --git a/builtin.h b/builtin.h
index cdbe91bbe8..4627229944 100644
--- a/builtin.h
+++ b/builtin.h
@@ -184,6 +184,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
new file mode 100644
index 0000000000..a51158ebf8
--- /dev/null
+++ b/builtin/merge-resolve.c
@@ -0,0 +1,63 @@
+/*
+ * Builtin "git merge-resolve"
+ *
+ * Copyright (c) 2020 Alban Gruin
+ *
+ * Based on git-merge-resolve.sh, written by Linus Torvalds and Junio C
+ * Hamano.
+ *
+ * Resolve two trees, using enhanced multi-base read-tree.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_resolve_usage[] =
+	"git merge-resolve <bases>... -- <head> <remote>";
+
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
+{
+	int i, sep_seen = 0;
+	const char *head = NULL;
+	struct commit_list *bases = NULL, *remote = NULL;
+	struct commit_list **next_base = &bases;
+	struct repository *r = the_repository;
+
+	if (argc < 5)
+		usage(builtin_merge_resolve_usage);
+
+	setup_work_tree();
+	if (repo_read_index(r) < 0)
+		die("invalid index");
+
+	/*
+	 * The first parameters up to -- are merge bases; the rest are
+	 * heads.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--"))
+			sep_seen = 1;
+		else if (!strcmp(argv[i], "-h"))
+			usage(builtin_merge_resolve_usage);
+		else if (sep_seen && !head)
+			head = argv[i];
+		else {
+			struct object_id oid;
+			struct commit *commit;
+
+			if (get_oid(argv[i], &oid))
+				die("object %s not found.", argv[i]);
+
+			commit = oideq(&oid, r->hash_algo->empty_tree) ?
+				NULL : lookup_commit_or_die(&oid, argv[i]);
+
+			if (sep_seen)
+				commit_list_insert(commit, &remote);
+			else
+				next_base = commit_list_append(commit, next_base);
+		}
+	}
+
+	return merge_strategies_resolve(r, bases, head, remote);
+}
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
deleted file mode 100755
index e59175eb75..0000000000
--- a/git-merge-resolve.sh
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-# Copyright (c) 2005 Junio C Hamano
-#
-# Resolve two trees, using enhanced multi-base read-tree.
-
-. git-sh-setup
-
-# Abort if index does not match HEAD
-if ! git diff-index --quiet --cached HEAD --
-then
-    gettextln "Error: Your local changes to the following files would be overwritten by merge"
-    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
-    exit 2
-fi
-
-# The first parameters up to -- are merge bases; the rest are heads.
-bases= head= remotes= sep_seen=
-for arg
-do
-	case ",$sep_seen,$head,$arg," in
-	*,--,)
-		sep_seen=yes
-		;;
-	,yes,,*)
-		head=$arg
-		;;
-	,yes,*)
-		remotes="$remotes$arg "
-		;;
-	*)
-		bases="$bases$arg "
-		;;
-	esac
-done
-
-# Give up if we are given two or more remotes -- not handling octopus.
-case "$remotes" in
-?*' '?*)
-	exit 2 ;;
-esac
-
-# Give up if this is a baseless merge.
-if test '' = "$bases"
-then
-	exit 2
-fi
-
-git update-index -q --refresh
-git read-tree -u -m --aggressive $bases $head $remotes || exit 2
-echo "Trying simple merge."
-if result_tree=$(git write-tree 2>/dev/null)
-then
-	exit 0
-else
-	echo "Simple merge failed, trying Automatic merge."
-	if git merge-index -o --use=merge-one-file -a
-	then
-		exit 0
-	else
-		exit 1
-	fi
-fi
diff --git a/git.c b/git.c
index f5d3c6cb39..09d222da88 100644
--- a/git.c
+++ b/git.c
@@ -565,6 +565,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-resolve", cmd_merge_resolve, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index 373b69c10b..30f225ae5f 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,9 +1,34 @@
 #include "cache.h"
+#include "cache-tree.h"
 #include "dir.h"
 #include "entry.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+static int check_index_is_head(struct repository *r, const char *head_arg)
+{
+	struct commit *head_commit;
+	struct tree *head_tree;
+	struct object_id head;
+	struct strbuf sb = STRBUF_INIT;
+
+	get_oid(head_arg, &head);
+	head_commit = lookup_commit_reference(r, &head);
+	head_tree = repo_get_commit_tree(r, head_commit);
+
+	if (repo_index_has_changes(r, head_tree, &sb)) {
+		error(_("Your local changes to the following files "
+			"would be overwritten by merge:\n  %s"),
+		      sb.buf);
+		strbuf_release(&sb);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int add_merge_result_to_index(struct index_state *istate, unsigned int mode,
 				     const struct object_id *oid, const char *path,
 				     int checkout)
@@ -280,3 +305,115 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 		error(_("merge program failed"));
 	return err;
 }
+
+static int merge_trees(struct repository *r, struct tree_desc *t,
+		       int nr, int aggressive)
+{
+	struct unpack_trees_options opts;
+
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = r->index;
+	opts.dst_index = r->index;
+	opts.merge = 1;
+	opts.update = 1;
+	opts.aggressive = aggressive;
+
+	if (nr == 1)
+		opts.fn = oneway_merge;
+	else if (nr == 2) {
+		opts.fn = twoway_merge;
+		opts.initial_checkout = is_index_unborn(r->index);
+	} else if (nr >= 3) {
+		opts.fn = threeway_merge;
+		opts.head_idx = nr - 1;
+	}
+
+	if (unpack_trees(nr, t, &opts))
+		return -1;
+	return 0;
+}
+
+static int add_tree(struct tree *tree, struct tree_desc *t)
+{
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+	return 0;
+}
+
+static int write_tree(struct repository *r)
+{
+	int was_valid;
+	was_valid = r->index->cache_tree &&
+		cache_tree_fully_valid(r->index->cache_tree);
+
+	if (!was_valid && cache_tree_update(r->index, WRITE_TREE_SILENT) < 0)
+		return WRITE_TREE_UNMERGED_INDEX;
+	return 0;
+}
+
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote)
+{
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct commit_list *i;
+	struct lock_file lock = LOCK_INIT;
+	int nr = 0, ret = 0;
+
+	/* Abort if index does not match head */
+	if (check_index_is_head(r, head_arg))
+		return 2;
+
+	/*
+	 * Give up if we are given two or more remotes.  Not handling
+	 * octopus.
+	 */
+	if (remote && remote->next)
+		return 2;
+
+	/* Give up if this is a baseless merge. */
+	if (!bases)
+		return 2;
+
+	puts(_("Trying simple merge."));
+
+	for (i = bases; i && i->item; i = i->next) {
+		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))
+			return 2;
+	}
+
+	if (head_arg) {
+		struct object_id head;
+		struct tree *tree;
+
+		get_oid(head_arg, &head);
+		tree = parse_tree_indirect(&head);
+
+		if (add_tree(tree, t + (nr++)))
+			return 2;
+	}
+
+	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
+		return 2;
+
+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+
+	if (merge_trees(r, t, nr, 1)) {
+		rollback_lock_file(&lock);
+		return 2;
+	}
+
+	if (write_tree(r)) {
+		puts(_("Simple merge failed, trying Automatic merge."));
+		ret = merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
+	}
+
+	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
+		return !!error(_("unable to write new index file"));
+	return !!ret;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index 8705a550ca..bba4bf999c 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_STRATEGIES_H
 #define MERGE_STRATEGIES_H
 
+#include "commit.h"
 #include "object.h"
 
 int merge_three_way(struct index_state *istate,
@@ -28,4 +29,8 @@ int merge_index_path(struct index_state *istate, int oneshot, int quiet,
 int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 		    merge_fn fn, void *data);
 
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.37.1.412.gcfdce49ffd

