Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D6C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977EE222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420287AbgJYWmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420281AbgJYWl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:58 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8AC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:58 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-ML; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 08/21] trailer: keep track of conf in trailer_item
Date:   Sun, 25 Oct 2020 22:26:39 +0100
Message-Id: <20201025212652.3003036-9-anders@0x63.nu>
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
        id 1kWnXp-0007u5-ML; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/trailer.c b/trailer.c
index 047781463a..0986d4267e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -34,6 +34,7 @@ struct trailer_item {
 	 */
 	char *token;
 	char *value;
+	const struct conf_info *conf;
 };
 
 struct arg_item {
@@ -182,6 +183,7 @@ static struct trailer_item *trailer_from_arg(const struct arg_item *arg_tok)
 	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
 	new_item->token = xstrdup(arg_tok->token);
 	new_item->value = xstrdup(arg_tok->value);
+	new_item->conf = &arg_tok->conf;
 	return new_item;
 }
 
@@ -655,11 +657,12 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 }
 
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
-					     char *val)
+					     char *val, const struct conf_info *conf)
 {
 	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
 	new_item->token = tok;
 	new_item->value = val;
+	new_item->conf = conf;
 	list_add_tail(&new_item->list, head);
 	return new_item;
 }
@@ -959,19 +962,22 @@ static size_t process_input_file(FILE *outfile,
 			continue;
 		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
-			parse_trailer(&tok, &val, NULL, trailer,
+			const struct conf_info *conf;
+			parse_trailer(&tok, &val, &conf, trailer,
 				      separator_pos);
 			if (opts->unfold)
 				unfold_value(&val);
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL));
+					 strbuf_detach(&val, NULL),
+					 conf);
 		} else if (!opts->only_trailers) {
 			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
-					 strbuf_detach(&val, NULL));
+					 strbuf_detach(&val, NULL),
+					 NULL);
 		}
 	}
 
-- 
2.25.1

