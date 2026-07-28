Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5942CAE1
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243636; cv=none; b=jy93YT7L8bXtnT/VF7jGH8UCHjCbPLkut7cUZ4E4igV0kGZoyQ3LE6n7/cAQY4rBs5/2H3WNeGhgvL3+HItvENUH9+v1WWVS5zh3Vve83c9XNkg9TvjLNbjpZRRcRYZmq66nve2Tfcxmep4WHhETaYUsmvBoJJQIrI3ByvkEYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243636; c=relaxed/simple;
	bh=gKwt4G5CCsWTq1m+9bp+FT5vRDIJHX/gRpdauq80/10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WbMH33JwuUHSH1QFOKT3eFk5TKL42LJFP1444Wtzy7j5/r/ddMhQjvO0JXVZ9jV9ekjyyi8lxIavs/hbztg0sfabHVwZzH2wU1NCvmC+muPr5npl84ZITNx8Vl7CMZ+sEjUvlMHHDu9GkRwiazT/DmtoARVdZbqyMX56GeFjHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pwYVgLDS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pwYVgLDS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785243625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AybxSZkkgDOm6+SOyJ1pLHoGmbLphkyz1TvcKmQ0VyA=;
	b=pwYVgLDSbA9VTTmm/pkwOM6kWD0UVL3TC+kTJciHy+gxip5py/2D7PpHIzcLZ0ENZkHtUV
	6wJOEhaGMWwzlfR91wu6CwJeATjuPcdt6uLGldAR0jUOpHv8q6G5QwdCA/w5WwHjL9AQkl
	EtcJDOSvJa918BusJsVX7ClKJiFfIGQ=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 28 Jul 2026 15:00:04 +0200
Subject: [PATCH] merge: fix leak with merge.defaultToUpstream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-toon-fix-merge-leak-v1-1-d6bd161a3acf@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyML3ZL8/DzdtMwK3dzUIqBsTmpitq5ZinFSsmlimpGBhZESUGdBUSp
 QBdjU6FgIv7g0KSs1uQRklFJtLQCYsNwvdwAAAA==
X-Change-ID: 20260728-toon-fix-merge-leak-6d3bc5af2082
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

By default the setting 'merge.defaultToUpstream' for git-merge(1) is set
to 'true', which means when `git merge` is invoked with no arguments it
merges the upstream branch configured for the current branch.

With this configuration set to 'true', setup_with_upstream() is called.
That function allocates an array of arguments and hands it back to
cmd_merge() via its `argv` parameter. This array is never freed, so
cmd_merge() leaks it on every invocation.

Track the allocated array in a separate variable and free it at the end.

The leak has been present since 93e535a5b7 (merge: merge with the
default upstream branch without argument, 2011-03-24). Although the leak
sanitizer was enabled for tests in fc1ddf42af (t: remove
TEST_PASSES_SANITIZE_LEAK annotations, 2024-11-21), it went unnoticed
because no test calls `git merge` without arguments, exercising the
default-to-upstream path. Add such a test in t7600, which fails under
the leak sanitizer without this fix.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
I ran into this leak while running `yay`[1] (I use Arch btw). `yay` uses
Git to fetch packages from source, and it happens to call `git merge`
without any revision to merge (it only passes the options `--no-edit`
and `--ff`). Because I have Git with the leak sanitizer enabled in my
$PATH, my `yay` tripped on a leak.

This series fixes the leak and adds a test to reproduce it.

[1]: https://github.com/Jguer/yay
---
 builtin/merge.c  |  7 +++++--
 t/t7600-merge.sh | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 58d1b7bb07..5b4eb23a83 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1373,7 +1373,7 @@ int cmd_merge(int argc,
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list *remoteheads = NULL, *p;
-	void *branch_to_free;
+	void *branch_to_free, *argv_to_free = NULL;
 	int orig_argc = argc;
 	int merge_log_config = -1;
 
@@ -1517,8 +1517,10 @@ int cmd_merge(int argc,
 		option_commit = 1;
 
 	if (!argc) {
-		if (default_to_upstream)
+		if (default_to_upstream) {
 			argc = setup_with_upstream(&argv);
+			argv_to_free = argv;
+		}
 		else
 			die(_("No commit specified and merge.defaultToUpstream not set."));
 	} else if (argc == 1 && !strcmp(argv[0], "-")) {
@@ -1880,6 +1882,7 @@ int cmd_merge(int argc,
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(argv_to_free);
 	free(pull_twohead);
 	free(pull_octopus);
 	discard_index(the_repository->index);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7f2a1db16d..e31d261f9d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -1166,4 +1166,21 @@ test_expect_success 'suggested names are not ambiguous' '
 	test_grep remotes/origin/not-local stderr
 '
 
+test_expect_success 'merge with no argument defaults to upstream' '
+	test_when_finished "rm -rf upstream downstream" &&
+	git init upstream &&
+	(
+		cd upstream &&
+		test_commit one &&
+		test_commit two
+	) &&
+	git clone upstream downstream &&
+	(
+		cd downstream &&
+		git reset --hard HEAD^ &&
+		git merge &&
+		test_cmp_rev origin/main HEAD
+	)
+'
+
 test_done

---
base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
change-id: 20260728-toon-fix-merge-leak-6d3bc5af2082

