Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A857256C88
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465060; cv=none; b=OnEmn1sAuf58JwxHMuwRVq20LsG7vHhCOv8uvP82+d9d3XbjsQl4RKGX13xZIsJeJ9xzYqoRtYqqvyC009I2uHTphB783F1MF/rT92wXqhPvlUzEJvM/GdtNrQL7hE+RBXMwZhKqt8wEJUaoOzrXasBMmBcGnxWY4pPvCqlXR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465060; c=relaxed/simple;
	bh=dIlvnyf7j8YaT1s4xEGjK41/PMSJ3UI9fWr2UOG1ckw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJGf+s2Uw6U67hz7I/OH3/vEYZYT83bzrBzcEHZ9m9HHEGzF8SALzHLZFl+jT8vbvnHvItxrtQj3cw2Svg899I5ldVjVXDuYMXSGyUQwVzBjKQ8VhaQ5G5EtP34PjvP5xEbpB1YcqUyaa0tvsvSqMxESBUE9duylUxQg3o30I1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aG9waDtz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aG9waDtz"
Received: (qmail 24620 invoked by uid 109); 25 Feb 2025 06:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dIlvnyf7j8YaT1s4xEGjK41/PMSJ3UI9fWr2UOG1ckw=; b=aG9waDtzxp2OtdPZAJ+W/jCGIFFQnRW3Dp3+galZloIUDE9ohJhz3X8H2gFrdHxmWM3CreV79LXVyu+dOIiO9dwAEwC+/VFb5Lx1/C3TbdlhNNYw705OqQvPzp0Dl/bNgdihVYqtb14WDWNhJxXIHlcDn/TTJLmIdTpNpgcOBe3R2/Oy4ra5HJRVfZcN3Vr59tCSkJVgCRD9FhG5AF0WDYL/QRmvhCWxEZiC012O9jo33mZSgD5QrTtJO4jqflpZuj6XQL/PJB+qJ/KCIzEOoUMaXalPAjbdPaDXsHGQBLRIe4lNIEfjZArPAygR3ERA7jjpOEhUZBr5aF4VYFUsCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2755 invoked by uid 111); 25 Feb 2025 06:30:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:30:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:30:56 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 06/10] unpack_loose_header(): avoid numeric comparison of
 zlib status
Message-ID: <20250225063056.GF1293961@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062518.GA1293854@coredump.intra.peff.net>

When unpacking a loose header, we try to inflate the first 32 bytes.
We'd expect either Z_OK (we filled up the output buffer, but there are
more bytes in the object) or Z_STREAM_END (this is a tiny object whose
header and content fit in the buffer).

We check for that with "if (status < Z_OK)", making the assumption that
all of the errors we'd see have negative values (as Z_OK itself is "0",
and Z_STREAM_END is "1").

But there's at least one case this misses: Z_NEED_DICT is "2". This
isn't something we'd ever expect to see, but if we do see it, we should
consider it an error (since we have no dictionary to load).

Instead, the current code interprets Z_NEED_DICT as success and looks
for the object header's terminating NUL in the bytes we've read. This
will generaly be zero bytes if the dictionary is mentioned at the start
of the stream. So we'll fail to find it and complain "the header is too
long" (ULHR_LONG). But really, the problem is that the object is
malformed, and we should return ULHR_BAD.

This is a minor bug, as we consider both cases to be an error. But it
does mean we print the wrong error message. The test case added in the
previous patch triggers this code, so we can just confirm the error
message we see here.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c       | 2 +-
 t/t1006-cat-file.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 5b2446bfc1..5b347cfc2f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1362,7 +1362,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	obj_read_unlock();
 	status = git_inflate(stream, 0);
 	obj_read_lock();
-	if (status < Z_OK)
+	if (status != Z_OK && status != Z_STREAM_END)
 		return ULHR_BAD;
 
 	/*
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index e493600aff..86a2825473 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -951,6 +951,8 @@ test_expect_success 'object reading handles zlib dictionary' - <<\EOT
 	printf '\170\273\017\112\003\143' >$objpath &&
 
 	test_must_fail git cat-file blob $blob 2>err &&
+	test_grep ! 'too long' err &&
+	test_grep 'error: unable to unpack' err &&
 	test_grep 'error: inflate: needs dictionary' err
 EOT
 
-- 
2.48.1.709.gf47ae731ff

