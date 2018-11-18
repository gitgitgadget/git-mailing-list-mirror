Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297A91F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKRWFk (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:05:40 -0500
Received: from 0x63.nu ([109.74.10.199]:54730 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeKRWFk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:05:40 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVy-0003J7-4e; Sun, 18 Nov 2018 12:45:22 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 3/5] pretty: add support for "valueonly" option in %(trailers)
Date:   Sun, 18 Nov 2018 12:44:25 +0100
Message-Id: <20181118114427.1397-4-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181118114427.1397-1-anders@0x63.nu>
References: <20181104152232.20671-1-anders@0x63.nu>
 <20181118114427.1397-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new "key=" option to %(trailers) it often makes little sense to
show the key, as it by definition already is know which trailer is
printed there. This new "valueonly" option makes it omit the key when
printing trailers.

E.g.:
 $ git show -s --pretty='%s%n%(trailers:key=Signed-off-by,valueonly)' aaaa88182
will show:
 > upload-pack: fix broken if/else chain in config callback
 > Jeff King <peff@peff.net>
 > Junio C Hamano <gitster@pobox.com>

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 2 ++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 trailer.c                        | 6 ++++--
 trailer.h                        | 1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 75c2e838d..8cc8c3f9f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -216,6 +216,8 @@ endif::git-rev-list[]
   ** 'key=<K>': only show trailers with specified key. Matching is
      done case-insensitively and trailing colon is optional. If option
      is given multiple times only last one is used.
+  ** 'valueonly': skip over the key part of the trailer and only show
+     the its value part.
   ** Examples: `%(trailers:only,unfold)` unfolds and shows all trailer
      lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
      trailer lines with key `Reviewed-by`.
diff --git a/pretty.c b/pretty.c
index aaedc8447..2e99f2418 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1335,6 +1335,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.only_trailers = 1;
 				else if (match_placeholder_arg(arg, "unfold", &arg))
 					opts.unfold = 1;
+				else if (match_placeholder_arg(arg, "valueonly", &arg))
+					opts.value_only = 1;
 				else if (skip_prefix(arg, "key=", &arg)) {
 					const char *end = arg + strcspn(arg, ",)");
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index aba7ba206..095208d6b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -634,6 +634,12 @@ test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,valueonly)" >actual &&
+	echo "A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 97c8f2762..662c7ff03 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1150,8 +1150,10 @@ static void format_trailer_info(struct strbuf *out,
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);
-
-				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+				if (!opts->value_only)
+					strbuf_addf(out, "%s: ", tok.buf);
+				strbuf_addbuf(out, &val);
+				strbuf_addch(out, '\n');
 			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
diff --git a/trailer.h b/trailer.h
index 5255b676d..06d417fe9 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int value_only;
 	int (*filter)(const struct strbuf *, void *);
 	void *filter_data;
 };
-- 
2.17.1

