Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE31B1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeKEAjy (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:39:54 -0500
Received: from 0x63.nu ([109.74.10.199]:37232 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbeKEAjy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 19:39:54 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJKGN-0005Wk-TE; Sun, 04 Nov 2018 16:24:32 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v2 3/5] pretty: add support for "nokey" option in %(trailers)
Date:   Sun,  4 Nov 2018 16:22:30 +0100
Message-Id: <20181104152232.20671-4-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104152232.20671-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181104152232.20671-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new "key=" option to %trailers it often makes little sense to
show the key, as it by definition already is know which trailer is
printed there. This new "nokey" option makes it omit key trailer key
when printing trailers.

E.g.:
 $ git show -s --pretty='%s%n%(trailers:key=Signed-off-by,nokey)' aaaa88182
will show:
 > upload-pack: fix broken if/else chain in config callback
 > Jeff King <peff@peff.net>
 > Junio C Hamano <gitster@pobox.com>

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 11 ++++++-----
 pretty.c                         |  2 ++
 t/t4205-log-pretty-formats.sh    |  9 +++++++++
 trailer.c                        |  6 ++++--
 trailer.h                        |  1 +
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8326fc45e..e115e355d 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -212,11 +212,12 @@ endif::git-rev-list[]
   followed by a colon and zero or more comma-separated options. The
   allowed options are `only` which omits non-trailer lines from the
   trailer block, `unfold` to make it behave as if interpret-trailer's
-  `--unfold` option was given, and `key=T` to only show trailers with
-  specified key (matching is done
-  case-insensitively). E.g. `%(trailers:only,unfold)` unfolds and
-  shows all trailer lines, `%(trailers:key=Reviewed-by,unfold)`
-  unfolds and shows trailer lines with key `Reviewed-by`.
+  `--unfold` option was given, `key=T` to only show trailers with
+  specified key (matching is done case-insensitively), and `nokey`
+  which makes it skip over the key part of the trailer and only show
+  value. E.g. `%(trailers:only,unfold)` unfolds and shows all trailer
+  lines, `%(trailers:key=Reviewed-by,unfold)` unfolds and shows
+  trailer lines with key `Reviewed-by`.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index cdca9dce2..f87ba4f18 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1323,6 +1323,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.only_trailers = 1;
 				else if (match_placeholder_arg(arg, "unfold", &arg))
 					opts.unfold = 1;
+				else if (match_placeholder_arg(arg, "nokey", &arg))
+					opts.no_key = 1;
 				else if (skip_prefix(arg, "key=", &arg)) {
 					const char *end = arg + strcspn(arg, ",)");
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0f5207242..e7de3b18a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -643,6 +643,15 @@ test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,nokey) shows only value' '
+	git log --no-walk --pretty="%(trailers:key=Acked-by,nokey)" >actual &&
+	{
+		echo "A U Thor <author@example.com>" &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index cbbb553e4..4f19c34cb 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1150,8 +1150,10 @@ static void format_trailer_info(struct strbuf *out,
 			if (!opts->filter_key || !strcasecmp (tok.buf, opts->filter_key)) {
 				if (opts->unfold)
 					unfold_value(&val);
-
-				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+				if (opts->no_key)
+					strbuf_addf(out, "%s\n", val.buf);
+				else
+					strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
 			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
diff --git a/trailer.h b/trailer.h
index d052d02ae..83de87ee9 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int no_key;
 	char *filter_key;
 };
 
-- 
2.17.1

