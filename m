Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3D25A343
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465002; cv=none; b=JEqtJe75uJMTQyNDLaE2L1MjPYr4e2DKVBV545/MCyFa/ZOYZPo9LW7T6i6G7DZtqXREPGpw2cxTAx1pzfCbGMm7Q7Esmub1SVJxmakEiM+angisGnztY5d3TSvrER9Qjh65KYCC4+jOg4IYu3fa/h5acuOl7CuXz3b8aBYgPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465002; c=relaxed/simple;
	bh=LzgM5QvFa5WiI2p/dd2I95OmHFyeMo/XNlq5gq6XH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl5VFBgEo9pv/4/xfWJLtlDSFoQmfaRY3n/vMlr9CWivJ95lh5CA6KarVPHCvfx9oS+upF/NToaKWA/8xCO21D6TmpG0PR7Wx+hMlg3P05JqyLOuheebEPQt+t/zpd2ZOr0vMZu6VBm6BWppUyeHHGKfs0/jm+uPHjYjugbVJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q8whKnUL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q8whKnUL"
Received: (qmail 24596 invoked by uid 109); 25 Feb 2025 06:29:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LzgM5QvFa5WiI2p/dd2I95OmHFyeMo/XNlq5gq6XH+s=; b=Q8whKnULIQxXDAXKkMZLkh+l+ozM0INXPTI5tHLcFPm7XYsXfSNVWo9WeJ2G5JQ+asMnaHhxHXHSkokQEsM0CqV7MD/5ntVoCcFDsMVMjmz9nkcsvqHpT2DzOYgZEfPjHe/kPLMrA7QYkKg6gyTD7kisgTOglfZKua5sbSeK+KXlZm0EAp2Dk92L84LPRtoTFlyy6oOtO62Flcbb756vhue/glROr/FqfOE6CQPcsz38/rKuMRh148Njqtm6TAjjmOrlRhOQeMmjkloj+MCeJgpmmixaoGby4xs5zqW+7a9rzGjIDe7xlVPrExm1RL4qAPU4hX7FyucGT7DpUIM8eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:29:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2705 invoked by uid 111); 25 Feb 2025 06:29:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:29:58 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:29:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 04/10] unpack_loose_header(): fix infinite loop on broken
 zlib input
Message-ID: <20250225062958.GD1293961@coredump.intra.peff.net>
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

When reading a loose object, we first try to expand the first 32 bytes
to read the type+size header. This is enough for any of the normal Git
types. But since 46f034483e (sha1_file: support reading from a loose
object of unknown type, 2015-05-03), the caller can also ask us to parse
any unknown names, which can be much longer. In this case we keep
inflating until we find the NUL at the end of the header, or hit
Z_STREAM_END.

But what if zlib can't make forward progress? For example, if the loose
object file is truncated, we'll have no more data to feed it. It will
return Z_BUF_ERROR, and we'll just loop infinitely, calling
git_inflate() over and over but never seeing new bytes nor an
end-of-stream marker.

We can fix this by only looping when we think we can make forward
progress. This will always be Z_OK in this case. In other code we might
also be able to continue on Z_BUF_ERROR, but:

  - We will never see Z_BUF_ERROR because the output buffer is full; we
    always feed a fresh 32-byte buffer on each call to git_inflate().

  - We may see Z_BUF_ERROR if we run out of input. But since we've fed
    the whole mmap'd buffer to zlib, if it runs out of input there is
    nothing more we can do.

So if we don't see Z_OK (and didn't see the end-of-header NUL, otherwise
we'd have broken out of the loop), then we should stop looping and
return an error.

The test case shows an example where the input is truncated (which gives
us the input Z_BUF_ERROR case above).

Although we do operate on objects we might get from an untrusted remote,
I don't think the security implications of this bug are too great. It
can only trigger if both of these are true:

  - You're reading a loose object whose on-disk representation was
    written by an attacker. So fetching an object (or receiving a push)
    are mostly OK, because even with unpack-objects it is our local,
    trusted code that writes out the object file. The exception may be
    fetching from an untrusted local repo, or using dumb-http, which
    copies objects verbatim. But...

  - The only code path which triggers the inflate loop is cat-file's
    --allow-unknown-type option. This is unlikely to be called at all
    outside of debugging. But I also suspect that objects with
    non-standard types (or that are truncated) would not survive the
    usual fetch/receive checks in the first place.

So I think it would be quite hard to trick somebody into running the
infinite loop, and we can just fix the bug.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c       |  2 +-
 t/t1006-cat-file.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 8c9295413b..5b2446bfc1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1396,7 +1396,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
-	} while (status != Z_STREAM_END);
+	} while (status == Z_OK);
 	return ULHR_BAD;
 }
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 398865d6eb..0b0d915773 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -903,6 +903,25 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 	)
 '
 
+test_expect_success 'truncated object with --allow-unknown-type' - <<\EOT
+	objtype='a really long type name that exceeds the 32-byte limit' &&
+	blob=$(git hash-object -w --literally -t "$objtype" /dev/null) &&
+	objpath=.git/objects/$(test_oid_to_path "$blob") &&
+
+	# We want to truncate the object far enough in that we don't hit the
+	# end while inflating the first 32 bytes (since we want to have to dig
+	# for the trailing NUL of the header). But we don't want to go too far,
+	# since our header isn't very big. And of course we are counting
+	# deflated zlib bytes in the on-disk file, so it's a bit of a guess.
+	# Empirically 50 seems to work.
+	mv "$objpath" obj.bak &&
+	test_when_finished 'mv obj.bak "$objpath"' &&
+	test_copy_bytes 50 <obj.bak >"$objpath" &&
+
+	test_must_fail git cat-file --allow-unknown-type -t $blob 2>err &&
+	test_grep "unable to unpack $blob header" err
+EOT
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.48.1.709.gf47ae731ff

