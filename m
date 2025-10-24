Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FE341AD7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325768; cv=none; b=CRP0ZUrYcK5NkvGkK3i18FOg70ZkJ+Tv2DkiWCQ/Hwbd3oJq0x2uiodfgvtO883Sq2UjTlPFfHlE3z1G4/u7i5JAA3GMPY0Zxbo7H/fVH0aJKtyIj4F6fwDmtm1no+dkW5+7PQ9I+c1jtuyw+CF8vtVmysl8LcdKiKV0FGFv/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325768; c=relaxed/simple;
	bh=gcNPX1CxyOQwNuxPGpD5Cyw6iYyrazlxod6o4iLueOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioaVj3OfzMBk+7Pu7TvHaKDxbXB0dCDN0HOYBOZ1O5YDLtV3i49XkGQv90Qf70qPg7kcB1XEvceQOZGLY//8wtaWCQZj+ZR2gLEjiP/tQTGtPGlaaxVEsW6q6f1kvns02nVLJ967lYAw78wFz8gguldJBByGFJ6V87SuztbTftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eRiEgEn1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eRiEgEn1"
Received: (qmail 326190 invoked by uid 109); 24 Oct 2025 17:09:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gcNPX1CxyOQwNuxPGpD5Cyw6iYyrazlxod6o4iLueOE=; b=eRiEgEn1cY/1ZqBP1iPnURHytRRNcn6PzaeF3MrdoYKrpyUmRYo8Mel5y9uOLikMSlYGpuYyVEL12Of7YDheZf+s6YO7r3zwvOT+Nf+FDXiodHEi1qD87hy6d48unylF/klzCcW+rHkMr4rHbdBaTT/mQEW1cz714RT8vlUZALM4qO87wZgs/2C4gTaFXfdyQn95s3vS9PViIpHln4j+/rMhB3VjREssP0oTzUVPdBljv06Zf2fU8xHZO0JQ/AJzVf6w7ew1DP4Urk8lKMt+2WnhDNFMOyM1MNC4+YliPJRduO9USc+CtLvW8DTdDiHLJjlFXhUdpPqKyGArIsvjWw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:09:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513243 invoked by uid 111); 24 Oct 2025 17:09:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:09:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:09:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diff: drop dry-run redirection to /dev/null
Message-ID: <20251024170925.GD2345184@coredump.intra.peff.net>
References: <20251024170522.GA2344972@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024170522.GA2344972@coredump.intra.peff.net>

As an added protection against dry-run diffs accidentally producing
output, we redirect diff_options.file to /dev/null. But as of the
previous patch, this now does nothing, since dry-run diffs are
implemented by setting "file" to NULL.

So we can drop this extra code with no change in behavior. This is
effectively a revert of 623f7af284 (diff: restore redirection to
/dev/null for diff_from_contents, 2025-10-17) and 3da4413dbc (diff: make
sure the other caller of diff_flush_patch_quietly() is silent,
2025-10-22), but:

  1. We get a conflict because we already dropped the color_moved
     handling in an earlier patch. But we just resolve the conflicts to
     "theirs" (removing all of the code).

  2. We retain the test from 623f7af284.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/diff.c b/diff.c
index a8d50fb1fc..9169ccfaa9 100644
--- a/diff.c
+++ b/diff.c
@@ -6835,35 +6835,18 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_NAME |
 			     DIFF_FORMAT_NAME_STATUS |
 			     DIFF_FORMAT_CHECKDIFF)) {
-		/*
-		 * make sure diff_Flush_patch_quietly() to be silent.
-		 */
-		FILE *dev_null = NULL;
-
-		if (options->flags.diff_from_contents) {
-			dev_null = xfopen("/dev/null", "w");
-		}
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 
 			if (!check_pair_status(p))
 				continue;
 
-			if (options->flags.diff_from_contents) {
-				FILE *saved_file = options->file;
-				int found_changes;
+			if (options->flags.diff_from_contents &&
+			    !diff_flush_patch_quietly(p, options))
+				continue;
 
-				options->file = dev_null;
-				found_changes = diff_flush_patch_quietly(p, options);
-				options->file = saved_file;
-				if (!found_changes)
-					continue;
-			}
 			flush_one_pair(p, options);
 		}
-		if (options->flags.diff_from_contents) {
-			fclose(dev_null);
-		}
 		separator++;
 	}
 
@@ -6914,14 +6897,6 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
-		/*
-		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
-		 */
-		diff_free_file(options);
-		options->file = xfopen("/dev/null", "w");
-		options->close_file = 1;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-- 
2.51.1.797.g1148beab57
