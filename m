Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2497524F
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315260; cv=none; b=ipEdZ+KCpc6TLUYKwhpM3q9JSHIT2AwlxYOsJOYdCY6sKiDJ5TXmm0vQ1H8sYRJMHypD9t6kFLOcGQmtCkLyphLR8i33AW/w2NPobMzehrrA3cgc67a2Imttb2E4KrjLC42TpGocYOFlrSJ+km9tatoItotisVO94RlwzpphKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315260; c=relaxed/simple;
	bh=RJ/WvXr0922sDPna1G0Nd0FxGLr12OU7GE1JG+SfjgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA8+dmXVtdos/7S48VIZHTQa0EhilEfpK+pkRoFZ/0upEJm2t5YLR4sS+ZxnmXpvs+uj6Uroj+6BwONb0edeJO4ZyLiP6VlOn4vPHaStRACwfJoCEXf9o7smhJMOPDavQDW9HluqddeTPmU+uowCfj9+uCg82mWUCwGxosdhRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NdbqfT9Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NdbqfT9Z"
Received: (qmail 11969 invoked by uid 109); 24 Jul 2025 00:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RJ/WvXr0922sDPna1G0Nd0FxGLr12OU7GE1JG+SfjgA=; b=NdbqfT9ZePofPEz2K/694svrRAi1oQ7DjV5BQ/dIVjigi4I3KxawHoRZvVk56T5SvgRWdfCo2Exmj8VrVAT1Z4g8lt6Vq1Fm0zTnHK93TWLKiCLhlNX9ZQ1BvgI66RGhQBXQP1hhpTdAQ1+TqNO1lq+q8Ekp5IFaD61gWAewwlOQeFxYw5bFGv0YTXNwwF2RAQTOuY416XBAkRNpHG1yhvbtxidSpIhSi+C+wqSXVikr57cAKk+SxcnhWFn0Wp82A/qwOyBtnaSn4WlMcusvFnIdnNXpWpv19JD9zI8jJnGaHkuavHXPf6SSS6JgknOugGhJAVGbiWBN7m/3mFlhTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jul 2025 00:00:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25833 invoked by uid 111); 24 Jul 2025 00:01:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 20:01:00 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 20:00:56 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/3] test-delta: handle errors with die()
Message-ID: <20250724000056.GA597294@coredump.intra.peff.net>
References: <20250723235929.GB592873@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723235929.GB592873@coredump.intra.peff.net>

This is a short test helper that does all of its work in the main
function. When we encounter an error, we try to clean up memory and
descriptors and then jump to an error return, which exits the program.

We can get the same effect by just calling die(), which means we do not
have to bother with cleaning up. This simplifies the code, and also
removes some inconsistencies where a few code paths forgot to clean up
descriptors (though in practice it was not a big deal since we were
exiting anyway).

In addition to die() and die_errno(), we'll also use a few of our usual
helpers like xopen() and usage() that make things more ergonomic.

This does change the exit code in these cases from 1 to 128, but I
don't think it matters (and arguably is better, as we'd already exit 128
for other errors like xmalloc() failure).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-delta.c | 55 ++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..4495b32b49 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,39 +21,26 @@ int cmd__delta(int argc, const char **argv)
 	struct stat st;
 	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
 	unsigned long from_size, data_size, out_size;
-	int ret = 1;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "usage: %s\n", usage_str);
-		return 1;
-	}
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
+		usage(usage_str);
 
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[2]);
-		return 1;
-	}
+	fd = xopen(argv[2], O_RDONLY);
+	if (fstat(fd, &st) < 0)
+		die_errno("fstat(%s)", argv[2]);
 	from_size = st.st_size;
 	from_buf = xmalloc(from_size);
-	if (read_in_full(fd, from_buf, from_size) < 0) {
-		perror(argv[2]);
-		close(fd);
-		goto cleanup;
-	}
+	if (read_in_full(fd, from_buf, from_size) < 0)
+		die_errno("read(%s)", argv[2]);
 	close(fd);
 
-	fd = open(argv[3], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[3]);
-		goto cleanup;
-	}
+	fd = xopen(argv[3], O_RDONLY);
+	if (fstat(fd, &st) < 0)
+		die_errno("fstat(%s)", argv[3]);
 	data_size = st.st_size;
 	data_buf = xmalloc(data_size);
-	if (read_in_full(fd, data_buf, data_size) < 0) {
-		perror(argv[3]);
-		close(fd);
-		goto cleanup;
-	}
+	if (read_in_full(fd, data_buf, data_size) < 0)
+		die_errno("read(%s)", argv[3]);
 	close(fd);
 
 	if (argv[1][1] == 'd')
@@ -64,22 +51,16 @@ int cmd__delta(int argc, const char **argv)
 		out_buf = patch_delta(from_buf, from_size,
 				      data_buf, data_size,
 				      &out_size);
-	if (!out_buf) {
-		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		goto cleanup;
-	}
+	if (!out_buf)
+		die("delta operation failed (returned NULL)");
 
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
-		perror(argv[4]);
-		goto cleanup;
-	}
+	fd = xopen(argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
+	if (write_in_full(fd, out_buf, out_size) < 0)
+		die_errno("write(%s)", argv[4]);
 
-	ret = 0;
-cleanup:
 	free(from_buf);
 	free(data_buf);
 	free(out_buf);
 
-	return ret;
+	return 0;
 }
-- 
2.50.1.666.gdb1e186d6a

