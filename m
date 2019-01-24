Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959F81F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfAXMcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:32:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727596AbfAXMcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:32:43 -0500
Received: (qmail 25768 invoked by uid 109); 24 Jan 2019 12:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27956 invoked by uid 111); 24 Jan 2019 12:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:32:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:32:41 -0500
Date:   Thu, 24 Jan 2019 07:32:41 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] diff: clear emitted_symbols flag after use
Message-ID: <20190124123240.GB11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's an odd bug when "log --color-moved" is used with the combination
of "--cc --stat -p": the stat for merge commits is erroneously shown
with the diff of the _next_ commit.

The included test demonstrates the issue. Our history looks something
like this:

  A-B-M--D
   \ /
    C

When we run "git log --cc --stat -p --color-moved" starting at D, we get
this sequence of events:

  1. The diff for D is using -p, so diff_flush() calls into
     diff_flush_patch_all_file_pairs(). There we see that o->color_moved
     is in effect, so we point o->emitted_symbols to a static local
     struct, causing diff_flush_patch() to queue the symbols instead of
     actually writing them out.

     We then do our move detection, emit the symbols, and clear the
     struct. But we leave o->emitted_symbols pointing to our struct.

  2. Next we compute the diff for M. This is a merge, so we use the
     combined diff code. In find_paths_generic(), we compute the
     pairwise diff between each commit and its parent. Normally this is
     done with DIFF_FORMAT_NO_OUTPUT, since we're just looking for
     intersecting paths. But since "--stat --cc" shows the first-parent
     stat, and since we're computing that diff anyway, we enable
     DIFF_FORMAT_DIFFSTAT for the first parent. This outputs the stat
     information immediately, saving us from running a separate
     first-parent diff later.

     But where does that output go? Normally it goes directly to stdout,
     but because o->emitted_symbols is set, we queue it. As a result, we
     don't actually print the diffstat for the merge commit (yet), which
     is wrong.

  3. Next we compute the diff for C. We're actually showing a patch
     again, so we end up in diff_flush_patch_all_file_pairs(), but this
     time we have the queued stat from step 2 waiting in our struct.

     We add new elements to it for C's diff, and then flush the whole
     thing. And we see the diffstat from M as part of C's diff, which is
     wrong.

So triggering the bug really does require the combination of all of
those options.

To fix it, we can simply restore o->emitted_symbols to NULL after
flushing it, so that it does not affect anything outside of
diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
nobody outside of that function is going to bother flushing it, so we
would not want them to write to it either.

In fact, we could take this a step further and turn the local "esm"
struct into a non-static variable that goes away after the function
ends. However, since it contains a dynamically sized array, we benefit
from amortizing the cost of allocations over many calls. So we'll leave
it as static to retain that benefit.

But let's push the zero-ing of esm.nr into the conditional for "if
(o->emitted_symbols)" to make it clear that we do not expect esm to hold
any values if we did not just try to use it. With the code as it is
written now, if we did encounter such a case (which I think would be a
bug), we'd silently leak those values without even bothering to display
them. With this change, we'd at least eventually show them, and somebody
would notice.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                     |  4 +-
 t/t4066-diff-emit-delay.sh | 79 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100755 t/t4066-diff-emit-delay.sh

diff --git a/diff.c b/diff.c
index 1b5f276360..7b97739799 100644
--- a/diff.c
+++ b/diff.c
@@ -5894,8 +5894,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 		for (i = 0; i < esm.nr; i++)
 			free((void *)esm.buf[i].line);
+		esm.nr = 0;
+
+		o->emitted_symbols = NULL;
 	}
-	esm.nr = 0;
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
new file mode 100755
index 0000000000..5df6b5e64e
--- /dev/null
+++ b/t/t4066-diff-emit-delay.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='test combined/stat/moved interaction'
+. ./test-lib.sh
+
+# This test covers a weird 3-way interaction between "--cc -p", which will run
+# the combined diff code, along with "--stat", which will be computed as a
+# first-parent stat during the combined diff, and "--color-moved", which
+# enables the emitted_symbols list to store the diff in memory.
+
+test_expect_success 'set up history with a merge' '
+	test_commit A &&
+	test_commit B &&
+	git checkout -b side HEAD^ &&
+	test_commit C &&
+	git merge -m M master &&
+	test_commit D
+'
+
+test_expect_success 'log --cc -p --stat --color-moved' '
+	cat >expect <<-\EOF &&
+	commit D
+	---
+	 D.t | 1 +
+	 1 file changed, 1 insertion(+)
+
+	diff --git a/D.t b/D.t
+	new file mode 100644
+	index 0000000..1784810
+	--- /dev/null
+	+++ b/D.t
+	@@ -0,0 +1 @@
+	+D
+	commit M
+
+	 B.t | 1 +
+	 1 file changed, 1 insertion(+)
+	commit C
+	---
+	 C.t | 1 +
+	 1 file changed, 1 insertion(+)
+
+	diff --git a/C.t b/C.t
+	new file mode 100644
+	index 0000000..3cc58df
+	--- /dev/null
+	+++ b/C.t
+	@@ -0,0 +1 @@
+	+C
+	commit B
+	---
+	 B.t | 1 +
+	 1 file changed, 1 insertion(+)
+
+	diff --git a/B.t b/B.t
+	new file mode 100644
+	index 0000000..223b783
+	--- /dev/null
+	+++ b/B.t
+	@@ -0,0 +1 @@
+	+B
+	commit A
+	---
+	 A.t | 1 +
+	 1 file changed, 1 insertion(+)
+
+	diff --git a/A.t b/A.t
+	new file mode 100644
+	index 0000000..f70f10e
+	--- /dev/null
+	+++ b/A.t
+	@@ -0,0 +1 @@
+	+A
+	EOF
+	git log --format="commit %s" --cc -p --stat --color-moved >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.20.1.842.g8986705066

