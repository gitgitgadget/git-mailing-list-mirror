Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA62EEE61
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400873; cv=none; b=BrS51FcmAHyrDHPwkvZle4FnxWcnM8qvTW3ArEk+biYWxXRRCSeUw0jUfI47HaXj1uNNppWJwIBPt/R/XT1nZ46ajT9Fwx+4UrO7gNCDrI/hIfFX6LKbUvYjn6IkEd8z7sRo62dTLOrp6RPLAlGDhZqlS4sgr3oylMR3McG47Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400873; c=relaxed/simple;
	bh=UtZCjwV3vAAUfzD4PF/j7okYw0YA7/KMVYbHJ3bk32U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B20bjAYfjvns1tg1iVmkO91clOjp8ZxxMNEOYU/KNMj8kMAH1/qeYgXimccEHmypH0DtfWU8RfcwXRceTLrJsqaEeyCgPWkeKt21SZlCgfzuUj6L7ZSl1D+eIYqu8d9S63Y28x4VyBS4W6vLFP+qXBx4Jg9HKKmPShZuIjN78Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fkFHQ020; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fkFHQ020"
Received: (qmail 17532 invoked by uid 106); 7 Jul 2026 05:07:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UtZCjwV3vAAUfzD4PF/j7okYw0YA7/KMVYbHJ3bk32U=; b=fkFHQ020Y4pHGyrG8Irknk1WP+UZ/2FttausIQzQ097P0rldUgAVE5Fjho4IxGKwCqbf3t6zpmxDrHnFW109Vz/I9YFXrelTQJLgJA6ENtS4f7fzu8oOgI25X+7Rg6hvO3M0vE4Gjtxcg09LKzAiPF5cF2tCxIEHo151IiojtWJj6XzKHvM+ZhQSkFjdGa3vccbx70NE9eu8NPLn1Rcx4ySN4grZ4UhXsY8MY1HTge41SHQajNkOj0LdyoYt7vkPwsdBSr4ySiujvq1hn8GiBqEwV5Ni7Z1SaKNEUhtGhZPviRPBLBd+EmXkxDmhRgmBmBHV6BxvLLDOMn6lFd3qXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 05:07:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22504 invoked by uid 111); 7 Jul 2026 05:07:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 01:07:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 01:07:50 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/7] csum-file: use idempotent git_hash_discard()
Message-ID: <20260707050750.GE1288294@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707045556.GA1288172@coredump.intra.peff.net>

Now that it is safe to call git_hash_discard() even after finalizing it,
we can simplify our cleanup logic a bit. This is mostly undoing a few
bits of 64337aecde (csum-file: always finalize or discard hash,
2026-07-02):

  - We no longer need a separate free_hashfile_memory() function for
    finalize_hashfile(). It can just call free_hashfile(), which will
    now discard (or not) the hash as appropriate.

  - When f->skip_hash is set, we don't need to discard; we can rely on
    free_hashfile() to do it.

Signed-off-by: Jeff King <peff@peff.net>
---
 csum-file.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7e81391524..fe18ee1de3 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -55,32 +55,25 @@ void hashflush(struct hashfile *f)
 	}
 }
 
-static void free_hashfile_memory(struct hashfile *f)
+void free_hashfile(struct hashfile *f)
 {
+	git_hash_discard(&f->ctx);
 	free(f->buffer);
 	free(f->check_buffer);
 	free(f);
 }
 
-void free_hashfile(struct hashfile *f)
-{
-	git_hash_discard(&f->ctx);
-	free_hashfile_memory(f);
-}
-
 int finalize_hashfile(struct hashfile *f, unsigned char *result,
 		      enum fsync_component component, unsigned int flags)
 {
 	int fd;
 
 	hashflush(f);
 
-	if (f->skip_hash) {
-		git_hash_discard(&f->ctx);
+	if (f->skip_hash)
 		hashclr(f->buffer, f->algop);
-	} else {
+	else
 		git_hash_final(f->buffer, &f->ctx);
-	}
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -105,7 +98,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 		if (close(f->check_fd))
 			die_errno("%s: sha1 file error on close", f->name);
 	}
-	free_hashfile_memory(f);
+	free_hashfile(f);
 	return fd;
 }
 
-- 
2.55.0.459.g1b256877c9

