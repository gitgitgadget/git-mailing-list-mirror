Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6604EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 00:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjHUAfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 20:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUAfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 20:35:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19CBA3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 17:35:33 -0700 (PDT)
Received: (qmail 8537 invoked by uid 109); 21 Aug 2023 00:35:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 00:35:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 407 invoked by uid 111); 21 Aug 2023 00:35:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 20 Aug 2023 20:35:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 20 Aug 2023 20:35:32 -0400
From:   Jeff King <peff@peff.net>
To:     Romain Chossart <romainchossart@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] diff: handle negative status in diff_result_code()
Message-ID: <20230821003532.GA1113755@coredump.intra.peff.net>
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2023 at 08:52:36PM +0100, Romain Chossart wrote:

> I recently found out (the hard way :-) ) that running the following
> command prints an appropriate error on stderr but returns a zero exit
> code:
> 
> > $ git diff --no-pager --exit-code
> > error: invalid option: --no-pager
> > $ echo $?
> > 0
> 
> I would expect a non-zero exit code to be returned.

Yikes, I would expect that, too.

> Interestingly, running `git diff --no-pager --exit-code HEAD` shows a
> usage instead and does return a non-zero exit code as expected.

The difference has to do with where the parsing occurs. Because "git
diff" has so many sub-modes, without the "HEAD" it passes options down
to a helper function, where we first notice the invalid option and
return an error. So the real bug here is how we handle errors with
exit-code, and extends beyond just invalid options.

Fix is below. AFAICT the bug has been around forever (I didn't check
earlier than v1.6.6, which shows it). So it is not new in the upcoming
v2.42, and we can probably apply it to the 'maint' track after the
release.

Thanks for your report. And I'm impressed you managed to find such an
ancient bug. :)

-- >8 --
Subject: [PATCH] diff: handle negative status in diff_result_code()

Most programs which run a diff (porcelain git-diff, diff-tree, etc) run
their result through diff_result_code() before presenting it to the user
as a program return code. That result generally comes from a library
function like builtin_diff_files(), etc, and may be "-1" if the function
bailed with an error.

There are two problems here:

  - if --exit-code is not in use, then we pass the code along as-is.
    Even though Unix exit codes are unsigned, this usually works OK
    because the integer representation, and "-1" ends up as "255". But
    it's not something we should rely on, and we've tried to avoid it
    elsewhere. E.g. in 5391e94813 (branch: remove negative exit code,
    2022-03-29) and 246f0edec0 (execv_dashed_external: stop exiting with
    negative code, 2017-01-06) and probably others.

  - when --exit-code is in use, we ignore the incoming "status" variable
    entirely, and rely on the "has_changes" field. But if we saw an
    error, this field is almost certainly invalid, and means we'd likely
    just say "no changes", which is completely bogus. Likewise for
    the "--check" format.

So let's intercept the negative value here and return an appropriate
code before even considering --exit-code, etc. And while doing so, we
can swap out the negative value for a more normal exit code.

The test here uses an invalid option to trigger the error condition,
since that's easy and reliable. But this could also happen, for example,
if we failed to load the index (in which case we'd just report "no
changes" with --exit-code, which is very wrong).

Reported-by: Romain Chossart <romainchossart@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I know we talked recently about not matching "128" explicitly in tests,
but it seems like the least-bad thing here, as explained in the comment.

 diff.c                 | 11 +++++++++++
 t/t4017-diff-retval.sh | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/diff.c b/diff.c
index ee3eb629e3..b8cd829b1f 100644
--- a/diff.c
+++ b/diff.c
@@ -6980,6 +6980,17 @@ int diff_result_code(struct diff_options *opt, int status)
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
+
+	/*
+	 * A negative status indicates an internal error in the diff routines.
+	 * We want to avoid codes like "1" or "2" here that have a documented
+	 * meaning (and obviously not "0" for success / no diff). But we also
+	 * want to avoid negative values, since the result is passed out via
+	 * exit(). Convert them all to 128, which matches die().
+	 */
+	if (status < 0)
+		return 128;
+
 	if (!opt->flags.exit_with_status &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 5bc28ad9f0..0278364fcd 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -138,4 +138,14 @@ test_expect_success 'check honors conflict marker length' '
 	git reset --hard
 '
 
+test_expect_success 'errors are not confused by --exit-code' '
+	# The exact code here is not important and not documented. But
+	# we do want to make sure that it is not a meaningful documented
+	# value like "1", nor the result of whatever platform-specific cruft
+	# might result from a negative value. The easiest way to check
+	# that is just to match what we know the code does now. But it would be
+	# OK to change this to match if the code changes.
+	test_expect_code 128 git diff --nonsense --exit-code
+'
+
 test_done
-- 
2.42.0.rc2.418.g602d5859fc

