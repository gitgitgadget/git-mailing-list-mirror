Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10F214A8F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020402; cv=none; b=JODtx1MQYxTEJSPEWm9Iu09j4IbKQAxVeHSb3nkpjp28+4jHBeG3JMEOUbMDZnrO86FmdA40yjoEGe3EMvtbjLx9W3iBdVX6eshjc79ZZV8dLnqoDVRmbB9feU7GNgSK+rBs674iEbJ/hKr6sAEmdknq2B5aRy1fs5yCe7yfc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020402; c=relaxed/simple;
	bh=DlIbwCVA4Z8fR6YFuZYrAxXpBtYZamNwX+6SHp00/sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgA2fRe2ZoXesddZMEaoqpjTbAYYVdhocTSHbLKgLcDqUYlS4rMpjgUAl3N6uwVtXq0Zeb5p+o9Jzk7ixsogz2JlUlCaaO/1jA0OxbthbSUME5ZJ+5T9CvRjiqAIxIgNz3wtaM+J0h17UL8aM3kAVR0fz2p7cyxVQCKy2e48Jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1sPnY0Uz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1sPnY0Uz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWymkKJjSTq1VhSrlAN4k2u3aqs/e4N/vBlfvHlBAL8=;
	b=1sPnY0UzhwtU/s4aZ2bSjZPSSgSovZT64/358hD9yHc4azmZMPSWlanZWNAtfl0+kX+QlC
	cxFqXv5VrO0/z8rUXwKvJ/Qc2EwHJgyF8rFnnS/YoT4m72G9rENOOUgayRfVnzdnrMKbSj
	2Pa8OVNXD6AwrO5aZXK3hK2UA/OaqK4=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:32 +0100
Subject: [PATCH 8/8] blame-tree: narrow pathspec as we traverse
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-toon-blame-tree-v1-8-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

As we find out the "last touched" for each path, we cease to
care about that path. However, we traditionally have not
told the revision-walking machinery about this, for two
reasons:

  1. Munging the pathspecs mid-traversal is not an
     officially supported thing to be doing. It does seem to
     work, though, and with Duy's recent pathspec
     refactoring, it's fairly straightforward.

  2. The pathspec machinery is slow. We know have to look at
     each pathspec to see if each tree entry is interesting.
     And since our cost to handle a diff_filepair is so
     cheap, it doesn't really help us much.

It turns out that (2) is not quite right, though. For the
diffs themselves, limiting the pathspec doesn't help at all.
But it does mean that we can simplify history more
aggressively, which may mean avoiding whole swaths of
history that don't touch interesting paths. This happens
especially near the end of the traversal, when we are only
interested in a few paths, and there are many side branches
that do not touch any of them.

And as of the last commit, the pathspec machinery is no
longer quadratic, so the cost to use it is easily worth
paying, even for large trees.

Here are runs of `git blame-tree --max-depth=0` for
torvalds/linux (a complex history with a small root tree)
and git/git (a flat hierarchy with a large root tree):

For git/git:

    Benchmark 1: ./git.old blame-tree --max-depth=0
      Time (mean ± σ):      2.223 s ±  0.360 s    [User: 1.808 s, System: 0.369 s]
      Range (min … max):    1.866 s …  2.927 s    10 runs

    Benchmark 2: ./git.new blame-tree --max-depth=0
      Time (mean ± σ):     945.0 ms ±  93.4 ms    [User: 783.6 ms, System: 131.0 ms]
      Range (min … max):   846.4 ms … 1071.5 ms    10 runs

    Summary
      ./git.new blame-tree --max-depth=0 ran
        2.35 ± 0.45 times faster than git.old blame-tree --max-depth=0

For torvalds/linux:

    Benchmark 1: ./git.old blame-tree --max-depth=0
      Time (mean ± σ):     13.504 s ±  0.545 s    [User: 12.605 s, System: 0.583 s]
      Range (min … max):   12.947 s … 14.488 s    10 runs

    Benchmark 2: ./git.new blame-tree --max-depth=0
      Time (mean ± σ):     622.8 ms ±  39.2 ms    [User: 522.1 ms, System: 95.7 ms]
      Range (min … max):   556.6 ms … 681.6 ms    10 runs

    Summary
      ./git.new blame-tree --max-depth=0 ran
       21.68 ± 1.62 times faster than ./git.old blame-tree --max-depth=0

Note that the output may change slightly in some cases due
to the history pruning. This should be acceptable, as either
output is correct in these cases (e.g., scenarios like a
cherry-picked commit on two parallel branches).

Signed-off-by: Jeff King <peff@peff.net>
---
 blame-tree.c | 18 ++++++++++++++
 pathspec.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h   |  3 +++
 3 files changed, 99 insertions(+)

diff --git a/blame-tree.c b/blame-tree.c
index ed4ec1e694..7be67520f8 100644
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -79,6 +79,18 @@ void blame_tree_init(struct repository *r, struct blame_tree *bt,
 
 	if (add_from_revs(bt) < 0)
 		die(_("unable to setup blame-tree"));
+
+	pathspec_setup(&bt->rev.prune_data, &bt->paths);
+	copy_pathspec(&bt->rev.pruning.pathspec, &bt->rev.prune_data);
+	copy_pathspec(&bt->rev.diffopt.pathspec, &bt->rev.prune_data);
+	bt->rev.prune = 1;
+
+	/*
+	 * Have the diff engine tell us about everything, including trees.
+	 * We may have used --max-depth to get our list of paths to blame,
+	 * in which case we would mention trees explicitly.
+	 */
+	bt->rev.diffopt.flags.tree_in_recursive = 1;
 }
 
 void blame_tree_release(struct blame_tree *bt)
@@ -91,6 +103,7 @@ struct blame_tree_callback_data {
 	struct commit *commit;
 	struct string_list *paths;
 	size_t num_interesting;
+	struct rev_info *rev;
 
 	blame_tree_fn callback;
 	void *callback_data;
@@ -122,6 +135,10 @@ static void mark_path(const char *path, const struct object_id *oid,
 	data->num_interesting--;
 	if (data->callback)
 		data->callback(path, data->commit, data->callback_data);
+
+	pathspec_drop(&data->rev->pruning.pathspec, path);
+	clear_pathspec(&data->rev->diffopt.pathspec);
+	copy_pathspec(&data->rev->diffopt.pathspec, &data->rev->pruning.pathspec);
 }
 
 static void blame_diff(struct diff_queue_struct *q,
@@ -172,6 +189,7 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdata)
 	data.num_interesting = bt->paths.nr;
 	data.callback = cb;
 	data.callback_data = cbdata;
+	data.rev = &bt->rev;
 
 	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	bt->rev.diffopt.format_callback = blame_diff;
diff --git a/pathspec.c b/pathspec.c
index c174edef32..7ef2a55280 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -117,6 +117,50 @@ struct pathspec_trie *pathspec_trie_build(const struct pathspec *pathspec)
 	return ret;
 }
 
+static void pathspec_drop_from_trie(struct pathspec *ps,
+				    const char *path)
+{
+	struct pathspec_trie *prev = NULL, *cur = ps->trie;
+	int pos = -1;
+
+	if (!cur)
+		return;
+
+	while (*path) {
+		const char *end = strchrnul(path, '/');
+		size_t len = end - path;
+		pos = pathspec_trie_lookup(cur, path, len);
+
+		if (pos < 0)
+			die("BUG: didn't find the pathspec trie we matched");
+
+		prev = cur;
+		cur = cur->entries[pos];
+		path = end;
+		while (*path == '/')
+			path++;
+	}
+
+	if (!cur->terminal)
+		die("BUG: pathspec trie we found isn't terminal?");
+
+	if (cur->nr) {
+		cur->terminal = 0;
+		cur->must_be_dir = 0;
+		return;
+	}
+
+	free(cur);
+	if (pos < 0)
+		ps->trie = NULL;
+	else if (prev) {
+		prev->nr--;
+		memmove(prev->entries + pos,
+			prev->entries + pos + 1,
+			sizeof(*prev->entries) * (prev->nr - pos));
+	}
+}
+
 static void pathspec_trie_clear(struct pathspec_trie *t)
 {
 	if (t) {
@@ -878,6 +922,40 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 	dst->trie = pathspec_trie_build(dst);
 }
 
+void pathspec_setup(struct pathspec *ps, const struct string_list *paths)
+{
+	struct strvec argv = STRVEC_INIT;
+	size_t i;
+
+	for (i = 0; i < paths->nr; i++)
+		strvec_push(&argv, paths->items[i].string);
+
+	clear_pathspec(ps);
+	parse_pathspec(ps, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "",
+		       argv.v);
+	strvec_clear(&argv);
+}
+
+void pathspec_drop(struct pathspec *ps, const char *path)
+{
+	int i;
+
+	/* We know these are literals, so we can just strcmp */
+	for (i = 0; i < ps->nr; i++)
+		if (!strcmp(ps->items[i].match, path))
+			break;
+
+	if (i == ps->nr)
+		die("BUG: didn't find the pathspec we just matched");
+
+	memmove(ps->items + i, ps->items + i + 1,
+		sizeof(*ps->items) * (ps->nr - i - 1));
+	ps->nr--;
+
+	pathspec_drop_from_trie(ps, path);
+}
+
 void clear_pathspec(struct pathspec *pathspec)
 {
 	int i, j;
diff --git a/pathspec.h b/pathspec.h
index ff11599d25..a46b3177e3 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -3,6 +3,7 @@
 
 struct index_state;
 struct pathspec;
+struct string_list;
 
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
@@ -152,6 +153,8 @@ void parse_pathspec_file(struct pathspec *pathspec,
 			 int nul_term_line);
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
+void pathspec_setup(struct pathspec *ps, const struct string_list *paths);
+void pathspec_drop(struct pathspec *ps, const char *path);
 void clear_pathspec(struct pathspec *);
 
 /*

-- 
2.49.0.rc2

