Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B2C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5394222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420320AbgJYWmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420312AbgJYWmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:14 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F15C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:14 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXo-0007u5-Jw; Sun, 25 Oct 2020 22:27:16 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 01/21] trailer: change token_{from,matches}_item into taking conf_info
Date:   Sun, 25 Oct 2020 22:26:32 +0100
Message-Id: <20201025212652.3003036-2-anders@0x63.nu>
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
        id 1kWnXo-0007u5-Jw; Sun, 25 Oct 2020 22:27:16 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

These functions don't use anything from the arg_item except the conf,
so make them take conf as argument instead. This will allow them to be
used on other things that has a conf_info.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3f7391d793..efb88c2008 100644
--- a/trailer.c
+++ b/trailer.c
@@ -574,20 +574,20 @@ static void ensure_configured(void)
 	configured = 1;
 }
 
-static const char *token_from_item(struct arg_item *item, char *tok)
+static const char *token_from_conf(const struct conf_info *conf, char *tok)
 {
-	if (item->conf.key)
-		return item->conf.key;
+	if (conf->key)
+		return conf->key;
 	if (tok)
 		return tok;
-	return item->conf.name;
+	return conf->name;
 }
 
-static int token_matches_item(const char *tok, struct arg_item *item, size_t tok_len)
+static int token_matches_conf(const char *tok, const struct conf_info *conf, size_t tok_len)
 {
-	if (!strncasecmp(tok, item->conf.name, tok_len))
+	if (!strncasecmp(tok, conf->name, tok_len))
 		return 1;
-	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
+	return conf->key ? !strncasecmp(tok, conf->key, tok_len) : 0;
 }
 
 /*
@@ -650,11 +650,11 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 		*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
-		if (token_matches_item(tok->buf, item, tok_len)) {
+		if (token_matches_conf(tok->buf, &item->conf, tok_len)) {
 			char *tok_buf = strbuf_detach(tok, NULL);
 			if (conf)
 				*conf = &item->conf;
-			strbuf_addstr(tok, token_from_item(item, tok_buf));
+			strbuf_addstr(tok, token_from_conf(&item->conf, tok_buf));
 			free(tok_buf);
 			break;
 		}
@@ -710,7 +710,7 @@ static void process_command_line_args(struct list_head *arg_head,
 		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
 			add_arg_item(arg_head,
-				     xstrdup(token_from_item(item, NULL)),
+				     xstrdup(token_from_conf(&item->conf, NULL)),
 				     xstrdup(""),
 				     &item->conf, NULL);
 	}
@@ -879,7 +879,7 @@ static size_t find_trailer_start(const char *buf, size_t len)
 			list_for_each(pos, &conf_head) {
 				struct arg_item *item;
 				item = list_entry(pos, struct arg_item, list);
-				if (token_matches_item(bol, item,
+				if (token_matches_conf(bol, &item->conf,
 						       separator_pos)) {
 					recognized_prefix = 1;
 					break;
-- 
2.25.1

