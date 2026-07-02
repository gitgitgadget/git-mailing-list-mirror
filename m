Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110F2F532C
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979506; cv=none; b=A7uNYGNkZR8Tm3gN5i1fPhK4hEKbLIMSEAI8AITVu/oD5KVs0DQPpvi8H+QjRx+JdT+kmobeQeUyDuzCuikFQ0I5ZxGx6glFbnKUTdc+i1/rWCvREAechtQNdVeHgeQugoCnOEphUQFpMDpZpR6W1ZgySTj/rMi5ZTWYKDsvMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979506; c=relaxed/simple;
	bh=W9FfZ4f59Xk4lnI2EU6SFpX5AVKmKHY1CQMc4bKbI7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks1sPEYTEhkmv1n/EmiZ9xSWA+cvPq7zIhSzwQROImOxjePkgGbaQCdA8nb8udAe6ndH6GFDvlERsxe2vqhdZiy431wPGYwmArkiEinnJAOJ4KasfWdxd/g+eqKb0tUoMQn/haGS3MsjQu6PLMf4X3XovLDT2H6qR6AQRHFMMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P5ElcChM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P5ElcChM"
Received: (qmail 85652 invoked by uid 106); 2 Jul 2026 08:05:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=W9FfZ4f59Xk4lnI2EU6SFpX5AVKmKHY1CQMc4bKbI7M=; b=P5ElcChM0HhLybQTSe55GH174uydbcUDOfCyWdOVJOuqWsuYIF+iwWeIUMOw0KjRJUDkJgl6NQ5HGfcQv5LAa86Ck1thC15zsrTQ+zmPhz5JztHsJZOnSm+uEDKun/A3gbYas1Ba5LFzS0uXYnB5vbLaie7gWyb9xsLjdg9ALI8FkQLwYYzDgSm/Gv2S9fqHFLXKsvHGtj763v8C7+bXW3I5qCymCx4WCS6T1ZvLMJscr7KFVCJ5rHk4yqA6hNxbNXIUTzJCYRzFiFIIvKGnEDPNwsKkeDiPCvH+DkX1cKFplTenfcIaaG5TmJ+/creaq0TKFBJWOO7qmu5wbtJOdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178273 invoked by uid 111); 2 Jul 2026 08:05:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:05:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:05:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/9] check_stream_oid(): discard hash on read error
Message-ID: <20260702080503.GF2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

The happy path of check_stream_oid() is to initialize a hash, feed the
loose object zlib stream into it, and then get the final result. But if
we hit a zlib error or see extra cruft we'll bail early with an error.

Since we never call git_hash_final() in this cases, any resources held
by the git_hash_ctx may be leaked. Our default hash algorithms don't
allocate anything in the hash_ctx, but some implementations do. For
example, running:

  make SANITIZE=leak \
       OPENSSL_SHA256=1 \
       GIT_TEST_DEFAULT_HASH=sha256 \
       test

will fail t1450, since it feeds corrupted objects that cause us to bail
from check_stream_oid(). This patch fixes it by discarding the hash in
those early return paths. Trying to jump to a common "out:" label is not
worth it here, as we must _not_ discard a hash that was already fed to
git_hash_final(). And the hash_ctx itself does not carry any information
(so we cannot check for a NULL pointer, etc).

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 32a0d6d237..035d005279 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1587,11 +1587,13 @@ static int check_stream_oid(git_zstream *stream,
 
 	if (status != Z_STREAM_END) {
 		error(_("corrupt loose object '%s'"), oid_to_hex(expected_oid));
+		git_hash_discard(&c);
 		return -1;
 	}
 	if (stream->avail_in) {
 		error(_("garbage at end of loose object '%s'"),
 		      oid_to_hex(expected_oid));
+		git_hash_discard(&c);
 		return -1;
 	}
 
-- 
2.55.0.418.g37da59dd42

