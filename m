Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62361A6835
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979292; cv=none; b=ZdoMoM//TMBYHGNfpAj89LJQGg7LMqtUIfdKr1afj4WPXCr5sQB5jgKfs74+BynolNkaJm/HQlvZVvtqbhf7gUQynlieIRnsnDwkepJuMrkRk+BR0eWjyUUbfuLeh7LuBWFyaC1mk5fqwbRHOoe3TTzwmqkrlMe+PijiIgxTVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979292; c=relaxed/simple;
	bh=DEfy8+gNiDNvqqcnfBrhs2LrBF/Gg0/5OSksFxNYO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdImm6jK3xya/bw+Xy5XliBjuKNT4eztdL2G9kaG32tYunG3eM8JnZgJH8K+t3SrVpX1MeBpt7CbZy0PyAXtJ2UzRvxWIE9rzWQdSdVDC8qBkp67Oy1JnTgf/wBxodkiriD1DE4BDJ1l6TdonEpeznzP0Fznm+8uaRS+ujtaqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Me7lUcfJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Me7lUcfJ"
Received: (qmail 85598 invoked by uid 106); 2 Jul 2026 08:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DEfy8+gNiDNvqqcnfBrhs2LrBF/Gg0/5OSksFxNYO+k=; b=Me7lUcfJ+R78QRzgpmHm5paoEle/cm+ZALSQzffyORxuDmsx3+F33TdJK8EA0jBs8exnFy1gYHlrknHLI08VQanp9SfkCRiRqZgcZpjo5lTBsPoXckymxbvr7PXRWm+QEnT6WiRgs/1FOqhWhGwBSLUNR3CnR+zDl/UceTD4GK1e1JbE8b1ZfOqFwj6p46FBOPi9FA/kpJEVs3u7vzNiGMS+F1b62gMoX4mCVrtvhVa/dQazqr01IxZrfpFK59hv0vwxv2v0UFFHLVbfuVlu7jXejzFB3/J2cl1Dx/Uq0gut/xAAivWLqSBQPjZXE8pTTGjXDC+k7sb4N1EogwZe8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178210 invoked by uid 111); 2 Jul 2026 08:01:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:01:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:01:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/9] csum-file: always finalize or discard hash
Message-ID: <20260702080130.GC2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

When a hashfile struct is created, we always initialize the git_hash_ctx
inside it. We usually end up in hashfile_finalize(), which passes that
ctx to git_hash_final(), cleaning it up.

But a few code paths don't do so:

  1. If we bail on the hashfile and call free_hashfile() directly rather
     than finalizing.

  2. If the skip_hash flag is set, the hashfile_finalize() call will
     never call git_hash_final(). (You might think that we should just
     avoid git_hash_init() entirely in this case, but the skip_hash flag
     is set by the caller after the hashfile is initialized).

For most hash implementations this is OK, but for ones that allocate on
initialization it causes a memory leak. You can see many failures by
running:

  make SANITIZE=leak OPENSSL_SHA1_UNSAFE=1 test

since OpenSSL >= 3.0 is such an allocating hash implementation (and
csum-file uses the "unsafe" algorithm variant).

We can solve this by calling git_hash_discard() as appropriate.

Note that free_hashfile() is used both directly by callers to abort
without finalizing, and by hashfile_finalize() to free memory. In the
latter case we _don't_ want to call git_hash_discard(), because we'll
already have either finalized or discarded it. So we'll push that to an
internal "free_memory" function, and keep free_hashfile() as the public
interface to abort a hashfile without finalizing.

This fix makes several scripts leak-free with the command above: t1600,
t1601, t2107, t7008, t9210, t9211.

Signed-off-by: Jeff King <peff@peff.net>
---
 csum-file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 8ca9246a80..44ff460692 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -55,24 +55,32 @@ void hashflush(struct hashfile *f)
 	}
 }
 
-void free_hashfile(struct hashfile *f)
+static void free_hashfile_memory(struct hashfile *f)
 {
 	free(f->buffer);
 	free(f->check_buffer);
 	free(f);
 }
 
+void free_hashfile(struct hashfile *f)
+{
+	git_hash_discard(&f->ctx);
+	free_hashfile_memory(f);
+}
+
 int finalize_hashfile(struct hashfile *f, unsigned char *result,
 		      enum fsync_component component, unsigned int flags)
 {
 	int fd;
 
 	hashflush(f);
 
-	if (f->skip_hash)
+	if (f->skip_hash) {
+		git_hash_discard(&f->ctx);
 		hashclr(f->buffer, f->algop);
-	else
+	} else {
 		git_hash_final(f->buffer, &f->ctx);
+	}
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -97,7 +105,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 		if (close(f->check_fd))
 			die_errno("%s: sha1 file error on close", f->name);
 	}
-	free_hashfile(f);
+	free_hashfile_memory(f);
 	return fd;
 }
 
-- 
2.55.0.418.g37da59dd42

