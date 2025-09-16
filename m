Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461F1A2389
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053976; cv=none; b=afz4S2tkEf7nfsWWCIE/FC2Mie0eYDjArPpgRm2gTNJPXmZgoLndsZjHkrZvnyf7/06mOBpPSZiq8f1lQCyMkoqfexSHjGqjVD2wgdsQGanq9NRKV9ExbAJSYIBd5D+Q8YgRYhj+bweI6NJPiAEt3Lak0os0A414Xlm0kqkcfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053976; c=relaxed/simple;
	bh=M5RVVTWTK5jVvL/QxUJp24SWWf5TCH5jsil37ME7MHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+AZ7qiy8Af5rxs5NiJ0tlmVYyk2AeN4C2E8948mQXNmfWJFUD2vVfmvG5aYB5qGMNmNVkQ9qMwuKiPcfBTILpWWS2cTrNV9r6FHV/26zncJ2YaR9rF2WgcQHy1MoDi7JAArCuBy5Wzg6+fZvd75FsFI1wPUusL36N7HmDuo6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gE3SEtQU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gE3SEtQU"
Received: (qmail 102366 invoked by uid 109); 16 Sep 2025 20:19:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=M5RVVTWTK5jVvL/QxUJp24SWWf5TCH5jsil37ME7MHA=; b=gE3SEtQUj774QxNKvSrjuhD+YWMacLcHJO7iMqBS9eQWpqf4mbWVM6XVkvUKB9Fkv6iYu9+aSFKuZEHwTwmzKxM0p3UmyO3w9O1En5aSMDT/X4owyujnazQEScewDG4Z+w2o/ytps01j80cdxvfCAca6/aFaIZQg3kOHmGkOpCCATKPhGltxPHp9lFHIachVjYncimi7QE0k/dkM7LfwJfv2YIE3ZQf7aB3nDe0nE0oRn9TkqRglpQVPaeBwvbVYvwBMPu18MjlZrnOy4G0a5M6T8OTCmQAwA72mbiq8osAacLCnwQmaGNgCxwDpuZ83oYa7p5Dmk5ZgOP6DaPxOpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166186 invoked by uid 111); 16 Sep 2025 20:19:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:19:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:19:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/13] diff: don't use diff_options.use_color as a strict bool
Message-ID: <20250916201933.GE612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

We disable --color-moved if color is not in use at all. This happens in
diff_setup_done(), where we set options->color_moved to 0 if
options->use_color is not true. But a strict boolean check here is not
correct; use_color could be GIT_COLOR_UNKNOWN or GIT_COLOR_AUTO, both of
which evaluate to true, even though we may later decide not to show
colors.

We should be using want_color() to convert that git_colorbool into a
true boolean. As it turns out, this does not produce wrong output. Even
though we go to the trouble to detect the moved lines, ultimately we get
the color values from diff_get_color(), which does check want_color().
And so it returns the empty string for each color, and we "color" the
result with nothing.

So the output is correct, but there is a small but measurable
performance cost to doing the line detection. E.g., in git.git before
and after this patch (there are no colors shown because hyperfine
redirects output to /dev/null):

  Benchmark 1: ./git.old log --no-merges -p --color-moved -1000
    Time (mean ± σ):      1.019 s ±  0.013 s    [User: 0.955 s, System: 0.064 s]
    Range (min … max):    1.005 s …  1.045 s    10 runs

  Benchmark 2: ./git.new log --no-merges -p --color-moved -1000
    Time (mean ± σ):     982.9 ms ±  14.5 ms    [User: 925.8 ms, System: 57.1 ms]
    Range (min … max):   965.1 ms … 1003.2 ms    10 runs

  Summary
    ./git.new log --no-merges -p --color-moved -1000 ran
      1.04 ± 0.02 times faster than ./git.old log --no-merges -p --color-moved -1000

Note that the fix is not quite as simple as just calling want_color()
from diff_setup_done(). There's a subtle timing issue that goes back to
daa0c3d971 (color: delay auto-color decision until point of use,
2011-08-17), the commit that adds want_color() in the first place.  As
discussed there, we must delay evaluating the colorbool value until all
pager setup is complete.

So instead, we'll leave the "color_moved" field intact in diff_setup_done(),
and modify the point where it is evaluated. Fortunately there is only
one such spot that controls whether we run any of the color-moved code
at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e6c85c8491..cc3542e7f4 100644
--- a/diff.c
+++ b/diff.c
@@ -4995,8 +4995,7 @@ void diff_setup_done(struct diff_options *options)
 	if (options->flags.follow_renames)
 		diff_check_follow_pathspec(&options->pathspec, 1);
 
-	if (!options->use_color ||
-	    (options->flags.allow_external && external_diff()))
+	if (options->flags.allow_external && external_diff())
 		options->color_moved = 0;
 
 	if (options->filter_not) {
@@ -6733,7 +6732,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (WSEH_NEW & WS_RULE_MASK)
 		BUG("WS rules bit mask overlaps with diff symbol flags");
 
-	if (o->color_moved)
+	if (o->color_moved && want_color(o->use_color))
 		o->emitted_symbols = &esm;
 
 	if (o->additional_path_headers)
-- 
2.51.0.527.g34bc42dacd

