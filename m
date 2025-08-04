Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43F28A40A
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326628; cv=none; b=isTSLYEDzz//qxezNuoBtol8gsyLS/iHn8YY78ReEAVwqYY6vjBen4UeO9fVxKIuTCJaUPjDcrfsf/bo/rx1mtjBRgDVMJ1tyiyXhV28iXWKVIDX/VqEPucGHosCqegocQpWPxRV4rbpAoYcqbuRAQ8VvVV35Hk5v0rcqBovQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326628; c=relaxed/simple;
	bh=3UTKr7+7F6gvH4y2NRAAtyFqaPoo1Wxe2oTIICMOCXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9QvLa0orXEpGZmfNADl+dzwZU7KgIyOHsYCYYBcHMVpI2L85Oo9UFVRA1i3EmXbno4Fgxcexs4nzESpeQgFm/U8H3f4nTBUbX6xwtWa9cryx5ddVJ0/dufZDEB6nTpX2hALq0CuCtLtDGxJ5VG8NU16w70Sn/bT9MZwBseyRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xn2CIGwg; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xn2CIGwg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCvDvYvsa6Xqc8y0o1D39KUWkyOMQF5l1DRkwgtY2E4=;
	b=xn2CIGwgEIH0w2aaLcRL+3ldsO7MFtk8CsgrCT3L8jb+uXhR67YksuKHgfk5ChNrZKA/Bh
	P5KCtMvNSt5pf1HyqEAzsXHHmg8HGx+r0Twfhd2eb2JE1hYD3vwNbJJX7pq0v33M7C+sjM
	O5hG9ArlK8Vq/AanRrjLH+NEUpE1tog=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 04 Aug 2025 18:56:35 +0200
Subject: [PATCH 4/4] archive-zip: move git_deflate() with Z_FINISH into the
 loop
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-toon-archive-zip-fix-v1-4-ca89858e5eaa@iotcl.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Instead duplicating code to do the final deflate (with `flush` value
Z_FINISH), bring this call inside the loop that's deflate parts of the
input stream. This causes also this final deflate to be wrapped in a
loop to ensure the whole input is taken care of.

This change makes crc32() to be called without checking if the `readlen`
is greater than zero, but looking at the zlib manual[1] should be
allowed.

This patch concluded some refactoring, making the code more similar to
the example usage of the official zlib docs[2].

[1]: https://zlib.net/manual.html
[2]: https://zlib.net/zlib_how.html

Co-authored-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 archive-zip.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 25a0224130..559ed267be 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -451,7 +451,7 @@ static int write_zip_entry(struct archiver_args *args,
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
 		git_zstream zstream;
-		int result;
+		int result, flush;
 		size_t out_len;
 		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
 
@@ -459,44 +459,37 @@ static int write_zip_entry(struct archiver_args *args,
 
 		compressed_size = 0;
 
-		for (;;) {
+		do {
 			readlen = read_istream(stream, buf, sizeof(buf));
-			if (readlen <= 0)
+			if (readlen < 0)
 				break;
 			crc = crc32(crc, buf, readlen);
-			if (is_binary == -1)
+			if ((is_binary == -1) && readlen)
 				is_binary = entry_is_binary(args->repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 
+			flush = readlen ? Z_NO_FLUSH : Z_FINISH;
 			zstream.next_in = buf;
 			zstream.avail_in = readlen;
 			do {
 				zstream.next_out = compressed;
 				zstream.avail_out = sizeof(compressed);
-				result = git_deflate(&zstream, 0);
-				if (result != Z_OK)
+				result = git_deflate(&zstream, flush);
+				if ((result != Z_OK) && (result != Z_STREAM_END))
 					die(_("deflate error (%d)"), result);
 				out_len = zstream.next_out - compressed;
 
 				write_or_die(1, compressed, out_len);
 				compressed_size += out_len;
 			} while (zstream.avail_out == 0);
-		}
+		} while (flush != Z_FINISH);
+
 		close_istream(stream);
 		if (readlen)
 			return readlen;
 
-		zstream.next_in = buf;
-		zstream.avail_in = 0;
-		result = git_deflate(&zstream, Z_FINISH);
-		if (result != Z_STREAM_END)
-			die("deflate error (%d)", result);
-
 		git_deflate_end(&zstream);
-		out_len = zstream.next_out - compressed;
-		write_or_die(1, compressed, out_len);
-		compressed_size += out_len;
 		zip_offset += compressed_size;
 
 		write_zip_data_desc(size, compressed_size, crc);

-- 
2.50.1.327.g047016eb4a

