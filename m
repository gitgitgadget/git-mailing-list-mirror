Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07542257437
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465029; cv=none; b=Tk72IM5L9lwbuvjTS7wOGxriZVdKTWbNAVPjncAtZIy9q0O9ilWVDIoReu+Z/m7WXw38K4vpIbPrjmENgcWV4XpPSal/HKYt6k9kJRbymrKmQwa5TwVBaQJqe9Fa7bhKhNSW/gzyAPGs4Md4v0HimAjsHoUKs8kirF7oYi2xxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465029; c=relaxed/simple;
	bh=6Yuc0V/zUvjf1rmB2CQrePXucNIgrCiWaFlQwZ5eRPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+x0/k/KFwG5ae/JV4AQ/4cwx9RwbCg5qPqTQhOB8N9PcXetZVeX6ps9TnJCLtqOTzlE235cEYiVemOdQJBgtujNEKAoU/hwuEvpUwPxaOMCMxKVeqMadR65Jszc7mn7ivE8Tchxqqqna6iBTq4vAxHRsRz0v8u06YuqRgV7FD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H0wzeQOq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H0wzeQOq"
Received: (qmail 24607 invoked by uid 109); 25 Feb 2025 06:30:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6Yuc0V/zUvjf1rmB2CQrePXucNIgrCiWaFlQwZ5eRPo=; b=H0wzeQOq5c28x2+IDVpyfEzTsUztlGNIVHH9XRT7Ods6H3AxzGDQyvGdVbz4mGoFjnCiBerwW3yiB0yzCv2LgUUEqhDM/LMxYoy3ogkoHJZydoPBT8bNRfeVwKZLdXW8ixznyHaNJfAiHHdHQvN086c4VWeN/A5lVm2wcEvU4nyVK20iAoEJaZumNITKpi3hgZ4zKqVUSEn4B7v3veLlZPYg66nXrgwq5uCg7P+0k4ABgFHyU0MpUS4bqrNOszzEGDkGVzMHajqT8kaT57tG0Kgo8WlTe5RiVzTZl6I+PMsSYM2A6fYPGcXmTOo1oG13NR7St7it0JN6QpqE4dwCUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:30:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2751 invoked by uid 111); 25 Feb 2025 06:30:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:30:26 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:30:26 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 05/10] git_inflate(): skip zlib_post_call() sanity check on
 Z_NEED_DICT
Message-ID: <20250225063026.GE1293961@coredump.intra.peff.net>
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

This fixes a case where malformed object input can cause us to hit a
BUG() call in the git-zlib.c code.

The zlib format allows the use of preset dictionaries to reduce the size
of deflated data. The checksum of the dictionary is computed by the
deflate code and goes into the stream. On the inflating side, zlib sees
the dictionary checksum and returns Z_NEED_DICT, asking the caller to
provide the dictionary data via inflateSetDictionary().

This should never happen in Git, because we never provide a dictionary
for deflating (and if we get a stream that mentions a dictionary, we
have no idea how to provide it). So normally Z_NEED_DICT is a hard error
for us. But something interesting happens if we _do_ happen to see it
(e.g., because of a corrupt or malicious input).

In git_inflate() as we loop over calls to zlib's inflate(), we translate
between our large-integer git_zstream values and zlib's native z_stream
types, copying in and out with zlib_pre_call() and zlib_post_call(). In
zlib_post_call() we have a few sanity checks, including one that checks
that the number of bytes consumed by zlib (as measured by it moving the
"next_in" pointer) is equal to the movement of its "total_in" count.

But these do not correspond when we see Z_NEED_DICT! Zlib consumes the
bytes from the input buffer but it does not increment total_in. And so
we hit the BUG("total_in mismatch") call.

There are a few options here:

  - We could ditch that BUG() check. It is making too many assumptions
    about how zlib updates these values. But it does have value in most
    cases as a sanity check on the values we're copying.

  - We could skip the zlib_post_call() entirely when we see Z_NEED_DICT.
    We know that it's hard error for us, so we should just send the
    status up the stack and let the caller bail.

    The downside is that if we ever did want to support dictionaries,
    we couldn't (the git_zstream will be out of sync, since we never
    copied its values back from the z_stream).

  - We could continue to call zlib_post_call(), but skip just that BUG()
    check if the status is Z_NEED_DICT. This keeps git_inflate() as a
    thin wrapper around inflate(), and would let us later support
    dictionaries for some calls if we wanted to.

This patch uses the third approach. It seems like the least-surprising
thing to keep git_inflate() a close to inflate() as possible. And while
it makes the diff a bit larger (since we have to pass the status down to
to the zlib_post_call() function), it's a static local function, and
every caller by definition will have just made a zlib call (and so will
have a status integer).

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-zlib.c          | 27 ++++++++++++++++-----------
 t/t1006-cat-file.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index 651dd9e07c..df9604910e 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -45,7 +45,7 @@ static void zlib_pre_call(git_zstream *s)
 	s->z.avail_out = zlib_buf_cap(s->avail_out);
 }
 
-static void zlib_post_call(git_zstream *s)
+static void zlib_post_call(git_zstream *s, int status)
 {
 	unsigned long bytes_consumed;
 	unsigned long bytes_produced;
@@ -54,7 +54,12 @@ static void zlib_post_call(git_zstream *s)
 	bytes_produced = s->z.next_out - s->next_out;
 	if (s->z.total_out != s->total_out + bytes_produced)
 		BUG("total_out mismatch");
-	if (s->z.total_in != s->total_in + bytes_consumed)
+	/*
+	 * zlib does not update total_in when it returns Z_NEED_DICT,
+	 * causing a mismatch here. Skip the sanity check in that case.
+	 */
+	if (status != Z_NEED_DICT &&
+	    s->z.total_in != s->total_in + bytes_consumed)
 		BUG("total_in mismatch");
 
 	s->total_out = s->z.total_out;
@@ -72,7 +77,7 @@ void git_inflate_init(git_zstream *strm)
 
 	zlib_pre_call(strm);
 	status = inflateInit(&strm->z);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	if (status == Z_OK)
 		return;
 	die("inflateInit: %s (%s)", zerr_to_string(status),
@@ -90,7 +95,7 @@ void git_inflate_init_gzip_only(git_zstream *strm)
 
 	zlib_pre_call(strm);
 	status = inflateInit2(&strm->z, windowBits);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	if (status == Z_OK)
 		return;
 	die("inflateInit2: %s (%s)", zerr_to_string(status),
@@ -103,7 +108,7 @@ void git_inflate_end(git_zstream *strm)
 
 	zlib_pre_call(strm);
 	status = inflateEnd(&strm->z);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	if (status == Z_OK)
 		return;
 	error("inflateEnd: %s (%s)", zerr_to_string(status),
@@ -122,7 +127,7 @@ int git_inflate(git_zstream *strm, int flush)
 				 ? 0 : flush);
 		if (status == Z_MEM_ERROR)
 			die("inflate: out of memory");
-		zlib_post_call(strm);
+		zlib_post_call(strm, status);
 
 		/*
 		 * Let zlib work another round, while we can still
@@ -160,7 +165,7 @@ void git_deflate_init(git_zstream *strm, int level)
 	memset(strm, 0, sizeof(*strm));
 	zlib_pre_call(strm);
 	status = deflateInit(&strm->z, level);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	if (status == Z_OK)
 		return;
 	die("deflateInit: %s (%s)", zerr_to_string(status),
@@ -176,7 +181,7 @@ static void do_git_deflate_init(git_zstream *strm, int level, int windowBits)
 	status = deflateInit2(&strm->z, level,
 				  Z_DEFLATED, windowBits,
 				  8, Z_DEFAULT_STRATEGY);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	if (status == Z_OK)
 		return;
 	die("deflateInit2: %s (%s)", zerr_to_string(status),
@@ -207,7 +212,7 @@ int git_deflate_abort(git_zstream *strm)
 
 	zlib_pre_call(strm);
 	status = deflateEnd(&strm->z);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	return status;
 }
 
@@ -227,7 +232,7 @@ int git_deflate_end_gently(git_zstream *strm)
 
 	zlib_pre_call(strm);
 	status = deflateEnd(&strm->z);
-	zlib_post_call(strm);
+	zlib_post_call(strm, status);
 	return status;
 }
 
@@ -244,7 +249,7 @@ int git_deflate(git_zstream *strm, int flush)
 				 ? 0 : flush);
 		if (status == Z_MEM_ERROR)
 			die("deflate: out of memory");
-		zlib_post_call(strm);
+		zlib_post_call(strm, status);
 
 		/*
 		 * Let zlib work another round, while we can still
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0b0d915773..e493600aff 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -922,6 +922,38 @@ test_expect_success 'truncated object with --allow-unknown-type' - <<\EOT
 	test_grep "unable to unpack $blob header" err
 EOT
 
+test_expect_success 'object reading handles zlib dictionary' - <<\EOT
+	echo 'content that will be recompressed' >file &&
+	blob=$(git hash-object -w file) &&
+	objpath=.git/objects/$(test_oid_to_path "$blob") &&
+
+	# Recompress a loose object using a precomputed zlib dictionary.
+	# This was originally done with:
+	#
+	#  perl -MCompress::Raw::Zlib -e '
+	#    binmode STDIN;
+	#    binmode STDOUT;
+	#    my $data = do { local $/; <STDIN> };
+	#    my $in = new Compress::Raw::Zlib::Inflate;
+	#    my $de = new Compress::Raw::Zlib::Deflate(
+	#      -Dictionary => "anything"
+	#    );
+	#    $in->inflate($data, $raw);
+	#    $de->deflate($raw, $out);
+	#    print $out;
+	#  ' <obj.bak >$objpath
+	#
+	# but we do not want to require the perl module for all test runs (nor
+	# carry a custom t/helper program that uses zlib features we don't
+	# otherwise care about).
+	mv "$objpath" obj.bak &&
+	test_when_finished 'mv obj.bak "$objpath"' &&
+	printf '\170\273\017\112\003\143' >$objpath &&
+
+	test_must_fail git cat-file blob $blob 2>err &&
+	test_grep 'error: inflate: needs dictionary' err
+EOT
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.48.1.709.gf47ae731ff

