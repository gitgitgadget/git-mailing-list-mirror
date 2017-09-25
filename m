Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A2B20281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbdIYKLO (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:14 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23508 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbdIYKLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:11 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM1dIVIG; Mon, 25 Sep 2017 11:11:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334270; bh=YGhvkBipgcsMjq4XNiGHRjNptKp67aCX/ZYeFqryo3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=dbUBcMgM+lfvaZeyymgh4lqzsS3LfEg7HJMsor0RE3gZbacmgCmWjretarzLt9vOl
         ovbkRHr3SKr0TfrKxyew/FgKsKudJ7HNjRHE572CbFhj6kEfpgmXfWasqj+DdOcwul
         ouaQcZITILQ5sFAKQ8EGJ4w2iJvhCIF7hQ4aPRLI=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=uGhzjvUkAXt2G3G7hqYA:9
 a=9LasAyfj8Q-Xi7W1:21 a=vNNAxXcONZHWS02k:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 1/8] commit: move empty message checks to libgit
Date:   Mon, 25 Sep 2017 11:10:34 +0100
Message-Id: <20170925101041.18344-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfE4kNZ+VLz2VccYsBojBh3ZlTm418I8E/NjMUXL/sr4xCJBtnV7kTwTNfRAuUU9NS3ASbIzIsTaini4obo+MmRgzlNLS4E9CnMLTGEh0yhuYuHy1XCDF
 X/lKFHjvW5h3jvr7xE7wBWb/NbzOYnhj3RoT149zc7mi+iwJHux2xip3KABKU9QoCr+NcwmVNkwzo2OFGUF5f5uyIcENXmg0ynJ+k+pGtWpX7hbZn5Hdzij+
 lCr8/wM3JnM4QcWmRaeJEsZ88m7q9YUsT1xRvjenQfI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 70 +++-----------------------------------------------------
 sequencer.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      | 10 ++++++++
 3 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b3b04f5dd3a94d1661e877c5019cc56ac46854ef..0b8c1ef6f57cfed328d12255e6834adb4bda4137 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -128,12 +128,7 @@ static char *sign_commit;
  * if editor is used, and only the whitespaces if the message
  * is specified explicitly.
  */
-static enum {
-	CLEANUP_SPACE,
-	CLEANUP_NONE,
-	CLEANUP_SCISSORS,
-	CLEANUP_ALL
-} cleanup_mode;
+static enum cleanup_mode cleanup_mode;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
@@ -978,65 +973,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-static int rest_is_empty(struct strbuf *sb, int start)
-{
-	int i, eol;
-	const char *nl;
-
-	/* Check if the rest is just whitespace and Signed-off-by's. */
-	for (i = start; i < sb->len; i++) {
-		nl = memchr(sb->buf + i, '\n', sb->len - i);
-		if (nl)
-			eol = nl - sb->buf;
-		else
-			eol = sb->len;
-
-		if (strlen(sign_off_header) <= eol - i &&
-		    starts_with(sb->buf + i, sign_off_header)) {
-			i = eol;
-			continue;
-		}
-		while (i < eol)
-			if (!isspace(sb->buf[i++]))
-				return 0;
-	}
-
-	return 1;
-}
-
-/*
- * Find out if the message in the strbuf contains only whitespace and
- * Signed-off-by lines.
- */
-static int message_is_empty(struct strbuf *sb)
-{
-	if (cleanup_mode == CLEANUP_NONE && sb->len)
-		return 0;
-	return rest_is_empty(sb, 0);
-}
-
-/*
- * See if the user edited the message in the editor or left what
- * was in the template intact
- */
-static int template_untouched(struct strbuf *sb)
-{
-	struct strbuf tmpl = STRBUF_INIT;
-	const char *start;
-
-	if (cleanup_mode == CLEANUP_NONE && sb->len)
-		return 0;
-
-	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
-		return 0;
-
-	strbuf_stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
-	if (!skip_prefix(sb->buf, tmpl.buf, &start))
-		start = sb->buf;
-	strbuf_release(&tmpl);
-	return rest_is_empty(sb, start - sb->buf);
-}
-
 static const char *find_author_by_nickname(const char *name)
 {
 	struct rev_info revs;
@@ -1744,12 +1680,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 
-	if (message_is_empty(&sb) && !allow_empty_message) {
+	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
 		exit(1);
 	}
-	if (template_untouched(&sb) && !allow_empty_message) {
+	if (template_untouched(&sb, template_file, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
 		exit(1);
diff --git a/sequencer.c b/sequencer.c
index fcceabb80f4261006cdd65bc0ec95ac54ea42e7c..319208afb3de36c97b6c62d4ecf6e641245e7a54 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -690,6 +690,66 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	return run_command(&cmd);
 }
 
+static int rest_is_empty(const struct strbuf *sb, int start)
+{
+	int i, eol;
+	const char *nl;
+
+	/* Check if the rest is just whitespace and Signed-off-by's. */
+	for (i = start; i < sb->len; i++) {
+		nl = memchr(sb->buf + i, '\n', sb->len - i);
+		if (nl)
+			eol = nl - sb->buf;
+		else
+			eol = sb->len;
+
+		if (strlen(sign_off_header) <= eol - i &&
+		    starts_with(sb->buf + i, sign_off_header)) {
+			i = eol;
+			continue;
+		}
+		while (i < eol)
+			if (!isspace(sb->buf[i++]))
+				return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * Find out if the message in the strbuf contains only whitespace and
+ * Signed-off-by lines.
+ */
+int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode)
+{
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
+		return 0;
+	return rest_is_empty(sb, 0);
+}
+
+/*
+ * See if the user edited the message in the editor or left what
+ * was in the template intact
+ */
+int template_untouched(const struct strbuf *sb, const char *template_file,
+		       enum cleanup_mode cleanup_mode)
+{
+	struct strbuf tmpl = STRBUF_INIT;
+	const char *start;
+
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
+		return 0;
+
+	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
+		return 0;
+
+	strbuf_stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
+	if (!skip_prefix(sb->buf, tmpl.buf, &start))
+		start = sb->buf;
+	strbuf_release(&tmpl);
+	return rest_is_empty(sb, start - sb->buf);
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
diff --git a/sequencer.h b/sequencer.h
index f885b68395f4bff1ded96c0ab84ed87d164f0c7d..dd071cfcd82d165bd23726814b74cbf3384e1a17 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,4 +50,14 @@ extern const char sign_off_header[];
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
 
+enum cleanup_mode {
+	CLEANUP_SPACE,
+	CLEANUP_NONE,
+	CLEANUP_SCISSORS,
+	CLEANUP_ALL
+};
+
+int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
+int template_untouched(const struct strbuf *sb, const char *template_file,
+		       enum cleanup_mode cleanup_mode);
 #endif
-- 
2.14.1

