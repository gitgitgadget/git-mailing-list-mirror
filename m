Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1312D5412
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986852; cv=none; b=h2y0Lygc0Ek73YzwrYOJqbjoDI0MJaHC0Czq3FcUt/52ItkKfYqaIBeIzYxAtu3nGvOtujwdyWPt5dq/01wjsx+L8p8jjTHpQyzYIydFRZrx6KC1PpqBVHBSjCmRyDvrV49m90472a88EAzXMaOI6gRp0gI8RZ1BdW2R2Pucs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986852; c=relaxed/simple;
	bh=hbYu+GIE4eU/HUrxSUgZ16jgrzr/xe8b45T2VcOv3ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HO8FCWT7YXF1EWdlxLKqEaUspAu1Zn9UYCETHYyg5IN69pQ8QWJKzjyOOYBc2VhnTsbrhXXrAbzZmWCbY5/fC0TWtqnfrFziNkWOKPxpPB/od5tilGq0gTz9lcITt4lNZ7DowP/sJ65d+h4q1YC1Uu/hr8UENBDbXsw2WcZAzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nQbNyHTx; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nQbNyHTx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1756986842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8BLx1fdmAg1rfm+Nfc0VEzce1qS5dgSCYNrJCzQLy3s=;
	b=nQbNyHTxHK3PkBViGg2nFcj4sI8yHKRllQyXqVXVf9h6/RMJIlKUjQ5oglhzw4tqtqp4xh
	FDZg3mc4at8NTZpNQhzbcv0ElLy9mU7K/GEyA4/ym6v8FYF1xIBrlwGbRt4ijY2Npp8Y/2
	XYjEekNuXekM2dkTScmMue57AehIdCo=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 04 Sep 2025 13:53:40 +0200
Subject: [PATCH] combine-diff: don't override recursive flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAMN9uWgC/x2MSQqAMAwAvyI5G4iB1uUr4kFs1IC20ooI4t8tH
 gdm5oEkUSVBVzwQ5dKkwWeoygKmdfSLoLrMwMSGWmI8Q/A4643bmE7cg9NZxWFjTVUzWWJrIMd
 HlCz943543w/rs2XaaAAAAA==
X-Change-ID: 20250902-toon-fix-last-modified-865172060265
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Function diff_tree_combined() copies the 'struct diff_options' from the
input 'struct rev_info' to override some flags. One flag was
'recursive', which is set to 1. This has been the case since the
inception of this function in af3feefa1d (diff-tree -c: show a merge
commit a bit more sensibly., 2006-01-24). From that commit there's no
clear indication why recursive is overridden. But it seems to be
incorrect.

Looking at a test case in t4013. The expected test results are in
t/t4013/. And take 'diff.noellipses-diff-tree_-c_--abbrev_master' as an
example:

   $ git diff-tree -c --abbrev master
   59d314ad6f356dd08601a4cd5e530381da3e3c64
   ::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
   ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
   $

Here we see the expected results include 'dir/sub', while argument
'-r' (for recursive) was not given. So we should expect 'dir' instead.

Stop overriding the 'recursive' flag in diff_tree_combined(). This
changes the expected results for the example above to be:

    $ git diff-tree -c --abbrev master
    59d314ad6f356dd08601a4cd5e530381da3e3c64
    ::040000 040000 040000 65f5c9d f977ed4 0564e02 MM	dir
    ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
    $

This also fixes the recently added subcommand git-last-modified(1),
which in some cases (when merges are involved) exited with the error:

    BUG: paths remaining beyond boundary in last-modified

The last-modified machinery uses a hashmap for all the files it wants to
get the last-modified commit for. Through log_tree_commit() the callback
mark_path() is called. Here the incoming path is looked up in the
hashmap, but because the diff-tree machinery internally switched to
recursive (even if the last-modified machinery wasn't) the entry for
'dir' was never expelled from the hashmap, and the BUG() statement was
hit.

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

Besides that, set the flag 'recursive' in submodule.c to 1 because it
calls diff_tree_combined_merge() which no longer enables the flag
itself.

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
 combine-diff.c                                       |  1 -
 submodule.c                                          |  1 +
 t/t4013/diff.diff-tree_-c_--abbrev_master            |  2 +-
 t/t4013/diff.diff-tree_-c_-r_master                  |  5 +++++
 t/t4013/diff.diff-tree_-c_master                     |  2 +-
 t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master |  2 +-
 t/t8020-last-modified.sh                             | 16 ++++++++++++++++
 7 files changed, 25 insertions(+), 4 deletions(-)

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
diff --git a/t/t4013/diff.diff-tree_-c_--abbrev_master b/t/t4013/diff.diff-tree_-c_--abbrev_master
index b8e4aa2530717abc7d7b8bea62f12d615dfcd759..1f00877ca5ee513aebb185cc1a2827783a6af618 100644
--- a/t/t4013/diff.diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.diff-tree_-c_--abbrev_master
@@ -1,5 +1,5 @@
 $ git diff-tree -c --abbrev master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
-::100644 100644 100644 cead32e... 7289e35... 992913c... MM	dir/sub
+::040000 040000 040000 65f5c9d... f977ed4... 0564e02... MM	dir
 ::100644 100644 100644 b414108... f4615da... 10a8a9f... MM	file0
 $
diff --git a/t/t4013/diff.diff-tree_-c_-r_master b/t/t4013/diff.diff-tree_-c_-r_master
new file mode 100644
index 0000000000000000000000000000000000000000..8980be8744079119a7b789947d3442d8f8e6d404
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-c_-r_master
@@ -0,0 +1,5 @@
+$ git diff-tree -c -r master
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
+::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0
+$
diff --git a/t/t4013/diff.diff-tree_-c_master b/t/t4013/diff.diff-tree_-c_master
index e2d2bb26114ac886fbf2467dc7a33ec8cfab5daf..1ecc2cfc6c50e923a671fba29a6a395f4240e0ff 100644
--- a/t/t4013/diff.diff-tree_-c_master
+++ b/t/t4013/diff.diff-tree_-c_master
@@ -1,5 +1,5 @@
 $ git diff-tree -c master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
-::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
+::040000 040000 040000 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 f977ed46ae6873c1c30ab878e15a4accedc3618b 0564e026437809817a64fff393079714b6dd4628 MM	dir
 ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0
 $
diff --git a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
index bb80f013b37da0f11a9e7d454222487bd2f61d5a..62d655dac240a8bb6334c7247913f24bb4641cfc 100644
--- a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
@@ -1,5 +1,5 @@
 $ git diff-tree -c --abbrev master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
-::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
+::040000 040000 040000 65f5c9d f977ed4 0564e02 MM	dir
 ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
 $
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 5eb4cef0359212eeddc68578697ca432760e0be3..ff837a40f40b8c4f92c4975e29615a507a5d3b2d 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -128,6 +128,22 @@ test_expect_success 'only last-modified files in the current tree' '
 	EOF
 '
 
+test_expect_success 'last-modified with files in a subdir merged' '
+	git checkout -b branch-k1 1 &&
+	mkdir a k &&
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

