Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF15C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiFIXo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiFIXo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 19:44:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB3606CE
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 16:44:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEE8F118ECF;
        Thu,  9 Jun 2022 19:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=v
        CQmJkUJdkZL5Ghmx+WRsTF48xYGrCCKrRgJHF4l6pc=; b=KC5wZdgUEcG7zPESB
        w2hVRRlSfn6LbblROc10bCJ9Bj2CafJAMrhgDNym/9yIDPciIWjM7rZsjUP3a5gT
        PDhtYz4hkTXfkrtpqIiRrUwTsR0yav4CMzWl+7kXvBO9n+TEA7qw+2JYkYutTh+P
        P+YkhgISDWayFLAm2TeyS8xy8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C69BF118ECE;
        Thu,  9 Jun 2022 19:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 421EA118ECD;
        Thu,  9 Jun 2022 19:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Date:   Thu, 09 Jun 2022 16:44:20 -0700
Message-ID: <xmqqfskdieqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15D2A494-E84E-11EC-B918-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resolve-undo extension was added to the index in cfc5789a
(resolve-undo: record resolved conflicts in a new index extension
section, 2009-12-25).  This extension records the blob object names
and their modes of conflicted paths when the path gets resolved
(e.g. with "git add"), to allow "undoing" the resolution with
"checkout -m path".  These blob objects should be guarded from
garbage-collection while we have the resolve-undo information in the
index (otherwise unresolve operation may try to use a blob object
that has already been pruned away).

But the code called from mark_reachable_objects() for the index
forgets to do so.  Teach add_index_objects_to_pending() helper to
also add objects referred to by the resolve-undo extension.

Also make matching changes to "fsck", which has code that is fairly
similar to the reachability stuff, but have parallel implementations
for all these stuff, which may (or may not) someday want to be unified.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c            | 38 +++++++++++++++++++++
 revision.c                | 36 ++++++++++++++++++++
 t/t2030-unresolve-info.sh | 71 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9e54892311..4b17ccc3f4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "resolve-undo.h"
 #include "run-command.h"
 #include "worktree.h"
 
@@ -757,6 +758,42 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
+static int fsck_resolve_undo(struct index_state *istate)
+{
+	struct string_list_item *item;
+	struct string_list *resolve_undo = istate->resolve_undo;
+
+	if (!resolve_undo)
+		return 0;
+
+	for_each_string_list_item(item, resolve_undo) {
+		const char *path = item->string;
+		struct resolve_undo_info *ru = item->util;
+		int i;
+
+		if (!ru)
+			continue;
+		for (i = 0; i < 3; i++) {
+			struct object *obj;
+
+			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
+				continue;
+
+			obj = parse_object(the_repository, &ru->oid[i]);
+			if (!obj) {
+				error(_("%s: invalid sha1 pointer in resolve-undo"),
+				      oid_to_hex(&ru->oid[i]));
+				errors_found |= ERROR_REFS;
+			}
+			obj->flags |= USED;
+			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
+					     ":(%d):%s", i, path);
+			mark_object_reachable(obj);
+		}
+	}
+	return 0;
+}
+
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
 	struct object *obj = lookup_unknown_object(the_repository, oid);
@@ -938,6 +975,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
+		fsck_resolve_undo(&the_index);
 	}
 
 	check_connectivity();
diff --git a/revision.c b/revision.c
index 7d435f8048..cd78627b20 100644
--- a/revision.c
+++ b/revision.c
@@ -33,6 +33,7 @@
 #include "bloom.h"
 #include "json-writer.h"
 #include "list-objects-filter-options.h"
+#include "resolve-undo.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1690,6 +1691,39 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 
 }
 
+static void add_resolve_undo_to_pending(struct index_state *istate, struct rev_info *revs)
+{
+	struct string_list_item *item;
+	struct string_list *resolve_undo = istate->resolve_undo;
+
+	if (!resolve_undo)
+		return;
+
+	for_each_string_list_item(item, resolve_undo) {
+		const char *path = item->string;
+		struct resolve_undo_info *ru = item->util;
+		int i;
+
+		if (!ru)
+			continue;
+		for (i = 0; i < 3; i++) {
+			struct blob *blob;
+
+			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
+				continue;
+
+			blob = lookup_blob(revs->repo, &ru->oid[i]);
+			if (!blob) {
+				warning(_("resolve-undo records `%s` which is missing"),
+					oid_to_hex(&ru->oid[i]));
+				continue;
+			}
+			add_pending_object_with_path(revs, &blob->object, "",
+						     ru->mode[i], path);
+		}
+	}
+}
+
 static void do_add_index_objects_to_pending(struct rev_info *revs,
 					    struct index_state *istate,
 					    unsigned int flags)
@@ -1718,6 +1752,8 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		add_cache_tree(istate->cache_tree, revs, &path, flags);
 		strbuf_release(&path);
 	}
+
+	add_resolve_undo_to_pending(istate, revs);
 }
 
 void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index f691e6d903..2d8c70b03a 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -194,4 +194,75 @@ test_expect_success 'rerere forget (add-add conflict)' '
 	test_i18ngrep "no remembered" actual
 '
 
+test_expect_success 'resolve-undo keeps blobs from gc' '
+	git checkout -f main &&
+
+	# First make sure we do not have any cruft left in the object store
+	git repack -a -d &&
+	git prune --expire=now &&
+	git prune-packed &&
+	git gc --prune=now &&
+	git fsck --unreachable >cruft &&
+	test_must_be_empty cruft &&
+
+	# Now add three otherwise unreferenced blob objects to the index
+	git reset --hard &&
+	B1=$(echo "resolve undo test data 1" | git hash-object -w --stdin) &&
+	B2=$(echo "resolve undo test data 2" | git hash-object -w --stdin) &&
+	B3=$(echo "resolve undo test data 3" | git hash-object -w --stdin) &&
+	git update-index --add --index-info <<-EOF &&
+	100644 $B1 1	frotz
+	100644 $B2 2	frotz
+	100644 $B3 3	frotz
+	EOF
+
+	# These three blob objects are reachable (only) from the index
+	git fsck --unreachable >cruft &&
+	test_must_be_empty cruft &&
+	# and they should be protected from GC
+	git gc --prune=now &&
+	git cat-file -e $B1 &&
+	git cat-file -e $B2 &&
+	git cat-file -e $B3 &&
+
+	# Now resolve the conflicted path
+	B0=$(echo "resolve undo test data 0" | git hash-object -w --stdin) &&
+	git update-index --add --cacheinfo 100644,$B0,frotz &&
+
+	# These three blob objects are now reachable only from the resolve-undo
+	git fsck --unreachable >cruft &&
+	test_must_be_empty cruft &&
+
+	# and they should survive GC
+	git gc --prune=now &&
+	git cat-file -e $B0 &&
+	git cat-file -e $B1 &&
+	git cat-file -e $B2 &&
+	git cat-file -e $B3 &&
+
+	# Now we switch away, which nukes resolve-undo, and
+	# blobs B0..B3 would become dangling.  fsck should
+	# notice that they are now unreachable.
+	git checkout -f side &&
+	git fsck --unreachable >cruft &&
+	sort cruft >actual &&
+	sort <<-EOF >expect &&
+	unreachable blob $B0
+	unreachable blob $B1
+	unreachable blob $B2
+	unreachable blob $B3
+	EOF
+	test_cmp expect actual &&
+
+	# And they should go away when gc runs.
+	git gc --prune=now &&
+	git fsck --unreachable >cruft &&
+	test_must_be_empty cruft &&
+
+	test_must_fail git cat-file -e $B0 &&
+	test_must_fail git cat-file -e $B1 &&
+	test_must_fail git cat-file -e $B2 &&
+	test_must_fail git cat-file -e $B3
+'
+
 test_done
-- 
2.36.1-502-gf5055183a0

