Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5570215051
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412265; cv=none; b=Sgd0eiyL8RXZADhMVSFjhppgBC+x5XkC12lTcrf6KnzmD3nnKvSGp1WwDpLB25P4F0cis+TkueX9PmEvSk1+OIcOFxX5PtQrw5R0BP5WaYM2TA4BTPiRp5al9woIoWITm2c/UVbmdMgZte9Md83XZyl8fC+QiosjCKaZX86hxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412265; c=relaxed/simple;
	bh=WkNA5paKm3lbA0PCaaUwsWVG8+W30SxcWMzSUvjl12w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6AIl0dC7/+YhPHEQgXrQ+fBIILVh48zcqOMQB9rzIN08b/ee0sJWIZr19fo3D/kPx6dN7UzRFeJ0yGtut628m2XOmvBfeIOfFI/UgFokbGVrEQOmnxuQLZy6MKpWKViKeAiYGRCQmUmrXge4Qrsq9grwRs7sZzsJtNvfbt4Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=esRtMa3z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="esRtMa3z"
Received: (qmail 25681 invoked by uid 109); 9 Jan 2025 08:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WkNA5paKm3lbA0PCaaUwsWVG8+W30SxcWMzSUvjl12w=; b=esRtMa3zWSterUBkqNyEIAmVop1Vqc9rdLdFO1F3qpxn5WUt75G6S4/HgmHup8t562g6CDDZl6/YBCZusBJIzMe3plF59MCEfi+xAe7aiX2rfcUFJoExCpM+sn6x+xpn2ztacyoqm5aVMOoNiZ8LV77/6b0QltidbFuM0ukbBMfbxgTD669eMD7x8il20JCsJmJ16ZrnB4QGKcWqyqXLXl7ozBNqRQ70Eh2dU1BL6l0d/LgMH+zwi/Qvm57ZqsfoMwkdy3zrH8upLacX+vDhB56dS0RDyUQr6jopOOCUYQqVb0EjY1ma8YDomXI1+342tzuANRMIPW0g1/iuYxLRjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:44:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20298 invoked by uid 111); 9 Jan 2025 08:44:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:44:22 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:44:21 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 06/14] run_diff_files(): de-mystify the size of
 combine_diff_path struct
Message-ID: <20250109084421.GF2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

We allocate a combine_diff_path struct with space for 5 parents. Why 5?

The history is not particularly enlightening. The allocation comes from
b4b1550315 (Don't instantiate structures with FAMs., 2006-06-18), which
just switched to xmalloc from a stack struct with 5 elements. That
struct changed to 5 from 4 in 2454c962fb (combine-diff: show mode
changes as well., 2006-02-06), when we also moved from storing raw sha1
bytes to the combine_diff_parent struct. But no explanation is given.
That 4 comes from the earliest code in ea726d02e9 (diff-files: -c and
--cc options., 2006-01-28).

One might guess it is for the 4 stages we can store in the index. But
this code path only ever diffs the current state against stages 2 and 3.
So we only need two slots.

And it's easy to see this is still the case. We fill the parent slots by
subtracting 2 from the ce_stage() values, ignoring values below 2. And
since ce_stage() is only 2 bits, there are 4 values, and thus we need 2
slots.

Let's use the correct value (saving a tiny bit of memory) and add a
comment explaining what's going on (saving a tiny bit of programmer
brain power).

Arguably we could use:

  1 + (STAGEMASK >> STAGESHIFT) - 2

which lets the compiler enforce that we will not go out-of-bounds if we
see an unexpected value from ce_stage(). But that is more confusing to
explain, and the constant "2" is baked into other parts of the function.
It is a fundamental constant, not something where somebody might bump a
macro and forget to update this code.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 471ef99614..353b473ed5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -166,8 +166,13 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				wt_mode = 0;
 			}
 
+			/*
+			 * Allocate space for two parents, which will come from
+			 * index stages #2 and #3, if present. Below we'll fill
+			 * these from (stage - 2).
+			 */
 			dpath = combine_diff_path_new(ce->name, ce_namelen(ce),
-						      wt_mode, null_oid(), 5);
+						      wt_mode, null_oid(), 2);
 
 			while (i < entries) {
 				struct cache_entry *nce = istate->cache[i];
-- 
2.48.0.rc2.413.gc1c80375a3

