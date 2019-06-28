Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF991F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF1Jlh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:41:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbfF1Jlh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:41:37 -0400
Received: (qmail 14470 invoked by uid 109); 28 Jun 2019 09:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 09:41:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16145 invoked by uid 111); 28 Jun 2019 09:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 05:42:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 05:41:35 -0400
Date:   Fri, 28 Jun 2019 05:41:35 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 3/6] t3311: use test_commit_bulk
Message-ID: <20190628094135.GC27329@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628093751.GA3569@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the tests in t3311 creates 300 commits by running "test_commit"
in a loop. This requires 900 processes. Instead, we can use
test_commit_bulk to do it with only four. This improves the runtime of
the script from:

  Benchmark #1: ./t3311-notes-merge-fanout.sh --root=/var/ram/git-tests
    Time (mean ± σ):      5.821 s ±  0.691 s    [User: 3.146 s, System: 2.782 s]
    Range (min … max):    4.783 s …  6.841 s    10 runs

to:

  Benchmark #1: ./t3311-notes-merge-fanout.sh --root=/var/ram/git-tests
    Time (mean ± σ):      1.743 s ±  0.116 s    [User: 1.144 s, System: 0.691 s]
    Range (min … max):    1.629 s …  1.994 s    10 runs

for an average speedup of over 70%.

Unfortunately we still have to run 300 instances of "git notes add",
since the point is to test the fanout that comes from adding notes one
by one.

Signed-off-by: Jeff King <peff@peff.net>
---
Re-reading the patch again, the notes numbering will be in reverse
order from the original. That's fine for the purposes of the test,
though I could probably fix it if we want to be pedantic.

 t/t3311-notes-merge-fanout.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 93516ef67c..37151a3adc 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -114,12 +114,12 @@ cp expect_log_x expect_log_y
 test_expect_success 'Add a few hundred commits w/notes to trigger fanout (x -> y)' '
 	git update-ref refs/notes/y refs/notes/x &&
 	git config core.notesRef refs/notes/y &&
-	i=5 &&
-	while test $i -lt $num
+	test_commit_bulk --start=6 --id=commit $((num - 5)) &&
+	i=0 &&
+	while test $i -lt $((num - 5))
 	do
-		i=$(($i + 1)) &&
-		test_commit "commit$i" >/dev/null &&
-		git notes add -m "notes for commit$i" || return 1
+		git notes add -m "notes for commit$i" HEAD~$i || return 1
+		i=$((i + 1))
 	done &&
 	test "$(git rev-parse refs/notes/y)" != "$(git rev-parse refs/notes/x)" &&
 	# Expected number of commits and notes
-- 
2.22.0.768.gd89de1e449

