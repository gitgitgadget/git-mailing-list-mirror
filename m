Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBAB201A7
	for <e@80x24.org>; Thu, 18 May 2017 05:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbdERFCP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 01:02:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:54058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbdERFCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 01:02:14 -0400
Received: (qmail 1330 invoked by uid 109); 18 May 2017 05:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 05:02:11 +0000
Received: (qmail 14768 invoked by uid 111); 18 May 2017 05:02:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 01:02:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 01:02:09 -0400
Date:   Thu, 18 May 2017 01:02:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t5400: avoid concurrent writes into a trace file
Message-ID: <20170518050209.dezna5tillvlbwgw@sigill.intra.peff.net>
References: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
 <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
 <afca6bf5-472e-dda4-2c16-a2256080ac51@kdbg.org>
 <20170517054424.cq66cl5ukvhsz34y@sigill.intra.peff.net>
 <83b6c8d3-2787-995a-a4e5-e6a437c53e89@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b6c8d3-2787-995a-a4e5-e6a437c53e89@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 08:41:01PM +0200, Johannes Sixt wrote:

> Am 17.05.2017 um 07:44 schrieb Jeff King:
> > I wonder if there's a way we could convince the trace for the two
> > programs to go to separate locations. We don't care about receive-pack's
> > trace at all. So maybe:
> 
> This works. Below it is with a commit message. I'm unsure about the
> sign-off procedure, though.

Thanks for testing. I actually wrote one in preparation, but I like
yours a little better.

I'll repost here with my signoff and a cc to Junio, since the earlier
subject line was less likely to grab attention. This goes on top of
jk/alternate-ref-optim.

-- >8 --
Subject: t5400: avoid concurrent writes into a trace file

One test in t5400 examines the packet exchange between git-push and
git-receive-pack. The latter inherits the GIT_TRACE_PACKET environment
variable, so that both processes dump trace data into the same file
concurrently. This should not be a problem because the trace file is
opened with O_APPEND.

On Windows, however, O_APPEND is not atomic as it should be: it is
emulated as lseek(SEEK_END) followed by write(). For this reason, the
test is unreliable: it can happen that one process overwrites a line
that was just written by the other process. As a consequence, the test
sometimes does not find one or another line that is expected (and it is
also successful occasionally).

The test case is actually only interested in the output of git-push.
To ensure that only git-push writes to the trace file, override the
receive-pack command such that it does not even open the trace file.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5400-send-pack.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3331e0f53..d375d7110 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,10 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace git push fork HEAD:foo &&
+	GIT_TRACE_PACKET=$(pwd)/trace \
+	    git push \
+		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
+		fork HEAD:foo &&
 	extract_ref_advertisement <trace >refs &&
 	test_cmp expect refs
 '
-- 
2.13.0.219.g63f6bc368

