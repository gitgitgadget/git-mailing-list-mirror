Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D91DC9B1
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687517; cv=none; b=Glpz7Ntog80794YCyCSGvWAJNzJQcjvdJ82UFMwwngJ5D8ST8L6K8ZJyaMCR5JPTaF289Vn6YawVhDS3INKzOMiWSUrmW0y9K6aELcOaVsueJXD0GcfQaoCvE4fwzT7PQ3WM/Qc3MLLxoBlQDEQ5L+5o6SNZCho6qe8gLm9KMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687517; c=relaxed/simple;
	bh=jrl0K1eUc6HdK8Wu6Z2k+ceY+OJToaxszVEL51D23uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocGDgEQQXE9w/vVL74n9TNfMk83UvLRg0GxDfqDpgFrmNxlFALCt8QdfwC1w5PW6feHCxr+7/Wsa28srzhFp+uCSuzjgpXIvdEsqs0YIL11S9s2IlJswOJLRiAcfYw0euSbfl4EPvD+RLrp/ht8qv6h49vkj+Tz8sbJiWu95bBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lbv1uMdj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lbv1uMdj"
Received: (qmail 252095 invoked by uid 109); 17 Oct 2025 07:51:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jrl0K1eUc6HdK8Wu6Z2k+ceY+OJToaxszVEL51D23uc=; b=Lbv1uMdjN9qc0TsFzY9ffVfYpfzEbVYWBxjirdp1HKp3nXcB02TZszIRkTya0gA6dgYNSemBj07s4OcMa954G3hsOauKanWANALuCWPfbILnS0yuNgg+w4wT8hVDsBETh+QWY7VF5kIgiRzVa7BWc5TxvnpyZkz3nRisS8aMEK640ZCIzcaqsOizPMk6X4svh/ibtyP7RawZZGGqjkWeVCDY6+vPGI8OMD2S5Wl26qmpGuqwVM7YskaSgVojE0MhRwRjc3u+DWgdNDS5Ak1R2Cnh3lvSJsfU9YQuAk3L8tS2Kj4x2N6j2tDHrxhmaCidaRy3dFmm19H7ctw3QiuXkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 07:51:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393190 invoked by uid 111); 17 Oct 2025 07:51:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 03:51:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 03:51:53 -0400
From: Jeff King <peff@peff.net>
To: Jake Zimmerman <jake@zimmerman.io>
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251017075153.GA4078773@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 05:09:07PM -0700, Jake Zimmerman wrote:

> In git v2.51.1, `git diff --quiet HEAD` will actually print something
> if the diff output includes a new, staged file.
> [...]
> I ran a git bisect and isolated this commit:
> b55e6d36ebce69136559add8fffd1a65df231518

Yikes, that is a pretty bad regression. I'm rather surprised that this
wasn't covered in the test suite. t4035 does set this situation up, but
it checks with git-diff-tree, not git-diff. I initially thought that was
because diff defaults to "--patch" output and diff-tree does not, but
even "diff-tree --patch" does not show the bug. Weird. Maybe it has to
do with running diffcore bits?

I see that the author of b55e6d36eb (diff: ensure consistent diff
behavior with ignore options, 2025-08-08) posted this patch earlier
today:

  https://lore.kernel.org/git/pull.2071.git.git.1760671049113.gitgitgadget@gmail.com/

which seems to fix it, but there's no mention there of this thread. And
the included test is still using "-I", where there is clearly collateral
damage even for people who are not using "-I" at all. So I'm not sure if
it's coincidence, or meant to be a fix. ;)

Looking at that patch, my biggest concern is: are we missing other spots
that need to special-case the dry_run setting? Because it's a regression
in a maint release, I'm tempted to say we should do the dumbest possible
thing that covers all cases and just revert this hunk from the original
patch, like:

diff --git a/diff.c b/diff.c
index 87fa16b730..687206f353 100644
--- a/diff.c
+++ b/diff.c
@@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
+		/*
+		 * run diff_flush_patch for the exit status. setting
+		 * options->file to /dev/null should be safe, because we
+		 * aren't supposed to produce any output anyway.
+		 */
+		diff_free_file(options);
+		options->file = xfopen("/dev/null", "w");
+		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))

That would catch the bug here, as well as any others lurking. And it
converts any missing dry_run from correctness problems (we definitely
will not produce extra output) into optimization problems (we might emit
data we do not need, but we can fix those separately). At least for the
normal code paths. I think without those extra fixes the problems that
b55e6d36eb tried to fix for "-I" would still be observable, but at least
its fixes could not regress the other code paths.

-Peff
