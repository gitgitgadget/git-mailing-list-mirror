Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6239989D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380729; cv=none; b=N9OJMVsV2xG4sYILf9dsx6a+LXggaCLBaAJjaH6Bit/yvftnahFeSHjNZ3bT3T6lHUHJVum5g8dPl2g1s/GHNp45OZ3HoVOUzf2gVmk8OX+wNm1Lz7nZ5hXkPH8o4UPHCoN9tJ7vb601fxfNjkt45XYR+FFmfKP0sy9j1DnRWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380729; c=relaxed/simple;
	bh=l+5Ie2+6jLQX0Bd+dVLMQLQ/4O1UjnxaEsP9dMYcdrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A1DtwHZewQcwG0zgNdBr5zeFLfppq8R4M7w5i2BjSi3/a+rQ6E+4/xC+ikkeztnctAr64LwuL4WwqfF67j4XjhJVTKq8m9ezwdUfqHD6lZ4LQim4oBOazsPtrPeP9Kz3W/qKjC7nJWSncoTCtvKC4W9XYb+0xk92rlIhkcbkYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SY0f4JBm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SY0f4JBm"
Received: (qmail 30369 invoked by uid 106); 2 Jun 2026 06:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=l+5Ie2+6jLQX0Bd+dVLMQLQ/4O1UjnxaEsP9dMYcdrU=; b=SY0f4JBmVfbgRYCmT+MOvTcbv2H1FymOKkIJ+dtE7eWZNQfWxek3Z7gO2CeVCs6GLfvYKloXV9uP7umN5Tjeu90H2Tt82nOllZ2YDuy5Sdg+sffEx2YZg2+vqdTVFUXIvONgXj5qT59s/o11yHa9k6uG7F5OzfBlXVMvPFv2U2Zq/GkA9nqY78JEeAVlwSRUsG8mRoiZZERzBitlAQRq+GOCsthTcvfnTAGjgfI2PvFIrsWIZnYvYjp+rjFiS1RyOtCk0Bq/K1HBKXE5JU/3QX7iUcUTOjW2fdhSTX5of/1qPafVg+jZvtaMAmPlqGu4PocovZTND163tBMpJuFhBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 06:12:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 75567 invoked by uid 111); 2 Jun 2026 06:12:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 02:12:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 02:11:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH] read_gitfile_gently(): return non-repo path on error
Message-ID: <20260602061159.GA693928@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This patch fixes a potential segfault when resolving a .git file that
points to an invalid path. The bug was introduced by 1dd27bfbfd (setup:
improve error diagnosis for invalid .git files, 2026-03-04).

In setup_git_directory_gently() we call read_gitfile_gently(), which may
return a numeric code to us on error. If die_on_error is set, we then
feed that code to read_gitfile_error_die(), which also wants the path to
the gitfile and, in the case of ERROR_NOT_A_REPO, the non-repo directory
that the gitfile pointed to.

But we don't have that pointed-to directory available, so we just pass
NULL. That ends up calling die("not a git repository: %s", NULL). This
may crash, though on many systems (like glibc) it will just print
"(null)". So even if we don't crash, we're generating nonsense output.

The problem comes from 1dd27bfbfd. Before that, when die_on_error was
set we'd pass NULL to read_gitfile_gently()'s return_error_code
parameter, which means it would call read_gitfile_error_die() itself.
And it _does_ have that pointed-to directory as a string, and correctly
passes it.  But since 1dd27bfbfd, we always get the numeric error code
back from read_gitfile_gently(), and then decide whether to call
read_gitfile_error_die() in the caller. And since we don't have the
"dir" parameter, we just pass NULL.

Unfortunately the fix is not a simple matter of passing the string to
the right function. We have to get it out of read_gitfile_gently() in
the first place, which means we have to return it as another
out-parameter. And because it involves allocating memory, we can't just
do so unconditionally; callers need to be ready to free it after
handling the error.

I've tried to make the minimally-invasive fix here:

  1. We only copy the string when we hit READ_GITFILE_ERR_NOT_A_REPO,
     so other error codes don't have to worry about freeing it.

  2. We'll turn read_gitfile_gently() into a wrapper which passes NULL
     by default, leaving other callers unaffected.

The result is kind of gross. There's an extra layer of macro
indirection, and the validity of the string is subtly tied to the
NOT_A_REPO error. A cleaner solution might be an error struct that
couples the code and the output string together, along with a function
to free the error struct. But then all callers would have to be modified
to call the free function. Alternatively, we could perhaps put a
large-ish fixed-size buffer in the struct, though that means potential
truncation and a larger stack footprint in each caller (even when they
don't have see an error).

So I've left that as possible work for the future, or maybe never. Some
of this gross-ness was already there. For example, the only other caller
of read_gitfile_error_die() is in submodule.c, and it also passes NULL
for the "dir" parameter. But it does so only when the code is not
NOT_A_REPO! So it is depending on the same subtle connection to avoid
triggering the bug.

There's an existing test in t0002 which triggers this case, but we
didn't notice the problem because it checks only that we said "not a
repository", and not the full string. So if we print "(null)" it is
happy. It will probably crash on some non-glibc platforms, but nobody
seems to have reported it yet (the breakage is recent-ish as of v2.54).
I'm also somewhat surprised that building with ASan/UBSan doesn't catch
this, but it doesn't seem to (and I found an open issue with somebody
asking for it to be implemented in the sanitizers).

We can beef up the test by checking for the full string, which does
demonstrate the bug.

Signed-off-by: Jeff King <peff@peff.net>
---
Two other points of interest.

One, I'm not sure how useful printing the pointed-to directory is. We
_could_ just say:

  fatal: gitfile does not point to a valid repository: /path/to/.git

which is enough for somebody to investigate themselves. That would
certainly make the patch smaller.

And two, I ran into this running doc-diff:

  $ ./doc-diff HEAD^ HEAD
  fatal: not a git repository: (null)

The correct output (which this patch produces) is:

  fatal: not a git repository: /home/peff/compile/git/.git/worktrees/worktree3

And indeed, that path is missing. But why? I feel like I've run into
this same problem occasionally over the last year or so, but never
before. Did we get more aggressive about removing worktrees at some
point? I haven't been able to reproduce whatever is killing off the
worktree directory, and by the time I see the error it is long gone.

Anyway, that's not strictly related to this bug, but just how I
happened across it.

 setup.c            | 19 +++++++++++++++----
 setup.h            |  3 ++-
 t/t0002-gitfile.sh |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index 075bf89fa9..2df6fbf595 100644
--- a/setup.c
+++ b/setup.c
@@ -955,8 +955,14 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
  * will be set to an error code and NULL will be returned. If
  * return_error_code is NULL the function will die instead (for most
  * cases).
+ *
+ * If the code is READ_GITFILE_ERR_NOT_A_REPO and return_error_dir is
+ * non-NULL, the directory to which the gitfile points will be returned
+ * there. The caller is responsible for freeing the resulting string.
  */
-const char *read_gitfile_gently(const char *path, int *return_error_code)
+const char *read_gitfile_gently_with_error_dir(const char *path,
+					       int *return_error_code,
+					       char **return_error_dir)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
@@ -1021,6 +1027,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	}
 	if (!is_git_directory(dir)) {
 		error_code = READ_GITFILE_ERR_NOT_A_REPO;
+		if (return_error_dir)
+			*return_error_dir = xstrdup(dir);
 		goto cleanup_return;
 	}
 
@@ -1613,11 +1621,12 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		int offset = dir->len, error_code = 0;
 		char *gitdir_path = NULL;
 		char *gitfile = NULL;
+		char *error_dst = NULL;
 
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
+		gitdirenv = read_gitfile_gently_with_error_dir(dir->buf, &error_code, &error_dst);
 		if (!gitdirenv) {
 			switch (error_code) {
 			case READ_GITFILE_ERR_MISSING:
@@ -1641,9 +1650,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 					return GIT_DIR_INVALID_GITFILE;
 			default:
 				if (die_on_error)
-					read_gitfile_error_die(error_code, dir->buf, NULL);
-				else
+					read_gitfile_error_die(error_code, dir->buf, error_dst);
+				else {
+					free(error_dst);
 					return GIT_DIR_INVALID_GITFILE;
+				}
 			}
 		} else {
 			gitfile = xstrdup(dir->buf);
diff --git a/setup.h b/setup.h
index 7878c9d267..65f55d5268 100644
--- a/setup.h
+++ b/setup.h
@@ -39,7 +39,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_MISSING 9
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
-const char *read_gitfile_gently(const char *path, int *return_error_code);
+const char *read_gitfile_gently_with_error_dir(const char *path, int *return_error_code, char **return_error_dir);
+#define read_gitfile_gently(path, err) read_gitfile_gently_with_error_dir((path), (err), NULL)
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index dfbcdddbcc..6967e12b9f 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -27,7 +27,7 @@ test_expect_success 'bad setup: invalid .git file format' '
 test_expect_success 'bad setup: invalid .git file path' '
 	echo "gitdir: $REAL.not" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_grep "not a git repository" .err
+	test_grep "not a git repository: $REAL.not" .err
 '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
-- 
2.54.0.682.g2f9b59d445
