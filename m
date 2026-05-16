Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43514A4CC
	for <git@vger.kernel.org>; Sat, 16 May 2026 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897785; cv=none; b=SVVpw0Yaf9n2/bUZOrTIMVOsRHu7SQWmc6n6hryVvjeZd2izP/2mtE5Eec/DD4084vUHc1V/JpQo9iYk+E8ibsWHx9MsTzvXhWwqhq2ChFjW3A/GdesiHW/gMvNbGXSCopt4bttg+zERx2c6NMTQ3xJ1gbbvC+wxRITZS1s1HJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897785; c=relaxed/simple;
	bh=wbaz6yh1LwNf6Rx/icaHz2Qc/sI9hz5B7zJ4XR7IgdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqsSDwwDUxd4nZ6jjf4IGuwOmbO5rXOjxQjlWY/32xn7NRGeFFxuD60sKuiNiHcGzj+CErZG4NkehzdIWYkOlTi2iFJP1ZHcoGSIJxEdQr4/sBX9aekEEhuRsLjAJegAAjHK+E3qDhp/yngffKSq9OnWa+cAHZiJC5EXRvRr8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Jme/L6no; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Jme/L6no"
Received: (qmail 3352 invoked by uid 106); 16 May 2026 02:16:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wbaz6yh1LwNf6Rx/icaHz2Qc/sI9hz5B7zJ4XR7IgdU=; b=Jme/L6noMNwwg67TQ9EN89KFxTrvdbI6J9+lXj30XbOpk19uc5vMTpvxf5xydv4QyRXFMHU1QdTr+BmnHt/r5byjWl9g0vlrtlX6YwYOIVNv7GvP1mCQBUHj5gLJXZoKhLut0o6FrbZTHY66t+FTjw52Aps9S9PXGQKZK0l6AVl1Mwhd//ePYQqUgrq8nAZodGS7KCE8cB4H1g/rbqRm2+eMHK/iHLP4y/0u3F42ngs6wbt8Gklx5n41FwImLgRD/L4wEnVz8XWOhO4Xej+lECYR5decMMW/KuSgzKOpf1CFUvG18tgLje3P1U+vC/XFRHFdrRxAbj7X4AstOTscvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 May 2026 02:16:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7509 invoked by uid 111); 16 May 2026 02:16:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 22:16:22 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 22:16:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] apply: plug leak on "patch too large" error
Message-ID: <20260516021622.GA744303@coredump.intra.peff.net>
References: <20260516021343.GA174647@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516021343.GA174647@coredump.intra.peff.net>

In apply_patch(), we return immediately if read_patch_file() returns an
error. Traditionally this was OK, since an error from strbuf_read()
would restore the strbuf to its unallocated state.

But since f1c0e3946e (apply: reject patches larger than ~1 GiB,
2022-10-25), we may also return an error if we successfully read the
patch but it is too large. In this case we leak the strbuf contents when
apply_patch() returns.

You can see it in action by running t4141 under LSan with the EXPENSIVE
prereq enabled.

We can fix this in one of two places:

  1. In read_patch_file(), we could release the buffer before returning
     the error, behaving more like a raw strbuf_read() call.

  2. In apply_patch(), we can release the strbuf ourselves before
     returning.

I picked the latter, since it future proofs us against read_patch_file()
getting new error modes. We also have a cleanup label in that function
already, so now our error handling at this spot matches the rest of the
function (and all of the variables are initialized such that the rest of
the cleanup is correctly a noop at this point).

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 4aa1694cfa..249248d4f2 100644
--- a/apply.c
+++ b/apply.c
@@ -4881,8 +4881,10 @@ static int apply_patch(struct apply_state *state,
 
 	state->patch_input_file = filename;
 	state->linenr = 1;
-	if (read_patch_file(&buf, fd) < 0)
-		return -128;
+	if (read_patch_file(&buf, fd) < 0) {
+		res = -128;
+		goto end;
+	}
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.54.0.490.gaeb18d0c26

