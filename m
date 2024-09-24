Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2065E74418
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211133; cv=none; b=D9A2NtaQ0umG5Ep8buN9DN9pKTS8ncRb3TAl5x9qUpey/LHjvWAjTXKhZ6JbIDoGJe7U+LGqT3zL/SYpD0+2LCQrXhokqsOFwxFOpem+nUzqeCDVFCewclIVeA7Kii82ZblYuJpZKuAojh/AwiRrh4Ucag5iygyl5RFRPbBrBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211133; c=relaxed/simple;
	bh=DU1DIcXJbZmDorIG1PCPuxCZtA0nR5lTTZDMXj5hIpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lic/v7b+xoEw7OmFlmDCgxOOTOlXN/whlXjgqr64PhEncUUjMioFiFdIZOEQXn/en+G3AAE9KHR0FJK4BiwcRYs6TY7+4V7StdcsEawi7GxifqNANguDAeVOLV7eE/OiHa7C2P7PMGDY+Xs61pxWy62ZvRpza5iizBxGG3E90Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14508 invoked by uid 109); 24 Sep 2024 20:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 20:52:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17308 invoked by uid 111); 24 Sep 2024 20:52:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 16:52:09 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 16:52:09 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <20240924205209.GB586150@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

On Tue, Sep 24, 2024 at 01:32:01PM -0400, Taylor Blau wrote:

> This version is another fairly substantial reroll, with the main
> differences being renaming the "fast" SHA-1 options to "unsafe", as well
> as not running the collision checks via finalize_object_file() when
> handling loose objects (see the relevant patches for details on why).

I left some rambling comments on the collision check changes.  Nothing
earth-shattering, but you may or may not want to tweak based on what I
said.

I'm happy with the s/fast/unsafe/ rename.

The rest of it was more or less the same, and looks good to me. I do
think with the extra collision-check it would be OK to teach index-pack
to use the fast sha1, too. That would speed up receiving objects by the
same absolute numbers (but less as a relative portion, since delta
resolution is usually much more expensive). And it would also make
verify-pack a bit faster, too (IIRC fsck for some reason does not use
verify-pack, so its code is a potential candidate, too, if it's not
already using csum-file).

Those don't strictly need to come now, but it seems like they might be
worthwhile while we're in the area (OTOH, using the fast hash only when
sending is a belt-and-suspenders with the collision check).

> Note also there is an important bug fix in finalize_object_file() to
> unlink() the temporary file when we do run the collision check, but no
> collisions were found. This bug was causing a pile-up of tmp_obj_XXXXXX
> files in GitHub's infrastructure.

Oops. :) I wondered if we could have a test here, but I don't think this
can be easily triggered in the tests. The loose object collision happens
only via TOCTOU race. I also tried instrumenting the code like below,
and it triggers zero times in the test suite.

diff --git a/object-file.c b/object-file.c
index b9a3a1f62d..d9172df8d9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -40,6 +40,7 @@
 #include "fsck.h"
 #include "loose.h"
 #include "object-file-convert.h"
+#include "trace.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1994,6 +1995,7 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
+	static struct trace_key t = TRACE_KEY_INIT(COLLISION);
 	struct stat st;
 	int ret = 0;
 
@@ -2031,6 +2033,8 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
+		if (flags & FOF_SKIP_COLLISION_CHECK)
+			trace_printf_key(&t, "skipping check of %s and %s", tmpfile, filename);
 		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
 		    check_collision(tmpfile, filename))
 				return -1;
