Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A01C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2B9206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgAaJTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:19:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:49362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728159AbgAaJTT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:19:19 -0500
Received: (qmail 13142 invoked by uid 109); 31 Jan 2020 09:19:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 09:19:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30473 invoked by uid 111); 31 Jan 2020 09:27:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 04:27:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 04:19:17 -0500
From:   Jeff King <peff@peff.net>
To:     Mike McGranahan <mike@mcgwiz.com>
Cc:     git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
Message-ID: <20200131091917.GC2857810@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 01:53:52PM -0800, Mike McGranahan wrote:

> I'm using version 2.25.0.windows.1. If I set config "wsErrorHighlight"
> to "old", and run `git diff -p`, the resulting patch text highlights
> whitespace differences in the old text.
> 
> If I then run git-add in interactive patch mode, I expect the diff to
> include the whitespace highlights. But actually, it does not.
> 
> Is this a bug? Thanks for your help.

Sort of. It's more of a feature that has not yet been implemented. ;)

Like the rest of the color config, diff.wsErrorHighlight is not enabled
for scriptable plumbing commands like git-diff-index, etc; it is only
used for the user-facing porcelain commands like git-diff.

So scripts like git-add--interactive, which use the plumbing under the
hood, are responsible for deciding which config options should be
respected and passing the correct command-line options on to the
plumbing. We do that for color.diff, diff.algorithm, and a few others.
But nobody has yet taught it that diff.wsErrorHighlight is safe to pass
(for the user-facing "color" version of the diff).

The solution for the existing perl script would be something like this:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c4b75bcb7f..fac1d1e63e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -46,6 +46,7 @@
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
+my $diff_error_highlight = $repo->config('diff.wsErrorHighlight');
 my $diff_filter = $repo->config('interactive.difffilter');
 
 my $use_readkey = 0;
@@ -727,7 +728,11 @@ sub parse_diff {
 	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
 	if ($diff_use_color) {
-		my @display_cmd = ("git", @diff_cmd, qw(--color --), $path);
+		my @display_cmd = ("git", @diff_cmd, qw(--color),
+			           $diff_error_highlight ?
+				     "--ws-error-highlight=$diff_error_highlight" :
+				     (),
+				   qw(--), $path);
 		if (defined $diff_filter) {
 			# quotemeta is overkill, but sufficient for shell-quoting
 			my $diff = join(' ', map { quotemeta } @display_cmd);

but this is all being rewritten in C. I'm not sure how the multiple
diffs are being handled there.

All that said, I kind of wonder if diff.wsErrorHighlight ought to be
respected by even plumbing commands. After all, it does nothing unless
color is enabled anyway, so I don't think it runs the risk of confusing
a user of the plumbing. It's no different than color.diff.*, which we
respect even in the plumbing commands (if the caller has manually asked
for color, of course).

-Peff
