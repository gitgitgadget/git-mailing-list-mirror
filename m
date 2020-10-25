Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75553C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475CE222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420317AbgJYWmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420307AbgJYWmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:09 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5BC0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:08 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXr-0007u5-Um; Sun, 25 Oct 2020 22:27:19 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 18/21] trailer: factor out config lookup to separate function
Date:   Sun, 25 Oct 2020 22:26:49 +0100
Message-Id: <20201025212652.3003036-19-anders@0x63.nu>
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
        id 1kWnXr-0007u5-Um; Sun, 25 Oct 2020 22:27:19 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index d75d240e10..02061877b4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -605,6 +605,20 @@ static int token_matches_conf(const char *tok, const struct conf_info *conf, siz
 	return conf->key ? !strncasecmp(tok, conf->key, tok_len) : 0;
 }
 
+static const struct conf_info *lookup_conf_for_tok(const struct strbuf *tok)
+{
+	struct conf_info_item *item;
+	struct list_head *pos;
+
+	list_for_each(pos, &conf_head) {
+		item = list_entry(pos, struct conf_info_item, list);
+		if (token_matches_conf(tok->buf, &item->conf, tok->len)) {
+			return &item->conf;
+		}
+	}
+	return &default_conf_info;
+}
+
 /*
  * If the given line is of the form
  * "<token><optional whitespace><separator>..." or "<separator>...", return the
@@ -645,9 +659,6 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, struct strbuf
 			 const struct conf_info **conf, const char *trailer,
 			 ssize_t separator_pos)
 {
-	struct conf_info_item *item;
-	struct list_head *pos;
-
 	if (separator_pos != -1) {
 		size_t sep_spacing_begin = separator_pos;
 		size_t sep_spacing_end = separator_pos + 1;
@@ -667,17 +678,8 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, struct strbuf
 		strbuf_trim(tok);
 	}
 
-	/* Lookup if the token matches something in the config */
 	if (conf)
-		*conf = &default_conf_info;
-	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct conf_info_item, list);
-		if (token_matches_conf(tok->buf, &item->conf, tok->len)) {
-			if (conf)
-				*conf = &item->conf;
-			break;
-		}
-	}
+		*conf = lookup_conf_for_tok (tok);
 }
 
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
-- 
2.25.1

