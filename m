Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B943BB128
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387347; cv=none; b=QhzHbNAnFzDUErboyiZub5x0r3KaXQcfWuz5y5YM1/SCjf1C0W2dD0wyJGq/+5lnSsKAwkgwMo/rOO038MSe2aMPBrZbkUI1TBUmozFJ1Thj0yK6z8CxaExKsMfGZL4aoC7tPdU4FekBI9sVIPWsWjGBFsJp1dFVslhaNX4arnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387347; c=relaxed/simple;
	bh=bYSdpoBNVjiT/PFLm7KC5wKJS5xeqyN6lZXCx2JPw2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jumifk93Wxja1JcqR0yhFUFXrIAs6Lw4xneA4QgQzESRT5Wwz26U09vTKjbyzFPXua992JyDDsIitwJQFt+vN3y6/6KWQeJbUBG7OWpQXC4oR+lqyEp5LiQppsg9foQseUzJvwE2qHTMlt3qTxEvdv+Yil06hkoEspPDOyhG70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=baNGIeG5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="baNGIeG5"
Received: (qmail 31070 invoked by uid 106); 2 Jun 2026 08:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bYSdpoBNVjiT/PFLm7KC5wKJS5xeqyN6lZXCx2JPw2I=; b=baNGIeG58PguB3smu5qepTLlFfnXRYNRTN4AOV5TLLF7mLVSq5T3iT306+qDc8mJ4+y9iw+HiG2hAbFibS7EJHPREeP6e2WSvzs/mriS0hjQ3cXHjC+JmYBi5R0jiN77JNB7EGRQTGFdq98ZN+GZVlvAgmbV1D0HJIJ8w0A3mQwD3fkU6SsCOOoDM/at9v6Pn3i0Xuviq+c3Ztbln6Duh9Fgxs6UJYLPizQuDm1FH+Jx4tdqeA/k7nGUfHOyG9b6EJQKd8kTj2zFUMwYQ0IUbd6miYIVTuJbsghjajvdVcPOhX/afcryelgxLb37t+EwgHg2tWZEEbv6wGmI3guTKg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 08:02:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 76961 invoked by uid 111); 2 Jun 2026 08:02:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 04:02:28 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 04:02:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
Message-ID: <20260602080223.GA763528@coredump.intra.peff.net>
References: <20260602061159.GA693928@coredump.intra.peff.net>
 <xmqq4ijlz8vc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ijlz8vc.fsf@gitster.g>

On Tue, Jun 02, 2026 at 04:42:15PM +0900, Junio C Hamano wrote:

> > One, I'm not sure how useful printing the pointed-to directory is. We
> > _could_ just say:
> >
> >   fatal: gitfile does not point to a valid repository: /path/to/.git
> >
> > which is enough for somebody to investigate themselves. That would
> > certainly make the patch smaller.
> 
> Thanks.  While reading the main explanation, it was the first thing
> that came to me.

Here's what that looks like, for reference. It is nice and simple, if we
think the change in error message is acceptable. I hate to change
user-facing error messages because of internal code details, but I
really do wonder if the existing message is the most useful thing to
print in the first place.

diff --git a/setup.c b/setup.c
index 075bf89fa9..ed86671d84 100644
--- a/setup.c
+++ b/setup.c
@@ -920,7 +920,7 @@ int verify_repository_format(const struct repository_format *format,
 	return 0;
 }
 
-void read_gitfile_error_die(int error_code, const char *path, const char *dir)
+void read_gitfile_error_die(int error_code, const char *path)
 {
 	switch (error_code) {
 	case READ_GITFILE_ERR_NOT_A_FILE:
@@ -940,7 +940,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 	case READ_GITFILE_ERR_NO_PATH:
 		die(_("no path in gitfile: %s"), path);
 	case READ_GITFILE_ERR_NOT_A_REPO:
-		die(_("not a git repository: %s"), dir);
+		die(_("gitfile does not point to a valid repository: %s"),
+		    path);
 	default:
 		BUG("unknown error code");
 	}
@@ -1031,7 +1032,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	if (return_error_code)
 		*return_error_code = error_code;
 	else if (error_code)
-		read_gitfile_error_die(error_code, path, dir);
+		read_gitfile_error_die(error_code, path);
 
 	free(buf);
 	return error_code ? NULL : path;
@@ -1641,7 +1642,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 					return GIT_DIR_INVALID_GITFILE;
 			default:
 				if (die_on_error)
-					read_gitfile_error_die(error_code, dir->buf, NULL);
+					read_gitfile_error_die(error_code, dir->buf);
 				else
 					return GIT_DIR_INVALID_GITFILE;
 			}
diff --git a/setup.h b/setup.h
index 7878c9d267..436aaa22c1 100644
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
index a939ff5072..c36732ca0b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2578,7 +2578,7 @@ void absorb_git_dir_into_superproject(const char *path,
 
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
