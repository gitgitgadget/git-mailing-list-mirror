Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C03F1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbcHCTae (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:30:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:54058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754482AbcHCTac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:30:32 -0400
Received: (qmail 13528 invoked by uid 102); 3 Aug 2016 19:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:30:21 -0400
Received: (qmail 4490 invoked by uid 107); 3 Aug 2016 19:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:30:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 15:30:18 -0400
Date:	Wed, 3 Aug 2016 15:30:18 -0400
From:	Jeff King <peff@peff.net>
To:	Stephen Morton <stephen.morton@nokia.com>
Cc:	Jan Smets <jan.smets@nokia.com>, git@vger.kernel.org
Subject: Re: Client exit whilst running pre-receive hook : commit accepted
 but no post-receive hook ran
Message-ID: <20160803193018.ydhmxntikhyowmjz@sigill.intra.peff.net>
References: <5795EB1C.1080102@nokia.com>
 <20160725222201.GC13589@sigill.intra.peff.net>
 <a3f64a09-3094-eee1-0050-9960f0674036@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3f64a09-3094-eee1-0050-9960f0674036@nokia.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 02, 2016 at 12:01:57PM -0400, Stephen Morton wrote:

> Sounds tricky. I do think it's important, almost a 'data integrity' issue,
> that IF a commit is received, THEN the post-receive hook must be run. Too
> much mission-critical stuff is based on post-receive hooks.

I agree it would be a good property to have. I think it's hard to do
atomically, though. Certainly we can wait to tell the other side "your
push has been recorded" until after the hook is run. But we would
already have updated the refs locally at that point (and we must -- that
is part of the interface to the post-receive hooks, that the refs are
already in place). So would we roll-back the ref update then? Even that
suffers from power failures, etc.

So I'm not sure if making it truly atomic is all the feasible. However,
we could certainly make things more robust than they are now.

The simplest thing may be to just bump the post-receive hook before the
status report. That opens up the question of whether clients are
actually waiting already for the post-receive to finish. Looking at the
code in send-pack, it looks like the network is hooked up to the
sideband demuxer thread, which will read until EOF on the network. So we
are waiting either way for the post-receive to run. It doesn't really
matter if it happens before or after the report to the client.

So I _think_ something like this would work:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 15c323a..91d01f0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1767,9 +1767,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		execute_commands(commands, unpack_status, &si);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
+		run_receive_hook(commands, "post-receive", 1);
 		if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, "post-receive", 1);
 		run_update_post_hook(commands);
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {

but maybe there are other gotchas.

-Peff
