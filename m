Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0B8C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA72223BD
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420264AbgJYWlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420258AbgJYWlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:51 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D1C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:51 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-HV; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 07/21] trailer: simplify 'arg_item' lifetime
Date:   Sun, 25 Oct 2020 22:26:38 +0100
Message-Id: <20201025212652.3003036-8-anders@0x63.nu>
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
        id 1kWnXp-0007u5-HV; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

'struct arg_item' are created from config and '--trailers' arguments
in 'git interpret-trailers'.

Then they were freed as they were processed. This made it harder to
reason about and ensure that all of them were properly freed in all
cases.

This commit extends the lifetime by not doing any freeing during
processing but rather freeing the whole list afterwards. This make it
clearer and will allow keeping a reference to the config stored in the
arg item.

The drawback is that there is extra memory allocation as previously
the strings could be donated to the trailer_item when that is
created. Now they have to be copied.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/trailer.c b/trailer.c
index 227df1c0ef..047781463a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -177,13 +177,11 @@ static void print_all(FILE *outfile, struct list_head *head,
 	}
 }
 
-static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
+static struct trailer_item *trailer_from_arg(const struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
-	new_item->token = arg_tok->token;
-	new_item->value = arg_tok->value;
-	arg_tok->token = arg_tok->value = NULL;
-	free_arg_item(arg_tok);
+	new_item->token = xstrdup(arg_tok->token);
+	new_item->value = xstrdup(arg_tok->value);
 	return new_item;
 }
 
@@ -274,7 +272,6 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
-		free_arg_item(arg_tok);
 		break;
 	case EXISTS_REPLACE:
 		apply_item_command(in_tok, arg_tok);
@@ -290,15 +287,11 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(in_tok, arg_tok, 1, head))
 			add_arg_to_input_list(on_tok, arg_tok);
-		else
-			free_arg_item(arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
 		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(on_tok, arg_tok, 0, head))
 			add_arg_to_input_list(on_tok, arg_tok);
-		else
-			free_arg_item(arg_tok);
 		break;
 	default:
 		BUG("trailer.c: unhandled value %d",
@@ -314,7 +307,6 @@ static void apply_arg_if_missing(struct list_head *head,
 
 	switch (arg_tok->conf.if_missing) {
 	case MISSING_DO_NOTHING:
-		free_arg_item(arg_tok);
 		break;
 	case MISSING_ADD:
 		where = arg_tok->conf.where;
@@ -364,15 +356,13 @@ static int find_same_and_apply_arg(struct list_head *head,
 static void process_trailers_lists(struct list_head *head,
 				   struct list_head *arg_head)
 {
-	struct list_head *pos, *p;
+	struct list_head *pos;
 	struct arg_item *arg_tok;
 
-	list_for_each_safe(pos, p, arg_head) {
+	list_for_each(pos, arg_head) {
 		int applied = 0;
 		arg_tok = list_entry(pos, struct arg_item, list);
 
-		list_del(pos);
-
 		applied = find_same_and_apply_arg(head, arg_tok);
 
 		if (!applied)
@@ -999,6 +989,15 @@ static void free_all_trailer_items(struct list_head *head)
 	}
 }
 
+static void free_all_arg_items(struct list_head *head)
+{
+	struct list_head *pos, *p;
+	list_for_each_safe(pos, p, head) {
+		list_del(pos);
+		free_arg_item(list_entry(pos, struct arg_item, list));
+	}
+}
+
 static struct tempfile *trailers_tempfile;
 
 static FILE *create_in_place_tempfile(const char *file)
@@ -1035,6 +1034,7 @@ void process_trailers(const char *file,
 		      struct list_head *new_trailer_head)
 {
 	LIST_HEAD(head);
+	LIST_HEAD(arg_head);
 	struct strbuf sb = STRBUF_INIT;
 	size_t trailer_end;
 	FILE *outfile = stdout;
@@ -1050,7 +1050,6 @@ void process_trailers(const char *file,
 	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
 
 	if (!opts->only_input) {
-		LIST_HEAD(arg_head);
 		process_command_line_args(&arg_head, new_trailer_head);
 		process_trailers_lists(&head, &arg_head);
 	}
@@ -1058,6 +1057,7 @@ void process_trailers(const char *file,
 	print_all(outfile, &head, opts);
 
 	free_all_trailer_items(&head);
+	free_all_arg_items(&arg_head);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-- 
2.25.1

