Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05B255E4E
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465078; cv=none; b=g29xqXPuQvW9Ohf7ToMTNov9R5JT3OxLOBoaQsDl4l6rS+XBDFA4nR3YTZ9LxmOYPyhZrkXF+hmBO8gYp4na6BVPGXLyCrSSbcXjpvY8HyuzAlEOk53nZFC+YgDmpC9G4NhQIxLPChZDQIze+1JcXWZ33yzUombaWjxrcxkFi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465078; c=relaxed/simple;
	bh=WMcgWFp9+KLiZFsnz9L0+TrqgNFh6ReZZmkPm6fMBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5h0Zt9ZwdA9ymHy4AlJrihHpMKwZlgXCDcFtmKRtlrBC1dTz1Nwn9KwK5vKRMfMCo5xhy+yeWc3dr0VVFBiVpn5vsZpyVNV41snZ6RKysUWMwKNJ5GkLCtRqs6esxD1iJL0Ia+O1NiXW8vYG38boyKOUDejx/P/RD8nSW0tw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=id6bsllj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="id6bsllj"
Received: (qmail 24631 invoked by uid 109); 25 Feb 2025 06:31:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WMcgWFp9+KLiZFsnz9L0+TrqgNFh6ReZZmkPm6fMBwM=; b=id6bslljgkeNA/+90eQKiAAMHSyNr8OkeOT8Ik21L3/cr5CHzyj5lt7aeGV678jae3peWUixumQ9p8TA6QNyBVnClhukQO5KykxViIwy4nvVeGr9eLqVpO5R79kcHgV3IPQV3+0LfB6s2jXgYD/kypD4ZzmTlKjAMVEu1tVtxyMFxJaPTGYJjZ8uiGnsF3hh0NMp+OYHmIa1lxJnQf+pOgUwgOARDjDxtzcxvffD6ijqO5zDWx8gzA4/OOHLQA8ei99vtg1gI0/eyQCjYz7K9mRfShzd78LjbUOnPvgbRZRStSQVYompJRPkRbRAlbsJulj9nRFIDC5UVuoSL2BTUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2759 invoked by uid 111); 25 Feb 2025 06:31:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:31:15 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:31:15 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 07/10] unpack_loose_rest(): avoid numeric comparison of zlib
 status
Message-ID: <20250225063115.GG1293961@coredump.intra.peff.net>
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

When unpacking the actual content of a loose object file, we insist both
that the status code we got is Z_STREAM_END, and that we consumed all
bytes.

If we didn't, we'll return an error, but the specific error message we
produce depends on which of the two error conditions we saw. So we'll
check both a second time to decide which error to produce. But this
second time, our status code check is loose: it checks for a negative
status value.

This can get confused by zlib codes which are not negative, such as
Z_NEED_DICT. In this case we'd erroneously print nothing at all, when we
should say "corrupt loose object".

Instead, this second check should check explicitly against Z_STREAM_END.

Note that Z_OK is "0", so the existing code also produced no message for
Z_OK. But it's impossible to see that status, since we only break out of
the inflate loop when we stop seeing Z_OK (so a stream which has more
bytes than its object header claims would eventually yield Z_BUF_ERROR).

There's no test here, as it would require a loose object whose zlib
stream returns Z_NEED_DICT in the middle of the object content. I think
that is probably possible, but even our Z_NEED_DICT test in t1006 does
not trigger this, because we hit that error while reading the header. I
found this bug while reviewing all callers of git_inflate() for bugs
similar to the one we saw in unpack_loose_header(). This was the only
other case that did a numeric comparison rather than explicitly checking
for Z_STREAM_END.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 5b347cfc2f..859888eb2a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1441,7 +1441,7 @@ static void *unpack_loose_rest(git_zstream *stream,
 		return buf;
 	}
 
-	if (status < 0)
+	if (status != Z_STREAM_END)
 		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
 	else if (stream->avail_in)
 		error(_("garbage at end of loose object '%s'"),
-- 
2.48.1.709.gf47ae731ff

