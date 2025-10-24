Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA824254855
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325676; cv=none; b=przy3nTd0Q9LJn1sJ7wIkj/4FbvWbIEV/Gn8VJUg0FoCgh63sJo0QyzjRAzxzU78XYAvjg3aXFtlreFkBwwJZZJEHw06ks5w+nU4AJFUh3yAHaLSRl8IIzqconKrDpnU1CsnhaYKMLZcR4H/IwoP1riC84HMZpZxm/0XzXcHY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325676; c=relaxed/simple;
	bh=y82VR5Dhe2JNz+wurg9VLLEF1AvTFDy2uBBgXl+hE9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fegPl3ruACMihPflB+AJTdF3jOvpJIh2BQ3puTd5e+io6Mba2ymVl0fqBcWQSuRCjQdP5XK58Z75wrMCno9U6QlS/ft/iaXgzCgC7fBgrEHMCn7NQZQdEc+OP0E5DEDSAzWgrqkNqh7pctR8/ZMfhCmiK+jt5xWBzbmCsjGFYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XvMzOVYw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XvMzOVYw"
Received: (qmail 326153 invoked by uid 109); 24 Oct 2025 17:07:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y82VR5Dhe2JNz+wurg9VLLEF1AvTFDy2uBBgXl+hE9I=; b=XvMzOVYwTbv8RABGzob0sMtq7Uz4eDBVjiioesSL1jnFJOQjxFhDp1SrZCp++nEXQDHiaHbjUR+GZU7UeKOL1P6bUghkn/8+Yu+Y1brDpFjQk2FIhEqhlH14PqfpBrwlEB/uEFnRPtVgaPfaCccVjW1YDZ/QNkjbt5QZu99jisEds20nu4UBwxI6aoJP/aIb+c3D/2RmpYzgT7UdTsoW0LdbifOZjKSnis9obJE8K7B09JtkuBV5dzmw9zJGS3G4j084TpDyhpVv1wWdr9SZ0EZ2cf0UEtdlMD7P+DxwdIBZvFqWKkj/f4D/GvCJicItbaYsjHWy/D5+1Df9pVRYzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:07:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513224 invoked by uid 111); 24 Oct 2025 17:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:07:53 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:07:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] diff: drop save/restore of color_moved in dry-run mode
Message-ID: <20251024170753.GB2345184@coredump.intra.peff.net>
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

When running a dry-run content-level diff to check whether a "--quiet"
diff has any changes, we have always unset the color_moved variable
since the feature was added in 2e2d5ac184 (diff.c: color moved lines
differently, 2017-06-30). The reasoning is not given explicitly there,
but presumably the idea is that since color_moved requires a lot of
extra computation to match lines but does not actually affect the
found_changes flag, we want to skip it.

Later, in 3da4413dbc (diff: make sure the other caller of
diff_flush_patch_quietly() is silent, 2025-10-22) we copied the same
idea for other dry-run diffs.

But neither spot actually needs to reset this flag at all, because
diff_flush_patch() will not ever compute color_moved. Nor could it, as
it is only looking at a single file-pair, and we detect moves across
files. So color_moved is checked only when we are actually doing real
DIFF_FORMAT_PATCH output, and call diff_flush_patch_all_file_pairs().

So we can get rid of these extra lines to save and restore the
color_moved flag without changing the behavior at all. (Note that there
is no "restore" to drop for the second caller, as we know at that point
we are not generating any output and can just leave the feature
disabled).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/diff.c b/diff.c
index 39029cc096..d83d898702 100644
--- a/diff.c
+++ b/diff.c
@@ -6839,11 +6839,9 @@ void diff_flush(struct diff_options *options)
 		 * make sure diff_Flush_patch_quietly() to be silent.
 		 */
 		FILE *dev_null = NULL;
-		int saved_color_moved = options->color_moved;
 
 		if (options->flags.diff_from_contents) {
 			dev_null = xfopen("/dev/null", "w");
-			options->color_moved = 0;
 		}
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
@@ -6865,7 +6863,6 @@ void diff_flush(struct diff_options *options)
 		}
 		if (options->flags.diff_from_contents) {
 			fclose(dev_null);
-			options->color_moved = saved_color_moved;
 		}
 		separator++;
 	}
@@ -6925,7 +6922,6 @@ void diff_flush(struct diff_options *options)
 		diff_free_file(options);
 		options->file = xfopen("/dev/null", "w");
 		options->close_file = 1;
-		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-- 
2.51.1.797.g1148beab57

