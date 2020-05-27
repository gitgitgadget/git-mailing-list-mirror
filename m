Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741E4C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3CE20E65
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgE0H4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 03:56:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgE0H4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 03:56:49 -0400
Received: (qmail 20565 invoked by uid 109); 27 May 2020 07:56:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 07:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1668 invoked by uid 111); 27 May 2020 07:56:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 03:56:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 03:56:48 -0400
From:   Jeff King <peff@peff.net>
To:     Merlin =?utf-8?B?QsO8Z2U=?= <toni@bluenox07.de>
Cc:     git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
Message-ID: <20200527075648.GA4006373@coredump.intra.peff.net>
References: <20200525221100.31d36d4d.toni@bluenox07.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525221100.31d36d4d.toni@bluenox07.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 10:11:00PM +0200, Merlin Büge wrote:

> This works like expected, I end up with a 1:1 copy of the original
> worktree, including empty files. However, if I include the -p option in
> the last step:
> 
> 	git checkout -p master .
> 
> ... I correctly get asked for any non-empty files/hunks if I want to
> apply them - but not for empty ones. It would just display e.g.
> 
> 	diff --git b/emptyfile a/emptyfile
> 	new file mode 100644
> 	index 0000000..e69de29
> 
> and then skip over it, asking for the next non-empty hunk.
> 
> Why does it skip over empty hunks?

I think this case was just never anticipated, and it's a bug. The
original patch-selection code was written for "add -p", and the
fundamental unit it works on is a hunk. We hacked around that to handle
deletions back in 24ab81ae4d (add-interactive: handle deletion of empty
files, 2009-10-27). But "add -p" would never see a new file, since we
only consider the set of tracked files in the index.

However, when it was extended for "checkout -p", etc, we could see new
files. I guess the right fix is something along these lines, extending
the deletion concept to new files:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c4b75bcb7f..9c8844434e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -768,7 +768,7 @@ sub parse_diff_header {
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
 		my $dest =
 		   $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ? $mode :
-		   $src->{TEXT}->[$i] =~ /^deleted file/ ? $deletion :
+		   $src->{TEXT}->[$i] =~ /^(deleted|new) file/ ? $deletion :
 		   $head;
 		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
 		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];

which does do the right thing. But:

  - all of this is in the process of being rewritten in C, so it should
    probably go into add-interactive.c (it's not yet the default to use
    the C version, but it probably will be soon).

  - that still says "Apply deletion..." in the UI. We'd need to update
    the messages to differentiate the two cases.

-Peff
