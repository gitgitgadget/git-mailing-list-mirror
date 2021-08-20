Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A2C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D6C60F8F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhHTT4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhHTT4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 15:56:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCD6C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=GcwvdgC0vjGblusXhLO5J4EuJlVkvc/Fha3HKddio+g=; t=1629489363; x=1630698963; 
        b=KYlXBfkx4yP+gJ5ThYAvfx6tI08k76GvPt0yIXrNDEg36mVK0KrJFMWEzlwUVAb3Bjzw1UcAAmo
        wgf3Byy6EQZrkXjKehk7MhAaQue9uVncfDPdUR0Wbm4LofDP1qAzkayACLymWnVGYvJdoLZGnT9V9
        9bI2Kk2kqKToug/sn/3Rn5TK7XHH7mLEyMwHyXKIMrXPwFnjoqmNTK9A+6jN0yPsv/aXLRAya3wsh
        V8wUPhDhAKbCOS901e1M1z7GKV9aiEYP+0AzZ2f3o3r3La4XXlyAuXiwyloF2QlXBtWabaaazsiWa
        kwIEi8zWhft0Ee4EskTK3dpdea1LIk9L82OA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mHAcT-00DjRb-Tc; Fri, 20 Aug 2021 21:56:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     bup-list@googlegroups.com
Subject: [RFC PATCH] multi-pack-index: allow operating without pack files
Date:   Fri, 20 Aug 2021 21:55:58 +0200
Message-Id: <20210820195558.44275-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Technically, multi-pack-index doesn't need pack files to exist,
but add_packed_git() today checks whether it exists or not.

In bup, a git pack format based backup tool, we'd really like
to take advantage of the multi-pack-index, since bup needs it
to save new objects to the repository efficiently (to check if
something already exists), and uses git to access the repo, so
the multi-pack-index can make more efficient.

Alternatively, bup has its own 'midx' format, of which multiple
can exist in a repository, predating the multi-pack-index.

All of this works well as long as the bup repository is just a
normal git repository. However, I've been adding encrypted and
encrypted remote repositories to bup, where the pack files are
not local, similar to promisor remotes, but not really done in
the same way.

In this case, the local storage is only the idx files, no pack
files (it's just a cache), and we access the pack files and
objects within in different ways. Unfortunately, in this case
we also cannot reuse bup's midx format very well: it only has
information on which objects exists, not where to find them,
and so reading from the repository requires reading all of the
idx files, something that git's multi-pack-index solves.

While we'll need to add read access to git's multi-pack-index
to bup, having a call to 'git multi-pack-index' write it would
be nice and save some duplication. However, in the case of the
remote/encrypted repositories, git currently cannot do that as
it requires the pack files to exist.

Add a command-line option to be able to not require pack files
to exist, to make that easier (rather than requiring writing
some dummy pack files, git even accepts empty files.)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/git-multi-pack-index.txt |  6 +++++-
 builtin/multi-pack-index.c             |  5 ++++-
 midx.c                                 |  9 ++++++---
 midx.h                                 |  1 +
 packfile.c                             | 10 ++++++++--
 packfile.h                             |  2 ++
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ffd601bc17b4..23db70fbebc2 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
-	[--preferred-pack=<pack>] <subcommand>
+	<subcommand> [<subcommand options>]
 
 DESCRIPTION
 -----------
@@ -40,6 +40,10 @@ write::
 		multiple packs contain the same object. If not given,
 		ties are broken in favor of the pack with the lowest
 		mtime.
+
+	--no-require-packs::
+		Don't require pack files to exist, useful only for
+		certain non-repository caches.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8ff0dee2ecbb..2c9293b20c49 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -7,7 +7,7 @@
 #include "object-store.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>] [--no-require-packs]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -68,6 +68,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
 			   N_("preferred-pack"),
 			   N_("pack for reuse when computing a multi-pack bitmap")),
+		OPT_BIT(0, "no-require-packs", &opts.flags,
+			N_("don't require pack files to exist"),
+			MIDX_DONT_REQUIRE_PACKS),
 		OPT_END(),
 	};
 
diff --git a/midx.c b/midx.c
index 902e1a7a7d9d..98b3cb33201f 100644
--- a/midx.c
+++ b/midx.c
@@ -468,6 +468,7 @@ struct write_midx_context {
 	uint32_t num_large_offsets;
 
 	int preferred_pack_idx;
+	unsigned flags;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -482,9 +483,10 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-		ctx->info[ctx->nr].p = add_packed_git(full_path,
-						      full_path_len,
-						      0);
+		ctx->info[ctx->nr].p = _add_packed_git(full_path,
+						       full_path_len,
+						       0,
+						       !(ctx->flags & MIDX_DONT_REQUIRE_PACKS));
 
 		if (!ctx->info[ctx->nr].p) {
 			warning(_("failed to add packfile '%s'"),
@@ -924,6 +926,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
+	ctx.flags = flags;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
 	if (ctx.m) {
diff --git a/midx.h b/midx.h
index 8684cf0fefe8..aa6382d99386 100644
--- a/midx.h
+++ b/midx.h
@@ -41,6 +41,7 @@ struct multi_pack_index {
 
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
+#define MIDX_DONT_REQUIRE_PACKS (1 << 2)
 
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
diff --git a/packfile.c b/packfile.c
index 9ef6d9829280..dfe994205914 100644
--- a/packfile.c
+++ b/packfile.c
@@ -687,7 +687,8 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+struct packed_git *_add_packed_git(const char *path, size_t path_len, int local,
+				   int require_pack)
 {
 	struct stat st;
 	size_t alloc;
@@ -717,7 +718,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		p->pack_promisor = 1;
 
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
-	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
+	if (require_pack && (stat(p->pack_name, &st) || !S_ISREG(st.st_mode))) {
 		free(p);
 		return NULL;
 	}
@@ -734,6 +735,11 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+{
+	return _add_packed_git(path, path_len, local, 1);
+}
+
 void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
diff --git a/packfile.h b/packfile.h
index 3ae117a8aef0..a921077a05ef 100644
--- a/packfile.h
+++ b/packfile.h
@@ -96,6 +96,8 @@ void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
 struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+struct packed_git *_add_packed_git(const char *path, size_t path_len, int local,
+				   int require_pack);
 
 /*
  * Unlink the .pack and associated extension files.
-- 
2.31.1

