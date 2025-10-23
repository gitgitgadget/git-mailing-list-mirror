Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54F1D555
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222658; cv=none; b=iFdHhzBDoyIYXeqmlDqhHYYVHmUF79B4APTVAQA+PFhBSZGHyNb2hZrFzZjj8bdMf70DynTFllw9nWac92yPNKAfCI/3RCROKKCcayuU3jV/F4lfl3WtRsBonTja3Ei2rbKSNFy8zon4KYefTWuej68LgaAQS0UWXdy2HpUsaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222658; c=relaxed/simple;
	bh=5cPXHRDF6PQJik5fE2DvlxG9myXp6InEKB9sreguW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1hsF50A1KAYpx4B1btSUVlUiaIasUeY5Tf9iLUAuWpOEsFhroW141PPjkZgB6NNyZqc0Vr9q0+sbr7qV5nmN0h1wWN/eUPutX2Pb+D/CYrTzlqqhEbKpGhQFN5z7W7yRJkNGPdaNe2MCgVcHLApEF+YgYzNflnaGr9wd8oWslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FzhsyBwc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FzhsyBwc"
Received: (qmail 315630 invoked by uid 109); 23 Oct 2025 12:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5cPXHRDF6PQJik5fE2DvlxG9myXp6InEKB9sreguW6U=; b=FzhsyBwcyXOK6YSUClzGOvsCWmFCwm1AHliXRgGIoCE8m7PZU6DXLsehFicG1PBP6xZCXTK/e+hgd7FkIknGgV03rikKHgf5z4GEF17Q0ZHyLwQP64k45iuE8Zym549wOt0iAWdvG/Xt84c0CWqAtVnOrsMCuxTejaDD78DnjhXKtAK2SaQU83rlYtelDWxyMyqN1h42m7WGLV2TwUnX8jVEpIQHwy3GbBUPYA3z51rFfdqZYI2rVSaqH9v0aD2OwTrNzJkq6CZNh2K4663QyeOOQZLm77QOUSIH4cGnnw7vkOxfpw3JBUFbK892wjkx5yd0imxAcCUV7kF80GfEgQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 12:30:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490864 invoked by uid 111); 23 Oct 2025 12:30:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 08:30:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 08:30:55 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de, jake@zimmerman.io
Subject: Re: [PATCH v4] diff: stop output garbled message in dry run mode
Message-ID: <20251023123055.GA1160519@coredump.intra.peff.net>
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
 <20251019163024.18939-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251019163024.18939-1-yldhome2d2@gmail.com>

On Mon, Oct 20, 2025 at 12:30:24AM +0800, Lidong Yan wrote:

> @@ -4420,7 +4423,7 @@ static void run_external_diff(const struct external_diff *pgm,
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	struct diff_queue_struct *q = &diff_queued_diff;
> -	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
> +	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
>  	int rc;
>  
>  	/*

BTW, this hunk is interesting because it is the one spot (that we know
of!) which cannot be found by looking for mentions of o->file. But I
think that is a sign that it was already buggy, because it is not
respecting o->file in the first place!

If I make a simple commit like this:

  git init
  echo old >file && git add file && git commit -m old
  echo new >file && git add file && git commit -m new

and then run this:

  git diff-tree --output=foo.out -p HEAD^ HEAD

I should get the diff in foo.out, and I do. But if I instead do:

  GIT_EXTERNAL_DIFF='echo doing diff:' \
    git diff-tree --output=foo.out -p --ext-diff HEAD^ HEAD

then the external diff output goes to stdout. Whoops.

AFAICT this has been the case since "--output" was added. So we don't
need to worry about it in the context of the current regression.

Probably the solution is something like:

diff --git a/diff.c b/diff.c
index dac3ea9e01..15ef06ac9e 100644
--- a/diff.c
+++ b/diff.c
@@ -4458,6 +4458,8 @@ static void run_external_diff(const struct external_diff *pgm,
 	diff_free_filespec_data(two);
 	cmd.use_shell = 1;
 	cmd.no_stdout = quiet;
+	fflush(o->file);
+	cmd.out = fileno(o->file);
 	rc = run_command(&cmd);
 	if (!pgm->trust_exit_code && rc == 0)
 		o->found_changes = 1;

but I didn't test it beyond seeing that it makes the command above work.

-Peff
