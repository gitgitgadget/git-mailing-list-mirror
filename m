Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB521FF3D
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371002; cv=none; b=aT58M7tdKoSbMZr9tERGROVCGrKtpkrSjqqQNDe8mDgeRA7zOlsBu66e2s4dUgMIlnOMh1X/ss+/DO6KPF0gQN/unphnuGCn5Jka4A/2hwmEJmbvInuQLIVhczq/Zlp5w+tRmkxg8TQliRg4Z7+Jc5KYyOH4kCbAqQCxjNa0+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371002; c=relaxed/simple;
	bh=s+cN2o8RXQ15q5lcAC92doZh8QYxoGFBtm00JeABifo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5JqXVozEq8StoMtwKfEo4z5GS4FIlqmk9PidbG9027SLi25RDg4JDJ0F015qedHHqqbun769a7vBj20gQqxdpE5sgoMF+WYwBhLoCzOs3XnahBOU1/KHu86oY8mutm74SJIaSjraFhCXYraGHmWIIU+NPRfND0+RRXamR0oz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IZnfQ9gu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IZnfQ9gu"
Received: (qmail 5174 invoked by uid 109); 16 May 2025 04:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=s+cN2o8RXQ15q5lcAC92doZh8QYxoGFBtm00JeABifo=; b=IZnfQ9guwe03JZ8saVo9wsiu2HfOOWYNBWk8N+Dd/u4LxPR02ztq64E1Gtv+K9XZijOua8DqF5elfk9YuKz5fxgpwtpuR4lFFF1mHjkNNA/qOKeZhDY/2+kVCfh+jmsYRNKFq2ZjWhLy0z9V3puvRBKDzmHIVkG4LuvjFrP+8Cb9uRM1dcZQKU83u12RIeiQhGKUtXgiO4Pw767L7IfGsAk/NIICRRsEGq9t6kdyrmp0eHHulijar0Ko/xaVG2K7zAqqfpoMTYGHjY3ddtkKQx5iLbQPTBg0RclbYGRL8HDEOO9cMG0/vy43K0+tL+YzS2BERxdhvdneWRqchGytTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4951 invoked by uid 111); 16 May 2025 04:50:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 08/13] t/helper: add zlib test-tool
Message-ID: <20250516044959.GH22242@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net>

It's occasionally useful when testing or debugging to be able to do raw
zlib inflate/deflate operations (e.g., to check the bytes of a specific
loose or packed object).

Even though zlib's deflate algorithm is used by many other programs,
this is surprisingly hard to do in a portable way. E.g., gzip can do
this if you manually munge some header bytes. But the result is somewhat
arcane, and we don't assume gzip is available anyway. Likewise, pigz
will handle raw zlib, but we can't assume it is available.

So let's introduce a short test helper for just doing zlib operations.
We'll use it in subsequent patches to add some new tests, but it would
also have come in handy a few times in the past:

  - The hard-coded pack data from 3b910d0c5e (add tests for indexing
    packs with delta cycles, 2013-08-23) could probably be generated on
    the fly.

  - Likewise we could avoid the hard-coded data from 0b1493c2d4
    (git_inflate(): skip zlib_post_call() sanity check on Z_NEED_DICT,
    2025-02-25). Though note this would require support for more zlib
    options.

  - It would have helped with the debugging documented in 41dfbb2dbe
    (howto: add article on recovering a corrupted object, 2013-10-25).

I'll leave refactoring existing tests for another day, but I hope the
examples above show the general utility.

I aimed for simplicity in the code. In particular, it will read all
input into a memory buffer, rather than streaming. That makes the zlib
loops harder to get wrong (which has been a source of subtle bugs in the
past).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile             |  1 +
 t/helper/meson.build |  1 +
 t/helper/test-tool.c |  1 +
 t/helper/test-tool.h |  1 +
 t/helper/test-zlib.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 t/helper/test-zlib.c

diff --git a/Makefile b/Makefile
index de73c6ddcd..14616ff625 100644
--- a/Makefile
+++ b/Makefile
@@ -859,6 +859,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_BUILTINS_OBJS += test-zlib.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d4e8b26df8..675e64c010 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -77,6 +77,7 @@ test_tool_sources = [
   'test-windows-named-pipe.c',
   'test-write-cache.c',
   'test-xml-encode.c',
+  'test-zlib.c',
 ]
 
 test_tool = executable('test-tool',
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 74812ed86d..a7abc618b3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -91,6 +91,7 @@ static struct test_cmd cmds[] = {
 	{ "windows-named-pipe", cmd__windows_named_pipe },
 #endif
 	{ "write-cache", cmd__write_cache },
+	{ "zlib", cmd__zlib },
 };
 
 static NORETURN void die_usage(void)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 2571a3ccfe..7f150fa1eb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -84,6 +84,7 @@ int cmd__wildmatch(int argc, const char **argv);
 int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
 int cmd__write_cache(int argc, const char **argv);
+int cmd__zlib(int argc, const char **argv);
 
 int cmd_hash_impl(int ac, const char **av, int algo, int unsafe);
 
diff --git a/t/helper/test-zlib.c b/t/helper/test-zlib.c
new file mode 100644
index 0000000000..de7e9edee1
--- /dev/null
+++ b/t/helper/test-zlib.c
@@ -0,0 +1,62 @@
+#include "test-tool.h"
+#include "git-zlib.h"
+#include "strbuf.h"
+
+static const char *zlib_usage = "test-tool zlib [inflate|deflate]";
+
+static void do_zlib(struct git_zstream *stream,
+		    int (*zlib_func)(git_zstream *, int),
+		    int fd_in, int fd_out)
+{
+	struct strbuf buf_in = STRBUF_INIT;
+	int status = Z_OK;
+
+	if (strbuf_read(&buf_in, fd_in, 0) < 0)
+		die_errno("read error");
+
+	stream->next_in = (unsigned char *)buf_in.buf;
+	stream->avail_in = buf_in.len;
+
+	while (status == Z_OK ||
+	       (status == Z_BUF_ERROR && !stream->avail_out)) {
+		unsigned char buf_out[4096];
+
+		stream->next_out = buf_out;
+		stream->avail_out = sizeof(buf_out);
+
+		status = zlib_func(stream, Z_FINISH);
+		if (write_in_full(fd_out, buf_out,
+				  sizeof(buf_out) - stream->avail_out) < 0)
+			die_errno("write error");
+	}
+
+	if (status != Z_STREAM_END)
+		die("zlib error %d", status);
+
+	strbuf_release(&buf_in);
+}
+
+int cmd__zlib(int argc, const char **argv)
+{
+	git_zstream stream;
+
+	if (argc != 2)
+		usage(zlib_usage);
+
+	memset(&stream, 0, sizeof(stream));
+
+	if (!strcmp(argv[1], "inflate")) {
+		git_inflate_init(&stream);
+		do_zlib(&stream, git_inflate, 0, 1);
+		git_inflate_end(&stream);
+	} else if (!strcmp(argv[1], "deflate")) {
+		git_deflate_init(&stream, Z_DEFAULT_COMPRESSION);
+		do_zlib(&stream, git_deflate, 0, 1);
+		git_deflate_end(&stream);
+	} else {
+		error("unknown mode: %s", argv[1]);
+		usage(zlib_usage);
+	}
+
+	return 0;
+}
-- 
2.49.0.896.g93578ceaaf

