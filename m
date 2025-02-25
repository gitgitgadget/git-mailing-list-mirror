Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33520136341
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465195; cv=none; b=aKgmQ2KVpXkLyqD6TlZFkcbSECeQMBu4ejowypzkwkmMkfWeKGPuIyHoAojwTSpl6AE5uXWjpLVSHXJ2HsLDhoItTNynArP9rtUPjP0FsxvTg8Kbtos9R0cTkTmR6eJjFZY21EKTgljE5YbdHxUwBcVMeqSb7wDi/TP0WNihPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465195; c=relaxed/simple;
	bh=qclubNOT9fAUzvov1T9rC4L8ngwbdMiMBcBj9zFZNNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3lN9LzUPK4l3d8QQ30Pdh/4to0Jn/4eWjbESL2Z1Voj1dOXE+rrBH9Z12jnvUH1l5yknIxYF3zEElgsP2owKNtWrYINog4iayWY22PLVuIWFEzQHj0jKhlPpMOvAOCTOKb2CTbJWVp8BOiOPamhHF6LwJLYodCULDIa1jmj4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gKWRRsje; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gKWRRsje"
Received: (qmail 24662 invoked by uid 109); 25 Feb 2025 06:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qclubNOT9fAUzvov1T9rC4L8ngwbdMiMBcBj9zFZNNw=; b=gKWRRsjekpOAPcUk1qwehH2o1yNouOaLswPVLGny3K3NqhPx+eYIFMSLeuedh4MwQVoFLVgWkjXPKswtuGVRd5gRC4UoPvpK/GBmXRiS57PB5T9huCDlulXg0nQLhPDa5+1zqVShKKDkyRa+P3bF85NViNoOrvBeLPGAewai/vdTZ8+uGk9HRJY+HMmD5Lt75OhEUdjuX24Cob7qBtVsot3UHKYRj1hE/pWL2EbD7HB4gkeY5GbD0tD70gqcCbghWTKYqzkp5gEN88RBfkIyXIHu/sWrFFK9iMAG1Mn0UAVjOZemQHq2n02U6qRKcurwaNexPvLA6AqKI3/pNbsF2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:33:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2798 invoked by uid 111); 25 Feb 2025 06:33:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:33:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:33:12 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 08/10] unpack_loose_rest(): never clean up zstream
Message-ID: <20250225063312.GH1293961@coredump.intra.peff.net>
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

The unpack_loose_rest() function has funny ownership semantics: we pass
in a z_stream opened by the caller, but then only _sometimes_ close it.

This oddity has developed over time. When the function was originally
split out in 5180cacc20 (Split up unpack_sha1_file() some more,
2005-06-02), it always called inflateEnd() to clean up the stream
(though nowadays it is a git_zstream and we call git_inflate_end()).

But in 7efbff7531 (unpack_sha1_file(): detect corrupt loose object
files., 2007-03-05) we added error code paths which don't close the
stream. This makes some sense, as we'd still look at parts of the stream
struct to decide which error to show (though I am not sure in practice
if inflateEnd() even touches those fields).

This subtlety makes it hard to know when the caller has to clean up the
stream and when it does not. That led to the leak fixed by aa9ef614dc
(object-file: fix memory leak when reading corrupted headers,
2024-08-14).

Let's instead always leave the stream intact, forcing the caller to
clean it up. You might think that would create more work for the
callers, but it actually ends up simplifying them, since they can put
the call to git_inflate_end() in the common cleanup code path.

Two things to note, though:

  - The check_stream_oid() function is used as a replacement for
    unpack_loose_rest() in read_loose_object() to read blobs. It
    inherited the same funny semantics, and we should fix it here, too
    (to keep the cleanup in read_loose_object() consistent).

  - In read_loose_object() we need a second "out" label, as we can jump
    to the existing label before opening the stream at all (and since
    the struct is opaque, there is no way to if it was initialized or
    not, so we must not call git_inflate_end() in that case).

Signed-off-by: Jeff King <peff@peff.net>
---
This patch and the two after are pure cleanups which should have no
behavior effect. I think they make things better, but one could argue
they are churn.

I didn't reproduce it, but I think this is also fixing a leak when
check_stream_oid() returned an error.

 object-file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 859888eb2a..8cf87caef5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1437,7 +1437,6 @@ static void *unpack_loose_rest(git_zstream *stream,
 		}
 	}
 	if (status == Z_STREAM_END && !stream->avail_in) {
-		git_inflate_end(stream);
 		return buf;
 	}
 
@@ -1601,8 +1600,8 @@ static int loose_object_info(struct repository *r,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(oid), path);
 
-	git_inflate_end(&stream);
 cleanup:
+	git_inflate_end(&stream);
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
@@ -3081,7 +3080,6 @@ static int check_stream_oid(git_zstream *stream,
 		git_hash_update(&c, buf, stream->next_out - buf);
 		total_read += stream->next_out - buf;
 	}
-	git_inflate_end(stream);
 
 	if (status != Z_STREAM_END) {
 		error(_("corrupt loose object '%s'"), oid_to_hex(expected_oid));
@@ -3128,35 +3126,34 @@ int read_loose_object(const char *path,
 	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				NULL) != ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
-		git_inflate_end(&stream);
-		goto out;
+		goto out_inflate;
 	}
 
 	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
-		git_inflate_end(&stream);
-		goto out;
+		goto out_inflate;
 	}
 
 	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
-			goto out;
+			goto out_inflate;
 	} else {
 		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
 		if (!*contents) {
 			error(_("unable to unpack contents of %s"), path);
-			git_inflate_end(&stream);
-			goto out;
+			goto out_inflate;
 		}
 		hash_object_file_literally(the_repository->hash_algo,
 					   *contents, *size,
 					   oi->type_name->buf, real_oid);
 		if (!oideq(expected_oid, real_oid))
-			goto out;
+			goto out_inflate;
 	}
 
 	ret = 0; /* everything checks out */
 
+out_inflate:
+	git_inflate_end(&stream);
 out:
 	if (map)
 		munmap(map, mapsize);
-- 
2.48.1.709.gf47ae731ff

