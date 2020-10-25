Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A19C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EF9222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420254AbgJYWlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418775AbgJYWlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:46 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC11C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:46 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXs-0007u5-31; Sun, 25 Oct 2020 22:27:20 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 19/21] trailer: move config lookup out of parse_trailer
Date:   Sun, 25 Oct 2020 22:26:50 +0100
Message-Id: <20201025212652.3003036-20-anders@0x63.nu>
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
        id 1kWnXs-0007u5-31; Sun, 25 Oct 2020 22:27:20 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

This may be seen as making it worse adding code duplication. But will
hopefully make different handling for config lookups easier.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/trailer.c b/trailer.c
index 02061877b4..0db3bba3b1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -656,8 +656,7 @@ static ssize_t find_separator(const char *line, const char *separators)
  * If separator_pos is -1, interpret the whole trailer as a token.
  */
 static void parse_trailer(struct strbuf *tok, struct strbuf *val, struct strbuf *sep,
-			 const struct conf_info **conf, const char *trailer,
-			 ssize_t separator_pos)
+			 const char *trailer, ssize_t separator_pos)
 {
 	if (separator_pos != -1) {
 		size_t sep_spacing_begin = separator_pos;
@@ -677,9 +676,6 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, struct strbuf
 		strbuf_addstr(tok, trailer);
 		strbuf_trim(tok);
 	}
-
-	if (conf)
-		*conf = lookup_conf_for_tok (tok);
 }
 
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
@@ -752,8 +748,9 @@ static void process_command_line_args(struct list_head *arg_head,
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, NULL, &conf, tr->text,
+			parse_trailer(&tok, &val, NULL, tr->text,
 				      separator_pos);
+			conf = lookup_conf_for_tok(&tok);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
@@ -1026,8 +1023,9 @@ static size_t process_input_file(FILE *outfile,
 		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
 			const struct conf_info *conf;
-			parse_trailer(&tok, &val, &sep, &conf, trailer,
+			parse_trailer(&tok, &val, &sep, trailer,
 				      separator_pos);
+			conf = lookup_conf_for_tok(&tok);
 			if (opts->unfold)
 				unfold_value(&val);
 			add_trailer_item(head,
@@ -1221,7 +1219,8 @@ static void format_trailer_info(struct strbuf *out,
 
 			const struct conf_info *conf;
 
-			parse_trailer(&tok, &val, NULL, &conf, trailer, separator_pos);
+			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
+			conf = lookup_conf_for_tok(&tok);
 			if (!opts->filter ||
 			    opts->filter(&tok, conf ? conf->name : NULL, opts->filter_data)) {
 				if (opts->unfold)
@@ -1282,7 +1281,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
-		parse_trailer(&iter->key, &iter->val, NULL, NULL,
+		parse_trailer(&iter->key, &iter->val, NULL,
 			      trailer, separator_pos);
 		unfold_value(&iter->val);
 		return 1;
-- 
2.25.1

