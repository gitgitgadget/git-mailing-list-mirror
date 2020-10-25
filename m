Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D8C5517A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DD5222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420300AbgJYWmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420293AbgJYWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:03 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08568C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:03 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXo-0007u5-Oy; Sun, 25 Oct 2020 22:27:16 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 02/21] trailer: don't use 'struct arg_item' for storing config
Date:   Sun, 25 Oct 2020 22:26:33 +0100
Message-Id: <20201025212652.3003036-3-anders@0x63.nu>
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
        id 1kWnXo-0007u5-Oy; Sun, 25 Oct 2020 22:27:16 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

The '--trailer' options given to 'git interpret-trailers' are store in
the suitably named 'struct arg_item'.

The configuration done in 'trailer.<name>.xyz' was also stored in that
struct. Even though it only needs the "conf_info" part of it.

This commit creates a separate struct for conf_info_item

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/trailer.c b/trailer.c
index efb88c2008..ca7a823af6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -19,6 +19,11 @@ struct conf_info {
 	enum trailer_if_missing if_missing;
 };
 
+struct conf_info_item {
+	struct list_head list;
+	struct conf_info conf;
+};
+
 static struct conf_info default_conf_info;
 
 struct trailer_item {
@@ -432,16 +437,16 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 	dst->command = xstrdup_or_null(src->command);
 }
 
-static struct arg_item *get_conf_item(const char *name)
+static struct conf_info *get_conf_item(const char *name)
 {
 	struct list_head *pos;
-	struct arg_item *item;
+	struct conf_info_item *item;
 
 	/* Look up item with same name */
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
+		item = list_entry(pos, struct conf_info_item, list);
 		if (!strcasecmp(item->conf.name, name))
-			return item;
+			return &item->conf;
 	}
 
 	/* Item does not already exists, create it */
@@ -451,7 +456,7 @@ static struct arg_item *get_conf_item(const char *name)
 
 	list_add_tail(&item->list, &conf_head);
 
-	return item;
+	return &item->conf;
 }
 
 enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
@@ -502,7 +507,6 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 {
 	const char *trailer_item, *variable_name;
-	struct arg_item *item;
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
@@ -527,8 +531,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	if (!name)
 		return 0;
 
-	item = get_conf_item(name);
-	conf = &item->conf;
+	conf = get_conf_item(name);
 	free(name);
 
 	switch (type) {
@@ -630,7 +633,7 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 			 const struct conf_info **conf, const char *trailer,
 			 ssize_t separator_pos)
 {
-	struct arg_item *item;
+	struct conf_info_item *item;
 	size_t tok_len;
 	struct list_head *pos;
 
@@ -649,7 +652,7 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 	if (conf)
 		*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
+		item = list_entry(pos, struct conf_info_item, list);
 		if (token_matches_conf(tok->buf, &item->conf, tok_len)) {
 			char *tok_buf = strbuf_detach(tok, NULL);
 			if (conf)
@@ -693,7 +696,7 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 static void process_command_line_args(struct list_head *arg_head,
 				      struct list_head *new_trailer_head)
 {
-	struct arg_item *item;
+	struct conf_info_item *item;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct conf_info *conf;
@@ -707,7 +710,7 @@ static void process_command_line_args(struct list_head *arg_head,
 
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
+		item = list_entry(pos, struct conf_info_item, list);
 		if (item->conf.command)
 			add_arg_item(arg_head,
 				     xstrdup(token_from_conf(&item->conf, NULL)),
@@ -877,8 +880,8 @@ static size_t find_trailer_start(const char *buf, size_t len)
 			if (recognized_prefix)
 				continue;
 			list_for_each(pos, &conf_head) {
-				struct arg_item *item;
-				item = list_entry(pos, struct arg_item, list);
+				struct conf_info_item *item;
+				item = list_entry(pos, struct conf_info_item, list);
 				if (token_matches_conf(bol, &item->conf,
 						       separator_pos)) {
 					recognized_prefix = 1;
-- 
2.25.1

