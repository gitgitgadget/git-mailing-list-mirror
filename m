Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65903C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D135222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420332AbgJYWmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420303AbgJYWmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:07 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B073C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:07 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXs-0007u5-DU; Sun, 25 Oct 2020 22:27:20 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 21/21] trailer: only do prefix matching for configured trailers on commandline
Date:   Sun, 25 Oct 2020 22:26:52 +0100
Message-Id: <20201025212652.3003036-22-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXs-0007u5-DU; Sun, 25 Oct 2020 22:27:20 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

If there is a trailer "foobar" in configuration a trailer "foo" in
input shouldn't match that, except in `--trailer` arguments as a
shortcut.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 t/t7513-interpret-trailers.sh | 17 +++++++++++++----
 trailer.c                     | 14 +++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index a99d6d7e3b..9e06fa4454 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -151,8 +151,7 @@ test_expect_success 'spelling and separators are not canonicalized with --parse
 	test_cmp expected actual
 '
 
-# Matching currently is prefix matching, causing "This-trailer" to be normalized too
-test_expect_failure 'config option matches exact only' '
+test_expect_success 'config option matches exact only' '
 	cat >patch <<-\EOF &&
 
 		This-trailer: a
@@ -171,8 +170,7 @@ test_expect_failure 'config option matches exact only' '
 	test_cmp expected actual
 '
 
-# Matching currently uses the config key even if key value is different
-test_expect_failure 'config option matches exact only' '
+test_expect_success 'config option matches exact only' '
 	cat >patch <<-\EOF &&
 
 		Ticket: 1234
@@ -550,6 +548,17 @@ test_expect_success 'with config setup' '
 	test_cmp expected actual
 '
 
+test_expect_success 'trailer on commandline can be prefix of configured' '
+	cat >expected <<-\EOF &&
+
+		Acked-by: 10
+	EOF
+	git interpret-trailers --trailer "A=10" empty >actual &&
+	test_cmp expected actual
+'
+
+
+
 test_expect_success 'with config setup and ":=" as separators' '
 	git config trailer.separators ":=" &&
 	git config trailer.ack.key "Acked-by= " &&
diff --git a/trailer.c b/trailer.c
index 0db3bba3b1..b00b35ea0e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -605,14 +605,18 @@ static int token_matches_conf(const char *tok, const struct conf_info *conf, siz
 	return conf->key ? !strncasecmp(tok, conf->key, tok_len) : 0;
 }
 
-static const struct conf_info *lookup_conf_for_tok(const struct strbuf *tok)
+static const struct conf_info *lookup_conf_for_tok(const struct strbuf *tok, int strict)
 {
 	struct conf_info_item *item;
 	struct list_head *pos;
 
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct conf_info_item, list);
-		if (token_matches_conf(tok->buf, &item->conf, tok->len)) {
+		if (strict) {
+			const char *match = item->conf.key ? item->conf.key : item->conf.name;
+			if (!strcasecmp(match, tok->buf))
+				return &item->conf;
+		} else if (token_matches_conf(tok->buf, &item->conf, tok->len)) {
 			return &item->conf;
 		}
 	}
@@ -750,7 +754,7 @@ static void process_command_line_args(struct list_head *arg_head,
 		} else {
 			parse_trailer(&tok, &val, NULL, tr->text,
 				      separator_pos);
-			conf = lookup_conf_for_tok(&tok);
+			conf = lookup_conf_for_tok(&tok, 0);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
@@ -1025,7 +1029,7 @@ static size_t process_input_file(FILE *outfile,
 			const struct conf_info *conf;
 			parse_trailer(&tok, &val, &sep, trailer,
 				      separator_pos);
-			conf = lookup_conf_for_tok(&tok);
+			conf = lookup_conf_for_tok(&tok, 1);
 			if (opts->unfold)
 				unfold_value(&val);
 			add_trailer_item(head,
@@ -1220,7 +1224,7 @@ static void format_trailer_info(struct strbuf *out,
 			const struct conf_info *conf;
 
 			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			conf = lookup_conf_for_tok(&tok);
+			conf = lookup_conf_for_tok(&tok, 1);
 			if (!opts->filter ||
 			    opts->filter(&tok, conf ? conf->name : NULL, opts->filter_data)) {
 				if (opts->unfold)
-- 
2.25.1

