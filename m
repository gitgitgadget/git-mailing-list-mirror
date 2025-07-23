Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1617E4
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258003; cv=none; b=LR2dD/q4UMgdXIhCYootbowPS0kUUdXazI3UoyXzedpfoZBsTTGefS3i1tx6zU18hKAi4zKa9Lner3OPxoD8XqT6W78+OcDullA8l04ZY1oFcrCTZyHvkp6jJd2OrvhSjR2z2GzOmIRpFV/qg14AQ+d0S1JFFK5uStk3xB5ZvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258003; c=relaxed/simple;
	bh=OUlo8puVhqgIhT3HBXv++EcH40q+/v54PG7jlXqWRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3JH20lV8TpaFZ3xoyrOql/OXILWMhc0FMcp1bLlboQ3pVTuLHaOXCTkc7eKJuP9GvCbiM4RJxq62s6rdY0kVCSVJwIcjRV8xb5yX0MZ494awwlk3MCP99v/SwDgSSwGiQjC3c6DAhohw29uAJpfU8+fMkTJKU1HnR8tnyQiUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DTTBh08z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DTTBh08z"
Received: (qmail 4485 invoked by uid 109); 23 Jul 2025 08:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OUlo8puVhqgIhT3HBXv++EcH40q+/v54PG7jlXqWRj4=; b=DTTBh08zzXbFIW7bAqjDop3DDKJmrmUyBzz1hTqvcnmQCEmgiZv36VqE6Rf4vgkOT5gNKBOEzIZaGYdqmxGcBp+N1FaRgncV44VOp+RGZTpcoFjjgX6bwP/nkyatJqy7BK9riSuyYC3zJXkn86ONCzuUGKeSAZT0bf9efZPvlbaOXRbtbCT+ZJCfZatJ6dLSOKDSueMnLWpr89ZG3hjKQjstLC093oh5qNEJS/V16Lje85IfwM6B7NYRyWk3Xa8QXQqiSgHncb1s5nBM4B3xcK1Lr/sJ/UD97uyIxSy1z+4oG14SpiGGKIIPPz89dMN61H6nRZzYQH33dZi1WxwOcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 08:06:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13180 invoked by uid 111); 23 Jul 2025 08:06:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 04:06:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 04:06:39 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
Message-ID: <20250723080639.GA570920@coredump.intra.peff.net>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
 <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
 <20250723075513.GA570540@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723075513.GA570540@coredump.intra.peff.net>

On Wed, Jul 23, 2025 at 03:55:13AM -0400, Jeff King wrote:

> I dunno. We are reaching diminishing returns spending brainpower on a
> function that is meant to be somewhat quick-and-dirty.

OK, I clearly could not resist spending more brainpower on it. If we are
doing quick-and-dirty, why not just die()? The end result is the same,
but per my argument in the earlier iteration of the series, that means
we do not have to worry about cleaning up at all.

Like:

 t/helper/test-delta.c | 49 ++++++++++++-----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..769b68839d 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,39 +21,28 @@ int cmd__delta(int argc, const char **argv)
 	struct stat st;
 	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
 	unsigned long from_size, data_size, out_size;
-	int ret = 1;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
 		return 1;
 	}
 
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
@@ -64,22 +53,16 @@ int cmd__delta(int argc, const char **argv)
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


I'd guess that one could probably go even further by replacing the bare
pointers with strbufs. And then you could use strbuf_read_file().

Incidentally that would also fix two minor bugs I noticed:

  - passing st.st_size directly to xmalloc() is wrong, because of
    truncation from off_t to size_t. This should use the xsize_t helper.
    This is even a potential security vulnerability, but probably not
    important in a test helper.

  - likewise read_in_full() might return a non-negative value smaller
    than the requested size (if the file racily changes and we get an
    early EOF). But we only check whether we got a negative error value.
    So we may read fewer bytes than expected and feed uninitialized
    garbage to the delta code.

-Peff
