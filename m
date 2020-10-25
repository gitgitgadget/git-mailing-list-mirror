Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4127FC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F586222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420308AbgJYWmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420299AbgJYWmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:06 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2111C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:05 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXq-0007u5-4C; Sun, 25 Oct 2020 22:27:18 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 11/21] trailer: remember separator used in input
Date:   Sun, 25 Oct 2020 22:26:42 +0100
Message-Id: <20201025212652.3003036-12-anders@0x63.nu>
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
        id 1kWnXq-0007u5-4C; Sun, 25 Oct 2020 22:27:18 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

This will in later commits make it easier to allow configuration to
decide if separator should be canonicalized or displayed as it was in
input.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/trailer.c b/trailer.c
index d6882155be..1592e6c998 100644
--- a/trailer.c
+++ b/trailer.c
@@ -34,6 +34,7 @@ struct trailer_item {
 	 */
 	char *token;
 	char *value;
+	char *used_separator;
 	const struct conf_info *conf;
 };
 
@@ -125,6 +126,7 @@ static void free_trailer_item(struct trailer_item *item)
 {
 	free(item->token);
 	free(item->value);
+	free(item->used_separator);
 	free(item);
 }
 
@@ -616,18 +618,26 @@ static ssize_t find_separator(const char *line, const char *separators)
  *
  * If separator_pos is -1, interpret the whole trailer as a token.
  */
-static void parse_trailer(struct strbuf *tok, struct strbuf *val,
+static void parse_trailer(struct strbuf *tok, struct strbuf *val, struct strbuf *sep,
 			 const struct conf_info **conf, const char *trailer,
 			 ssize_t separator_pos)
 {
 	struct conf_info_item *item;
-	size_t tok_len;
 	struct list_head *pos;
 
 	if (separator_pos != -1) {
-		strbuf_add(tok, trailer, separator_pos);
-		strbuf_trim(tok);
-		strbuf_addstr(val, trailer + separator_pos + 1);
+		size_t sep_spacing_begin = separator_pos;
+		size_t sep_spacing_end = separator_pos + 1;
+
+		while (sep_spacing_begin > 0 && trailer[sep_spacing_begin - 1] == ' ')
+			sep_spacing_begin--;
+		while (trailer[sep_spacing_end] == ' ')
+			sep_spacing_end++;
+
+		strbuf_add(tok, trailer, sep_spacing_begin);
+		if (sep)
+			strbuf_add(sep, trailer + sep_spacing_begin, sep_spacing_end - sep_spacing_begin);
+		strbuf_addstr(val, trailer + sep_spacing_end);
 		strbuf_trim(val);
 	} else {
 		strbuf_addstr(tok, trailer);
@@ -635,12 +645,11 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 	}
 
 	/* Lookup if the token matches something in the config */
-	tok_len = token_len_without_separator(tok->buf, tok->len);
 	if (conf)
 		*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct conf_info_item, list);
-		if (token_matches_conf(tok->buf, &item->conf, tok_len)) {
+		if (token_matches_conf(tok->buf, &item->conf, tok->len)) {
 			if (conf)
 				*conf = &item->conf;
 			break;
@@ -649,11 +658,12 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 }
 
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
-					     char *val, const struct conf_info *conf)
+					     char *val, char *separator, const struct conf_info *conf)
 {
 	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
 	new_item->token = tok;
 	new_item->value = val;
+	new_item->used_separator = separator;
 	new_item->conf = conf;
 	list_add_tail(&new_item->list, head);
 	return new_item;
@@ -717,7 +727,7 @@ static void process_command_line_args(struct list_head *arg_head,
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, &conf, tr->text,
+			parse_trailer(&tok, &val, NULL, &conf, tr->text,
 				      separator_pos);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
@@ -936,6 +946,7 @@ static size_t process_input_file(FILE *outfile,
 	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
+	struct strbuf sep = STRBUF_INIT;
 	size_t i;
 
 	trailer_info_get(&info, str, opts);
@@ -955,13 +966,14 @@ static size_t process_input_file(FILE *outfile,
 		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
 			const struct conf_info *conf;
-			parse_trailer(&tok, &val, &conf, trailer,
+			parse_trailer(&tok, &val, &sep, &conf, trailer,
 				      separator_pos);
 			if (opts->unfold)
 				unfold_value(&val);
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL),
+					 strbuf_detach(&sep, NULL),
 					 conf);
 		} else if (!opts->only_trailers) {
 			strbuf_addstr(&val, trailer);
@@ -969,6 +981,7 @@ static size_t process_input_file(FILE *outfile,
 			add_trailer_item(head,
 					 NULL,
 					 strbuf_detach(&val, NULL),
+					 NULL,
 					 NULL);
 		}
 	}
@@ -1148,7 +1161,7 @@ static void format_trailer_info(struct strbuf *out,
 
 			const struct conf_info *conf;
 
-			parse_trailer(&tok, &val, &conf, trailer, separator_pos);
+			parse_trailer(&tok, &val, NULL, &conf, trailer, separator_pos);
 			if (!opts->filter ||
 			    opts->filter(&tok, conf ? conf->name : NULL, opts->filter_data)) {
 				if (opts->unfold)
@@ -1209,7 +1222,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
-		parse_trailer(&iter->key, &iter->val, NULL,
+		parse_trailer(&iter->key, &iter->val, NULL, NULL,
 			      trailer, separator_pos);
 		unfold_value(&iter->val);
 		return 1;
-- 
2.25.1

