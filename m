Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3001FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbcHaFFo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:05:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:35733 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750708AbcHaFFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:05:43 -0400
Received: (qmail 5106 invoked by uid 109); 31 Aug 2016 05:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 05:05:43 +0000
Received: (qmail 3047 invoked by uid 111); 31 Aug 2016 05:05:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 01:05:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 01:05:38 -0400
Date:   Wed, 31 Aug 2016 01:05:38 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, gitster@pobox.com
Subject: [PATCH 3/3] diff-highlight: avoid highlighting combined diffs
Message-ID: <20160831050538.53fki52cvwlmkd6y@sigill.intra.peff.net>
References: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The algorithm in diff-highlight only understands how to look
at two sides of a diff; it cannot correctly handle combined
diffs with multiple preimages. Often highlighting does not
trigger at all for these diffs because the line counts do
not match up.  E.g., if we see:

  - ours
   -theirs
  ++resolved

we would not bother highlighting; it naively looks like a
single line went away, and then a separate hunk added
another single line.

But of course there are exceptions. E.g., if the other side
deleted the line, we might see:

  - ours
  ++resolved

which looks like we dropped " ours" and added "+resolved".
This is only a small highlighting glitch (we highlight the
space and the "+" along with the content), but it's also the
tip of the iceberg. Even if we learned to find the true
content here (by noticing we are in a 3-way combined diff
and marking _two_ characters from the front of the line as
uninteresting), there are other more complicated cases where
we really do need to handle a 3-way hunk.

Let's just punt for now; we can recognize combined diffs by
the presence of extra "@" symbols in the hunk header, and
treat them as non-diff content.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/diff-highlight            |  2 +-
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 37 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 9280c88..81bd804 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -36,7 +36,7 @@ $SIG{PIPE} = 'DEFAULT';
 while (<>) {
 	if (!$in_hunk) {
 		print;
-		$in_hunk = /^$GRAPH*$COLOR*\@/;
+		$in_hunk = /^$GRAPH*$COLOR*\@\@ /;
 	}
 	elsif (/^$GRAPH*$COLOR*-/) {
 		push @removed, $_;
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 7d034aa..64dd9f7 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -254,4 +254,41 @@ test_expect_success 'diff-highlight works with the --graph option' '
 	test_cmp graph.exp graph.act
 '
 
+# Most combined diffs won't meet diff-highlight's line-number filter. So we
+# create one here where one side drops a line and the other modifies it. That
+# should result in a diff like:
+#
+#    - modified content
+#    ++resolved content
+#
+# which naively looks like one side added "+resolved".
+test_expect_success 'diff-highlight ignores combined diffs' '
+	echo "content" >file &&
+	git add file &&
+	git commit -m base &&
+
+	>file &&
+	git commit -am master &&
+
+	git checkout -b other HEAD^ &&
+	echo "modified content" >file &&
+	git commit -am other &&
+
+	test_must_fail git merge master &&
+	echo "resolved content" >file &&
+	git commit -am resolved &&
+
+	cat >expect <<-\EOF &&
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,0 +1,1 @@@
+	- modified content
+	++resolved content
+	EOF
+
+	git show -c | "$DIFF_HIGHLIGHT" >actual.raw &&
+	sed -n "/^---/,\$p" <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.0.rc2.125.gcfb3d08
