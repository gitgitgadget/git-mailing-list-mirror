Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1D194C78
	for <git@vger.kernel.org>; Sat, 14 Dec 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734200006; cv=none; b=c6XjfCgZwQvOZ9UucoXneHJ/3Yj9yL0Igbq9M2lT/jx7muBu4gqirsQ3kvpeWmxZ4HMw4LF1dfhUVd6qcG1q681xJE7aP85XRm2wUVw1LtLuV26bFVZ+HAMRuh+Gmz7QnnaA/pgMvRoRlv2dLTsh+VjXsPmng5Ln4MhG90W3w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734200006; c=relaxed/simple;
	bh=0fRxM0GrdkufNpKqSNu05a+Vr0QUEkhYy8jdYfyQi2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EtcCQXTPGPHbA4VS6+OGpjkilFCOfryUOIW1Eu2Y+0pCj/b33scIn4H+FMHoCH6q+LKv9mCjWmTK0AoF/utFS6U9oOVFvPDy1AywuZhB4MOibWBWq4Ofnr0AznNd6HdB/fh8T5dNMTOnGhN771La6KsxDct0iwLAS7DkjN59lvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=HuzwNgEr; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="HuzwNgEr"
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1734200001; bh=0fRxM0GrdkufNpKqSNu05a+Vr0QUEkhYy8jdYfyQi2k=;
	h=From:To:Cc:Subject:Date:From;
	b=HuzwNgErB+bgplFK+UcETqXRVnjeQ1EuF4e3ZgSZ1RB9hAs3Kz5cL02nti5A1iPuS
	 zo2WM6NojTBPusimtM9rdeEIMRcbY3FUMTdRIMPBje6iaBXsOedDO+I+ZlmrmgYBOm
	 SOnUn5PYKaATWt9gKRvct7CNtlAiORVOqp6z4hjIpuo+W6ki5EjmngSXBtfUntDeBJ
	 z2RAqLpHZwrWyzpVZ2GV6UjRhPN7TPzT7BUpUxwQL513pCg5mcP5jPz79YnkM6vuPQ
	 eWXg02cpLIG9FZupzpKnd1HkqVzyL0l6rcZlrCnXr3NLkpL/F+B5nq2dnV31QuW6PZ
	 7WhXwZrmTMZkg==
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [filter-repo PATCH] Don't crash on multi-line config values
Date: Sat, 14 Dec 2024 19:13:06 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20241214181306.296673-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The parsing of the output of `git config --list` fails if any of the
config values contain newlines. Fix this by using the --null parameter
to `git config`, which is designed for this purpose.

Add a simple test that causes the crash pre-patch.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 git-filter-repo               |  6 +++---
 t/t9390-filter-repo-basics.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-filter-repo b/git-filter-repo
index a40bce548d2c..3b75eadd81d7 100755
--- a/git-filter-repo
+++ b/git-filter-repo
@@ -1683,14 +1683,14 @@ class GitUtils(object):
   def get_config_settings(repo_working_dir):
     output = ''
     try:
-      output = subproc.check_output('git config --list'.split(),
+      output = subproc.check_output('git config --list --null'.split(),
                                     cwd=repo_working_dir)
     except subprocess.CalledProcessError as e: # pragma: no cover
       raise SystemExit('fatal: {}'.format(e))
 
     # FIXME: Ignores multi-valued keys, just let them overwrite for now
-    return dict(line.split(b'=', maxsplit=1)
-                for line in output.strip().split(b"\n"))
+    return dict(item.split(b'\n', maxsplit=1)
+                for item in output.strip().split(b"\0") if item)
 
   @staticmethod
   def get_blob_sizes(quiet = False):
diff --git a/t/t9390-filter-repo-basics.sh b/t/t9390-filter-repo-basics.sh
index c129799fb6a5..1dc2dca789ab 100755
--- a/t/t9390-filter-repo-basics.sh
+++ b/t/t9390-filter-repo-basics.sh
@@ -895,4 +895,15 @@ test_expect_success 'origin refs without origin remote does not die' '
 	)
 '
 
+test_expect_success 'multi-line config value' '
+	test_create_repo multiline_config &&
+	(
+		cd multiline_config &&
+
+		git config set test.test "test
+test" &&
+		git filter-repo --force
+	)
+'
+
 test_done
-- 
2.47.1

