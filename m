Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B79EC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615823998
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgI0IkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:40:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:42434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgI0IkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:40:13 -0400
Received: (qmail 29206 invoked by uid 109); 27 Sep 2020 08:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4142 invoked by uid 111); 27 Sep 2020 08:40:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:40:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:40:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: [PATCH v2 7/8] shortlog: parse trailer idents
Message-ID: <20200927084011.GG2465761@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927083933.GA2222823@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trailers don't necessarily contain name/email identity values, so
shortlog has so far treated them as opaque strings. However, since many
trailers do contain identities, it's useful to treat them as such when
they can be parsed. That lets "-e" work as usual, as well as mailmap.

When they can't be parsed, we'll continue with the old behavior of
treating them as a single string (there's no new test for that here,
since the existing tests cover a trailer like this).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  7 ++++---
 builtin/shortlog.c             |  6 ++++++
 t/t4201-shortlog.sh            | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 9e94613e13..3db0db2da0 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -64,9 +64,10 @@ Likewise, commits with multiple trailers (e.g., multiple signoffs) may
 be counted more than once (but only once per unique trailer value in
 that commit).
 +
-The contents of each trailer value are taken literally and completely.
-No mailmap is applied, and the `-e` option has no effect (if the trailer
-contains a username and email, they are both always shown).
+Shortlog will attempt to parse each trailer value as a `name <email>`
+identity. If successful, the mailmap is applied and the email is omitted
+unless the `--email` option is specified. If the value cannot be parsed
+as an identity, it will be taken literally and completely.
 
 -c::
 --committer::
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e6f4faec7c..28133aec68 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -228,6 +228,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 	struct trailer_iterator iter;
 	const char *commit_buffer, *body;
 	struct strset dups = STRSET_INIT;
+	struct strbuf ident = STRBUF_INIT;
 
 	/*
 	 * Using format_commit_message("%B") would be simpler here, but
@@ -245,12 +246,17 @@ static void insert_records_from_trailers(struct shortlog *log,
 		if (strcasecmp(iter.key.buf, log->trailer))
 			continue;
 
+		strbuf_reset(&ident);
+		if (!parse_ident(log, &ident, value))
+			value = ident.buf;
+
 		if (strset_check_and_add(&dups, value))
 			continue;
 		insert_one_record(log, value, oneline);
 	}
 	trailer_iterator_release(&iter);
 
+	strbuf_release(&ident);
 	strset_clear(&dups);
 	unuse_commit_buffer(commit, commit_buffer);
 }
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 83dbbc44e8..a62ee9ed55 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -230,10 +230,30 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
 	     2	C O Mitter <committer@example.com>
 	     1	SOB One <sob@example.com>
 	EOF
+	git shortlog -nse --group=trailer:signed-off-by HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'trailer idents are split' '
+	cat >expect <<-\EOF &&
+	     2	C O Mitter
+	     1	SOB One
+	EOF
 	git shortlog -ns --group=trailer:signed-off-by HEAD >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'trailer idents are mailmapped' '
+	cat >expect <<-\EOF &&
+	     2	C O Mitter
+	     1	Another Name
+	EOF
+	echo "Another Name <sob@example.com>" >mail.map &&
+	git -c mailmap.file=mail.map shortlog -ns \
+		--group=trailer:signed-off-by HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog de-duplicates trailers in a single commit' '
 	git commit --allow-empty -F - <<-\EOF &&
 	subject one
-- 
2.28.0.1127.ga65787d918

