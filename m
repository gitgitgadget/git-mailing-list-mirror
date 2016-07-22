Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E4020195
	for <e@80x24.org>; Fri, 22 Jul 2016 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbcGVP16 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:27:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48620 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751779AbcGVP15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:27:57 -0400
Received: (qmail 10410 invoked by uid 102); 22 Jul 2016 15:27:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 11:27:56 -0400
Received: (qmail 6345 invoked by uid 107); 22 Jul 2016 15:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 11:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 11:27:53 -0400
Date:	Fri, 22 Jul 2016 11:27:53 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH] diff: do not reuse worktree files that need "clean"
 conversion
Message-ID: <20160722152753.GA6859@sigill.intra.peff.net>
References: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
 <20160721213740.GB4604@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160721213740.GB4604@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 05:37:40PM -0400, Jeff King wrote:

> The next three are to show the final diffstat after the commit
> completes. It looks like the "should we reuse the worktree file?"
> optimization in diff_populate_filespec() does not take into account
> whether we will have to convert the contents, and it probably should.
> The point is that sometimes mmap-ing the file contents is more efficient
> than zlib inflating the object from disk. But if we have to exec an
> extra process and read the whole object contents into a strbuf, that is
> probably not a win.
> 
> Adding a "return 0" at the top of reuse_worktree_file() drops our 6 to
> 3 (but obviously it should actually check the attributes).

Here's a patch for that. I put it in t0021, as well, since I couldn't
find a more appropriate place. This means it conflicts with your earlier
patch, but I think it does a better job of addressing the specific area
it fixes.

We may want further tests on top as we fix more areas (though as I said
earlier, I think by avoiding the racy timestamps, your "commit" call
drops to just a single invocation per file. That still seems like one
more than we should need, but it at least matches your original
expectation :) ).

-- >8 --
Subject: diff: do not reuse worktree files that need "clean" conversion

When accessing a blob for a diff, we may try to reuse file
contents in the working tree, under the theory that it is
faster to mmap those file contents than it would be to
extract the content from the object database.

When we have to filter those contents, though, that
assumption does not hold. Even for our internal conversions
like CRLF, we have to allocate and fill a new buffer anyway.
But much worse, for external clean filters we have to exec
an arbitrary script, and we have no idea how expensive it
may be to run.

So let's skip this optimization when conversion into git's
"clean" form is required. This applies whenever the
"want_file" flag is false. When it's true, the caller
actually wants the smudged worktree contents, which the
reused file by definition already has (in fact, this is a
key optimization going the other direction, since reusing
the worktree file there lets us skip smudge filters).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                |  7 +++++++
 t/t0021-conversion.sh | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/diff.c b/diff.c
index 7d03419..b43d3dd 100644
--- a/diff.c
+++ b/diff.c
@@ -2683,6 +2683,13 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
 		return 0;
 
+	/*
+	 * Similarly, if we'd have to convert the file contents anyway, that
+	 * makes the optimization not worthwhile.
+	 */
+	if (!want_file && would_convert_to_git(name))
+		return 0;
+
 	len = strlen(name);
 	pos = cache_name_pos(name, len);
 	if (pos < 0)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7bac2bc..e799e59 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -268,4 +268,15 @@ test_expect_success 'disable filter with empty override' '
 	test_must_be_empty err
 '
 
+test_expect_success 'diff does not reuse worktree files that need cleaning' '
+	test_config filter.counter.clean "echo . >>count; sed s/^/clean:/" &&
+	echo "file filter=counter" >.gitattributes &&
+	test_commit one file &&
+	test_commit two file &&
+
+	>count &&
+	git diff-tree -p HEAD &&
+	test_line_count = 0 count
+'
+
 test_done
-- 
2.9.2.506.g8452fe7

