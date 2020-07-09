Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF3C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD620774
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGIUjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:39:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 16:39:11 -0400
Received: (qmail 5825 invoked by uid 109); 9 Jul 2020 20:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 20:39:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25067 invoked by uid 111); 9 Jul 2020 20:39:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 16:39:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 16:39:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 3/4] t5539: make timestamp requirements more explicit
Message-ID: <20200709203909.GC661064@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709203336.GA2748777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test for "no shallow lines after receiving ACK ready" is very
sensitive to the timestamps of the commits we create. It's looking for
the fetch negotiation to send a "ready", which in turn depends on the
order in which we traverse commits during the negotiation.

It works reliably now because the base commit "7" is created without
test_commit, and thus gets a commit time matching the current system
clock. Whereas the new commits created in this test do use test_commit,
and get the usual test_tick time from 2005. So the fetch into the
"clone" repository results in a commit graph like this (I omitted some
of the "unrelated" commits for clarity; they're all just a sequence of
test_ticks):

  $ git log --graph --format='%ct %s %d'
  * 1112912953 new  (origin/master, origin/HEAD)
  * 1594322236 7  (grafted, master)
  * 1112912893 unrelated15  (origin/unrelated15, unrelated15)
  [...]
  * 1112912053 unrelated1  (origin/unrelated1, unrelated1)
  * 1112911993 new-too  (HEAD -> newnew, tag: new-too)

The important things to see are:

  - "7" is way in the future compared to the other commits

  - "new-too" in the fetching repo is older than "new" (and its
    "unrelated" ancestors) in the shallow repo

If we change our "setup shallow clone" step to use test_tick, too (and
get rid of the dependency on the system clock), then the test will fail.
The resulting graph looks like this:

  $ git log --graph --format='%ct %s %d'
  * 1112913373 new  (origin/master, origin/HEAD)
  * 1112912353 7  (grafted, master)
  * 1112913313 unrelated15  (origin/unrelated15, unrelated15)
  [...]
  * 1112912473 unrelated1  (origin/unrelated1, unrelated1)
  * 1112912413 new-too  (HEAD -> newnew, tag: new-too)

Our "new-too" is still older than "new" and "unrelated", but now "7" is
older than all of them (because it advanced test_tick, which the other
tests built on top of). In the original, we advertised "7" as the first
"have" before anything else, but now "new-too" is more recent. You'd see
the same thing in the unlikely event that the system clock was set
before our test_tick default in 2005.

Let's make the timing requirements more explicit. The important thing is
that the client advertise all of its shared commits first, before
presenting its unique "new-too" commit. We can do that and get rid of
the system clock dependency at the same time by creating all of the
shared commits around time X (using test_tick), and then creating
"new-too" with some time long before X. The resulting graph looks like
this:

  $ git log --graph --format='%ct %s %d'
  * 1500001380 new  (origin/master, origin/HEAD)
  * 1500000420 7  (grafted, master)
  * 1500001320 unrelated15  (origin/unrelated15, unrelated15)
  [...]
  * 1500000480 unrelated1  (origin/unrelated1, unrelated1)
  * 1400000060 new-too  (HEAD -> newnew, tag: new-too)

That also lets us get rid of the hacky test_tick added by f0e802ca20
(t5539: update a flaky test, 2014-07-14). That was clearly dancing
around the same problem, but only addressed the relationship between
commits created in the two subshells (which did use test_tick, but
overlapped because increments of test_tick in subshells are lost). Now
that we're using consistent and well-placed times for both lines of
history, we don't have to care about a one-tick difference between the
two sides.

Signed-off-by: Jeff King <peff@peff.net>
---
Curiously, the test still passes if "7" has the same timestamp as
"new-too"! That's why I didn't notice the failure in the original
thread, where I looked at setting the deterministic default time to the
default test_tick time. I didn't dig in, but I believe it only worked
because we currently use insertion order to break timestamp ties. And
since "master" sorts before "newnew", we'd queue "7" before "new-too".

 t/t5539-fetch-http-shallow.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index c0d02dee89..82aa99ae87 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -9,10 +9,12 @@ start_httpd
 commit() {
 	echo "$1" >tracked &&
 	git add tracked &&
+	test_tick &&
 	git commit -m "$1"
 }
 
 test_expect_success 'setup shallow clone' '
+	test_tick=1500000000 &&
 	commit 1 &&
 	commit 2 &&
 	commit 3 &&
@@ -48,7 +50,6 @@ EOF
 test_expect_success 'no shallow lines after receiving ACK ready' '
 	(
 		cd shallow &&
-		test_tick &&
 		for i in $(test_seq 15)
 		do
 			git checkout --orphan unrelated$i &&
@@ -66,6 +67,7 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 	(
 		cd clone &&
 		git checkout --orphan newnew &&
+		test_tick=1400000000 &&
 		test_commit new-too &&
 		# NEEDSWORK: If the overspecification of the expected result is reduced, we
 		# might be able to run this test in all protocol versions.
-- 
2.27.0.730.gcc195a083d

