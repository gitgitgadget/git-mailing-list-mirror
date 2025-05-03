Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8223E342
	for <git@vger.kernel.org>; Sat,  3 May 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746279130; cv=none; b=PJkJDr4BgE0A4WoFfdSm560GwbEsOIyNG61FJXc3gZgcsykk8M4X8sSEC0C3FkC1aIlxOu3XlttkE3D0fgvSOlhCFyHNsblL100LjzBVhmuHA+RIoF02jz+VpFbbJ5GJ3FrPE75FGRkCKzBHLK2jXt03K6QnhDigacglEiSI6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746279130; c=relaxed/simple;
	bh=6iG2h4SxtN0Q95mFwSJzVn50Gnc2WqxkkGr0rsHORhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWLx6yBcC47RT7loTsteAWMDzQgvyPx8buLOHzbjGK94FOhSxyz5XsahwyliEKbtX697H1hXzXwrW+MaTe3bUv9r+fvxU+Dmgg0lstYjFPGSKc1nIbWPgS4UNmnr5Af8ToBb0kjUHtO/rLiTsaV6GgiU2FHOawdP8hssTyLm4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AGr2gka0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AGr2gka0"
Received: (qmail 10169 invoked by uid 109); 3 May 2025 13:32:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6iG2h4SxtN0Q95mFwSJzVn50Gnc2WqxkkGr0rsHORhI=; b=AGr2gka0dSP3GekVMljQJ2K1tDiOTrx2CZCYQtFU7ri+mfKoIpTM9lps5b/ZIGBbINowK6DxyH+QDYm1UQU3X4zIznDQ5GbfPUHwtkyLN0ZNEJeuIwF3yJtgkQ55ZkBVu09Dddcjueguw/35g9zrOTPJQ8iTbQrooSFyysDb+IY97elTOwHqOdOz+8Dq1AitW7AnjjSY8TrjIybgt+G06vGU0D9XSGouBYgunnuwdtNjPqJMOgpvJFR6d+5csjMdMaYZV+DXdTbOyTgqwS7y+xVbHgGL9+uJBjY7gCkLuOdHpLorwYFssnKhovF0gN9sqAvytu/dWaRBfWxiDbL6qA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 May 2025 13:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3934 invoked by uid 111); 3 May 2025 13:31:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 May 2025 09:31:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 3 May 2025 09:31:58 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <20250503133158.GA4450@coredump.intra.peff.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>

On Sat, May 03, 2025 at 12:57:11AM +0000, brian m. carlson wrote:

> > diff --git a/wrapper.c b/wrapper.c
> > index 3c79778055..4d448d7c57 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -737,7 +737,19 @@ int is_empty_or_missing_file(const char *filename)
> >  int open_nofollow(const char *path, int flags)
> >  {
> >  #ifdef O_NOFOLLOW
> > -	return open(path, flags | O_NOFOLLOW);
> > +	int ret = open(path, flags | O_NOFOLLOW);
> > +#ifdef __NetBSD__
> > +	/*
> > +	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
> > +	 * time this errno occurs when O_REGULAR is used. Since we don't use
> > +	 * it anywhere we can avoid an lstat here.
> > +	 */
> > +	if (ret < 0 && errno == EFTYPE) {
> > +		errno = ELOOP;
> > +		return -1;
> > +	}
> > +#endif
> > +	return ret;
> 
> This patch seems reasonable and correct.  I don't use NetBSD, but I do
> often test there, and I'm aware of this infelicity.  I'm surprised we
> haven't hit it before.
> 
> I suspect we'll also hit this on FreeBSD, which has a similar issue in
> that it returns `EMLINK` instead of `ELOOP`.  I do wish these two OSes
> would provide an appropriate POSIX-compatible `open` call when set with
> `_POSIX_SOURCE`, since this is one of the biggest portability problems
> with them.

The inconsistency in errno has been there since open_nofollow() was
added years ago. But we didn't notice it because in general we try not
to be too particular about which errno value we receive.

That changed in cfea2f2da8 (packed-backend: check whether the
"packed-refs" is regular file, 2025-02-28), which uses open_nofollow()
to check for symlinks while we open it. But it feels like it would be
more direct to just lstat() the file in the first place (which we end up
doing anyway to check for other things besides symlinks!).

I.e., I'd think this would just work everywhere:

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3ad1ed0787..a247220df9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2071,35 +2071,32 @@ static int packed_fsck(struct ref_store *ref_store,
 	if (o->verbose)
 		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
 
-	fd = open_nofollow(refs->path, O_RDONLY);
-	if (fd < 0) {
+	if (lstat(refs->path, &st) < 0) {
 		/*
 		 * If the packed-refs file doesn't exist, there's nothing
 		 * to check.
 		 */
 		if (errno == ENOENT)
 			goto cleanup;
 
-		if (errno == ELOOP) {
-			struct fsck_ref_report report = { 0 };
-			report.path = "packed-refs";
-			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_BAD_REF_FILETYPE,
-					      "not a regular file but a symlink");
-			goto cleanup;
-		}
-
-		ret = error_errno(_("unable to open '%s'"), refs->path);
-		goto cleanup;
-	} else if (fstat(fd, &st) < 0) {
 		ret = error_errno(_("unable to stat '%s'"), refs->path);
 		goto cleanup;
-	} else if (!S_ISREG(st.st_mode)) {
+	}
+
+	if (!S_ISREG(st.st_mode)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs";
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_FILETYPE,
 				      "not a regular file");
+		/* XXX optionally could keep going here and actually
+		 * check the contents we do find */
+		goto cleanup;
+	}
+
+	fd = open(refs->path, O_RDONLY);
+	if (fd < 0) {
+		ret = error_errno(_("unable to open '%s'"), refs->path);
 		goto cleanup;
 	}
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9d1dc2144c..34d54a7c05 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -632,7 +632,7 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 		ln -sf packed-refs-back .git/packed-refs &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: packed-refs: badRefFiletype: not a regular file but a symlink
+		error: packed-refs: badRefFiletype: not a regular file
 		EOF
 		rm .git/packed-refs &&
 		test_cmp expect err &&

It's not as "atomic" as open_nofollow() and fstat(), but I don't think
we care about that for fsck. This is about consistency checking, not
trying to beat races against active adversaries (not to mention that our
open_nofollow() is best-effort anyway, and may be racy).

I dunno. I don't mind making errno returns more consistent to prevent a
future foot-gun, but I think as a general rule we may be better off not
looking too hard at errno for exotic conditions.

-Peff

PS I notice that this same function reads the whole packed-refs file
   into a strbuf. That may be a problem, as they can grow pretty big in
   extreme cases (e.g., GitHub's fork networks easily got into the
   gigabytes, as it was every ref of every fork). We usually mmap it.
   Not related to this discussion, but just something I noticed while
   reading the function.
