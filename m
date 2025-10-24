Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D8331A70
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325613; cv=none; b=X5eujPPM5jb06wyI3j/4GOzoTmrTs0pwsRdC+oZ3cPKWmV3mfuGBqXpccx/LZV1Z097N6Zy5rm5ddKdcxAVVHZk/RcQWmruEOKt++olcYzM4GXaypWXnKyeSjAt6iwBD2G22luOQdARHC/vbF0Htf5Et4LP0y30G5sCi++vJoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325613; c=relaxed/simple;
	bh=f6jgMpsmls7AYfJWCP7yA2Td0c1jx+o+NJaBy+fWSnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENA2Eonnt6P4yf8DmdP3zDgl5NZFIIhNI6U/lgvLpL9DWI1MK1VJvBSoV36pZDruDdKdEO0HYChLc9kPOESDTiDPLpecSg3RHnJlxFGkAFv2lunIxM/w5Ae+c0IqXa7VoW8IWmFi5CY9E04+WIEKYzA4RFoq+oPYpM+FHlZxFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b0p8XLLW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b0p8XLLW"
Received: (qmail 326129 invoked by uid 109); 24 Oct 2025 17:06:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f6jgMpsmls7AYfJWCP7yA2Td0c1jx+o+NJaBy+fWSnE=; b=b0p8XLLWZg7G+1PsZt1cHxupzyLyEngjs7hHxFmnveSN+3Lh4ooIO1Zbi9lY14CLMiSYfKawZogwsM/ce98EmYnVfalwN/Fh1LGnP8TNT2vnXWOkXJ8GSY1Rulc7oWgPSBxA4l4bZSdYR2pRt595CI+YxL3tW6dzBWnyG6lQLEJQFQN6sjeDpIrL+mlgQnhHYP5+3MY0iVV9RfsMP+WMb2WoZruHUsc5h4x9BlpLW3SG326fJFrvhuUHQByDIQM0neKp4btKhWvCzs804G+HO66EgDIsJZNMoGuk4wJj6Y4doyCgr3ROI9mQTh8R0fh5ZNoXlO5EV/8k8SxAY4J26Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:06:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513165 invoked by uid 111); 24 Oct 2025 17:06:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:06:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:06:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] diff: send external diff output to diff_options.file
Message-ID: <20251024170649.GA2345184@coredump.intra.peff.net>
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

Diff output usually goes to the process stdout, but it can be redirected
with the "--output" option. We store this in the "file" pointer of
diff_options, and all of the diff code should write there instead of to
stdout.

But there's one spot we missed: running an external diff cmd. We don't
redirect its output at all, so it just defaults to the stdout of the
parent process. We should instead point its stdout at our output file.
There are a few caveats to watch out for when doing so:

  - The stdout field takes a descriptor, not a FILE pointer. We can pull
    out the descriptor with fileno().

  - The run-command API always closes the stdout descriptor we pass to
    it. So we must duplicate it (otherwise we break the FILE pointer,
    since it now points to a closed descriptor).

  - We don't need to worry about closing our dup'd descriptor, since the
    point is that run-command will do it for us (even in the case of an
    error). But we do need to make sure we skip the dup() if we set
    no_stdout (because then run-command will not look at it at all).

  - When the output is going to stdout, it would not be wrong to dup()
    the descriptor, but we don't need to. We can skip that extra work
    with a simple pointer comparison.

  - It seems like you'd need to fflush() the descriptor before handing
    off a copy to the child process to prevent out-of-order writes. But
    that was true even before this patch! It works because run-command
    always calls fflush(NULL) before running the child.

The new test shows the breakage (and fix). The need for duplicating the
descriptor doesn't need a new test; that is covered by the later test
"GIT_EXTERNAL_DIFF with more than one changed files".

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   |  5 ++++-
 t/t4020-diff-external.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 22415aecee..39029cc096 100644
--- a/diff.c
+++ b/diff.c
@@ -4457,7 +4457,10 @@ static void run_external_diff(const struct external_diff *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell = 1;
-	cmd.no_stdout = quiet;
+	if (quiet)
+		cmd.no_stdout = 1;
+	else if (o->file != stdout)
+		cmd.out = xdup(fileno(o->file));
 	rc = run_command(&cmd);
 	if (!pgm->trust_exit_code && rc == 0)
 		o->found_changes = 1;
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index c8a23d5148..7ec5854f74 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -44,6 +44,16 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF and --output' '
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff --output=out >stdout &&
+	cut -d" " -f1,3- <out >actual &&
+	test_must_be_empty stdout &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'typechange diff' '
 	rm -f file &&
 	ln -s elif file &&
-- 
2.51.1.797.g1148beab57

