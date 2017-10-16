Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC6B202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756192AbdJPWN2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 18:13:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756188AbdJPWN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 18:13:26 -0400
Received: (qmail 11092 invoked by uid 109); 16 Oct 2017 22:13:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:13:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17354 invoked by uid 111); 16 Oct 2017 22:13:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 18:13:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 18:13:24 -0400
Date:   Mon, 16 Oct 2017 18:13:24 -0400
From:   Jeff King <peff@peff.net>
To:     Joris Valette <joris.valette@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
Message-ID: <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
 <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
 <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
 <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 15, 2017 at 11:37:04PM +0200, Joris Valette wrote:

> 2017-10-15 22:06 GMT+02:00 Jeff King <peff@peff.net>:
> > Git's diff generation will never do such escaping by default, because it
> > means creating a patch that cannot be applied to get back the original
> > content.
> 
> Indeed this would be a problem. That's where my knowledge of git's
> source code ends, but in that case, can't the output be discriminated
> against the command that was executed?
> Command that outputs an applicable patch -> don't escape
> Command that outputs a diff to see changes -> escape

Speaking in a general sense, people use "git diff" for both purposes,
and we can't necessarily tell which[1]. As a matter of fact, that's a
potential problem with textconv filters as well (which are enabled by
default for git-diff, but not for plumbing like diff-tree, format-patch,
etc). I think the feature isn't widely used enough for people to run
into problems (and they also use it only on things that they don't
_expect_ to be able to make patches for, since they're binaries).

[1] Of course we can come up with heuristics, like "is stdout going to a
    a terminal"? But in such a case we already kick in the pager, and it
    does the exact escaping you're asking for. :)

For a command like add--interactive, it knows which invocations are for
showing to the user and which are for applying (and it already uses
"--color" selectively, for instance). So if there were an "escape this"
option in git's diff generation, we could selectively pass it. But
again, I think the right solution there is not building the escaping
into Git, but just passing it through another filter.

> > It doesn't seem out of the question to me to have an out-of-the-box
> > default for interactive.diffFilter which does some basic escaping (we
> > could even implement it inside the perl script for efficiency).
> 
> Yes I read this thread, but I was left unsatisfied because I would
> like something out-of-the-box.
> Your suggestion might be the best solution then: implement some
> default escaping for interactive.diffFilter.

Alternatively, I suppose we could just always escape in
add--interactive. I'm trying to think of a case where somebody would
really want their diffFilter to see the raw bytes (or vice versa, to
show raw bytes produced by their filter), but I'm having trouble coming
up with one.

I.e., something like this would probably help your case without hurting
anybody:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28b325d754..d44e5ea459 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -714,6 +714,16 @@ sub parse_diff {
 		push @{$hunk[-1]{DISPLAY}},
 			(@colored ? $colored[$i] : $diff[$i]);
 	}
+
+	foreach my $hunk (@hunk) {
+		foreach my $line (@{$hunk->{DISPLAY}}) {
+			# all control chars minus newline and ESC (for color)
+			if ($line =~ s/[\000-\011\013-\032\034-\037]/?/g) {
+				$hunk->{CONTROLCHARS} = 1;
+			}
+		}
+	}
+
 	return @hunk;
 }
 
@@ -1407,6 +1417,9 @@ sub patch_update_file {
 		if ($hunk[$ix]{TYPE} eq 'hunk') {
 			$other .= ',e';
 		}
+		if ($hunk[$ix]->{CONTROLCHARS}) {
+			print "warning: control characters in hunk have been replaced by '?'\n";
+		}
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}

I can't help but feel this is the tip of a larger iceberg, though. E.g.,
what about characters outside of the terminal's correct encoding? Or
broken UTF-8 characters?

-Peff
