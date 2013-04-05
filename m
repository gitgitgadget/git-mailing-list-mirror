From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri,  5 Apr 2013 22:07:58 +0530
Message-ID: <1365179878-2259-1-git-send-email-artagnon@gmail.com>
References: <CA+55aFxyyqkS4XyE1as2TdeARce9g9BTK=jdY+XcomNtMdrArg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWKK-0002u6-EK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161999Ab3DEQiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:38:06 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:48226 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161970Ab3DEQiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:38:04 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so1645533dan.7
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=i18dPUELWE5Iq68q1k+2u+VDLgiYZmp19CLP5cWvyYA=;
        b=TZNUfbv26YNYmZeM2GXxD7d3CSP3YNhOItPTHBDw8gvCyKBKPwzdgaumh7wrA3PZxB
         kGkufumx45BiseUtoV7oYCBR41w0mD07/PUhnkzEpkBYWMFxXskAks/I49JMK2NK6myt
         IoekjqCdBU574EbaCodDs9/BJUirSndgidDAFd4j6usasZot6dVfPq3lCbxFDta2af5K
         hhBYk2Nzn0zlG+KC31r2NbOS1hUK7yVL+lZIDCMSr0fEJT43gXOq68TOnplvTxm89dDK
         PY2PP1ItUrl+kznZ4kLDa6X6udEsDus1w2thP1b9Fjr3JWJyDHDYjsap0JNZxqmaFf1F
         A2qQ==
X-Received: by 10.68.57.139 with SMTP id i11mr15642982pbq.185.1365179883188;
        Fri, 05 Apr 2013 09:38:03 -0700 (PDT)
Received: from localhost.localdomain ([122.174.45.110])
        by mx.google.com with ESMTPS id is1sm15043011pbc.15.2013.04.05.09.38.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 09:38:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <CA+55aFxyyqkS4XyE1as2TdeARce9g9BTK=jdY+XcomNtMdrArg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220177>

Linus Torvalds wrote:
> So you absolutely need a dirty worktree. You need it for testing, and
> you need it for merging. Having a model where you don't have a
> in-progress entity that works as a temporary is absolutely and
> entirely wrong.

I agree entirely.  My comment was just a "by the way", and specific to
how people work with .gitmodules: I didn't imply any strong notions of
Right or Wrong with respect to dirty worktrees in general.  So, yes:
links stage and unstage, just like blobs do.

Oh, and I'm currently writing infrastructure to work with links like
blobs.  Here's a WIP: git cat-link <link> is exactly the same as cat
<file>, to the end user.

-- 8< --
From d8a1de6f9075771dde6f1fde9ffa193dce386a17 Mon Sep 17 00:00:00 2001
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Fri, 5 Apr 2013 19:42:56 +0530
Subject: [PATCH] builtin/cat-link: implement new builtin

This is a simple program that calls unpack_trees() with a custom
callback that just prints the contents of whatever objects were
matched using revs.prune_data.  Blobs can be cat'ed directly from the
filesystem, so this program is primarily useful for links; git
cat-link <link> shows it up like a blob.

We will use this program to build edit-link.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile           |  3 +-
 builtin.h          |  1 +
 builtin/cat-link.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff-lib.c         | 10 +++----
 diff.h             |  6 ++++
 git.c              |  1 +
 6 files changed, 98 insertions(+), 6 deletions(-)
 create mode 100644 builtin/cat-link.c

diff --git a/Makefile b/Makefile
index cd4b6f9..28194d7 100644
--- a/Makefile
+++ b/Makefile
@@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O0 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -893,6 +893,7 @@ BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
+BUILTIN_OBJS += builtin/cat-link.o
 BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-ref-format.o
diff --git a/builtin.h b/builtin.h
index faef559..be0160d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,7 @@ extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
+extern int cmd_cat_link(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
diff --git a/builtin/cat-link.c b/builtin/cat-link.c
new file mode 100644
index 0000000..14dd92b
--- /dev/null
+++ b/builtin/cat-link.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2013 Ramkumar Ramachandra
+ */
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+#include "unpack-trees.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+static int cat_file(struct cache_entry **src, struct unpack_trees_options *o) {
+	int cached, match_missing = 1;
+	unsigned dirty_submodule = 0;
+	unsigned int mode;
+	const unsigned char *sha1;
+	struct cache_entry *idx = src[0];
+	struct cache_entry *tree = src[1];
+	struct rev_info *revs = o->unpack_data;
+	enum object_type type;
+	unsigned long size;
+	char *buf;
+
+	cached = o->index_only;
+	if (ce_path_match(idx ? idx : tree, &revs->prune_data)) {
+		if (get_stat_data(idx, &sha1, &mode, cached, match_missing,
+					&dirty_submodule, NULL) < 0)
+			die("Something went wrong!");
+		buf = read_sha1_file(sha1, &type, &size);
+		printf("%s", buf);
+	}
+	return 0;
+}
+
+int cmd_cat_link(int argc, const char **argv, const char *prefix)
+{
+	struct unpack_trees_options opts;
+	int cached = 1;
+	struct rev_info revs;
+	struct tree *tree;
+	struct tree_desc tree_desc;
+	struct object_array_entry *ent;
+
+	if (argc < 2)
+		die("Usage: git cat-link <link>");
+
+	init_revisions(&revs, prefix);
+	setup_revisions(argc, argv, &revs, NULL); /* For revs.prune_data */
+	add_head_to_pending(&revs);
+
+	/* Hack to diff against index; we create a dummy tree for the
+	   index information */
+	if (!revs.pending.nr) {
+		struct tree *tree;
+		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+		add_pending_object(&revs, &tree->object, "HEAD");
+	}
+
+	if (read_cache() < 0)
+		die("read_cache() failed");
+	ent = revs.pending.objects;
+	tree = parse_tree_indirect(ent->item->sha1);
+	if (!tree)
+		return error("bad tree object %s",
+			     ent->name ? ent->name : sha1_to_hex(ent->item->sha1));
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.index_only = cached;
+	opts.diff_index_cached = cached;
+	opts.merge = 1;
+	opts.fn = cat_file;
+	opts.unpack_data = &revs;
+	opts.src_index = &the_index;
+	opts.dst_index = NULL;
+	opts.pathspec = &revs.diffopt.pathspec;
+	opts.pathspec->recursive = 1;
+	opts.pathspec->max_depth = -1;
+
+	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+	unpack_trees(1, &tree_desc, &opts);
+	return 0;
+}
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..b0ba136 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -246,11 +246,11 @@ static void diff_index_show_file(struct rev_info *revs,
 		       sha1, sha1_valid, ce->name, dirty_submodule);
 }
 
-static int get_stat_data(struct cache_entry *ce,
-			 const unsigned char **sha1p,
-			 unsigned int *modep,
-			 int cached, int match_missing,
-			 unsigned *dirty_submodule, struct diff_options *diffopt)
+int get_stat_data(struct cache_entry *ce,
+		const unsigned char **sha1p,
+		unsigned int *modep,
+		int cached, int match_missing,
+		unsigned *dirty_submodule, struct diff_options *diffopt)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
diff --git a/diff.h b/diff.h
index 78b4091..02ed497 100644
--- a/diff.h
+++ b/diff.h
@@ -326,6 +326,12 @@ extern int diff_result_code(struct diff_options *, int);
 
 extern void diff_no_index(struct rev_info *, int, const char **, int, const char *);
 
+extern int get_stat_data(struct cache_entry *ce,
+			const unsigned char **sha1p,
+			unsigned int *modep,
+			int cached, int match_missing,
+			unsigned *dirty_submodule, struct diff_options *diffopt);
+
 extern int index_differs_from(const char *def, int diff_flags);
 
 extern size_t fill_textconv(struct userdiff_driver *driver,
diff --git a/git.c b/git.c
index 850d3f5..3f3f074 100644
--- a/git.c
+++ b/git.c
@@ -313,6 +313,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
+		{ "cat-link", cmd_cat_link, RUN_SETUP },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 		{ "check-ref-format", cmd_check_ref_format },
-- 
1.8.2.380.g0d4e79b
