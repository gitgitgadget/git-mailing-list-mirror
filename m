Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4083D4128
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979402; cv=none; b=nQMMzhqtprMxB/xBlhcFvgOOv1o+lHzNdCycdaVzbRlRBNMG+tw9DrcHBXUPGJMh5iax8lArNomB9YjxU9tmrtqu9/nkYKc+e4hPuiaETyqDrWNkmhykGdHpUTpf6rTEerguw+JpvFgA8KU/ivC5PSxmH69+C0RSOzY51/9nk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979402; c=relaxed/simple;
	bh=JkKZfuOnxleW/mrulZrbiMHPHleynkkFtCaSnLEzmQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6tM6p40AJYsi2NyGoKrWifgJBlHE9v4l4kb5FY6VFnJUSba3vknFYdGvjVeosG9QzBz/tTSjOIO7b06+iymvF7H2ay4Cv919pk6607bY3AajFf3OekcvMCxiq6O5RsBS17mOid4Aqgr5rXAq8dJ9TdJGPGMxHZehG8i/F8zUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OHLQYZ5U; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OHLQYZ5U"
Received: (qmail 85621 invoked by uid 106); 2 Jul 2026 08:03:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JkKZfuOnxleW/mrulZrbiMHPHleynkkFtCaSnLEzmQQ=; b=OHLQYZ5U77atHdP+9I+0/EsexnfgiWg7/WioqPAr4L35OpV3IEO/lvZHf2q+Q/llMl7bltoU27b/qeY1tFKUEEBtwdd9u7BvUP0q2vY7H4uPpNLNWEoqWJIAGGsfSJXQRDt8ZUM8zF9/9fKDekdTVfS1zZWjVHChKsEqEmJ0+wZoM5WCenkQ15hlmxW69ieTM4SLNmdtBaQglNTbdAlM/ePvthVi/Y69xa7nHAThTUUL6Q1gSICwUIDEEbxTiT5sOr/GCdCiiCGqvXX4NRr7+lBkTItClryXagtdpkKiKEqSWzMynaqau+H6It28/5OnN+6EWZGDPW+mqTiaj4EeMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:03:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178222 invoked by uid 111); 2 Jul 2026 08:03:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:03:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:03:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/9] csum-file: provide a function to release checkpoints
Message-ID: <20260702080319.GD2029434@coredump.intra.peff.net>
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

A hashfile_checkpoint struct is basically just a copy of the hash_ctx
state at a given point in the file. As such, it contains its own
git_hash_ctx which may (depending on the underlying hash implementation)
need to be discarded when we're done with it.

Let's add a "release" function which cleans up the hash context it
holds. I chose "release" here and not "discard" because you'd use this
to clean up every checkpoint, whether you used it or not. As opposed to
git_hash_discard(), which is needed only if you didn't call
git_hash_final().

There are only two callers which use hashfile_checkpoints, and we can
add release calls to both. When built with "SANITIZE=leak
OPENSSL_SHA1_UNSAFE=1", this makes both t1050 and t9300 leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-import.c | 1 +
 csum-file.c           | 5 +++++
 csum-file.h           | 1 +
 object-file.c         | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index aa656c5195..f6473dcc8e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1216,6 +1216,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 out:
 	free(in_buf);
 	free(out_buf);
+	hashfile_checkpoint_release(&checkpoint);
 }
 
 /* All calls must be guarded by find_object() or find_mark() to
diff --git a/csum-file.c b/csum-file.c
index 44ff460692..b166f89624 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -223,6 +223,11 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	return 0;
 }
 
+void hashfile_checkpoint_release(struct hashfile_checkpoint *checkpoint)
+{
+	git_hash_discard(&checkpoint->ctx);
+}
+
 void crc32_begin(struct hashfile *f)
 {
 	f->crc32 = crc32(0, NULL, 0);
diff --git a/csum-file.h b/csum-file.h
index d1a0ff29cd..6ed74d1637 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -39,6 +39,7 @@ struct hashfile_checkpoint {
 void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
 void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
 int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
+void hashfile_checkpoint_release(struct hashfile_checkpoint *);
 
 /* finalize_hashfile flags */
 #define CSUM_CLOSE		1
diff --git a/object-file.c b/object-file.c
index e3d92bbda2..32a0d6d237 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1352,6 +1352,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 			   state->alloc_written);
 		state->written[state->nr_written++] = idx;
 	}
+
+	hashfile_checkpoint_release(&checkpoint);
 	return 0;
 }
 
-- 
2.55.0.418.g37da59dd42

