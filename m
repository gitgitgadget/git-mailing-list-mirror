Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C6C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282B7613BF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhFNHB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:01:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:54176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhFNHB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 03:01:57 -0400
Received: (qmail 442 invoked by uid 109); 14 Jun 2021 06:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Jun 2021 06:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30548 invoked by uid 111); 14 Jun 2021 06:59:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Jun 2021 02:59:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Jun 2021 02:59:53 -0400
From:   Jeff King <peff@peff.net>
To:     Mathijs Kwik <mathijs@bluescreen303.nl>
Cc:     git@vger.kernel.org
Subject: Re: still using `git pack-redundant` - alternatives?
Message-ID: <YMb+aXglvXel3Caa@coredump.intra.peff.net>
References: <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 01:10:58PM +0200, Mathijs Kwik wrote:

> I have some scripts for personal automation where I use git for
> backups and file synchronisation between systems.
> 
> It uses some form of tiering where large files, older files, and files
> no longer present in branch heads, move to slower networked storage
> and get linked via the "alternates" mechanism.
> 
> Since repacks are too expensive most of the time, I use `git
> pack-redundant --all --alt-odb` to clear out "local" packs which
> contents have become available in an alternate.
> 
> So since pack-redundant is nominated for removal, I would like to know
> if there are any alternatives for this type of book-keeping. Of course
> I can use `git show-index` and `comm` to implement similar
> functionality, but using built-in facilities is less error-prone and
> more efficient most of the time.

No, I don't think there's another mechanism. The recommended way is to
do a repack. It is more expensive, but one advantage is that you can
actually get rid of redundant objects that are in "mixed" packs that
also contain non-redundant objects (since we can't otherwise just delete
a pack without rescuing the objects).

A long time ago I wrote a "local-redundant" command to use for dropping
objects found in an alternate (because pack-redundant tried to do much
more than this simple case, and performed poorly). I'm including it here
in case it's useful to you or anybody else. I'm inclined _not_ to
include it in Git, and instead continue recommending repack, but I could
be persuaded otherwise if somebody feels strongly.

We did use this patch in production at GitHub for a while, so in theory
it's pretty correct. But I had to forward-port it from its ~2018 state,
which was when we stopped using it. It does compile and pass its tests,
but there may be gotchas lurking. In particular, we've had subtle
problems with midxs and code that iterates over packs, and the two
features were certainly not used together back then. I think using
get_all_packs() here works, but I didn't test.

-- >8 --
Subject: [PATCH] quick-and-dirty resurrection of local-redundant

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                 |   1 +
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/local-redundant.c  | 137 +++++++++++++++++++++++++++++++++++++
 git.c                      |   1 +
 object-file.c              |  19 +++++
 object-store.h             |   2 +
 t/t5326-local-redundant.sh |  46 +++++++++++++
 8 files changed, 208 insertions(+)
 create mode 100644 builtin/local-redundant.c
 create mode 100755 t/t5326-local-redundant.sh

diff --git a/.gitignore b/.gitignore
index 311841f9be..a880dcea3c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,6 +86,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-local-redundant
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index c3565fc0f8..99e468004a 100644
--- a/Makefile
+++ b/Makefile
@@ -1105,6 +1105,7 @@ BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
+BUILTIN_OBJS += builtin/local-redundant.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..d85d008685 100644
--- a/builtin.h
+++ b/builtin.h
@@ -167,6 +167,7 @@ int cmd_help(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
+int cmd_local_redundant(int argc, const char **argv, const char *prefix);
 int cmd_log(int argc, const char **argv, const char *prefix);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/local-redundant.c b/builtin/local-redundant.c
new file mode 100644
index 0000000000..b0b0852abc
--- /dev/null
+++ b/builtin/local-redundant.c
@@ -0,0 +1,137 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "dir.h"
+#include "object-store.h"
+#include "packfile.h"
+
+static const char * const local_redundant_usage[] = {
+	"git local-redundant [--delete]",
+	NULL
+};
+
+static int pack_is_redundant(struct packed_git *p)
+{
+	uint32_t i;
+
+	if (open_pack_index(p))
+		return 0;
+
+	for (i = 0; i < p->num_objects; i++) {
+		struct object_id oid;
+		nth_packed_object_id(&oid, p, i);
+		if (!has_oid_nonlocal(&oid))
+			return 0;
+	}
+
+	return 1;
+}
+
+static void split_path(const char *path,
+		       struct strbuf *dir,
+		       struct strbuf *base)
+{
+	const char *slash = path + strlen(path) - 1;
+
+	while (slash >= path && !is_dir_sep(*slash))
+		slash--;
+
+	if (slash >= path) {
+		strbuf_add(dir, path, slash - path);
+		strbuf_addstr(base, slash + 1);
+	} else {
+		strbuf_addstr(dir, ".");
+		strbuf_addstr(base, path);
+	}
+}
+
+static int string_list_readdir(struct string_list *sl, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+
+	if (!dir)
+		return -1;
+
+	while ((de = readdir(dir)))
+		if (!is_dot_or_dotdot(de->d_name))
+			string_list_append(sl, de->d_name);
+	closedir(dir);
+	return 0;
+}
+
+static void remove_paths_matching(struct strbuf *path, const char *match)
+{
+	static char *cached_dirname;
+	static struct string_list cached_dir = STRING_LIST_INIT_DUP;
+	size_t baselen = path->len;
+	int i;
+
+	if (!cached_dirname || strcmp(cached_dirname, path->buf)) {
+		free(cached_dirname);
+		string_list_clear(&cached_dir, 0);
+		cached_dirname = xstrdup(path->buf);
+		string_list_readdir(&cached_dir, cached_dirname);
+		string_list_sort(&cached_dir);
+	}
+
+	i = string_list_find_insert_index(&cached_dir, match, 0);
+	while (i < cached_dir.nr) {
+		const char *entry = cached_dir.items[i++].string;
+
+		if (!starts_with(entry, match))
+			break;
+
+		strbuf_addf(path, "/%s", entry);
+		unlink(path->buf);
+		strbuf_setlen(path, baselen);
+	}
+}
+
+static void remove_pack(struct packed_git *p)
+{
+	struct strbuf dir = STRBUF_INIT, base = STRBUF_INIT;
+
+	split_path(p->pack_name, &dir, &base);
+	if (base.len < 4)
+		die("BUG: packfile '%s' does not end in .pack?", p->pack_name);
+	strbuf_setlen(&base, base.len - 4);
+
+	remove_paths_matching(&dir, base.buf);
+
+	strbuf_release(&dir);
+	strbuf_release(&base);
+}
+
+static void do_packs(int delete)
+{
+	struct packed_git *p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (!p->pack_local || p->pack_keep)
+			continue;
+		if (!pack_is_redundant(p))
+			continue;
+
+		printf("%s\n", p->pack_name);
+		if (delete)
+			remove_pack(p);
+	}
+}
+
+int cmd_local_redundant(int argc, const char **argv, const char *prefix)
+{
+	int delete = 0;
+	const struct option options[] = {
+		OPT_BOOL(0, "delete", &delete, N_("delete redundant packs")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     local_redundant_usage, 0);
+	if (argc)
+		usage_with_options(local_redundant_usage, options);
+
+	do_packs(delete);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 18bed9a996..d2fec1b3de 100644
--- a/git.c
+++ b/git.c
@@ -542,6 +542,7 @@ static struct cmd_struct commands[] = {
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
+	{ "local-redundant", cmd_local_redundant, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/object-file.c b/object-file.c
index f233b440b2..31784c486f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -998,6 +998,25 @@ static int has_loose_object(const struct object_id *oid)
 	return check_and_freshen(oid, 0);
 }
 
+int has_packed_object_nonlocal(const struct object_id *oid)
+{
+	struct packed_git *p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (p->pack_local)
+			continue;
+		if (find_pack_entry_one(oid->hash, p))
+			return 1;
+	}
+	return 0;
+}
+
+int has_oid_nonlocal(const struct object_id *oid)
+{
+	return has_packed_object_nonlocal(oid) ||
+	       has_loose_object_nonlocal(oid);
+}
+
 static void mmap_limit_check(size_t length)
 {
 	static size_t limit = 0;
diff --git a/object-store.h b/object-store.h
index ec32c23dcb..8f17e782dd 100644
--- a/object-store.h
+++ b/object-store.h
@@ -288,6 +288,8 @@ int repo_has_object_file_with_flags(struct repository *r,
  * references.
  */
 int has_loose_object_nonlocal(const struct object_id *);
+int has_packed_object_nonlocal(const struct object_id *);
+int has_oid_nonlocal(const struct object_id *);
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
diff --git a/t/t5326-local-redundant.sh b/t/t5326-local-redundant.sh
new file mode 100755
index 0000000000..220b842870
--- /dev/null
+++ b/t/t5326-local-redundant.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='basic sanity checks for git-local-redundant'
+. ./test-lib.sh
+
+test_expect_success 'setup alternate' '
+	git init --bare alternate.git &&
+	echo "../../alternate.git/objects" >.git/objects/info/alternates
+'
+
+test_expect_success 'setup local pack' '
+	test_commit foo &&
+	sha1=$(git pack-objects --all .git/objects/pack/pack) &&
+	base=".git/objects/pack/pack-$sha1" &&
+	pack="$base.pack" &&
+	extra="$base.foobar" &&
+	echo whatever >"$extra"
+'
+
+test_expect_success 'local pack is not redundant' '
+	>expect &&
+	git local-redundant >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'local pack is redundant against loose objects' '
+	(cd alternate.git && git fetch .. master:foo) &&
+	echo "$pack" >expect &&
+	git local-redundant >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'local pack is redundant against packs' '
+	(cd alternate.git && git repack -ad) &&
+	echo "$pack" >expect &&
+	git local-redundant >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--delete removes all files related to pack' '
+	git local-redundant --delete &&
+	test_path_is_missing "$pack" &&
+	test_path_is_missing "$extra"
+'
+
+test_done
-- 
2.32.0.549.g52475a27a6

