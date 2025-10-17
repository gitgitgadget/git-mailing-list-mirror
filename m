Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52562877F7
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690205; cv=none; b=EeDC1Q/ev6FnDUnQeDZtBYTVevijrdnKIphTH3YwOm89x2lmj2GUYPdQgvi5qRVzjNUCxZ+VFSqyHxpycfjvAjDGUS4Pd7wWsiFR1UORnhr459aEWnQB1kBerNp7Fkxy29jQm0fUogEA84G4u8Np1bV5T1Jzzibt2C66IApLRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690205; c=relaxed/simple;
	bh=9V4q7rI+Yf7VpY2CAoAXvsXP6zwLuIGewqv7mtiqpQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf4mRNa34XUVE9nOMV3tjDFNoaQwxRFFXa1pxWsrelUBfgxXkMCK9pzQFdwnseVPZf9FrYEi9neQiBPvfZJpn1En0t5jfpehD88uzaF3KAxBpkupsDeimcyUbBBwxE+Y0dN4IVQxfEAvASlM0AF10LaIUn4L25sQC2NWlGIP3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GCbrkt9x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GCbrkt9x"
Received: (qmail 252213 invoked by uid 109); 17 Oct 2025 08:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9V4q7rI+Yf7VpY2CAoAXvsXP6zwLuIGewqv7mtiqpQQ=; b=GCbrkt9xNr0wVXTGAOdVWyyWxGB3QkUeoQs4xvFOShPOPmfUHuoP62iQ/8BIdALz3Ed9DbUM+EvZvl6piP9XyjyDNKD9bDoQhNpnE1d6Xom8T1OZoid3VyLwZ+KAJ+lo537kMbZLBVTJ0Ww3+agXGyM5QDfr//84QlgDpMxTzDgcvFChrlgIXHLYUFzO76qza0zE/yfCgPc4EW51uRHnbyT62dgvk8ACFnnvFOoo9MRaXLbMTOpLl4R6UOK45BhqjfiJ9xSJPvxOHPNuJ5QPe21zZndBx33XApXqRlWKRfisJAzhqrI8bvCfYXnHWn9YmjG4x76EFxsOFPwaBIDY6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 08:36:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393690 invoked by uid 111); 17 Oct 2025 08:36:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 04:36:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 04:36:41 -0400
From: Jeff King <peff@peff.net>
To: Jake Zimmerman <jake@zimmerman.io>
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: [PATCH] diff: restore redirection to /dev/null for diff_from_contents
Message-ID: <20251017083641.GB4073661@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017075153.GA4078773@coredump.intra.peff.net>

On Fri, Oct 17, 2025 at 03:51:53AM -0400, Jeff King wrote:

> On Thu, Oct 16, 2025 at 05:09:07PM -0700, Jake Zimmerman wrote:
> 
> > In git v2.51.1, `git diff --quiet HEAD` will actually print something
> > if the diff output includes a new, staged file.
> > [...]
> > I ran a git bisect and isolated this commit:
> > b55e6d36ebce69136559add8fffd1a65df231518
> 
> Yikes, that is a pretty bad regression. I'm rather surprised that this
> wasn't covered in the test suite. t4035 does set this situation up, but
> it checks with git-diff-tree, not git-diff. I initially thought that was
> because diff defaults to "--patch" output and diff-tree does not, but
> even "diff-tree --patch" does not show the bug. Weird. Maybe it has to
> do with running diffcore bits?

Ah, I see. It is because porcelain diff has --ext-diff turned on by
default. And that triggers content-level diffs due to this bit in
diff_setup_done():

          /*
           * External diffs could declare non-identical contents equal
           * (think diff --ignore-space-change).
           */
          if (options->flags.allow_external && options->flags.exit_with_status)
                  options->flags.diff_from_contents = 1;

The really gross part, of course, is that this triggers even when you do
not have any external diff commands defined, because we don't find out
about them until flushing individual pairs!

I suspect that things could be improved there. Once we're in
run_diff_cmd() and realize that no, we don't have have an external diff
command, I think we still run the actual diff anyway, not realizing that
we are only here on a contingency that is not true. So we produce the
diff and throw it away, but could return early. But again, that's an
optimization issue, not a correctness one (and it has been that way for
many years, so perhaps nobody cares too much).

I also suspect that textconv should get the same treatment (you could
define a textconv that turns two distinct binary blobs into an identical
text, so we should trigger a content diff for that). But again, it has
been that way for years.

> Looking at that patch, my biggest concern is: are we missing other spots
> that need to special-case the dry_run setting? Because it's a regression
> in a maint release, I'm tempted to say we should do the dumbest possible
> thing that covers all cases and just revert this hunk from the original
> patch, like:

Here it is with a commit message and test, in case that is helpful.

-- >8 --
Subject: [PATCH] diff: restore redirection to /dev/null for diff_from_contents

In --quiet mode, since we produce only an exit code for "something was
changed" and no actual output, we can often get by with just a
tree-level diff. However, certain options require us to actually look at
the file contents (e.g., if we are ignoring whitespace changes). We have
a flag "diff_from_contents" for that, and if it is set we call
diff_flush() on each path.

To avoid producing any output (since we were asked to be --quiet), we
traditionally just redirected the output to /dev/null. That changed in
b55e6d36eb (diff: ensure consistent diff behavior with ignore options,
2025-08-08), which replaced that with a "dry_run" flag. In theory, with
dry_run set, we should produce no output. But it carries a risk of
regression: if we forget to respect dry_run in any of the output paths,
we'll accidentally produce output.

And indeed, there is at least one such regression in that commit, as it
covered only the case where we actually call into xdiff, and not
creation or deletion diffs, where we manually generate the headers. We
even test this case in t4035, but only with diff-tree, which does not
show the bug by default because it does not require diff_from_contents.
But git-diff does, because it allows external diff programs by default
(so we must dig into each diff filepair to decide if it requires running
an external diff that may declare two distinct blobs to actually be the
same).

We should fix all of those code paths to respect dry_run correctly, but
in the meantime we can protect ourselves more fully by restoring the
redirection to /dev/null. This gives us an extra layer of protection
against regressions dues to other code paths we've missed.

Though the original issue was reported with "git diff" (and due to its
default of --ext-diff), I've used "diff-tree -w" in the new test. It
triggers the same issue, but I think the fact that "-w" implies
diff_from_contents is a bit more obvious, and fits in with the rest of
t4035.

Reported-by: Jake Zimmerman <jake@zimmerman.io>
Signed-off-by: Jeff King <peff@peff.net>
---
I didn't test, but I also wondered if this might be necessary to avoid
actual external diff programs from spewing to stdout. Looking at
run_external_diff(), we do:

  int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
  [...]
  cmd.no_stdout = quiet;

so I _think_ it should be OK even without this patch. But again, I like
the extra layer of protection here.

 diff.c                | 9 +++++++++
 t/t4035-diff-quiet.sh | 4 ++++
 2 files changed, 13 insertions(+)

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
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 0352bf81a9..35eaf0855f 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -50,6 +50,10 @@ test_expect_success 'git diff-tree HEAD HEAD' '
 	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&
 	test_line_count = 0 cnt
 '
+test_expect_success 'git diff-tree -w HEAD^ HEAD' '
+	test_expect_code 1 git diff-tree --quiet -w HEAD^ HEAD >cnt &&
+	test_line_count = 0 cnt
+'
 test_expect_success 'git diff-files' '
 	test_expect_code 0 git diff-files --quiet >cnt &&
 	test_line_count = 0 cnt
-- 
2.51.1.685.g6bf3278fbc

