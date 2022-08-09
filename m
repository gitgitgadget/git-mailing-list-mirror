Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E45BC25B08
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbiHITJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiHITJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7B2317E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay12so3908668wmb.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ksl2l8rhSZcCM4WzucrlS6OrefO74SDt8fRGsk1CB5g=;
        b=H7xA6y3+HZIWnUevlAatg3uMvfuAAjwXgfSPLOqGTcgtRuS8DaLkk9MeiSc6+DaHJB
         aMG7rGf3mkh7x0/wzcqS9CZpht1+/mViE2yPDS6l7uZXOXiR4J4f7NDn8xWO9ZP7q5RN
         KWZuHfTL9xtTHycaTiUgCWIuabEHwL07FHIciD0V9cA2pr4HSvsPRQZ6T5MoqEgWgQIW
         NxB5DGwxGNYfe59Dj2kDyyPFuMlrhCtX1oDtsSgKPXNDpwzDRme18wpwebbKAM8k4qvs
         M11eyTYFy1f9LNafWsIbDR57aywbHkRL5R5eULxcKz1AL3NNiTuW+f1WjK+tfbIIvOI8
         zOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ksl2l8rhSZcCM4WzucrlS6OrefO74SDt8fRGsk1CB5g=;
        b=b1U19+12yO71GTurozWVzk1X/Xn1m5UxaIwWAjl1dPB/aNufmZV/7RC9VxdHuBBsPu
         ZbnQpujw//baM5A0cxQ4hDH7AfQttrUn3XDISN0FJ3qR9geRkT0AUGzws/kiGoyQpk5D
         pLPNY7EG0fY745t7uk0bOKzlHLCNYPKEy9Dht8a//QpxcTw3cW8vFDJALLHxthAl5Urt
         cBM2lxS1gBkyDWkPfZ6bCLClgQtXfvol64/UZqgBWWhlBCpSrX46Pbh8A5QVcJpZFUGV
         shw9HyoqLQ+PhtPgcDHVHDw7i/g4B6oc+FlGO9fiOCoQl/51n7UZvP8dEJa5PPmcsNUz
         czfw==
X-Gm-Message-State: ACgBeo1QaHPXne/HoIC4UnZ5K6F3AE5a/MWmId3Vb/XKR/Kmhnv18PVm
        cWFd+Ejzu0f247xlK5j4gfridjdBcnY=
X-Google-Smtp-Source: AA6agR7pPga0+WXGmiG1ZHiVAwpkAKVlhvTGBbT9LQl0TqlhnvHjyNzgbt81GVXI6qdmIqesBm0spQ==
X-Received: by 2002:a1c:7209:0:b0:3a3:1f31:ef3a with SMTP id n9-20020a1c7209000000b003a31f31ef3amr21278358wmc.87.1660071333060;
        Tue, 09 Aug 2022 11:55:33 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 10/14] merge-octopus: rewrite in C
Date:   Tue,  9 Aug 2022 20:54:25 +0200
Message-Id: <20220809185429.20098-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-octopus' from shell to C.  As for the two last
conversions, this port removes calls to external processes to avoid
reading and writing the index over and over again.

 - Calls to `read-tree -u -m (--aggressive)?' are replaced by calls to
   unpack_trees().

 - The call to `write-tree' is replaced by a call to write_tree().

 - The call to `diff-index ...' is replaced by a call to
   repo_index_has_changes().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to merge_all_index().

The index is read in cmd_merge_octopus(), and is written back by
merge_strategies_octopus(), for the same reason as merge-resolve.

Here too, merge_strategies_octopus() takes two commit lists and a string
to reduce friction when try_merge_strategies() will be modified to call
it directly.  It also locks the index at the start of the merge, and
releases it at the end.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |   2 +-
 builtin.h               |   1 +
 builtin/merge-octopus.c |  63 +++++++++++++++
 git-merge-octopus.sh    | 112 --------------------------
 git.c                   |   1 +
 merge-strategies.c      | 171 ++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |   3 +
 7 files changed, 240 insertions(+), 113 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 delete mode 100755 git-merge-octopus.sh

diff --git a/Makefile b/Makefile
index 0c18acb979..9fe1e72f6e 100644
--- a/Makefile
+++ b/Makefile
@@ -630,7 +630,6 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1184,6 +1183,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-octopus.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
diff --git a/builtin.h b/builtin.h
index 4627229944..9305dda166 100644
--- a/builtin.h
+++ b/builtin.h
@@ -180,6 +180,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
new file mode 100644
index 0000000000..ff3089bfca
--- /dev/null
+++ b/builtin/merge-octopus.c
@@ -0,0 +1,63 @@
+/*
+ * Builtin "git merge-octopus"
+ *
+ * Copyright (c) 2020 Alban Gruin
+ *
+ * Based on git-merge-octopus.sh, written by Junio C Hamano.
+ *
+ * Resolve two or more trees.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_octopus_usage[] =
+	"git merge-octopus [<bases>...] -- <head> <remote1> <remote2> [<remotes>...]";
+
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
+{
+	int i, sep_seen = 0;
+	struct commit_list *bases = NULL, *remotes = NULL;
+	struct commit_list **next_base = &bases, **next_remote = &remotes;
+	const char *head_arg = NULL;
+	struct repository *r = the_repository;
+
+	if (argc < 5)
+		usage(builtin_merge_octopus_usage);
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
+		if (strcmp(argv[i], "--") == 0)
+			sep_seen = 1;
+		else if (strcmp(argv[i], "-h") == 0)
+			usage(builtin_merge_octopus_usage);
+		else if (sep_seen && !head_arg)
+			head_arg = argv[i];
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
+				next_remote = commit_list_append(commit, next_remote);
+			else
+				next_base = commit_list_append(commit, next_base);
+		}
+	}
+
+	return merge_strategies_octopus(r, bases, head_arg, remotes);
+}
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
deleted file mode 100755
index 2770891960..0000000000
--- a/git-merge-octopus.sh
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-# Resolve two or more trees.
-#
-
-. git-sh-setup
-
-LF='
-'
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
-# Reject if this is not an octopus -- resolve should be used instead.
-case "$remotes" in
-?*' '?*)
-	;;
-*)
-	exit 2 ;;
-esac
-
-# MRC is the current "merge reference commit"
-# MRT is the current "merge result tree"
-
-if ! git diff-index --quiet --cached HEAD --
-then
-    gettextln "Error: Your local changes to the following files would be overwritten by merge"
-    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
-    exit 2
-fi
-MRC=$(git rev-parse --verify -q $head)
-MRT=$(git write-tree)
-NON_FF_MERGE=0
-OCTOPUS_FAILURE=0
-for SHA1 in $remotes
-do
-	case "$OCTOPUS_FAILURE" in
-	1)
-		# We allow only last one to have a hand-resolvable
-		# conflicts.  Last round failed and we still had
-		# a head to merge.
-		gettextln "Automated merge did not work."
-		gettextln "Should not be doing an octopus."
-		exit 2
-	esac
-
-	eval pretty_name=\${GITHEAD_$SHA1:-$SHA1}
-	if test "$SHA1" = "$pretty_name"
-	then
-		SHA1_UP="$(echo "$SHA1" | tr a-z A-Z)"
-		eval pretty_name=\${GITHEAD_$SHA1_UP:-$pretty_name}
-	fi
-	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "$(eval_gettext "Unable to find common commit with \$pretty_name")"
-
-	case "$LF$common$LF" in
-	*"$LF$SHA1$LF"*)
-		eval_gettextln "Already up to date with \$pretty_name"
-		continue
-		;;
-	esac
-
-	if test "$common,$NON_FF_MERGE" = "$MRC,0"
-	then
-		# The first head being merged was a fast-forward.
-		# Advance MRC to the head being merged, and use that
-		# tree as the intermediate result of the merge.
-		# We still need to count this as part of the parent set.
-
-		eval_gettextln "Fast-forwarding to: \$pretty_name"
-		git read-tree -u -m $head $SHA1 || exit
-		MRC=$SHA1 MRT=$(git write-tree)
-		continue
-	fi
-
-	NON_FF_MERGE=1
-
-	eval_gettextln "Trying simple merge with \$pretty_name"
-	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
-	next=$(git write-tree 2>/dev/null)
-	if test $? -ne 0
-	then
-		gettextln "Simple merge did not work, trying automatic merge."
-		git merge-index -o --use=merge-one-file -a ||
-		OCTOPUS_FAILURE=1
-		next=$(git write-tree 2>/dev/null)
-	fi
-
-	MRC="$MRC $SHA1"
-	MRT=$next
-done
-
-exit "$OCTOPUS_FAILURE"
diff --git a/git.c b/git.c
index 09d222da88..7a5e506c64 100644
--- a/git.c
+++ b/git.c
@@ -560,6 +560,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-octopus", cmd_merge_octopus, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index 30f225ae5f..3e8255614b 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "cache-tree.h"
+#include "commit-reach.h"
 #include "dir.h"
 #include "entry.h"
 #include "lockfile.h"
@@ -417,3 +418,173 @@ int merge_strategies_resolve(struct repository *r,
 		return !!error(_("unable to write new index file"));
 	return !!ret;
 }
+
+static int octopus_fast_forward(struct repository *r, const char *branch_name,
+				struct tree *tree_head, struct tree *current_tree)
+{
+	/*
+	 * The first head being merged was a fast-forward.  Advance the
+	 * reference commit to the head being merged, and use that tree
+	 * as the intermediate result of the merge.  We still need to
+	 * count this as part of the parent set.
+	 */
+	struct tree_desc t[2];
+
+	printf(_("Fast-forwarding to: %s\n"), branch_name);
+
+	init_tree_desc(t, tree_head->buffer, tree_head->size);
+	if (add_tree(current_tree, t + 1))
+		return -1;
+	if (merge_trees(r, t, 2, 0))
+		return -1;
+	if (write_tree(r))
+		return -1;
+
+	return 0;
+}
+
+static int octopus_do_merge(struct repository *r, const char *branch_name,
+			    struct commit_list *common, struct tree *current_tree,
+			    struct tree *reference_tree)
+{
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct commit_list *i;
+	int nr = 0, ret = 0;
+
+	printf(_("Trying simple merge with %s\n"), branch_name);
+
+	for (i = common; i; i = i->next) {
+		struct tree *tree = repo_get_commit_tree(r, i->item);
+		if (add_tree(tree, t + (nr++)))
+			return -1;
+	}
+
+	if (add_tree(reference_tree, t + (nr++)))
+		return -1;
+	if (add_tree(current_tree, t + (nr++)))
+		return -1;
+	if (merge_trees(r, t, nr, 1))
+		return 2;
+
+	if (write_tree(r)) {
+		puts(_("Simple merge did not work, trying automatic merge."));
+		ret = !!merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
+		write_tree(r);
+	}
+
+	return ret;
+}
+
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remotes)
+{
+	int ff_merge = 1, ret = 0, nr_references = 1;
+	struct commit **reference_commits, *head_commit;
+	struct tree *reference_tree, *head_tree;
+	struct commit_list *i;
+	struct object_id head;
+	struct lock_file lock = LOCK_INIT;
+
+	/*
+	 * Reject if this is not an octopus -- resolve should be used
+	 * instead.
+	 */
+	if (commit_list_count(remotes) < 2)
+		return 2;
+
+	/* Abort if index does not match head */
+	if (check_index_is_head(r, head_arg))
+		return 2;
+
+	get_oid(head_arg, &head);
+	head_commit = lookup_commit_reference(r, &head);
+	head_tree = repo_get_commit_tree(r, head_commit);
+
+	CALLOC_ARRAY(reference_commits, commit_list_count(remotes) + 1);
+	reference_commits[0] = head_commit;
+	reference_tree = head_tree;
+
+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+
+	for (i = remotes; i && i->item; i = i->next) {
+		struct commit *c = i->item;
+		struct object_id *oid = &c->object.oid;
+		struct tree *current_tree = repo_get_commit_tree(r, c);
+		struct commit_list *common, *j;
+		char *branch_name = merge_get_better_branch_name(oid_to_hex(oid));
+		int up_to_date = 0;
+
+		common = repo_get_merge_bases_many(r, c, nr_references, reference_commits);
+		if (!common) {
+			error(_("Unable to find common commit with %s"), branch_name);
+
+			free(branch_name);
+			free_commit_list(common);
+
+			ret = 2;
+			break;
+		}
+
+		/*
+		 * If `oid' is reachable from `HEAD', we're already up
+		 * to date.
+		 */
+		for (j = common; j; j = j->next) {
+			if (oideq(&j->item->object.oid, oid)) {
+				up_to_date = 1;
+				break;
+			}
+		}
+
+		if (up_to_date) {
+			printf(_("Already up to date with %s\n"), branch_name);
+
+			free(branch_name);
+			free_commit_list(common);
+			continue;
+		}
+
+		/*
+		 * If we could fast-forward so far and `HEAD' is the
+		 * single merge base with the current `remote' revision,
+		 * keep fast-forwarding.
+		 */
+		if (ff_merge && common && !common->next && nr_references == 1 &&
+		    oideq(&common->item->object.oid,
+			  &reference_commits[0]->object.oid)) {
+			ret = octopus_fast_forward(r, branch_name, head_tree, current_tree);
+			nr_references = 0;
+		} else {
+			ret = octopus_do_merge(r, branch_name, common,
+					       current_tree, reference_tree);
+			ff_merge = 0;
+		}
+
+		free(branch_name);
+		free_commit_list(common);
+
+		if (ret == -1 || ret == 2)
+			break;
+		else if (ret && i->next) {
+			/*
+			 * We allow only last one to have a
+			 * hand-resolvable conflicts.  Last round failed
+			 * and we still had a head to merge.
+			 */
+			puts(_("Automated merge did not work."));
+			puts(_("Should not be doing an octopus."));
+
+			ret = 2;
+			break;
+		}
+
+		reference_commits[nr_references++] = c;
+		reference_tree = lookup_tree(r, &r->index->cache_tree->oid);
+	}
+
+	free(reference_commits);
+	write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+	return ret;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index bba4bf999c..8de2249ee6 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -32,5 +32,8 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 int merge_strategies_resolve(struct repository *r,
 			     struct commit_list *bases, const char *head_arg,
 			     struct commit_list *remote);
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
 
 #endif /* MERGE_STRATEGIES_H */
-- 
2.37.1.412.gcfdce49ffd

