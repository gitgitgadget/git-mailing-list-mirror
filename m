Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29591E764B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992927; cv=none; b=nsePSd67k1ukEO46XQqt8p6ECiGKGDbUG3I6h7V86Ht8uHBcnezHrYZxmotqhBPzuuof9CkoGaNRXKJqUmP1G803Jr5MPwaOr/Q9J8/NyuBYBgRIJgfHajP+sN+C5BL1ssYVjheXVkeXscg8lak8gMqSTgzkxlV+FA8v+QGW6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992927; c=relaxed/simple;
	bh=ukFjx/zbmU61JCfM9BuTtN28KRVmnlsZ3topqv6aUlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTopl8UB5N1bHCWnl+25GVkroEJsOSD80DXa1GkMYeWkzsGhMrIbwnT4FaKBFIwJj+xPGKLHj/n4Q1D6tBOJSB0vqwy1/xq4XWcNbyiLLggUgVCW3bSDklLAmx2m138rj770f2tLKz/4tB7kUeSpWiOaTTWQCQ5X+R5avqsRV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=KJBVdpLP; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="KJBVdpLP"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1728992923;
	bh=ukFjx/zbmU61JCfM9BuTtN28KRVmnlsZ3topqv6aUlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=KJBVdpLPY+1Gam8bf6ksJZTRJJZJUtmT+RUrJ4pfHM/CAPxmn0vcM8852kuRjURFC
	 2YocGw5TsOxf6EfTY6XnR7fABVanjo35YgpZGD4P5igvpJEz23kQvKO3HtNtmHmtMn
	 nRWFA659eToZpXjeeio9p6zV6A4AdDDT46Lj95GIXyQdn91T2Hw/a24y/YPtWmxWLG
	 pgqRFXkA5WRVIhzNx7vhndhQDIBjcwC2NOVD5iSsX2Whu5H+b0M0cHKOeiW1/tGVEo
	 0tcj2/KEqaADkSgx5XAfSnSGCTPITNzEGNvjMI5TN8jbdephMReR1b3vFVe706eAxN
	 YaZ3V3xsYGV/A==
To: git@vger.kernel.org
Cc: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when there is no repo
Date: Tue, 15 Oct 2024 13:48:26 +0200
Message-ID: <20241015114826.715158-1-wolf@oriole.systems>
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

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
 builtin/shortlog.c  | 12 ++++++++++++
 t/t4201-shortlog.sh |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3ed5c46078..0fa35202ed 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -387,6 +387,18 @@ int cmd_shortlog(int argc,
 	struct rev_info rev;
 	int nongit = !startup_info->have_repository;
 
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
 	const struct option options[] = {
 		OPT_BIT('c', "committer", &log.groups,
 			N_("group by committer rather than author"),
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index c20c885724..ed39c67ba1 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -143,6 +143,11 @@ fuzz()
 	test_grep "too many arguments" out
 '
 
+test_expect_success 'shortlog --author from non-git directory does not segfault' '
+	git log --no-expand-tabs HEAD >log &&
+	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):

Range-diff against v1:
1:  42516cc02d ! 1:  d3047a0291 builtin/shortlog: explicitly set hash algo when there is no repo
    @@ Commit message
         a repository when given arguments like --author that trigger a call to
         parse_revision_opt().
     
    -    Fix this for now by explicitly setting the hash algorithm to SHA1.
    +    Fix this for now by explicitly setting the hash algorithm to SHA1. Also
    +    add a regression test for the segfault.
     
         Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
     
    @@ builtin/shortlog.c: int cmd_shortlog(int argc,
      	int nongit = !startup_info->have_repository;
      
     +	/*
    -+	 * Later on we'll call parse_revision_opt which relies on the hash
    -+	 * algorithm being set but since we are operating outside of a Git
    -+	 * repository we cannot determine one. For now default to SHA1.
    ++	 * NEEDSWORK: Later on we'll call parse_revision_opt which relies on
    ++	 * the hash algorithm being set but since we are operating outside of a
    ++	 * Git repository we cannot determine one. This is only needed because
    ++	 * parse_revision_opt expects hexsz for --abbrev which is irrelevant
    ++	 * for shortlog outside of a git repository. For now explicitly set
    ++	 * SHA1, but ideally the parsing machinery would be split between
    ++	 * git/nongit so that we do not have to do this.
     +	 */
     +	if (nongit && !the_hash_algo)
     +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
    @@ builtin/shortlog.c: int cmd_shortlog(int argc,
      	const struct option options[] = {
      		OPT_BIT('c', "committer", &log.groups,
      			N_("group by committer rather than author"),
    +
    + ## t/t4201-shortlog.sh ##
    +@@ t/t4201-shortlog.sh: fuzz()
    + 	test_grep "too many arguments" out
    + '
    + 
    ++test_expect_success 'shortlog --author from non-git directory does not segfault' '
    ++	git log --no-expand-tabs HEAD >log &&
    ++	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
    ++'
    ++
    + test_expect_success 'shortlog should add newline when input line matches wraplen' '
    + 	cat >expect <<\EOF &&
    + A U Thor (2):
-- 
2.47.0

