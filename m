Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B7B1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHIWNe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:13:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726971AbeHIWNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:13:33 -0400
Received: (qmail 1453 invoked by uid 109); 9 Aug 2018 19:47:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 19:47:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12944 invoked by uid 111); 9 Aug 2018 19:47:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 15:47:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 15:47:12 -0400
Date:   Thu, 9 Aug 2018 15:47:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
Message-ID: <20180809194712.GC32376@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 10:35:24AM -0700, Johannes Schindelin via GitGitGadget wrote:

> The culprit is that two processes try simultaneously to write to the same
> file specified via GIT_TRACE_PACKET, and it is not well defined how that
> should work, even on Linux.

Are you sure that it's not well-defined? We open the path with O_APPEND,
which means every write() will be atomically positioned at the end of
file. So we would never lose or overwrite data.

We do our own buffering in a strbuf, writing the result out in a single
write() call (modulo the OS returning a short write, but that should not
generally happen when writing short strings to a file). So we should get
individual trace lines as atomic units.

The order of lines from the two processes is undefined, of course.

> This patch series addresses that by locking the trace fd. I chose to use 
> flock() instead of fcntl() because the Win32 API LockFileEx()
> [https://docs.microsoft.com/en-us/windows/desktop/api/fileapi/nf-fileapi-lockfileex] 
> (which does exactly what I want in this context) has much more similar
> semantics to the former than the latter.

I must admit I'm not excited to see us adding extra locking and
complexity when it is not necessarily needed. Is this a feature we
actually care about delivering for normal users of GIT_TRACE, or do we
just care about solving the test flakiness here?

Because we should be able to do the latter with the patch below.

I also wonder if we should be clearing GIT_TRACE as part of clearing
repo-env. It would do what we want automatically in this case, though
there are definitely cases where I prefer the current behavior (because
I really do want to see the upload-pack side of it). Of course I could
always use "--upload-pack 'GIT_TRACE_PACKET=... upload-pack'", so this
is really just a default.

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 3b60bd44e0..5ad5bece55 100755
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
@@ -88,7 +101,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
 	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
 	# (from "c5side" skip 1).
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	trace_fetch client "$(pwd)/server" &&
 	have_sent c5side c11 c9 c6 c1 &&
 	have_not_sent c10 c8 c7 c5 c4 c3 c2
 '
@@ -114,7 +127,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
+	trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
@@ -144,7 +157,7 @@ test_expect_success 'handle clock skew' '
 	# and sent, because (due to clock skew) its only parent has already been
 	# popped off the priority queue.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+	trace_fetch client "$(pwd)/server" &&
 	have_sent c2 c1 old4 old2 old1 &&
 	have_not_sent old3
 '
@@ -176,7 +189,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server commit-on-b1 &&
 
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
+	trace_fetch client "$(pwd)/server" to_fetch &&
 	grep "  fetch" trace &&
 
 	# fetch-pack sends 2 requests each containing 16 "have" lines before
