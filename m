Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B6C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjC1U5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjC1U5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:57:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FC2D41
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:56:56 -0700 (PDT)
Received: (qmail 2306 invoked by uid 109); 28 Mar 2023 20:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:56:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2242 invoked by uid 111); 28 Mar 2023 20:56:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:56:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:56:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] builtins: mark unused prefix parameters
Message-ID: <20230328205655.GD1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All builtins receive a "prefix" parameter, but it is only useful if they
need to adjust filenames given by the user on the command line. For
builtins that do not even call parse_options(), they often don't look at
the prefix at all, and -Wunused-parameter complains.

Let's annotate those to silence the compiler warning. I gave a quick
scan of each of these cases, and it seems like they don't have anything
they _should_ be using the prefix for (i.e., there is no hidden bug that
we are missing). The only questionable cases I saw were:

  - in git-unpack-file, we create a tempfile which will always be at the
    root of the repository, even if the command is run from a subdir.
    Arguably this should be created in the subdir from which we're run
    (as we report the path only as a relative name). However, nobody has
    complained, and I'm hesitant to change something that is deep
    plumbing going back to April 2005 (though I think within our
    scripts, the sole caller in git-merge-one-file would be OK, as it
    moves to the toplevel itself).

  - in fetch-pack, local-filesystem remotes are taken as relative to the
    project root, not the current directory. So:

       git init server.git
       [...put stuff in server.git...]
       git init client.git
       cd client.git
       mkdir subdir
       cd subdir
       git fetch-pack ../../server.git ...

    won't work, as we quietly move to the top of the repository before
    interpreting the path (so "../server.git" would work). This is
    weird, but again, nobody has complained and this is how it has
    always worked. And this is how "git fetch" works, too. Plus it
    raises questions about how a configured remote like:

      git config remote.origin.url ../server.git

    should behave. I can certainly come up with a reasonable set of
    behavior, but it may not be worth stirring up complications in a
    plumbing tool.

So I've left the behavior untouched in both of those cases. If anybody
really wants to revisit them, it's easy enough to drop the UNUSED
marker. This commit is just about removing them as obstacles to turning
on -Wunused-parameter all the time.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/credential.c        | 2 +-
 builtin/fetch-pack.c        | 2 +-
 builtin/fsmonitor--daemon.c | 2 +-
 builtin/merge-index.c       | 2 +-
 builtin/merge-ours.c        | 2 +-
 builtin/merge-recursive.c   | 2 +-
 builtin/pack-redundant.c    | 2 +-
 builtin/stash.c             | 2 +-
 builtin/submodule--helper.c | 2 +-
 builtin/unpack-file.c       | 2 +-
 builtin/unpack-objects.c    | 2 +-
 builtin/var.c               | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index d7b304fa084..70107529876 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -6,7 +6,7 @@
 static const char usage_msg[] =
 	"git credential (fill|approve|reject)";
 
-int cmd_credential(int argc, const char **argv, const char *prefix)
+int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
 {
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d1a4306da3a..0d75e474f02 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -42,7 +42,7 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	(*sought)[*nr - 1] = ref;
 }
 
-int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i, ret;
 	struct ref *ref = NULL;
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index cae804a1908..3d4f2ae1d0c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1575,7 +1575,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 }
 
 #else
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c875f5d37ee..b747b4ed983 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -71,7 +71,7 @@ static void merge_all(void)
 	}
 }
 
-int cmd_merge_index(int argc, const char **argv, const char *prefix)
+int cmd_merge_index(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i, force_file = 0;
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 284eb486098..c2e519301e9 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -14,7 +14,7 @@
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
 
-int cmd_merge_ours(int argc, const char **argv, const char *prefix)
+int cmd_merge_ours(int argc, const char **argv, const char *prefix UNUSED)
 {
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_merge_ours_usage);
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d342..0a50d0a0ae2 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -20,7 +20,7 @@ static char *better_branch_name(const char *branch)
 	return xstrdup(name ? name : branch);
 }
 
-int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
+int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
 {
 	const struct object_id *bases[21];
 	unsigned bases_count = 0;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 82115c5808c..104d10877b4 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -558,7 +558,7 @@ static void load_all(void)
 	}
 }
 
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i;
 	int i_still_use_this = 0;
diff --git a/builtin/stash.c b/builtin/stash.c
index 6a12fed2713..5f327435b53 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1466,7 +1466,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	return ret;
 }
 
-static int create_stash(int argc, const char **argv, const char *prefix)
+static int create_stash(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d05d1a84623..65a053261a9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2766,7 +2766,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int push_check(int argc, const char **argv, const char *prefix)
+static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 {
 	struct remote *remote;
 	const char *superproject_head;
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index e9b105a5397..374d980c910 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -24,7 +24,7 @@ static char *create_temp_file(struct object_id *oid)
 	return path;
 }
 
-int cmd_unpack_file(int argc, const char **argv, const char *prefix)
+int cmd_unpack_file(int argc, const char **argv, const char *prefix UNUSED)
 {
 	struct object_id oid;
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1908dcfcffb..3d8510ccf81 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -600,7 +600,7 @@ static void unpack_all(void)
 		die("unresolved deltas left after unpacking");
 }
 
-int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
+int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i;
 	struct object_id oid;
diff --git a/builtin/var.c b/builtin/var.c
index d9943be9afd..acb988d2d56 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -78,7 +78,7 @@ static int show_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-int cmd_var(int argc, const char **argv, const char *prefix)
+int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
 {
 	const struct git_var *git_var;
 	const char *val;
-- 
2.40.0.675.gb17cd5d94c8

