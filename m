Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D9F1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 12:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbcFPM1c (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 08:27:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:55624 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754457AbcFPM1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 08:27:32 -0400
Received: (qmail 17384 invoked by uid 102); 16 Jun 2016 12:27:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:27:31 -0400
Received: (qmail 16013 invoked by uid 107); 16 Jun 2016 12:27:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:27:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 08:27:29 -0400
Date:	Thu, 16 Jun 2016 08:27:29 -0400
From:	Jeff King <peff@peff.net>
To:	Alex =?utf-8?B?UHJlbmfDqHJl?= <alexprengere@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] add--interactive: respect diff.compactionHeuristic
Message-ID: <20160616122729.GC15988@sigill.intra.peff.net>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
 <20160614214211.GB21560@sigill.intra.peff.net>
 <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
 <CAEtHF9Ne7a25cOF_6L=ZXRnmR4NbnUBDFR+6V-PryjtK8yNO8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEtHF9Ne7a25cOF_6L=ZXRnmR4NbnUBDFR+6V-PryjtK8yNO8g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 08:24:47AM +0200, Alex Prengère wrote:

> I see, it makes sense ;-) Indeed it would seem logical to have all
> commands showing diffs (diff, add -p, log -p, reset -p, etc..) respect
> the diff options.

Here's a patch to do so, similar to what we do for diff.algorithm.

-- >8 --
Subject: add--interactive: respect diff.compactionHeuristic

We use plumbing to generate the diff, so it doesn't
automatically pick up UI config like compactionHeuristic.
Let's forward it on, since interactive adding is porcelain.

Note that we only need to handle the "true" case. There's no
point in passing --no-compaction-heuristic when the variable
is false, since nothing else could have turned it on.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 822f857..642cce1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,6 +45,7 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
+my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
 my $use_readkey = 0;
@@ -749,6 +750,9 @@ sub parse_diff {
 	if (defined $diff_algorithm) {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
+	if ($diff_compaction_heuristic) {
+		splice @diff_cmd, 1, 0, "--compaction-heuristic";
+	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, get_diff_reference($patch_mode_revision);
 	}
-- 
2.9.0.160.g4984cba

