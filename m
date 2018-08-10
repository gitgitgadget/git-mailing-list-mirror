Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84061F404
	for <e@80x24.org>; Fri, 10 Aug 2018 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeHJQjO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 12:39:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727270AbeHJQjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 12:39:14 -0400
Received: (qmail 8362 invoked by uid 109); 10 Aug 2018 14:09:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 14:09:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18505 invoked by uid 111); 10 Aug 2018 14:09:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 10:09:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 10:09:08 -0400
Date:   Fri, 10 Aug 2018 10:09:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
Message-ID: <20180810140908.GA23507@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <20180809194712.GC32376@sigill.intra.peff.net>
 <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 01:49:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Are you sure that it's not well-defined? We open the path with O_APPEND,
> > which means every write() will be atomically positioned at the end of
> > file. So we would never lose or overwrite data.
> >
> > We do our own buffering in a strbuf, writing the result out in a single
> > write() call (modulo the OS returning a short write, but that should not
> > generally happen when writing short strings to a file). So we should get
> > individual trace lines as atomic units.
> >
> > The order of lines from the two processes is undefined, of course.
> 
> Correct.  But I am more worried about the "mixed/overwriting"
> breakage, if there is one; it means we may need to be prepared for
> systems that lack O_APPEND that works correctly.  I initially just
> assumed that it was what Dscho was seeing, but after re-reading his
> message, I am not sure anymore.
> 
> I think the "do not trace the other side" approach you suggest for
> these tests that only care about one side is more appropriate
> solution for this particular case.  We then do not have to worry
> about overwriting or output from both sides mixed randomly.

Here it is as a patch on top of jt/fetch-negotiator-skipping, which lets
us pursue any fix for interleaved trace output on Windows without the
pressure of an impending flaky test.

My gut says that looking into making O_APPEND work there is going to be
the nicest solution, but my gut is not very well versed in Windows
subtleties. ;)

-- >8 --
Subject: [PATCH] t5552: suppress upload-pack trace output

The t5552 test script uses GIT_TRACE_PACKET to monitor what
git-fetch sends and receives. However, because we're
accessing a local repository, the child upload-pack also
sends trace output to the same file.

On Linux, this works out OK. We open the trace file with
O_APPEND, so all writes are atomically positioned at the end
of the file. No data can be overwritten or omitted. And
since we prepare our small writes in a strbuf and write them
with a single write(), we should see each line as an atomic
unit. The order of lines between the two processes is
undefined, but the test script greps only for "fetch>" or
"fetch<" lines. So under Linux, the test results are
deterministic.

The test fails intermittently on Windows, however,
reportedly even overwriting bits of the output file (i.e.,
O_APPEND does not seem to give us an atomic position+write).

Since the test only cares about the trace output from fetch,
we can just disable the output from upload-pack. That
doesn't solve the greater question of O_APPEND/trace issues
under Windows, but it easily fixes the flakiness from this
test.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I'm assuming that this really isn't triggerable on Linux. I tried and
couldn't manage to get it to fail, and the reasoning above explains why.
But I wasn't 100% clear that Dscho hadn't seen it fail on non-Windows.

 t/t5552-skipping-fetch-negotiator.sh | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 0a8e0e42ed..0ad50dd839 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -28,6 +28,19 @@ have_not_sent () {
 	done
 }
 
+# trace_fetch <client_dir> <server_dir> [args]
+#
+# Trace the packet output of fetch, but make sure we disable the variable
+# in the child upload-pack, so we don't combine the results in the same file.
+trace_fetch () {
+	client=$1; shift
+	server=$1; shift
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+	git -C "$client" fetch \
+	  --upload-pack 'unset GIT_TRACE_PACKET; git-upload-pack' \
+	  "$server" "$@"
+}
+
 test_expect_success 'commits with no parents are sent regardless of skip distance' '
 	git init server &&
 	test_commit -C server to_fetch &&
@@ -42,7 +55,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	# "c1" has no parent, it is still sent as "have" even though it would
 	# normally be skipped.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	trace_fetch client "$(pwd)/server" &&
 	have_sent c7 c5 c2 c1 &&
 	have_not_sent c6 c4 c3
 '
@@ -65,7 +78,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
 	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
 	# (from "c5side" skip 1).
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	trace_fetch client "$(pwd)/server" &&
 	have_sent c5side c11 c9 c6 c1 &&
 	have_not_sent c10 c8 c7 c5 c4 c3 c2
 '
@@ -91,7 +104,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
+	trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
@@ -121,7 +134,7 @@ test_expect_success 'handle clock skew' '
 	# and sent, because (due to clock skew) its only parent has already been
 	# popped off the priority queue.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	trace_fetch client "$(pwd)/server" &&
 	have_sent c2 c1 old4 old2 old1 &&
 	have_not_sent old3
 '
@@ -153,7 +166,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server commit-on-b1 &&
 
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
+	trace_fetch client "$(pwd)/server" to_fetch &&
 	grep "  fetch" trace &&
 
 	# fetch-pack sends 2 requests each containing 16 "have" lines before
-- 
2.18.0.1058.g0926f0b71f

