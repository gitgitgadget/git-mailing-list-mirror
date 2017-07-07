Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85503202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 08:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdGGIkE (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 04:40:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752526AbdGGIkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 04:40:03 -0400
Received: (qmail 7251 invoked by uid 109); 7 Jul 2017 08:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 08:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20519 invoked by uid 111); 7 Jul 2017 08:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 04:40:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 04:39:50 -0400
Date:   Fri, 7 Jul 2017 04:39:50 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 2/4] reflog-walk: duplicate strings in complete_reflogs
 list
Message-ID: <20170707083950.et7j6xzlvapggp2l@sigill.intra.peff.net>
References: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the add_reflog_to_walk() function, we keep a
string_list mapping refnames to their reflog contents. This
serves as a cache so that accessing the same reflog twice
requires only a single copy of the log in memory.

The string_list is initialized via xcalloc, meaning its
strdup_strings field is set to 0. But after inserting a
string into the list, we unconditionally call free() on the
string, leaving the list pointing to freed memory. If
another reflog is added (e.g., "git log -g HEAD HEAD"), then
the second one may have unpredictable results.

The extra free was added by 5026b47175 (add_reflog_for_walk:
avoid memory leak, 2017-05-04). Though if you look
carefully, you can see that the code was buggy even before
then. If we tried to read the reflogs by time but came up
with no entries, we exited with an error, freeing the string
in that code path. So the bug was harder to trigger, but
still there.

We can fix it by just asking the string list to make a copy
of the string. Technically we could fix the problem by not
calling free() on our string (and just handing over
ownership to the string list), but there are enough
conditionals that it's quite hard to figure out which code
paths need the free and which do not. Simpler is better
here.

The new test reliably shows the problem when run with
--valgrind or ASAN.

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          | 1 +
 t/t1411-reflog-show.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/reflog-walk.c b/reflog-walk.c
index f7ffd1caa3..aec718beba 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -136,6 +136,7 @@ struct reflog_walk_info {
 void init_reflog_walk(struct reflog_walk_info **info)
 {
 	*info = xcalloc(1, sizeof(struct reflog_walk_info));
+	(*info)->complete_reflogs.strdup_strings = 1;
 }
 
 int add_reflog_for_walk(struct reflog_walk_info *info,
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6ac7734d79..ae96eeb66a 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -171,4 +171,10 @@ test_expect_success 'reflog exists works' '
 	! git reflog exists refs/heads/nonexistent
 '
 
+# The behavior with two reflogs is buggy and the output is in flux; for now
+# we're just checking that the program works at all without segfaulting.
+test_expect_success 'showing multiple reflogs works' '
+	git log -g HEAD HEAD >actual
+'
+
 test_done
-- 
2.13.2.1000.g8590c1af5d

