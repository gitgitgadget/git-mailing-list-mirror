Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C0646
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879608; cv=none; b=W4mk8nGfAPwWIT+B5sqNpvls13+itR7I9G5lUhdJ9HqeHp4sH28X2F0GFqVym/uyBfv/LFWgAdZ528MBi2C/s4qA6rHx13ZiwyUB3jgMgzG/3NGFuAFkOKXUJQ/rBvV0s8r2DbdOVeUh5apt9duEJ64TQ7rDn56dUBZ/9SJ2m9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879608; c=relaxed/simple;
	bh=cV8CoVp27+UIwk01GlA/Tjtxy7CENQJfCFVFhmhlIsw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIm2pfnyQ+NRjinomcDAj4qwXiDin+4+DeRbEXQTqzXqbX2l/XF0UCzICvZ2BiQWrvvfcj8uerONqwObC88PSR7U17uj/eJtZq/Tl1iRcWss46m60E5jS/iu3kNv9/6d8K7arJ0Df2mnobJV3j8VV+14rIg6nM3tqiumY38G4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23552 invoked by uid 109); 17 Aug 2024 07:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27557 invoked by uid 111); 17 Aug 2024 07:26:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:26:49 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:26:44 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/5] refs: drop some unused parameters from
 create_symref_lock()
Message-ID: <20240817072644.GA1535915@coredump.intra.peff.net>
References: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817072621.GA1535666@coredump.intra.peff.net>

This function was factored out in 57d0b1e2ea (files-backend: extract out
`create_symref_lock()`, 2024-05-07), but we never look at the ref_store
or refname parameters. We just need the path, which is already contained
in the lockfile struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d6ec9458d..1cff65f6ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1961,9 +1961,8 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static int create_symref_lock(struct files_ref_store *refs,
-			      struct ref_lock *lock, const char *refname,
-			      const char *target, struct strbuf *err)
+static int create_symref_lock(struct ref_lock *lock, const char *target,
+			      struct strbuf *err)
 {
 	if (!fdopen_lock_file(&lock->lk, "w")) {
 		strbuf_addf(err, "unable to fdopen %s: %s",
@@ -2579,8 +2578,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
-		if (create_symref_lock(refs, lock, update->refname,
-				       update->new_target, err)) {
+		if (create_symref_lock(lock, update->new_target, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
 		}
-- 
2.46.0.585.gd6679c16d8

