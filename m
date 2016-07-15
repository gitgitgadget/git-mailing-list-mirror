Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CD92018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbcGOKe1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:34:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:45317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:34:25 -0400
Received: (qmail 18248 invoked by uid 102); 15 Jul 2016 10:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:34:25 -0400
Received: (qmail 14378 invoked by uid 107); 15 Jul 2016 10:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:34:23 -0400
Date:	Fri, 15 Jul 2016 06:34:22 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 08/12] index-pack: add flag for showing delta-resolution
 progress
Message-ID: <20160715103422.GH19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The index-pack command has two progress meters: one for
"receiving objects", and one for "resolving deltas". You get
neither by default, or both with "-v".

But for a push through receive-pack, we would want only the
"resolving deltas" phase, _not_ the "receiving objects"
progress. There are two reasons for this.

One is simply that existing clients are already printing
"writing objects" progress at the same time.  Arguably
"receiving" from the far end is more useful, because it
tells you what has actually gotten there, as opposed to what
might be stuck in a buffer somewhere between the client and
server. But that would require a protocol extension to tell
clients not to print their progress. Possible, but
complexity for little gain.

The second reason is much more important. In a full-duplex
connection like git-over-ssh, we can print progress while
the pack is incoming, and it will immediately get to the
client. But for a half-duplex connection like git-over-http,
we should not say anything until we have received the full
request.  Anything we write is subject to being stuck in a
buffer by the webserver.  Worse, we can end up in a deadlock
if that buffer fills up.

So our best bet is to avoid writing anything that isn't a
small fixed size until we've received the full pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e8c71fc..1cba120 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -77,6 +77,7 @@ static int strict;
 static int do_fsck_object;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int verbose;
+static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
 
@@ -1190,7 +1191,7 @@ static void resolve_deltas(void)
 	qsort(ref_deltas, nr_ref_deltas, sizeof(struct ref_delta_entry),
 	      compare_ref_delta_entry);
 
-	if (verbose)
+	if (verbose || show_resolving_progress)
 		progress = start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
@@ -1694,6 +1695,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				input_len = sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
+			} else if (!strcmp(arg, "--show-resolving-progress")) {
+				show_resolving_progress = 1;
 			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
-- 
2.9.1.434.g748be50

