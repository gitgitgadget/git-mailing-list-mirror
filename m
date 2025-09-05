Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857118DB01
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077614; cv=none; b=jifY1J+w+GAZnOjR8tjcNL3r2ahzylSsr/C0HXCKQOuX0FkZ4wzAUtTfR+xQOgEoA2pZ11a88IgWmWdzcV9iNR+MwBNC1sPuaUEPuymr77I+ks/bQSUc3rINYZn4FYLT6qdduG6s1CZ/l0UYmpAwQWOBxFGsJ6uISJoylP6/3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077614; c=relaxed/simple;
	bh=K8wY6r+idKy+uQUBXilAWwKjuTl6w9zHmKbM4H2iEqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dNuyGoCblNiaqW/1PKxFmVx51vn6WGf6g67E+sffewlIU0+MwU8BaFtIUxVIEw4EBIFTVuAAbqOKMpz4BTjA+39gqhrIA8cGEO7lRWpHwlsM2M/B/bleURmJgRfpBcPZkp9wXCQKjGUlToZFya3cEUq73J/+f5W2oXCLioKFGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ush+zL8i; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ush+zL8i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1757077606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rIbsPHBsv8reQfi7JpExBbUIf71u7PkkZqE6lUnCOeE=;
	b=ush+zL8iD++RJahsGo2KE8Y4zMWYJuQxKQDrLAMlRCbW3cnjKaj0UCoxFCfepFrV2LhVhz
	CIRpsdGS8DsGU8WRc34KJDSbu68LQkIZTuw7QMvRG9+QRAkHIci5Tv1SCDM+w1QY/+vyAQ
	H6t3Eh/zIFnu9dXEDl8QJuDE9ejnasM=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 05 Sep 2025 15:06:31 +0200
Subject: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAFbgumgC/3WNwQqDMBBEf0X23C3JUqP21P8oHtQkdUHdkgRpE
 f+9qdBjj2+YebNBdIFdhGuxQXArR5YlA50KGMZueThkmxlIUakaRZhEFvT8wqmLCWex7NlZrE2
 pK1JGkSkhj5/B5dIhvreZR45Jwvv4WfU3/Skv/5SrRo2N7n1dWesN9TeWNEznQWZo933/AAdq0
 im8AAAA
X-Change-ID: 20250902-toon-fix-last-modified-865172060265
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Christian Couder <chriscool@tuxfamily.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Function diff_tree_combined() copies the 'struct diff_options' from the
input 'struct rev_info' to override some flags. One flag was
'recursive', which is set to 1. This has been the case since the
inception of this function in af3feefa1d (diff-tree -c: show a merge
commit a bit more sensibly., 2006-01-24). From that commit there's no
clear indication why recursive is overridden. But this breaks the
recently introduced subcommand git-last-modified(1) in some cases
(i.e. when criss-cross merges are involved). It then would exit with the
error:

    BUG: paths remaining beyond boundary in last-modified

The last-modified machinery uses a hashmap for all the files it wants to
get the last-modified commit for. Through log_tree_commit() the callback
mark_path() is called. Here the incoming path is looked up in the
hashmap, but because the diff-tree machinery internally switched to
recursive (even if the last-modified machinery wasn't) the entry for
'dir' was never expelled from the hashmap, and the BUG() statement was
hit.

Remove overriding 'diffopt.flags.recursive' in diff_tree_combined() and
move setting this flag to the callers which relied on the recursive
behavior.

Because internally diff-tree no longer runs recursive, this results in a
nice speedup when running `git last-modified` on git.git:

    Benchmark 1: next
      Time (mean ± σ):      6.068 s ±  0.038 s    [User: 5.268 s, System: 0.187 s]
      Range (min … max):    6.007 s …  6.123 s    10 runs

    Benchmark 2: HEAD
      Time (mean ± σ):      3.057 s ±  0.009 s    [User: 2.996 s, System: 0.055 s]
      Range (min … max):    3.047 s …  3.070 s    10 runs

    Summary
      HEAD ran
        1.98 ± 0.01 times faster than next

Signed-off-by: Toon Claes <toon@iotcl.com>
---
git-last-modified(1) was recently merged into 'next', but upon use
I've (well actually Patrick) noticed it has a bug:

    $ git last-modified
    3f3e11118993fe0500b3957ab798e39caaa3952f	.gitignore
    3f3e11118993fe0500b3957ab798e39caaa3952f	Makefile
    3f3e11118993fe0500b3957ab798e39caaa3952f	builtin.h
    3f3e11118993fe0500b3957ab798e39caaa3952f	command-list.txt
    3f3e11118993fe0500b3957ab798e39caaa3952f	commit-graph.c
    3f3e11118993fe0500b3957ab798e39caaa3952f	git.c
    3f3e11118993fe0500b3957ab798e39caaa3952f	meson.build
    56072ff0384da5d874fc378d36e089a18f28f1e3	fetch-pack.c
    457534d0417d047b943f76a849f256b739894ce9	progress.c
    0d8f4ccfe3b13bb5eb95f030dc5fe76efb255397	for-each-ref.h
    109c3df14ccf372c2438a470bdfb566265399f0a	combine-diff.c
    109c3df14ccf372c2438a470bdfb566265399f0a	diff.c
    109c3df14ccf372c2438a470bdfb566265399f0a	diff.h
    109c3df14ccf372c2438a470bdfb566265399f0a	dir.c
    [snip]
    9e5878fbede57c0499133adf73844261849cd7b2	git-web--browse.sh
    b2fb3911eab730a08168c7f85a7935ad5a330b53	config.mak.in
    36268b762c4aa6a0d4831f69852b20ab545aff4d	LGPL-2.1
    1e58dba142c673c59fbb9d10aeecf62217d4fc9c	aclocal.m4
    9517e6b84357252e1882091343661c34d978771e	levenshtein.h
    703601d6780c32d33dadf19b2b367f2f79e1e34c	COPYING
    BUG: ../builtin/last-modified.c:236: paths remaining beyond boundary in last-modified
    zsh: IOT instruction (core dumped)  git last-modified

I didn't see this before but the BUG() statement was only moved up in
the last version of the patch series, and it only comes into trouble
with merge commits.

This series fixes that issue.

This patch is based on 'next' at 1ba7204a04 (Merge branch
'kh/doc-markup-fixes' into next, 2025-09-03).
---
Changes in v2:
- Do not change behavioral change in `git diff-tree -c`.
- Small change in the test to make it pass on Windows.
- Link to v1: https://lore.kernel.org/r/20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com
---
 builtin/diff-tree.c      | 13 ++++++++++++-
 combine-diff.c           |  1 -
 submodule.c              |  1 +
 t/t8020-last-modified.sh | 16 ++++++++++++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 49dd4d00ebf1bcc644383ee99df3a9e05502b89b..6ef0438d36dd1091d2806b46306f2b5ee7274bc0 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -16,10 +16,21 @@ static struct rev_info log_tree_opt;
 
 static int diff_tree_commit_oid(const struct object_id *oid)
 {
+	struct rev_info rev_info = log_tree_opt;
 	struct commit *commit = lookup_commit_reference(the_repository, oid);
+
 	if (!commit)
 		return -1;
-	return log_tree_commit(&log_tree_opt, commit);
+
+	/*
+	 * log_tree_commit() calls into diff_tree_combined() which historically
+	 * used to enable diffopt.flags.recursive when option '-c' is given.
+	 * To not break backward compatibility, set 'resursive' here.
+	 */
+	if (rev_info.combine_merges)
+		rev_info.diffopt.flags.recursive = 1;
+
+	return log_tree_commit(&rev_info, commit);
 }
 
 /* Diff one or more commits. */
diff --git a/combine-diff.c b/combine-diff.c
index 3878faabe7bb2f7c80cffbf3add6123f17960627..305414efdf436d53fee8d79aa4219f6a4dd3445e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1515,7 +1515,6 @@ void diff_tree_combined(const struct object_id *oid,
 
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
-	diffopts.flags.recursive = 1;
 	diffopts.flags.allow_external = 0;
 
 	/* find set of paths that everybody touches
diff --git a/submodule.c b/submodule.c
index fff3c755703163da423d5978b8bdf0d36c6f8ea9..1c273ec87fa865b635ffb9343cfd28744524c737 100644
--- a/submodule.c
+++ b/submodule.c
@@ -916,6 +916,7 @@ static void collect_changed_submodules(struct repository *r,
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
+		diff_rev.diffopt.flags.recursive = 1;
 		diff_rev.dense_combined_merges = 1;
 		diff_tree_combined_merge(commit, &diff_rev);
 		release_revisions(&diff_rev);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 5eb4cef0359212eeddc68578697ca432760e0be3..e13aad14398dd9055ff45ab57700329e7aab37c4 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -128,6 +128,22 @@ test_expect_success 'only last-modified files in the current tree' '
 	EOF
 '
 
+test_expect_success 'last-modified with subdir and criss-cross merge' '
+	git checkout -b branch-k1 1 &&
+	mkdir -p a k &&
+	test_commit k1 a/file2 &&
+	git checkout -b branch-k2 &&
+	test_commit k2 k/file2 &&
+	git checkout branch-k1 &&
+	test_merge km2 branch-k2 &&
+	test_merge km3 3 &&
+	check_last_modified <<-\EOF
+	km3 a
+	k2 k
+	1 file
+	EOF
+'
+
 test_expect_success 'cross merge boundaries in blaming' '
 	git checkout HEAD^0 &&
 	git rm -rf . &&

---
base-commit: 1ba7204a041bf9fa3af3ad21a018399fff66f7b9
change-id: 20250902-toon-fix-last-modified-865172060265

Best regards,
-- 
Toon Claes <toon@iotcl.com>

