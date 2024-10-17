Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E331D8E0F
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157755; cv=none; b=Nw/P7o9hCbiOM9H9ZQddRHRWws1QnkLl8gJDneRQHB8KPr5EQvlreRGEqM6ycpEsxoclHC1QY4NppxZHQzo+uunLTnhhSvtSQVjLkVhbyzTUtW5btFz94DCrCuG7CxrybcQ3yU4WhuE6Wx5hv03NctZZ/Ki3t3eHBJqijjoCB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157755; c=relaxed/simple;
	bh=UAXIEy++EtM2B6+wDCJDm3+40GR1/46vX7VMluhlOkE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxNPCeZNkMkCzenqcFbWFt7JgmLYUfezMtxNJTx9GbarU+Oox4LIhKP8rZ1MCeVYeaYzx/i0XVOsghLpH0O8/HG9jQpq1KqI7UegJFQseAF1+sONSq4UrLCjVVCLrqiP/OMEcJ9M/yuYAORYO6xjcxfeUxxEm+I4UXQa7hBGQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=n4FmPUaO; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="n4FmPUaO"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729157749;
	bh=UAXIEy++EtM2B6+wDCJDm3+40GR1/46vX7VMluhlOkE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=n4FmPUaO4mGtZN42NSn8yK1StgalaAdb1uZop4bkdnYp7xRZgbtE/3H5SZcrfH8Fw
	 qxzY0EtlDZiVRwIiR0ckJ4oQ7gJeQdGvWzfwH91i8gnk9zhezb+6iERhsS1514kDYD
	 c2Pqh0ee5qg69UbitNEsXX9znXT+CFn8jBq5lI1M6myL6DDTKp3S0BDEEAKbW4lsyi
	 YAj4ibeX20qvP07tErSJIHqi5cQ9+fRjDLdo8dFcESxyjh5Xtx7A3SvUKl7lNbvaku
	 6KLF7lPoSsujmwkwuVwWlkwzuKLcKirveh+N4ultMoYnnJCBU7z/V7OiiNfmov5Lns
	 6DECFutsR9iIA==
To: git@vger.kernel.org
Subject: [PATCH v4] builtin/shortlog: explicitly set hash algo when there is no repo
Date: Thu, 17 Oct 2024 11:35:28 +0200
Message-ID: <20241017093528.18157-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011183445.229228-1-wolf@oriole.systems>
References: <20241011183445.229228-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Whilst git-shortlog(1) does not explicitly need any repository
information when run without reference to one, it still parses some of
its arguments with parse_revision_opt() which assumes that the hash
algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
as the default object hash, 2024-05-07) we stopped setting up a default
hash algorithm and instead require commands to set it up explicitly.

This was done for most other commands like in ab274909d4 (builtin/diff:
explicitly set hash algo when there is no repo, 2024-05-07) but was
missed for builtin/shortlog, making git-shortlog(1) segfault outside of
a repository when given arguments like --author that trigger a call to
parse_revision_opt().

Fix this for now by explicitly setting the hash algorithm to SHA1. Also
add a regression test for the segfault.

Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
Here's v4 with the trailers fixed and a small improvement to the test.
The commit including the additional test has been dropped.

Thanks!

 builtin/shortlog.c  | 12 ++++++++++++
 t/t4201-shortlog.sh |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3ed5c46078..c86b75d981 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -407,6 +407,18 @@ int cmd_shortlog(int argc,
 
 	struct parse_opt_ctx_t ctx;
 
+	/*
+	 * NEEDSWORK: Later on we'll call parse_revision_opt which relies on
+	 * the hash algorithm being set but since we are operating outside of a
+	 * Git repository we cannot determine one. This is only needed because
+	 * parse_revision_opt expects hexsz for --abbrev which is irrelevant
+	 * for shortlog outside of a git repository. For now explicitly set
+	 * SHA1, but ideally the parsing machinery would be split between
+	 * git/nongit so that we do not have to do this.
+	 */
+	if (nongit && !the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	repo_init_revisions(the_repository, &rev, prefix);
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index c20c885724..5b5d3b637c 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -143,6 +143,10 @@ fuzz()
 	test_grep "too many arguments" out
 '
 
+test_expect_success 'shortlog --author from non-git directory does not segfault' '
+	nongit git shortlog --author=author </dev/null
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):

Range-diff against v3:
1:  4813b458ac ! 1:  1a2959c0de builtin/shortlog: explicitly set hash algo when there is no repo
    @@ Commit message
         Fix this for now by explicitly setting the hash algorithm to SHA1. Also
         add a regression test for the segfault.
     
    -    Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
         Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
    +    Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
     
      ## builtin/shortlog.c ##
     @@ builtin/shortlog.c: int cmd_shortlog(int argc,
    @@ t/t4201-shortlog.sh: fuzz()
      '
      
     +test_expect_success 'shortlog --author from non-git directory does not segfault' '
    -+	echo | nongit git shortlog --author=author
    ++	nongit git shortlog --author=author </dev/null
     +'
     +
      test_expect_success 'shortlog should add newline when input line matches wraplen' '
2:  9dfdc7510f < -:  ---------- shortlog: Test reading a log from a SHA256 repo in a non-git directory
-- 
2.47.0

