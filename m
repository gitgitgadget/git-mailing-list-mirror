Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72ED520193
	for <e@80x24.org>; Thu, 11 Aug 2016 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbcHKQNb (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 12:13:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53632 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbcHKQNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 12:13:31 -0400
Received: (qmail 22204 invoked by uid 109); 11 Aug 2016 16:13:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 16:13:12 +0000
Received: (qmail 10730 invoked by uid 111); 11 Aug 2016 16:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 12:13:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 12:13:09 -0400
Date:	Thu, 11 Aug 2016 12:13:09 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH] gc: default aggressive depth to 50
Message-ID: <20160811161309.ecmebaafcz6rkg6o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This commit message is long and has lots of background and
numbers. The summary is: the current default of 250 doesn't
save much space, and costs CPU. It's not a good tradeoff.
Read on for details.

The "--aggressive" flag to git-gc does three things:

  1. use "-f" to throw out existing deltas and recompute from
     scratch

  2. use "--window=250" to look harder for deltas

  3. use "--depth=250" to make longer delta chains

Items (1) and (2) are good matches for an "aggressive"
repack. They ask the repack to do more computation work in
the hopes of getting a better pack. You pay the costs during
the repack, and other operations see only the benefit.

Item (3) is not so clear. Allowing longer chains means fewer
restrictions on the deltas, which means potentially finding
better ones and saving some space. But it also means that
operations which access the deltas have to follow longer
chains, which affects their performance. So it's a tradeoff,
and it's not clear that the tradeoff is even a good one.

The existing "250" numbers for "--aggressive" come
originally from this thread:

  http://public-inbox.org/git/alpine.LFD.0.9999.0712060803430.13796@woody.linux-foundation.org/

where Linus says:

  So when I said "--depth=250 --window=250", I chose those
  numbers more as an example of extremely aggressive
  packing, and I'm not at all sure that the end result is
  necessarily wonderfully usable. It's going to save disk
  space (and network bandwidth - the delta's will be re-used
  for the network protocol too!), but there are definitely
  downsides too, and using long delta chains may
  simply not be worth it in practice.

There are some numbers in that thread, but they're mostly
focused on the improved window size, and measure the
improvement from --depth=250 and --window=250 together.
E.g.:

  http://public-inbox.org/git/9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com/

talks about the improved run-time of "git-blame", which
comes from the reduced pack size. But most of that reduction
is coming from --window=250, whereas most of the extra costs
come from --depth=250. There's a link in that thread showing
that increasing the depth beyond 50 doesn't seem to help
much with the size:

  https://vcscompare.blogspot.com/2008/06/git-repack-parameters.html

but again, no discussion of the timing impact.

In an earlier thread from Ted Ts'o which discussed setting
the non-aggressive default (from 10 to 50):

  http://public-inbox.org/git/20070509134958.GA21489%40thunk.org/

we have more numbers, with the conclusion that going past 50
does not help size much, and hurts the speed of normal
operations.

So from that, we might guess that 50 is actually a sweet
spot, even for aggressive, if we interpret aggressive to
"spend time now to make a better pack". It is not clear that
"--depth=250" is actually a better pack. It may be slightly
_smaller_, but it carries a run-time penalty.

Here are some more recent timings I did to verify that. They
show three things:

  - the size of the resulting pack (so disk saved to store,
    bandwidth saved on clones/fetches)

  - the cost of "rev-list --objects --all", which shows the
    effect of the delta chains on trees (commits typically
    don't delta, and the command doesn't touch the blobs at
    all)

  - the cost of "log -Sfoo", which will additionally access
    each blob

All cases were repacked with "git repack -adf --depth=$d
--window=250" (so basically, what would happen if we tweaked
the "gc --aggressive" default depth).

The timings are all wall-clock best-of-3. The machine itself
has plenty of RAM compared to the repositories (which is
probably typical of most workstations these days), so we're
really measuring CPU usage, as the whole thing will be in
disk cache after the first run.

The core.deltaBaseCacheLimit is at its default of 96MiB.
It's possible that tweaking it would have some impact on the
tests, as some of them (especially "log -S" on a large repo)
are likely to overflow that. But bumping that carries a
run-time memory cost, so for these tests, I focused on what
we could do just with the on-disk pack tradeoffs.

Each test is done for four depths: 250 (the current value),
50 (the current default that tested well previously), 100
(to show something on the larger side, which previous tests
showed was not a good tradeoff), and 10 (the very old
default, which previous tests showed was worse than 50).

Here are the numbers for linux.git:

   depth |  size |  %    | rev-list |  %     | log -Sfoo |   %
  -------+-------+-------+----------+--------+-----------+-------
    250  | 967MB |  n/a  | 48.159s  |   n/a  | 378.088   |   n/a
    100  | 971MB | +0.4% | 41.471s  | -13.9% | 342.060   |  -9.5%
     50  | 979MB | +1.2% | 37.778s  | -21.6% | 311.040s  | -17.7%
     10  | 1.1GB | +6.6% | 32.518s  | -32.5% | 279.890s  | -25.9%

and for git.git:

   depth |  size |  %    | rev-list |  %     | log -Sfoo |   %
  -------+-------+-------+----------+--------+-----------+-------
    250  |  48MB |  n/a  |  2.215s  |   n/a  |  20.922s  |   n/a
    100  |  49MB | +0.5% |  2.140s  |  -3.4% |  17.736s  | -15.2%
     50  |  49MB | +1.7% |  2.099s  |  -5.2% |  15.418s  | -26.3%
     10  |  53MB | +9.3% |  2.001s  |  -9.7% |  12.677s  | -39.4%

You can see that that the CPU savings for regular operations improves as we
decrease the depth. The savings are less for "rev-list" on a smaller repository
than they are for blob-accessing operations, or even rev-list on a larger
repository. This may mean that a larger delta cache would help (though setting
core.deltaBaseCacheLimit by itself doesn't).

But we can also see that the space savings are not that great as the depth goes
higher. Saving 5-10% between 10 and 50 is probably worth the CPU tradeoff.
Saving 1% to go from 50 to 100, or another 0.5% to go from 100 to 250 is
probably not.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 2 +-
 builtin/gc.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..8eb403d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1366,7 +1366,7 @@ fsck.skipList::
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 250.
+	to 50.
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
diff --git a/builtin/gc.c b/builtin/gc.c
index 332bcf7..069950d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,7 +28,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
-static int aggressive_depth = 250;
+static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
-- 
2.9.2.790.gaa5bc72
