Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB48202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbdKFLfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:35:54 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10561 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbdKFL2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:28:02 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfZCewttb; Mon, 06 Nov 2017 11:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967675; bh=7iNf2sQCZsnff5FfmupcEQ4eKCgnbrsFbfKU/ANAGto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=fYbsRu/pXfp6J8VrCd2K6RGUboXFr6HTQjgPBCB+RD4sLYIMT8CdXS/coVSdGjySJ
         hN5lPMRHFwsDN7NUcZbhn/QZikpX6Y0eTHlMgSO6euoLOcCAPNau2NAGh7sGiyGzq3
         Cav/R6kflxLZ3p/JfNZumvyjQsMEAlBNPu4C8r70=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=uGhzjvUkAXt2G3G7hqYA:9
 a=Wo9-lOUy9q14dEp_:21 a=hh9gD8s9WGRriRvp:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 1/8] commit: move empty message checks to libgit
Date:   Mon,  6 Nov 2017 11:27:02 +0000
Message-Id: <20171106112709.2121-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEkLZQpbRgy7j+O1KBmsc2vVx0e8BI1oHTI7qbwTNI/B0ndFatDYU9iKwKFDKX+n2K0xgz/7iyiXAROlGA+/SflxoLCACiinVAQM+00OS069UfXYXUmA
 rWIe8NY4s2JiJCbxCS8UqCqC05QQ4bvJtplHTXcv7TQXqWAU9q9H2b4te/KU8oKb/FH/rE+wt5Fq8Qesu9zMDNBCKrS7ihaCiZiP4qWOcrEep3Cc6FkpGKh7
 H+PJ+5CHQFva7cGjKhxLnG7lN+uE3LLuFF0O4NDLdLw0SMm4fO4GWT4rxcurPVM/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move the functions that check for empty messages from bulitin/commit.c
to sequencer.c so they can be shared with other commands. The
functions are refactored to take an explicit cleanup mode and template
filename passed by the caller.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 70 +++-----------------------------------------------------
 sequencer.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      | 10 ++++++++
 3 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 06ab495ae1d2baa5eef6b42eb61909883c681f4c..fab512b668af07a1fa927f713eca71c9f783b422 100644
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
@@ -983,65 +978,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1772,12 +1708,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 1eb2c4669d529485a045de66d6711039d19a2442..f4a04c913c0d60adbf78d68ca87db739c8e3a280 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -691,6 +691,66 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
index 6f3d3df82c0ade64b7b125acd49bf3f5e15c53af..65a4b0c25185d7ad5115035abb766d1b95df9a62 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -58,4 +58,14 @@ extern const char sign_off_header[];
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
2.14.3

