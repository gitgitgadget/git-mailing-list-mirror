Received: from mail.runxiyu.org (runxiyu.org [155.138.132.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DD155757
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.138.132.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856506; cv=none; b=fMGDyEimPKKl2IouxF416j1J7xxeUpumS6F+qbi2PteKKv5fUWUXxbRXqpGlOmxucIsJ0Ca+methI4CDSotRhHM9nQp+Fl2voaZmg8a3CcvaB3m7SqgON8GsCJnTiqyhuS0TxLC2iUU8Bc30C0sUQwEzDUjj4tdu3g1kdFbb8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856506; c=relaxed/simple;
	bh=FaXX+9Hys7vTMi1YnAVq/Bs0Z6EhQgGv/4ineGM0jFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX0Qiemdc6/1VCBAiRZz3sEJEHtbIBZLr3PwBdzviyeeaA18mwqGrgoMMWa8JY9n9N3mbZB6L2cN25/sNcYUhK0hGdfPAGdxwoFFxCaVC7lNMaHCLo5zuu9Z+5FajLdSBt5dkjIzdMfysCk+UPKhr7Aym7hiO4lpxERuO9Ak4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org; spf=pass smtp.mailfrom=runxiyu.org; dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b=C3OZNJJ8; arc=none smtp.client-ip=155.138.132.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runxiyu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runxiyu.org header.i=@runxiyu.org header.b="C3OZNJJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=runxiyu.org; s=mail;
	t=1771855968; bh=FaXX+9Hys7vTMi1YnAVq/Bs0Z6EhQgGv/4ineGM0jFA=;
	h=From:To:Cc:Subject:Date:From;
	b=C3OZNJJ88/BBvzIwZoCrRzQBG+wB2ft4qR0sQ52X9TOCz/tFzJ/eVEZpW+MZhTtXi
	 6maFNV0L3ShS+hPYQ3xCrQVJ9bWLnclk/UE2rYqyDk5LW02xMH2P9HahzEKT8wOeSW
	 mtgQGe8Kh03Q3ulIGoGmsP0YF46SshUmmI9mvD/gaucsSPN1cf58DQXe09HbCCbb/O
	 PL6DsbDwE40ZhETvCAF/xeLv8DbVZzh3qTHq8ABtjD8vtIPS+xjeIZ8nBLliNVBCL6
	 BkPDYqnTzWFScCzYRSp1pSCj4zLxYyBrwm6uqLHQbwzJt14tPxtpNQJYc3Zga1CG9e
	 wzv+yneQ07EOg==
From: Runxi Yu <me@runxiyu.org>
To: git@vger.kernel.org
Cc: Runxi Yu <me@runxiyu.org>
Subject: [PATCH git] t5516: test updateInstead with worktree and unborn bare HEAD
Date: Mon, 23 Feb 2026 22:12:20 +0800
Message-ID: <20260223141236.22476-1-me@runxiyu.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test which should presently fail, to demonstrate
the behavior I encountered that looks like a bug.

When a bare repository has a worktree checked out on a separate branch,
receive.denyCurrentBranch=updateInstead should allow a push to that
branch and update the linked worktree, as long as the linked worktree is
clean.

But, if the bare repository's own HEAD is repointed to an unborn branch,
the push is rejected with "Working directory has staged changes", even
though the linked worktree itself is clean.

This test is essentially a minimal working example of what I encountered
while actually using Git; it might not be the optimal way to demonstrate
the underlying bug. I suspect builtin/receive-pack.c is using the bare
repository's HEAD even when comparing it to the worktree's index.

Signed-off-by: Runxi Yu <me@runxiyu.org>
---
 t/t5516-fetch-push.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..f44250c38f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1816,6 +1816,24 @@ test_expect_success 'denyCurrentBranch and bare repository worktrees' '
 	test_must_fail git push --delete bare.git wt
 '
 
+# NEEDSWORK: updateInstead unexpectedly fails when bare HEAD points to unborn
+# branch (or probably any ref that differs from the target worktree) despite
+# the target worktree being clean. This seems to be because receive-pack.c
+# diffs the target worktree index against the bare repository HEAD.
+test_expect_failure 'updateInstead with bare repository worktree and unborn bare HEAD' '
+	test_when_finished "rm -fr bare.git cloned" &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add wt &&
+	git -C bare.git config receive.denyCurrentBranch updateInstead &&
+	git -C bare.git symbolic-ref HEAD refs/heads/unborn &&
+	test_must_fail git -C bare.git rev-parse -q --verify HEAD^{commit} &&
+	git clone . cloned &&
+	test_commit -C cloned mozzarella &&
+	git -C cloned push ../bare.git HEAD:wt &&
+	test_path_exists bare.git/wt/mozzarella.t &&
+	test "$(git -C cloned rev-parse HEAD)" = "$(git -C bare.git/wt rev-parse HEAD)"
+'
+
 test_expect_success 'refuse fetch to current branch of worktree' '
 	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
 	git worktree add wt &&
-- 
2.53.0

