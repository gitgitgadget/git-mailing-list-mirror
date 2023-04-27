Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCFC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbjD0IRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0IRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:17:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD014209
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:17:17 -0700 (PDT)
Received: (qmail 20711 invoked by uid 109); 27 Apr 2023 08:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17294 invoked by uid 111); 27 Apr 2023 08:17:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:17:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:17:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230427081715.GA1478467@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net>
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

We can solve this by trimming the whitespace ourselves, making sure that
it has some non-whitespace to parse. Note that we need to be a bit
careful about the definition of "whitespace" here, as our isspace()
doesn't match exotic characters like vertical tab or formfeed. We can
work around that by checking for an actual number (see the in-code
comment). This is slightly more restrictive than the current code, but
in practice the results are either the same (we reject "foo" as "0", but
so would parse_timestamp()) or extremely unlikely even for broken
commits (parse_timestamp() would allow "\v123" as "123", but we'll now
make it "0").

I did also allow "-" here, which may be controversial, as we don't
currently support negative timestamps. My reasoning was two-fold. One,
the design of parse_timestamp() is such that we should be able to easily
switch it to handling signed values, and this otherwise creates a
hard-to-find gotcha that anybody doing that work would get tripped up
on. And two, the status quo is that we currently parse them, though the
result of course ends up as a very large unsigned value (which is likely
to just get clamped to "0" for display anyway, since our date routines
can't handle it).

The new test checks the commit parser (via "--until") for both vanilla
spaces and the vertical-tab case. I also added a test to check these
against the pretty-print formatter, which uses split_ident_line().  It's
not subject to the same bug, because it already insists that there be
one or more digits in the timestamp.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c               | 28 ++++++++++++++++++++++++++--
 t/t4212-log-corrupt.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 04c20d9cc6..8dfe92cf37 100644
--- a/commit.c
+++ b/commit.c
@@ -121,10 +121,34 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	dateptr = eol;
 	while (dateptr > buf && dateptr[-1] != '>')
 		dateptr--;
-	if (dateptr == buf || dateptr == eol)
+	if (dateptr == buf)
 		return 0;
 
-	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
+	/*
+	 * Trim leading whitespace, but make sure we have at least one
+	 * non-whitespace character, as parse_timestamp() will otherwise walk
+	 * right past the newline we found in "eol" when skipping whitespace
+	 * itself.
+	 *
+	 * In theory it would be sufficient to allow any character not matched
+	 * by isspace(), but there's a catch: our isspace() does not
+	 * necessarily match the behavior of parse_timestamp(), as the latter
+	 * is implemented by system routines which match more exotic control
+	 * codes, or even locale-dependent sequences.
+	 *
+	 * Since we expect the timestamp to be a number, we can check for that.
+	 * Anything else (e.g., a non-numeric token like "foo") would just
+	 * cause parse_timestamp() to return 0 anyway.
+	 */
+	while (dateptr < eol && isspace(*dateptr))
+		dateptr++;
+	if (!isdigit(*dateptr) && *dateptr != '-')
+		return 0;
+
+	/*
+	 * We know there is at least one digit (or dash), so we'll begin
+	 * parsing there and stop at worst case at eol.
+	 */
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index af4b35ff56..85e90acb09 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -92,4 +92,45 @@ test_expect_success 'absurdly far-in-future date' '
 	git log -1 --format=%ad $commit
 '
 
+test_expect_success 'create commits with whitespace committer dates' '
+	# It is important that this subject line is numeric, since we want to
+	# be sure we are not confused by skipping whitespace and accidentally
+	# parsing the subject as a timestamp.
+	#
+	# Do not use munge_author_date here. Besides not hitting the committer
+	# line, it leaves the timezone intact, and we want nothing but
+	# whitespace.
+	#
+	# We will make two munged commits here. The first, ws_commit, will
+	# be purely spaces. The second contains a vertical tab, which is
+	# considered a space by strtoumax(), but not by our isspace().
+	test_commit 1234567890 &&
+	git cat-file commit HEAD >commit.orig &&
+	sed "s/>.*/>    /" <commit.orig >commit.munge &&
+	ws_commit=$(git hash-object --literally -w -t commit commit.munge) &&
+	sed "s/>.*/>   $(printf "\013")/" <commit.orig >commit.munge &&
+	vt_commit=$(git hash-object --literally -w -t commit commit.munge)
+'
+
+test_expect_success '--until treats whitespace date as sentinel' '
+	echo $ws_commit >expect &&
+	git rev-list --until=1980-01-01 $ws_commit >actual &&
+	test_cmp expect actual &&
+
+	echo $vt_commit >expect &&
+	git rev-list --until=1980-01-01 $vt_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty-printer handles whitespace date' '
+	# as with the %ad test above, we will show these as the empty string,
+	# not the 1970 epoch date. This is intentional; see 7d9a281941 (t4212:
+	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
+	echo : >expect &&
+	git log -1 --format="%at:%ct" $ws_commit >actual &&
+	test_cmp expect actual &&
+	git log -1 --format="%at:%ct" $vt_commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.1.663.g410c33770c.dirty

