Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B45C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36C6222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420283AbgJYWl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420276AbgJYWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:57 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21193C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:57 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXq-0007u5-0D; Sun, 25 Oct 2020 22:27:18 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 10/21] trailer: move trailer token canonicalization print time
Date:   Sun, 25 Oct 2020 22:26:41 +0100
Message-Id: <20201025212652.3003036-11-anders@0x63.nu>
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
        id 1kWnXq-0007u5-0D; Sun, 25 Oct 2020 22:27:18 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Now that config is stored on the trailer_item it can easily be
accessed print time and the changing of the token into the
configured (canonical) spelling can be done print time instead.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/trailer.c b/trailer.c
index 71921e70ce..d6882155be 100644
--- a/trailer.c
+++ b/trailer.c
@@ -149,20 +149,24 @@ static char last_non_space_char(const char *s)
 
 static void print_item(FILE *outfile, const struct trailer_item *item)
 {
-	char c;
-
-	if (!item->token) {
-		fprintf(outfile, "%s\n", item->value);
-		return;
+	if (item->token) {
+		const char *tok = item->token;
+		const struct conf_info *conf = item->conf;
+		char c;
+
+		if (conf && conf->key)
+			tok = conf->key;
+
+		c = last_non_space_char(tok);
+		if (!c)
+			return;
+		if (strchr(separators, c))
+			fputs(tok, outfile);
+		else
+			fprintf(outfile, "%s%c ", tok, separators[0]);
 	}
 
-	c = last_non_space_char(item->token);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", item->token, item->value);
-	else
-		fprintf(outfile, "%s%c %s\n", item->token, separators[0], item->value);
+	fprintf(outfile, "%s\n", item->value);
 }
 
 static void print_all(FILE *outfile, struct list_head *head,
@@ -569,15 +573,6 @@ static void ensure_configured(void)
 	configured = 1;
 }
 
-static const char *token_from_conf(const struct conf_info *conf, char *tok)
-{
-	if (conf->key)
-		return conf->key;
-	if (tok)
-		return tok;
-	return conf->name;
-}
-
 static int token_matches_conf(const char *tok, const struct conf_info *conf, size_t tok_len)
 {
 	if (!strncasecmp(tok, conf->name, tok_len))
@@ -646,11 +641,8 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct conf_info_item, list);
 		if (token_matches_conf(tok->buf, &item->conf, tok_len)) {
-			char *tok_buf = strbuf_detach(tok, NULL);
 			if (conf)
 				*conf = &item->conf;
-			strbuf_addstr(tok, token_from_conf(&item->conf, tok_buf));
-			free(tok_buf);
 			break;
 		}
 	}
@@ -706,7 +698,7 @@ static void process_command_line_args(struct list_head *arg_head,
 		item = list_entry(pos, struct conf_info_item, list);
 		if (item->conf.command)
 			add_arg_item(arg_head,
-				     xstrdup(token_from_conf(&item->conf, NULL)),
+				     xstrdup(item->conf.name),
 				     xstrdup(""),
 				     &item->conf, NULL);
 	}
-- 
2.25.1

