Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15547A0C7
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254990; cv=none; b=X0WUo2v44wfugHaS8JPTaTLF02MxTxB7yFcsSpq91YOTSqltyZrHEav/g/ZACDwt0NeOPaJ0JNg6MEgt8NQmH9pKBKNJErD3Ut7hzMVhBLWjMow5j7vPHfRwfNYPe7Mlk7GujDhfQ1Q9KRjsK7xaBURd/R2jnDZSzBxnnxmvB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254990; c=relaxed/simple;
	bh=jErDTTSkV0rN18NyAW0eDt1MVBuCxpcHOtmMG1jz46M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j00AXNfeHcFThWIinwgFvDqUd21rX/QBJWt6vmLVkQHqveoHtv7cZuJcyZCx2PNnYtkoIovbnHe0vcbdCfVUYGW8Kc1rY8qiFD33x9mKZcLGt2Mo/NQ4bb+2/3+RnyaO/NrbUDsdSu5786xS3ppzA9PTgzPUiOKf6kGmR2hBQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=CCtdMyNZ; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="CCtdMyNZ"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jErDTTSkV0rN18NyAW0eDt1MVBuCxpcHOtmMG1jz46M=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254984; v=1; x=1788859784;
 b=CCtdMyNZ19O2WVr7VqjVS7+2tXSLQL0P+stZpwDsJFt1gwEx7C0EjLiVHI+in8fu4bzlg9EF
 N7aoPA2nkDOUrfetxpkepZQQHf1id6amXFL758ZwuUmbXYgFSGnIWmLHQTJxexDgtirwQenccw4
 AxLFnWrTzBKpeHO8yLGOBr1c=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id be2ef3ceef191900;
	Tue, 01 Sep 2026 09:29:44 +0000
X-Mizu-Trace-ID: be2ef3ceef191900
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:25 +0200
Subject: [PATCH v4 5/6] last-modified: check pathspec against Bloom filter
 first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-5-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

When git-last-modified(1) starts, it builds a list of all the paths
matching the pathspec it needs to find the last modifying commit for.
For example, every file and subdirectory listed by:

    $ git last-modified -t --max-depth=0 -- src/

As it resolves a commit for each path during the revision walk, it drops
that path from the list.

To avoid diffing trees for every commit, Bloom filters are used when
available. For each remaining path, the commit's Bloom filter is checked
to see whether the commit changed that path. The Bloom filter says
either "no" or "maybe", and only in the latter case is the diff
calculated.

git-log(1) does this differently. It does not expand the pathspec but
checks the Bloom filter against the pathspec itself. This way, commits
not touching any path matching the pathspec can be discarded as a whole.

Apply this same check to git-last-modified(1). In a previous commit the
function revs_maybe_changed_in_bloom(), used by git-log(1), was made
public. Use this as a pre-filter in git-last-modified(1). After this
pre-filter, paths are still checked one-by-one to only find those which
don't have a "last commit" yet.

With `--show-trees` the list holds more than the paths matching the
pathspec. It also holds each parent tree entry, up to the root. Each of
those can resolve to a different commit. Thus for the pathspec "a/b/c",
the list will also hold "a" and "a/b".

When a commit touches "a/other", that commit could be the last commit
for "a", but revs_maybe_changed_in_bloom() would discard it, because it
doesn't match the full pathspec.

Instead, when `--show-trees` is given, use
revs_maybe_changed_in_bloom_with_parents(), which indicates the commit
maybe changed any of the paths leading up to the path in the pathspec.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  | 12 ++++++++++++
 t/t8020-last-modified.sh | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 3846244dfc..8ab7944314 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -272,6 +272,18 @@ static bool maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return true;
 
+	/*
+	 * With --show-trees we also track the tree entries containing the
+	 * paths, so a change to any of those parent directories matters too.
+	 */
+	if (lm->show_trees) {
+		if (!revs_maybe_changed_in_bloom_with_parents(&lm->rev, filter))
+			return false;
+	} else {
+		if (!revs_maybe_changed_in_bloom(&lm->rev, filter))
+			return false;
+	}
+
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (active && !bitmap_get(active, ent->diff_idx))
 			continue;
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 9dba4b9d90..e75437c18e 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -269,6 +269,29 @@ test_expect_success 'last-modified merge undoes changes' '
 	EOF
 '
 
+test_expect_success 'last-modified with Bloom filters and --show-trees' '
+	test_when_finished rm -rf bloom &&
+	git init bloom &&
+	(
+		cd bloom &&
+		mkdir d &&
+		test_commit base-a d/a &&
+		test_commit base-b d/b &&
+		test_commit touch-a d/a &&
+		test_commit touch-b d/b &&
+
+		git commit-graph write --reachable --changed-paths &&
+		GIT_TEST_COMMIT_GRAPH=0 \
+			git -c core.commitGraph=false last-modified -t HEAD \
+			-- d/a >expect &&
+		GIT_TEST_COMMIT_GRAPH=1 \
+			git -c core.commitGraph=true last-modified -t HEAD \
+			-- d/a >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'cannot run last-modified on two commits' '
 	test_must_fail git last-modified HEAD HEAD~1 2>err &&
 	test_grep "last-modified can only operate on one commit at a time" err

-- 
2.55.0.679.g6767b8d81c

