Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A3257437
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464908; cv=none; b=Oz/WCAdFIhHZu6H+TDlMw6bzoKezh5yNxdDaBsQIOXCrh8iPibu8nI6/xFmCXzqse7KJ2NGW79foRu7dB/IF/sBaxC+YAscAXXCqP01Xmxat2ACGHiAvIqMIWdiT+2FPYdDs+i+HHE7hXeWsdLdHUT1vQrLVPyrtjJtXwim1SX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464908; c=relaxed/simple;
	bh=a3+CFjYIABbUrhwimUaUcdaaSZ1z4vwFkMCNIxb3Jy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjP8ai97hJ2j6FinH+Lb7CCKpK05xrOXcQdzPbI+wE8LxwQzYALXoiQ857H7DRaikvRDYLRAhVluBSC9/+RQqWQYPdzmK13naNJShKMqMbGpHl9WZjEsFmJ7xnUIh4p3M/6Vsmoj3tSfiV6e58hLnrg6SdHfQ1tB5lIR9UPoIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OgzCTUQF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OgzCTUQF"
Received: (qmail 24560 invoked by uid 109); 25 Feb 2025 06:28:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=a3+CFjYIABbUrhwimUaUcdaaSZ1z4vwFkMCNIxb3Jy4=; b=OgzCTUQFe7Xhre+C9RIvBUsfrRolbRgl3i6K4Qx1iCi366DKMuCeQ8tgv6wOO3c2DRLGteK/ZH6Bb69JAqjnIgl92ybzLUhEn3PUy44mjUAuc6wqCMCfbkHQGrgpKV+Byy0loIRTCOSC5EuMbPTSCl4aNb9Jxo8fL7yME3k04acMhJQDbF3fB4n2dZmJmGhZOtFSMNzNzils/JSUGKIh169jHBkxdW2pIXpOJw6KU/Z02fWOQxPV82xfB4g0gtFVjzzq9gbHpao2Fb4/LJLidHOj+BjVWxo4bhcU2ebpVI5FHC32G3y/hxlqFCsLkbW/I+qsQs6bTxW6b/+w7hC/ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2672 invoked by uid 111); 25 Feb 2025 06:28:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:28:24 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:28:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 01/10] loose_object_info(): BUG() on inflating content with
 unknown type
Message-ID: <20250225062824.GA1293961@coredump.intra.peff.net>
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

After unpack_loose_header() returns, it will have inflated not only the
object header, but possibly some bytes of the object content. When we
call unpack_loose_rest() to extract the actual content, it finds those
extra bytes by skipping past the header's terminating NUL in the buffer.
Like this:

  int bytes = strlen(buffer) + 1;
  n = stream->total_out - bytes;
  ...
  memcpy(buf, (char *) buffer + bytes, n);

This won't work with the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag, as there
we allow a header of arbitrary size. We put into a strbuf, but feed only
the final 32-byte chunk we read to unpack_loose_rest(). In that case
stream->total_out may unexpectedly large, and thus our "n" will be
large, causing an out-of-bounds read (we do check it against our
allocated buffer size, which prevents an out-of-bounds write).

Probably this could be made to work by feeding the strbuf to
unpack_loose_rest(), along with adjusting some types (e.g., "bytes"
would need to be a size_t, since it is no longer operating on a 32-byte
buffer).

But I don't think it's possible to actually trigger this in practice.
The only caller who passes ALLOW_UNKNOWN_TYPE is cat-file, which only
allows it with the "-t" and "-s" options (neither of which access the
content). There is one way you can _almost_ trigger it: the oid compat
routines (i.e., accessing sha1 via sha256 names and vice versa) will
convert objects on the fly (which requires access to the content) using
the same flags that were passed in. So in theory this:

  t='some very large type field that causes an extra inflate call'
  sha1_oid=$(git hash-object -w -t "$t" file)
  sha256_oid=$(git rev-parse --output-object-format=sha256 $sha1_oid)
  git cat-file --allow-unknown-type -s $sha256_oid

would try to access the content. But it doesn't work, because using
compat objects requires an entry in the .git/objects/loose-object-idx
file, and we don't generate such an entry for non-standard types (see
the "compat" section of write_object_file_literally()).

If we use "t=blob" instead, then it does access the compat object, but
it doesn't trigger the problem (because "blob" is a standard short type
name, and it fits in the initial 32-byte buffer).

So given that this is almost a memory error bug, I think it's worth
addressing. But because we can't actually trigger the situation, I'm
hesitant to try a fix that we can't run. Instead let's document the
restriction and protect ourselves from the out-of-bounds read by adding
a BUG() check.

Signed-off-by: Jeff King <peff@peff.net>
---
I found this because I was tracing the code path after
unpack_loose_header() returns to verify some assumptions in the other
patches.

It really makes me wonder if this "unknown type" stuff has any value
at all. You can create an object with any type using "hash-object
--literally -t". And you can ask about its type and size. But you can
never retrieve the object content! Nor can you pack it or transfer it,
since packs use a numeric type field.

This code was added ~2015, but I don't think anybody built more on top
of it. I wonder if we should just consider it a failed experiment and
rip out the support.

 object-file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 00c3a4b910..45b251ba04 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1580,6 +1580,8 @@ static int loose_object_info(struct repository *r,
 
 		if (!oi->contentp)
 			break;
+		if (hdrbuf.len)
+			BUG("unpacking content with unknown types not yet supported");
 		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 		if (*oi->contentp)
 			goto cleanup;
-- 
2.48.1.709.gf47ae731ff

