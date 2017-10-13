Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB7F20372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbdJMASk (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:18:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753274AbdJMASj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:18:39 -0400
Received: (qmail 11634 invoked by uid 109); 13 Oct 2017 00:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 00:18:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22024 invoked by uid 111); 13 Oct 2017 00:18:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 20:18:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 20:18:37 -0400
Date:   Thu, 12 Oct 2017 20:18:37 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012233322.31203-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 04:33:22PM -0700, Stefan Beller wrote:

> Peff, feel free to take ownership here. I merely made it to a patch.

I think compared to my original, it makes sense to actually wrap the
whole thing with a check for the whitespace. You can do it just in the
IGNORE_WHITESPACE_CHANGE conditional, but I think it makes more sense to
cover both. Like the patch below (view with "-w" to see the logic more
clearly).

I also tweaked the test to remove "sed -i", which isn't portable, and
fixed up a few style nits.

-- >8 --
Subject: diff: fix infinite loop with --color-moved --ignore-space-change

The --color-moved code uses next_byte() to advance through
the blob contents. When the user has asked to ignore
whitespace changes, we try to collapse any whitespace change
down to a single space.

However, we enter the conditional block whenever we see the
IGNORE_WHITESPACE_CHANGE flag, even if the next byte isn't
whitespace.

This means that the combination of "--color-moved and
--ignore-space-change" was completely broken. Worse, because
we return from next_byte() without having advanced our
pointer, the function makes no forward progress in the
buffer and loops infinitely.

Fix this by entering the conditional only when we actually
see whitespace. We can apply this also to the
IGNORE_WHITESPACE change. That code path isn't buggy
(because it falls through to returning the next
non-whitespace byte), but it makes the logic more clear if
we only bother to look at whitespace flags after seeing that
the next byte is whitespace.

Reported-by: Orgad Shaneh <orgads@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                     | 28 +++++++++++++++-------------
 t/t4015-diff-whitespace.sh |  9 +++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 69f03570ad..d76bb937c1 100644
--- a/diff.c
+++ b/diff.c
@@ -712,20 +712,22 @@ static int next_byte(const char **cp, const char **endp,
 	if (*cp > *endp)
 		return -1;
 
-	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
-		while (*cp < *endp && isspace(**cp))
-			(*cp)++;
-		/*
-		 * After skipping a couple of whitespaces, we still have to
-		 * account for one space.
-		 */
-		return (int)' ';
-	}
+	if (isspace(**cp)) {
+		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
+			while (*cp < *endp && isspace(**cp))
+				(*cp)++;
+			/*
+			 * After skipping a couple of whitespaces,
+			 * we still have to account for one space.
+			 */
+			return (int)' ';
+		}
 
-	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
-		while (*cp < *endp && isspace(**cp))
-			(*cp)++;
-		/* return the first non-ws character via the usual below */
+		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
+			while (*cp < *endp && isspace(**cp))
+				(*cp)++;
+			/* return the first non-ws character via the usual below */
+		}
 	}
 
 	retval = (unsigned char)(**cp);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index bd0f75d9f7..87083f728f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1530,4 +1530,13 @@ test_expect_success 'move detection with submodules' '
 	test_cmp expect decoded_actual
 '
 
+test_expect_success 'move detection with whitespace changes' '
+	test_when_finished "git reset --hard" &&
+	test_seq 10 >test &&
+	git add test &&
+	sed s/3/42/ <test >test.tmp &&
+	mv test.tmp test &&
+	git -c diff.colormoved diff --ignore-space-change -- test
+'
+
 test_done
-- 
2.15.0.rc1.381.g94fac273d4

