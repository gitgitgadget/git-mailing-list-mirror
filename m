Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACB4400
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315335; cv=none; b=TaLd493GiBZXyWtmUzgiAEUHYYnUtX/zGr7jnhHBMd06CGQYQMoznt803Y+Gm5rlZd/hBeWkujAtXNbuCpYKGEHWkcJpV2LI/7y08k/pLP5u6L52AQ96bPFDMG3MAk21Hpb7k5KVtSbbFk17sJp6MtA5LuBTteNNDslR1LYMTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315335; c=relaxed/simple;
	bh=Vmde7UbLYeMv9gSUPOQNYA20ctDqf3KaChU4AbWp/dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCnbHg5S+XDrIZGVl+2N/z7QqFhcLQ7QGx4b3HMNlylFFt/yIxyLG9cEyloXSaXlEDo7l4Bl8KUN7tZVDfliy5uJKct/LA4ykwy+ZQ2JWWEjT4QN2yUqw/YGeGdJBzODXV3tik4Lgl51fLmDn5I+St5SrerBzvcMNTL9lummKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BP9kzYYd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BP9kzYYd"
Received: (qmail 11978 invoked by uid 109); 24 Jul 2025 00:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vmde7UbLYeMv9gSUPOQNYA20ctDqf3KaChU4AbWp/dQ=; b=BP9kzYYdw5i6BnkhmtRaw0A6Bjg14eV5D+PIqHiw0qDH5pKx5PZtRcnwkkYAoWa8/yYLOodoQWbdyR+u4+DrVjDnnPWMCU/C2QbwjUmcOuysYJlD1WzG5spGRSodLISbmtuInvHq8zrC3sN2XqwqWA3bQGyRwVjGXov8+1GtEDS6IWcmfLtfAWsJYz+1/SOYlOO5VMZjNmDI7gqQqPjJMXM7fQ5iRCx9S943eZvgqN0x+xQPgup6o/WEWmaD7x7ElAL7+oWAzdDJpI4rAt8sALq2kxDDgFanSx/BIsQWTJDdChJNTy+ylJYVZ50i1zzPagnUqrwGQcaTNDsLr20nig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jul 2025 00:02:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25851 invoked by uid 111); 24 Jul 2025 00:02:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 20:02:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 20:02:11 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/3] test-delta: use strbufs to hold input files
Message-ID: <20250724000211.GB597294@coredump.intra.peff.net>
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

We want to read the whole contents of two files into memory. If we
switch from raw ptr/len pairs to strbufs, we can use strbuf_read_file()
to shorten the code.

This incidentally fixes two small bugs:

  1. We stat() the files and allocate our buffers based on st.st_size.
     But that is an off_t which may be larger than the size_t we'd use
     to allocate. We should use xsize_t() to do a checked conversion.
     Otherwise integer truncation (on a file >4GB) could cause us to
     under-allocate (though in practice this does not result in a buffer
     overflow because the same truncation happens when read_in_full()
     also takes a size_t).

  2. We get the size from st.st_size, and then try to read_in_full()
     that many bytes. But it may return fewer bytes than expected (if
     the file changed racily and we get an early EOF), leading us to
     read uninitialized bytes in the allocated buffer. We don't notice
     because we only check the value for error, not that we got the
     expected number of bytes.

The strbuf code doesn't run into this, because it just reads to EOF,
expanding the buffer dynamically as necessary. Neither bug is a big deal
for a test helper, but fixing them is a nice bonus on top of simplifying
the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-delta.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 4495b32b49..7945793078 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,45 +11,33 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
+#include "strbuf.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
 
 int cmd__delta(int argc, const char **argv)
 {
 	int fd;
-	struct stat st;
-	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
-	unsigned long from_size, data_size, out_size;
+	struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
+	char *out_buf;
+	unsigned long out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
 		usage(usage_str);
 
-	fd = xopen(argv[2], O_RDONLY);
-	if (fstat(fd, &st) < 0)
-		die_errno("fstat(%s)", argv[2]);
-	from_size = st.st_size;
-	from_buf = xmalloc(from_size);
-	if (read_in_full(fd, from_buf, from_size) < 0)
-		die_errno("read(%s)", argv[2]);
-	close(fd);
-
-	fd = xopen(argv[3], O_RDONLY);
-	if (fstat(fd, &st) < 0)
-		die_errno("fstat(%s)", argv[3]);
-	data_size = st.st_size;
-	data_buf = xmalloc(data_size);
-	if (read_in_full(fd, data_buf, data_size) < 0)
-		die_errno("read(%s)", argv[3]);
-	close(fd);
+	if (strbuf_read_file(&from, argv[2], 0) < 0)
+		die_errno("unable to read '%s'", argv[2]);
+	if (strbuf_read_file(&data, argv[3], 0) < 0)
+		die_errno("unable to read '%s'", argv[3]);
 
 	if (argv[1][1] == 'd')
-		out_buf = diff_delta(from_buf, from_size,
-				     data_buf, data_size,
+		out_buf = diff_delta(from.buf, from.len,
+				     data.buf, data.len,
 				     &out_size, 0);
 	else
-		out_buf = patch_delta(from_buf, from_size,
-				      data_buf, data_size,
+		out_buf = patch_delta(from.buf, from.len,
+				      data.buf, data.len,
 				      &out_size);
 	if (!out_buf)
 		die("delta operation failed (returned NULL)");
@@ -58,8 +46,8 @@ int cmd__delta(int argc, const char **argv)
 	if (write_in_full(fd, out_buf, out_size) < 0)
 		die_errno("write(%s)", argv[4]);
 
-	free(from_buf);
-	free(data_buf);
+	strbuf_release(&from);
+	strbuf_release(&data);
 	free(out_buf);
 
 	return 0;
-- 
2.50.1.666.gdb1e186d6a

