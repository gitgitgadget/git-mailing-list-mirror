Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA07C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBDB235FF
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbhAHQPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:15:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:50096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbhAHQPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 11:15:47 -0500
Received: (qmail 32213 invoked by uid 109); 8 Jan 2021 16:15:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Jan 2021 16:15:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17578 invoked by uid 111); 8 Jan 2021 16:15:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Jan 2021 11:15:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Jan 2021 11:15:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jon Sagotsky <sagotsky@gmail.com>, git@vger.kernel.org
Subject: Re: Feature request - git add --patch should have an option to
 discard or drop a hunk Inbox
Message-ID: <X/iFCo0bXLR+LZXs@coredump.intra.peff.net>
References: <CAJamm=+Z=88G6cH3DRkttGQkrf9tng310+p=4cKiy-GvdCG3zg@mail.gmail.com>
 <X/ghgg+IdZYri1KV@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2101081614440.2213@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101081614440.2213@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 04:21:05PM +0100, Johannes Schindelin wrote:

> >   - in the most general form of the tool, it would let you take a pass
> >     through the hunks and annotating them. The simple common form is two
> >     annotations: stage these ones, discard those ones. There may be room
> >     for a more generalized tool, or it may just be over-complicating
> >     things.
> >
> >     The generalized form probably shouldn't be "add -p". The simplified
> >     one (just adding "discard this hunk from the worktree") could
> >     perhaps be, though it does feel a little weird for "git add" to
> >     modify working tree files.
> 
> We do have `git stash -p`, which I used sometimes to discard such unwanted
> pieces. However, `git stash -p` suffers from a couple implementation
> details (see e.g.
> https://lore.kernel.org/git/20200731165140.29197-1-alban.gruin@gmail.com/)

Yeah, and I often will take a first pass with "stash -p" to get rid of
unwanted hunks, and _then_ start dividing up the hunks into commits that
I want. But that requires multiple passes. I think the point is that you
often see the undesirable hunk (that you'd like to stash or discard)
while you're making another pass, and would like to deal with it then
and there, instead of separately.

To be clear, I'm not objecting to a "-p" command modifying the working
tree or anything like that. Just that mixing the modification of the
working tree into "add -p" feels weird, because of the "add" half, not
the "-p" half. :) Conceptually it's a separate action: take a single
pass over the hunks and decide what to do with them. But I do agree that
in practice that's the operation people are trying to do with "add -p",
so it may be a practical place to put it.

> More often than not, I am actually using `git add -p` to commit those
> changes instead, using the commit message `TO-DROP` and later using
> `rebase -i` to actually drop them.

That works OK, too, but suffers from the same multi-pass problem. You
have to do a separate pass to put them in a TO-DROP commit, and likely
you've already marked a bunch of other hunks to be staged for a real
commit.

> I could imagine that it should not be _too_ hard to implement an action in
> `git add -p` to allow stashing a given hunk. The biggest challenge there
> would be to make sure that potentially edited, to-be-stashed changes won't
> interfere with staging what was intended (because `git add -p` batches the
> changing per-file, and if the index changes while picking what to stage,
> things might conflict).
> 
> Maybe an Outreachy project?

Yeah, it's probably about the right size. The actual mechanics are
pretty easy. Here's a really ugly proof-of-concept in the perl script:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 96426a53c6..528688e553 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -106,6 +106,7 @@ sub colored {
 		APPLY_CHECK => 'apply --cached',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
+		DISCARD => sub { apply_patch 'apply -R', @_ },
 	},
 	'stash' => {
 		DIFF => 'diff-index -p HEAD',
@@ -1568,6 +1569,9 @@ sub patch_update_file {
 				print;
 			}
 		}
+		if (exists $patch_mode_flavour{DISCARD}) {
+			$other .= ',x';
+		}
 		my $type = $num ? $hunk[$ix]{TYPE} : $head->{TYPE};
 		print colored $prompt_color, "(", ($ix+1), "/", ($num ? $num : 1), ") ",
 			sprintf(__($patch_update_prompt_modes{$patch_mode}{$type}), $other);
@@ -1761,6 +1765,18 @@ sub patch_update_file {
 					splice @hunk, $ix, 1, $newhunk;
 				}
 			}
+			elsif ($line =~ /^x/) {
+				unless ($other =~ /x/) {
+					error_msg("don't know how to discard in this mode");
+				}
+				# should probably save up discards and apply at
+				# the end?
+				my @patch = reassemble_patch($head->{TEXT},
+					                     @{$hunk[$ix]->{TEXT}});
+				$patch_mode_flavour{DISCARD}->(@patch);
+				# should mark hunk as used so we don't
+				# redisplay it
+			}
 			else {
 				help_patch_cmd($other);
 				next;

I left this intentionally ugly because I do not even want to consider
implementing this for real in the perl version, not when we're so close
to getting rid of it (but I'm familiar enough with it and it's fast
enough to hack on that I did not want to even try the ugly thing in the
C code). It's just meant to show that we basically have all the
low-level parts available already.

There are some obvious unfinished bits in the comments, but I agree the
really tricky parts will be corner cases: what happens to edited hunks
or ones which overlap. It may all Just Work because we're applying to
two different spots, so overlap isn't a problem. But I haven't thought
deeply about it.

-Peff
