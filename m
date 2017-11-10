Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3F11F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdKJLKN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:13 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:36341 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbdKJLKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:06 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CGeDJl1; Fri, 10 Nov 2017 11:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312205;
        bh=FGyhcr/zHqgKn+STOXC0nmK5rfu7+x74diKosIVcVDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Vqklit0DFvpkMIf0UvLTDhtsSAsvaxn0c5eBAVWzwnPYWqhWT9ZqSWcNERtpG4mD0
         0xbh+qw4YS8pGO/B2kirJRIkmXAWz5Pm7Kpu+zkGht9yC+wSxqB6w4d+RR7h9dbI6y
         FwbJX8kSqHxz4n3jxJoDcqA6eSnP2MG4YXQYGgRk=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=gmYsS5rWCjj2l-UK0YYA:9
 a=MYcFLkyzOMbnKKlA:21 a=zFrQdP-yZpiLN47d:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/9] commit: move empty message checks to libgit
Date:   Fri, 10 Nov 2017 11:09:42 +0000
Message-Id: <20171110110949.328-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfC7HBmRWvkUeHbcT6KjewOYTLBXEFPfqk8uESRrhpaAvj7kpw/CAn+wngYGUx/uG9EZrOaI/jYM/23wg8b4aFPo0w5LDNMDhyZDrs4fEcTnPlJTNJ1WH
 391NYMYUE1q4esN2a7hTPvnEBmRVVKxhVHwMr8uMXJ7oTZikN5/tYnk+XUSj9Y5sOiwozTOXplr6nJFmj1/iwhJzXVE3gkIDYdSvyXNcTgFLVouQLz4y4/Vc
 zoWlHpjpVkbNKum/d0yADhHRqnaX4MGeBlm3zT6msbccRh+/iQmfcyAQaiZs4n1V
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

Notes:
    changes since v1:
     - prefix cleanup_mode enum and constants with commit_msg_

 builtin/commit.c | 99 +++++++++++---------------------------------------------
 sequencer.c      | 61 ++++++++++++++++++++++++++++++++++
 sequencer.h      | 11 +++++++
 3 files changed, 91 insertions(+), 80 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 605ea8c0e9663726c64950dba07afe21516c9b26..dbc160c525e7a9249b7c7df2180495a4c7102296 100644
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
+static enum commit_msg_cleanup_mode cleanup_mode;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
@@ -673,7 +668,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
-	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
+	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 
 	/* This checks and barfs if author is badly specified */
@@ -812,7 +807,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -832,14 +827,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 
 		fprintf(s->fp, "\n");
-		if (cleanup_mode == CLEANUP_ALL)
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == CLEANUP_SCISSORS && whence == FROM_COMMIT)
+		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+			 whence == FROM_COMMIT)
 			wt_status_add_cut_line(s->fp);
-		else /* CLEANUP_SPACE, that is. */
+		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\n"
@@ -984,65 +980,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1214,15 +1151,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
+		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_ALL :
+					    COMMIT_MSG_CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = CLEANUP_NONE;
+		cleanup_mode = COMMIT_MSG_CLEANUP_NONE;
 	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = CLEANUP_SPACE;
+		cleanup_mode = COMMIT_MSG_CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = CLEANUP_ALL;
+		cleanup_mode = COMMIT_MSG_CLEANUP_ALL;
 	else if (!strcmp(cleanup_arg, "scissors"))
-		cleanup_mode = use_editor ? CLEANUP_SCISSORS : CLEANUP_SPACE;
+		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
+					    COMMIT_MSG_CLEANUP_SPACE;
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
@@ -1749,17 +1688,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == CLEANUP_SCISSORS)
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
 
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
index 6d027b06c8d8dc69b14d05752637a65aa121ab24..23c250f16cfb7620215bb9c99b8e12d726dc9191 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -691,6 +691,67 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
+int message_is_empty(const struct strbuf *sb,
+		     enum commit_msg_cleanup_mode cleanup_mode)
+{
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_NONE && sb->len)
+		return 0;
+	return rest_is_empty(sb, 0);
+}
+
+/*
+ * See if the user edited the message in the editor or left what
+ * was in the template intact
+ */
+int template_untouched(const struct strbuf *sb, const char *template_file,
+		       enum commit_msg_cleanup_mode cleanup_mode)
+{
+	struct strbuf tmpl = STRBUF_INIT;
+	const char *start;
+
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_NONE && sb->len)
+		return 0;
+
+	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
+		return 0;
+
+	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
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
index 6f3d3df82c0ade64b7b125acd49bf3f5e15c53af..82e57713a2940c5d65ccac013c3f42c55cc12baf 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -58,4 +58,15 @@ extern const char sign_off_header[];
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
 
+enum commit_msg_cleanup_mode {
+	COMMIT_MSG_CLEANUP_SPACE,
+	COMMIT_MSG_CLEANUP_NONE,
+	COMMIT_MSG_CLEANUP_SCISSORS,
+	COMMIT_MSG_CLEANUP_ALL
+};
+
+int message_is_empty(const struct strbuf *sb,
+		     enum commit_msg_cleanup_mode cleanup_mode);
+int template_untouched(const struct strbuf *sb, const char *template_file,
+		       enum commit_msg_cleanup_mode cleanup_mode);
 #endif
-- 
2.15.0

