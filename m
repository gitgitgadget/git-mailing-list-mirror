Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4625779
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159790; cv=none; b=ihqmF+eMo/ic82QzH5RvSNsXr8im7+rX/o80jK+wpUZh9iFrJHxif6cBbbRpyKVt4ytSg+bjvyJqKWYUw06F9Dxudnx96tWyU9zOQpFERYtFKq4ybGTFzz06HlzOzSnTvlpX/+RlyvXwVp68maedjABCQ/9vsVFKl1tv7xolOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159790; c=relaxed/simple;
	bh=4O4BCoT4h3f52uS8x764ubIDKSDUUOLQUfUGlnyQb1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qFwYigtM/ewo26dXvFwQ4iHap8yULcOvqlD+egb2pe1c95lS4BTcE5YQERY+SPaOps3umJeH1gLZzYk4iPvImhskQqnDLW+QAJY6dwlTED3dNGDr1t6FGZ6JRlzxVvKs/yjN2yE5XqFBlWDaakn2ggX7LVBpO+0uRd68jdh/7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rYUe1l/O; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYUe1l/O"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95F733F4F2;
	Tue, 16 Jul 2024 15:56:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	O4BCoT4h3f52uS8x764ubIDKSDUUOLQUfUGlnyQb1w=; b=rYUe1l/O2iM76GJ+S
	bKv+zHrX+D2u2v1T6StZLfD3HEBjKnfu7FvJCRoReg+JO0mf6/HRG5guRrCvzmlb
	aVN0lJiNc849v6U4zxcc0oAKYvLM3ZnfqhlYx4TWinkG0WLZzEs1DE3Pwuh4Jah3
	7zi//V2GNBfOY1Q2ZVUNSupsYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E27F3F4F1;
	Tue, 16 Jul 2024 15:56:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F15BA3F4F0;
	Tue, 16 Jul 2024 15:56:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] Revert "reflog expire: don't use
 lookup_commit_reference_gently()"
Date: Tue, 16 Jul 2024 12:56:25 -0700
Message-ID: <xmqqv8156rh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C90E13E-43AD-11EF-9C44-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

During Git 2.35 timeframe, daf1d828 (reflog expire: don't use
lookup_commit_reference_gently(), 2021-12-22) replaced a call to
lookup_commit_reference_gently() with a call to lookup_commit().

What it failed to consider was that our refs do not necessarily
point at commits (most notably, we have annotated and signed tags),
and more importantly that lookup_commit() does not dereference a tag
to return a commit; instead it returns NULL when a tag is given.

Since the commit returned is used as a starting point for the
reachability check, this ejected the commits that are reachable only
by an annotated tag out of the set of reachable commits, breaking
the computation to correctly implement the "--expire-unreachable"
option.  We also started giving an error message that the API
function expected to be fed a commit object.

This problem hasn't been reported or noticed for a long time,
probably because the "refs/tags/" hierarchy by default is not
covered by reflogs, as nobody usually moves tags.

Revert the change to correctly find the commit pointed at by the ref
to restore the previous behaviour, but do so only in a more modern
codebase, as we had significant code churn since then and it is not
grave enough to worry about for older maintenance tracks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  cf. <patch-v3-6.9-cfa80e84c6d-20211222T040557Z-avarab@gmail.com>

 reflog.c          | 3 ++-
 t/t1410-reflog.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/reflog.c b/reflog.c
index 0a1bc35e8c..2e45a17e12 100644
--- a/reflog.c
+++ b/reflog.c
@@ -330,7 +330,8 @@ void reflog_expiry_prepare(const char *refname,
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		commit = lookup_commit(the_repository, oid);
+		commit = lookup_commit_reference_gently(the_repository,
+							oid, 1);
 		if (commit && is_null_oid(&commit->object.oid))
 			commit = NULL;
 		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index d2f5f42e67..16816e82b2 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -146,6 +146,14 @@ test_expect_success rewind '
 	test_line_count = 5 output
 '
 
+test_expect_success 'reflog expire should not barf on an annotated tag' '
+	test_when_finished "git tag -d v0.tag || :" &&
+	git -c core.logAllRefUpdates=always \
+		tag -a -m "tag name" v0.tag main &&
+	git reflog expire --dry-run refs/tags/v0.tag 2>err &&
+	test_grep ! "error: [Oo]bject .* not a commit" err
+'
+
 test_expect_success 'corrupt and check' '
 
 	corrupt $F &&
-- 
2.46.0-rc0-153-ge537c69d48

