Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8DC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbjD0IO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242985AbjD0IO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:14:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9615144A9
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:14:10 -0700 (PDT)
Received: (qmail 20692 invoked by uid 109); 27 Apr 2023 08:14:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:14:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17260 invoked by uid 111); 27 Apr 2023 08:14:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:14:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:14:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 2/4] parse_commit(): parse timestamp from end of line
Message-ID: <20230427081409.GB1477912@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To find the committer timestamp, we parse left-to-right looking for the
closing ">" of the email, and then expect the timestamp right after
that. But we've seen some broken cases in the wild where this fails, but
we _could_ find the timestamp with a little extra work. E.g.:

  Name <Name<email>> 123456789 -0500

This means that features that rely on the committer timestamp, like
--since or --until, will treat the commit as happening at time 0 (i.e.,
1970).

This is doubly confusing because the pretty-print parser learned to
handle these in 03818a4a94 (split_ident: parse timestamp from end of
line, 2013-10-14). So printing them via "git show", etc, makes
everything look normal, but --until, etc are still broken (despite the
fact that that commit explicitly mentioned --until!).

So let's use the same trick as 03818a4a94: find the end of the line, and
parse back to the final ">". In theory we could use split_ident_line()
here, but it's actually a bit more strict. In particular, it requires a
valid time-zone token, too. That should be present, of course, but we
wouldn't want to break --until for cases that are working currently.

We might want to teach split_ident_line() to become more lenient there,
but it would require checking its many callers (since right now they can
assume that if date_start is non-NULL, so is tz_start).

So for now we'll just reimplement the same trick in the commit parser.

The test is in t4212, which already covers similar cases, courtesy of
03818a4a94. We'll just adjust the broken commit to munge both the author
and committer timestamps. Note that we could match (author|committer)
here, but alternation can't be used portably in sed. Since we wouldn't
expect to see ">" except as part of an ident line, we can just match
that character on any line.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c               | 24 ++++++++++++++++--------
 t/t4212-log-corrupt.sh |  7 ++++++-
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index 878b4473e4..04c20d9cc6 100644
--- a/commit.c
+++ b/commit.c
@@ -96,6 +96,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 static timestamp_t parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
+	const char *eol;
 
 	if (buf + 6 >= tail)
 		return 0;
@@ -107,16 +108,23 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 		return 0;
 	if (memcmp(buf, "committer", 9))
 		return 0;
-	while (buf < tail && *buf++ != '>')
-		/* nada */;
-	if (buf >= tail)
+
+	/*
+	 * Jump to end-of-line so that we can walk backwards to find the
+	 * end-of-email ">". This is more forgiving of malformed cases
+	 * because unexpected characters tend to be in the name and email
+	 * fields.
+	 */
+	eol = memchr(buf, '\n', tail - buf);
+	if (!eol)
 		return 0;
-	dateptr = buf;
-	while (buf < tail && *buf++ != '\n')
-		/* nada */;
-	if (buf >= tail)
+	dateptr = eol;
+	while (dateptr > buf && dateptr[-1] != '>')
+		dateptr--;
+	if (dateptr == buf || dateptr == eol)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+
+	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 8b5433ea74..af4b35ff56 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup' '
 	test_commit foo &&
 
 	git cat-file commit HEAD >ok.commit &&
-	sed "/^author /s/>/>-<>/" <ok.commit >broken_email.commit &&
+	sed "s/>/>-<>/" <ok.commit >broken_email.commit &&
 
 	git hash-object --literally -w -t commit broken_email.commit >broken_email.hash &&
 	git update-ref refs/heads/broken_email $(cat broken_email.hash)
@@ -44,6 +44,11 @@ test_expect_success 'git log --format with broken author email' '
 	test_must_be_empty actual.err
 '
 
+test_expect_success '--until handles broken email' '
+	git rev-list --until=1980-01-01 broken_email >actual &&
+	test_must_be_empty actual
+'
+
 munge_author_date () {
 	git cat-file commit "$1" >commit.orig &&
 	sed "s/^\(author .*>\) [0-9]*/\1 $2/" <commit.orig >commit.munge &&
-- 
2.40.1.663.g410c33770c.dirty

