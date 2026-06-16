Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D52D8DD0
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608763; cv=none; b=L0jvRn4oRRuuuJ59xbpjlw9nc8AiUclIGMreu4MzMXIcm7hPlrB1LyZTse36wwO+PAFj9XESK01pjGFiTxbCfOSRcPfPABr4qC21QQ+oXQXUlG73PQFGCXIe3kYNY9aQrg8MpcZfZl7SVvesVw+qqUu+yFH5dJZZjc5n2hA1pVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608763; c=relaxed/simple;
	bh=8pc3szgRv6E5VapRqpgV2YSRbgGihmPEbWVmSoZu4EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsIDZUj4awKOy94cWYE4wwUBoDrP2oTahWVazg9MxoRgXusmGKkdegTYZKZeIEoRq5Xk1uBz4F49SpZOJl78xavVkCqFjU3kGJARy2UzpfGr644eZopoBu5XENUbw6SyU+G+WWGhQhXt/Bzzx5oGZ0DXzZEbjNco1bhZUSJtNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OhsHKuQ4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OhsHKuQ4"
Received: (qmail 149203 invoked by uid 106); 16 Jun 2026 11:19:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8pc3szgRv6E5VapRqpgV2YSRbgGihmPEbWVmSoZu4EI=; b=OhsHKuQ4Xjo6RyA7LpYhA2tHZ4kbYkMN20BsUlA1hJic3Ir1JU8OF3QXKQhVQgFI1mtvcV5M9B2SyVc/I6ryrG26zAY4MRI4Er7hqgfFxAQ5DKWud/Ah+CQlWvWyIKVqTHH2cBO3GsWELqSBdjyC16cB5vdhy2DsIsITnDi/1nLlRZzMe3aH4qjbm8JhLFCdLxFLGWpuCE6rvd2onkklfNtebo2eVh29WbYmzJb/W6LR3B2KRm+vOS8HbHA2tc2m+mA4ljOmn9FFCkPay8AMCl4gUJA+x95ps6qCYfbNa06HsL9xny66qwz28UmOwP2lfEm1demmxIfxY0tIPhzENw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2026 11:19:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 407798 invoked by uid 111); 16 Jun 2026 11:19:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2026 07:19:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jun 2026 07:19:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2] read_gitfile(): simplify NOT_A_REPO error message
Message-ID: <20260616111919.GC687438@coredump.intra.peff.net>
References: <20260602061159.GA693928@coredump.intra.peff.net>
 <ah6WEtk2pXyViEQA@pks.im>
 <xmqqeciezh0w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeciezh0w.fsf@gitster.g>

On Wed, Jun 10, 2026 at 06:01:03AM -0700, Junio C Hamano wrote:

> > I have to agree that the patch is somewhat gross, and I myself don't
> > really see much of an issue to move to an error message like the above
> > if it ends up simplifying the logic.
> 
> So we are in agreement among three of us that simplifying the code
> to lose error message with dubious value would be a good way
> forward.
> 
> Peff, can we have a formal [v2] then?

Here it is.

-- >8 --
Subject: read_gitfile(): simplify NOT_A_REPO error message

If a .git file is well-formed but points to a directory that is not
itself a valid repository, then we say:

  fatal: not a git repository: <pointed-to-repo>

without mentioning the .git file that pointed us there in the first
place. Doing so could better help the user understand the source of the
problem.

In theory the most helpful thing we could do is mention both paths,
like:

  gitfile '<gitfile>' points to invalid repository: <pointed-to-repo>

But there's another catch: when we generate the error, we don't always
know the pointed-to repository! This leads to a potential segfault.

The message comes from read_gitfile_error_die(). Originally we only
called that function from inside read_gitfile_gently(), passing in both
the gitfile path and the pointed-to path. But that changed in 1dd27bfbfd
(setup: improve error diagnosis for invalid .git files, 2026-03-04).
Since then, the caller in setup_git_directory_gently(), even if it wants
to die on error, always passes in the "return_error_code" flag, asking
the function to instead return a numeric error code. And then it calls
read_gitfile_error_die() itself, passing NULL for the pointed-to path.

If we get the READ_GITFILE_ERR_NOT_A_REPO code, we form a message using
that NULL pointer, and either segfault or get garbage like "not a git
repository: (null)", depending on the platform.

We could fix this by having the function pass out both the numeric error
code and the pointed-to path. But that creates a new headache: we have
to allocate that string on the heap and pass ownership back to the
caller. So now every caller has to be aware of it (and either free the
result, or signal that they are not interested by using an extra
parameter).

Instead, let's just drop the pointed-to path from the error message
entirely, and mention only the gitfile. This fixes the NULL dereference
without introducing any more complexity. The user-facing error message
is not as detailed as it could be, but is better than the original.
Since it mentions the gitfile, a user investigating the situation can
look there to find the pointed-to path (whereas you could not go the
other way from the original message).

There's an existing test in t0002 which triggers this case, but we
didn't notice the problem because it checks only that we said "not a
repository", and not the full string. So if we print "(null)" it is
happy. It will probably crash on some non-glibc platforms, but nobody
seems to have reported it yet (the breakage is recent-ish as of v2.54).
I'm also somewhat surprised that building with ASan/UBSan doesn't catch
this, but it doesn't seem to (and I found an open issue with somebody
asking for NULL printf checks to be implemented in the sanitizers).

We'll tweak the test to match the new error, but there's no need to beef
it up further, since we're not showing the pointed-to path at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c            | 9 +++++----
 setup.h            | 2 +-
 submodule.c        | 2 +-
 t/t0002-gitfile.sh | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..b1d9249d91 100644
--- a/setup.c
+++ b/setup.c
@@ -917,7 +917,7 @@ int verify_repository_format(const struct repository_format *format,
 	return 0;
 }
 
-void read_gitfile_error_die(int error_code, const char *path, const char *dir)
+void read_gitfile_error_die(int error_code, const char *path)
 {
 	switch (error_code) {
 	case READ_GITFILE_ERR_NOT_A_FILE:
@@ -937,7 +937,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 	case READ_GITFILE_ERR_NO_PATH:
 		die(_("no path in gitfile: %s"), path);
 	case READ_GITFILE_ERR_NOT_A_REPO:
-		die(_("not a git repository: %s"), dir);
+		die(_("gitfile does not point to a valid repository: %s"),
+		    path);
 	default:
 		BUG("unknown error code");
 	}
@@ -1028,7 +1029,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	if (return_error_code)
 		*return_error_code = error_code;
 	else if (error_code)
-		read_gitfile_error_die(error_code, path, dir);
+		read_gitfile_error_die(error_code, path);
 
 	free(buf);
 	return error_code ? NULL : path;
@@ -1629,7 +1630,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 					return GIT_DIR_INVALID_GITFILE;
 			default:
 				if (die_on_error)
-					read_gitfile_error_die(error_code, dir->buf, NULL);
+					read_gitfile_error_die(error_code, dir->buf);
 				else
 					return GIT_DIR_INVALID_GITFILE;
 			}
diff --git a/setup.h b/setup.h
index 705d1d6ff7..df8c93687a 100644
--- a/setup.h
+++ b/setup.h
@@ -38,7 +38,7 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_TOO_LARGE 8
 #define READ_GITFILE_ERR_MISSING 9
 #define READ_GITFILE_ERR_IS_A_DIR 10
-void read_gitfile_error_die(int error_code, const char *path, const char *dir);
+void read_gitfile_error_die(int error_code, const char *path);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
diff --git a/submodule.c b/submodule.c
index fd91201a92..93d0361072 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2579,7 +2579,7 @@ void absorb_git_dir_into_superproject(const char *path,
 
 		if (err_code != READ_GITFILE_ERR_NOT_A_REPO)
 			/* We don't know what broke here. */
-			read_gitfile_error_die(err_code, path, NULL);
+			read_gitfile_error_die(err_code, path);
 
 		/*
 		* Maybe populated, but no git directory was found?
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index dfbcdddbcc..6356e9ec72 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -27,7 +27,7 @@ test_expect_success 'bad setup: invalid .git file format' '
 test_expect_success 'bad setup: invalid .git file path' '
 	echo "gitdir: $REAL.not" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_grep "not a git repository" .err
+	test_grep "gitfile does not point to a valid repository" .err
 '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
-- 
2.55.0.rc0.342.g45e27e83e2

