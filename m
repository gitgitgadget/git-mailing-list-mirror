Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30F20F5BA
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102895; cv=none; b=lKAX3PU2QRd8nMmquJRvoyh/GadR35BmGC68n+pUYQ2zgN8zMK8SDU9JLbTkPffc5Cl8gfZle2f60rOSsShTJclpxZdQTaAh7XN2sfK5j1z/cT0+RCXVjp3hfv8omITLhdQytRF+bPm/1B9UKXaL7bPqciE5vWNsd285vB1KzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102895; c=relaxed/simple;
	bh=fbyYX1SK9XKXArxpCoh2oCcbwa0cJEM8t0ZAr7Wf93A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCfPFwVzhbQkUmkAfQlRe9dH8JbP2e9s+hbBLBOzvgVGRRtTBR+YEmrWx0JDn7bUIGcJTaxZYDA8mrioFQZT8r+qa/ufMDKAMZKSY/gMN9JfoEx+Uqgn4ttmSU4V8GaI5dKD0WgzYkpleyvxALCYHppRU+ARLn5uypwUJEeWCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=lkkz67NS; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="lkkz67NS"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729102892;
	bh=fbyYX1SK9XKXArxpCoh2oCcbwa0cJEM8t0ZAr7Wf93A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=lkkz67NSp6DfDWFZaYJovua46Ybl0RrO5MFV+WUdBJOSWPvG+sEJsncK5cefJeJhn
	 Ylt2ZU9h0dRF/0bNaZjNgmLtDMw27Nz+KZ6OGg5apk00Fj9U9xdETO4YdssjqzNicJ
	 ysjCGnjJW5Egi4Qex4qeS/6fVVjaR1THiUlWWBRqua21XNl7iPg0a0DBjsKDW8i9El
	 L5TUFcg+UO1IY9BYtpkSLIhpXyzBCcRWaPjzlcP00gNhBGeIVbsEudDABdvZYkZOlZ
	 vAU4au6SozDdf/GHr0MFNzKwQGg6LYFP8a6SS9Iqa/QA8hgNMcawLuch8qbc3YKEo1
	 u1bA66zZku23g==
To: git@vger.kernel.org
Cc: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when there is no repo
Date: Wed, 16 Oct 2024 20:21:23 +0200
Message-ID: <20241016182124.48148-2-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016182124.48148-1-wolf@oriole.systems>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
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

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
---
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
index c20c885724..0cc2aa5089 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -143,6 +143,10 @@ fuzz()
 	test_grep "too many arguments" out
 '
 
+test_expect_success 'shortlog --author from non-git directory does not segfault' '
+	echo | nongit git shortlog --author=author
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):
-- 
2.47.0

