Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11025B678
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464983; cv=none; b=g8VKxm9CAyxd/nYRX9sRfSwBZ33AdQ67TFqJ9ronRx5F78zVKW1B4xmGWdbwsrLrhGlipWVpvVR0tRiRVi36k9Ti+olTxRnCIORuP391uJSnMTHYdL0ElrLXlDpvYZIYsoGoFKJnPGlnUtvi8GRS5uRaUz7DwLKidhJlWrslBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464983; c=relaxed/simple;
	bh=DYIxHgMF1g1XR/FOe9ZxE+b+BndWt/AyeTx6octEjZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4T4NBT3Tzq1i73WJ9p9bY3omTiEgRRvmed3OrylWgmJSa0wn+o02T1WIQf+dbm9gJN+/arZrPxolMl1Y94fcHpkbj7fItB4rplvQUhXUNhYW/3ePZEi15cxBaGQiw2VrO3fb7cn5wq7TZcJuBQtYLRTeNrHn1ywlGDswLv/n/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NWQfotow; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NWQfotow"
Received: (qmail 24587 invoked by uid 109); 25 Feb 2025 06:29:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DYIxHgMF1g1XR/FOe9ZxE+b+BndWt/AyeTx6octEjZk=; b=NWQfotowl8f/knyU3a33z0aWV32giE4FLopMRsdn+Ozi9CvsTAaU9okIxlm0x47j75sN4H5o+GHVW0pI2DsQ9GpcsChJOQCHno7Ud9Jcbpj114dwlVIbt+z1RjhbnP+rsBLuzxFLbA3rGcaMCyUNnrUmWBWivCJTsXbxfiB7/Pp2cnY1SXAWFefgzTqWuXclu021TVFj+DNvSXWma28C0gnRuYaKHACTjKhJ16MeH3gPvitvq2JVuZ8m6re8/E747frZ6xfQvkcTNB8tsLLv/kPvlla1p3qAicvEiHH+n2Ksj3wBzD1JoF4nAi8Ec1ASwktrdmq37KZBDIJjJD2Zcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:29:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2701 invoked by uid 111); 25 Feb 2025 06:29:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:29:40 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:29:40 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 03/10] unpack_loose_header(): report headers without NUL as
 "bad"
Message-ID: <20250225062940.GC1293961@coredump.intra.peff.net>
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

If a caller asks us to read the whole loose object header value into a
strbuf (e.g., via "cat-file --allow-unknown-type"), we'll keep reading
until we see a NUL byte marking the end of the header.

If we hit Z_STREAM_END before seeing the NUL, we obviously have to stop.
But we return ULHR_TOO_LONG, which doesn't make any sense. The "too
long" return code is used in the normal, 32-byte limited mode to
indicate that we stopped looking. There is no such thing as "too long"
here, as we'd keep reading forever until we see the end of stream or the
NUL.

Instead, we should return ULHR_BAD. The loose object has no NUL marking
the end of header, so it is malformed. The behavior difference is
slight; in either case we'd consider the object unreadable and refuse to
go further. The only difference is the specific error message we
produce.

There's no test case here, as we'd need to generate a valid zlib stream
without a NUL. That's not something Git will do without writing new
custom code. And in the next patch we'll fix another bug in this area
which will make this easier to do (and we will test it then).

Signed-off-by: Jeff King <peff@peff.net>
---
You might be curious what happens if we see an error before the stream
end. If so, read on to patch 4...

 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 0fd42981fb..8c9295413b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1397,7 +1397,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
 	} while (status != Z_STREAM_END);
-	return ULHR_TOO_LONG;
+	return ULHR_BAD;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
-- 
2.48.1.709.gf47ae731ff

