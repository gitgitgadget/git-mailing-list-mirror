Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEB1990A7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326710; cv=none; b=ThiNZS3RnSzdkF5QewNvvf14TeQrrKTFKK+kyesD1me7qT83YohcwvymUh2++uZp9emFWCLY4k3CDr3T5DABlj/SLCA6aRMbxc/JyLnG6mtUsnz/gLk99IEMarsBm3mH9EI4xdGp88w88xlDo0co0Vgxx++bGxlvRrv/Il7XU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326710; c=relaxed/simple;
	bh=VKruF3RuXe/hvXwewM08YuaRN7Vopdjgmm4C9meOwIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNjffpVexZ7FhXCjFek7TZrpHtE5XwspPWpEIH9H39bNz+MbVQ5wOVKjewutQf2RO7I2ojeZmOpS3ewd9de7NF9BEUH2tw1ho3mN03yU02p9pu5mmtpk0Cqckh5Jno8wh64a9vNtqmZr+1kK5H93/NFpjnkwO9Bn6Kk5RahmN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SGMmaaGk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SGMmaaGk"
Received: (qmail 326336 invoked by uid 109); 24 Oct 2025 17:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VKruF3RuXe/hvXwewM08YuaRN7Vopdjgmm4C9meOwIo=; b=SGMmaaGkcpqMq1QxdB2WUhHYmVzXFELl2MxF33V9mJyeDxpaeeYAJkcuwa/edm7Pshr8yo8mqUwWAPA2T66ZKBiPHcGYiMJzhmgJ/rDjs7uUgZwXlt3ImgfrqXMln2Pdd+HxXmJcgCLf+FVH3NiCelC3bSrkt7/CDFBBWLFq1ahlOVoAsmIJcDsaePqbiIIUyvhI6Ze206v94MkyxlC2PSlMx1WfJD/MaNj4E8loJHftqhFcohU0l6XiB4Oina00aKCd1Q0nrn27mRb/MH7j55DGpG1C6ssCwUQ3Arp/57p4uovh5bGJEF0PVyNudhfRjiwypSWkFCb3gsXFyiELPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:25:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513578 invoked by uid 111); 24 Oct 2025 17:25:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:25:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:25:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/4] diff: simplify run_external_diff() quiet logic
Message-ID: <20251024172507.GA3081793@coredump.intra.peff.net>
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

We'd sometimes end up in run_external_diff() to do a dry-run diff (e.g.,
to find content-level changes for --quiet). We recognize this quiet mode
by seeing the lack of DIFF_FORMAT_PATCH in the output format.

But since introducing an explicit dry-run check via 3ed5d8bd73 (diff:
stop output garbled message in dry run mode, 2025-10-20), this logic can
never trigger. We can only get to this function by calling
diff_flush_patch(), and that comes from only two places:

  1. A dry-run flush comes from diff_flush_patch_quietly(), which is
     always in dry-run mode (so the other half of our "||" is true
     anyway).

  2. A regular flush comes from diff_flush_patch_all_file_pairs(),
     which is only called when output_format has DIFF_FORMAT_PATCH in
     it.

So we can simplify our "quiet" condition to just checking dry-run mode
(which used to be a specific flag, but recently became just a NULL
"file" pointer). And since it's so simple, we can just do that inline.
This makes the logic about o->file more obvious, since we handle the
NULL and non-stdout cases next to each other.

Signed-off-by: Jeff King <peff@peff.net>
---
Here's one more that I forgot to poke at before sending out the others.

 diff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 9169ccfaa9..a1961526c0 100644
--- a/diff.c
+++ b/diff.c
@@ -4423,7 +4423,6 @@ static void run_external_diff(const struct external_diff *pgm,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || !o->file;
 	int rc;
 
 	/*
@@ -4432,7 +4431,7 @@ static void run_external_diff(const struct external_diff *pgm,
 	 * external diff program lacks the ability to tell us whether
 	 * it's empty then we consider it non-empty without even asking.
 	 */
-	if (!pgm->trust_exit_code && quiet) {
+	if (!pgm->trust_exit_code && !o->file) {
 		o->found_changes = 1;
 		return;
 	}
@@ -4457,7 +4456,7 @@ static void run_external_diff(const struct external_diff *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell = 1;
-	if (quiet)
+	if (!o->file)
 		cmd.no_stdout = 1;
 	else if (o->file != stdout)
 		cmd.out = xdup(fileno(o->file));
-- 
2.51.1.797.g1148beab57

