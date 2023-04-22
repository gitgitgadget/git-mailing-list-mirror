Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F8C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDVNuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:50:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349F1BEB
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:50:02 -0700 (PDT)
Received: (qmail 13518 invoked by uid 109); 22 Apr 2023 13:50:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:50:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28978 invoked by uid 111); 22 Apr 2023 13:50:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:50:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:50:01 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/3] parse_commit(): handle broken whitespace-only timestamp
Message-ID: <20230422135001.GA3942563@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment in parse_commit_date() claims that parse_timestamp() will
not walk past the end of the buffer we've been given, since it will hit
the newline at "eol" and stop. This is usually true, when dateptr
contains actual numbers to parse. But with a line like:

   committer name <email>   \n

with just whitespace, and no numbers, parse_timestamp() will consume
that newline as part of the leading whitespace, and we may walk past our
"tail" pointer (which itself is set from the "size" parameter passed in
to parse_commit_buffer()).

In practice this can't cause us to walk off the end of an array, because
we always add an extra NUL byte to the end of objects we load from disk
(as a defense against exactly this kind of bug). However, you can see
the behavior in action when "committer" is the final header (which it
usually is, unless there's an encoding) and the subject line can be
parsed as an integer. We walk right past the newline on the committer
line, as well as the "\n\n" separator, and mistake the subject for the
timestamp.

The new test demonstrates such a case. I also added a test to check this
case against the pretty-print formatter, which uses split_ident_line().
It's not subject to the same bug, because it insists that there be one
or more digits in the timestamp.

We can use the same logic here. If there's a non-whitespace but
non-digit value (say "committer name <email> foo"), then
parse_timestamp() would already have returned 0 anyway. So the only
change should be for this "whitespace only" case.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c               | 10 ++++++++++
 t/t4212-log-corrupt.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/commit.c b/commit.c
index ede810ac1c..56877322d3 100644
--- a/commit.c
+++ b/commit.c
@@ -120,6 +120,16 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	if (dateptr == buf || dateptr == eol)
 		return 0;
 
+	/*
+	 * trim leading whitespace; parse_timestamp() will do this itself, but
+	 * it will walk past the newline at eol while doing so. So we insist
+	 * that there is at least one digit here.
+	 */
+	while (dateptr < eol && isspace(*dateptr))
+		dateptr++;
+	if (!strchr("0123456789", *dateptr))
+		return 0;
+
 	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
 	return parse_timestamp(dateptr, NULL, 10);
 }
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index af4b35ff56..d4ef48d646 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -92,4 +92,33 @@ test_expect_success 'absurdly far-in-future date' '
 	git log -1 --format=%ad $commit
 '
 
+test_expect_success 'create commit with whitespace committer date' '
+	# It is important that this subject line is numeric, since we want to
+	# be sure we are not confused by skipping whitespace and accidentally
+	# parsing the subject as a timestamp.
+	#
+	# Do not use munge_author_date here. Besides not hitting the committer
+	# line, it leaves the timezone intact, and we want nothing but
+	# whitespace.
+	test_commit 1234567890 &&
+	git cat-file commit HEAD >commit.orig &&
+	sed "s/>.*/>    /" <commit.orig >commit.munge &&
+	ws_commit=$(git hash-object --literally -w -t commit commit.munge)
+'
+
+test_expect_success '--until treats whitespace date as sentinel' '
+	echo $ws_commit >expect &&
+	git rev-list --until=1980-01-01 $ws_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty-printer handles whitespace date' '
+	# as with the %ad test above, we will show these as the empty string,
+	# not the 1970 epoch date. This is intentional; see 7d9a281941 (t4212:
+	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
+	echo : >expect &&
+	git log -1 --format="%at:%ct" $ws_commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.653.g15ca972062
