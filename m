Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFD41F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbdKMRNj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:13:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbdKMRNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:13:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1A5DAAB9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:13:36 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Subject: [RFC 2/3] am: semi working --cover-at-tip
To:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Openpgp: preference=signencrypt
Message-ID: <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de>
Date:   Mon, 13 Nov 2017 18:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue with empty patch detection

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 builtin/am.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 17 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 92c485350..702cbf8e0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -111,6 +111,11 @@ struct am_state {
 	char *msg;
 	size_t msg_len;
 
+	/* Series metadata */
+	int series_id;
+	int series_len;
+	int cover_id;
+
 	/* when --rebasing, records the original commit the patch came from */
 	struct object_id orig_commit;
 
@@ -131,6 +136,8 @@ struct am_state {
 	int committer_date_is_author_date;
 	int ignore_date;
 	int allow_rerere_autoupdate;
+	int cover_at_tip;
+	int applying_cover;
 	const char *sign_commit;
 	int rebasing;
 };
@@ -160,6 +167,7 @@ static void am_state_init(struct am_state *state)
 
 	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
+
 }
 
 /**
@@ -432,6 +440,20 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "cover-at-tip", 1);
+	state->cover_at_tip = !strcmp(sb.buf, "t");
+
+	if (state->cover_at_tip) {
+		read_state_file(&sb, state, "series_id", 1);
+		state->series_id = strtol(sb.buf, NULL, 10);
+
+		read_state_file(&sb, state, "series_len", 1);
+		state->series_len = strtol(sb.buf, NULL, 10);
+
+		read_state_file(&sb, state, "cover_id", 1);
+		state->cover_id = strtol(sb.buf, NULL, 10);
+	}
+
 	if (file_exists(am_path(state, "rerere-autoupdate"))) {
 		read_state_file(&sb, state, "rerere-autoupdate", 1);
 		state->allow_rerere_autoupdate = strcmp(sb.buf, "t") ?
@@ -1020,6 +1042,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_state_bool(state, "quiet", state->quiet);
 	write_state_bool(state, "sign", state->signoff);
 	write_state_bool(state, "utf8", state->utf8);
+	write_state_bool(state, "cover-at-tip", state->cover_at_tip);
 
 	if (state->allow_rerere_autoupdate)
 		write_state_bool(state, "rerere-autoupdate",
@@ -1076,6 +1099,12 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 			delete_ref(NULL, "ORIG_HEAD", NULL, 0);
 	}
 
+	if (state->cover_at_tip) {
+		write_state_count(state, "series_id", state->series_id);
+		write_state_count(state, "series_len", state->series_len);
+		write_state_count(state, "cover_id", state->cover_id);
+	}
+
 	/*
 	 * NOTE: Since the "next" and "last" files determine if an am_state
 	 * session is in progress, they should be written last.
@@ -1088,13 +1117,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 }
 
 /**
- * Increments the patch pointer, and cleans am_state for the application of the
- * next patch.
- */
-static void am_next(struct am_state *state)
+ * Cleans am_state.
+ */static void am_clean(struct am_state *state)
 {
-	struct object_id head;
-
 	FREE_AND_NULL(state->author_name);
 	FREE_AND_NULL(state->author_email);
 	FREE_AND_NULL(state->author_date);
@@ -1106,14 +1131,6 @@ static void am_next(struct am_state *state)
 
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
-
-	if (!get_oid("HEAD", &head))
-		write_state_text(state, "abort-safety", oid_to_hex(&head));
-	else
-		write_state_text(state, "abort-safety", "");
-
-	state->cur++;
-	write_state_count(state, "next", state->cur);
 }
 
 /**
@@ -1274,6 +1291,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	fclose(mi.input);
 	fclose(mi.output);
 
+
 	/* Extract message and author information */
 	fp = xfopen(am_path(state, "info"), "r");
 	while (!strbuf_getline_lf(&sb, fp)) {
@@ -1298,9 +1316,30 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty."));
-		die_user_resolve(state);
+	if (!state->applying_cover) {
+
+		state->series_id = mi.series_id;
+		state->series_len = mi.series_len;
+
+		if (state->cover_at_tip) {
+			write_state_count(state, "series_id", state->series_id);
+			write_state_count(state, "series_len", state->series_len);
+			write_state_count(state, "cover_id", state->cover_id);
+		}
+
+		if (mi.series_id == 0){
+			state->cover_id = state->cur;
+			ret = 1;
+			goto finish;
+		}
+
+		if (is_empty_file(am_path(state, "patch"))) {
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+		} else if (state->cur == 1) {
+			/* First mail is not empty. cover-at-tip cannot apply */
+			state->cover_at_tip = 0;
+		}
 	}
 
 	strbuf_addstr(&msg, "\n\n");
@@ -1776,6 +1815,74 @@ static int do_interactive(struct am_state *state)
 	}
 }
 
+
+/**
+ * Apply the cover letter of a patch series
+ */
+static void do_apply_cover(struct am_state *state)
+{
+	int previous_cur = state->cur;
+	const char *mail;
+
+	am_clean(state);
+
+	state->cur = state->cover_id;
+	state->applying_cover = 1;
+	mail = am_path(state, msgnum(state));
+	if (!file_exists(mail))
+		die("BUG: cover has disapeared");
+
+	if(parse_mail(state, mail))
+		die("BUG: first patch is not a cover-letter");
+
+	if (state->signoff)
+		am_append_signoff(state);
+
+	write_author_script(state);
+	write_commit_msg(state);
+
+	if (state->interactive && do_interactive(state))
+		goto cancel_cover;
+
+	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
+
+	do_commit(state);
+ cancel_cover:
+	state->cur = previous_cur;
+	state->applying_cover = 0;
+
+	/* Reset series metadata */
+	state->series_len = 0;
+	state->series_id = 0;
+	state->cover_id = 0;
+}
+
+/**
+ * Increments the patch pointer, and cleans am_state for the application of the
+ * next patch.
+ */
+static void am_next(struct am_state *state)
+{
+	struct object_id head;
+
+	/* Flush the cover letter if needed */
+	if (state->cover_at_tip == 1 &&
+	    state->series_len > 0 &&
+	    state->series_id == state->series_len &&
+	    state->cover_id > 0)
+		do_apply_cover(state);
+
+	am_clean(state);
+
+	if (!get_oid("HEAD", &head))
+		write_state_text(state, "abort-safety", oid_to_hex(&head));
+	else
+		write_state_text(state, "abort-safety", "");
+
+	state->cur++;
+	write_state_count(state, "next", state->cur);
+}
+
 /**
  * Applies all queued mail.
  *
@@ -2287,6 +2394,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
+		OPT_BOOL(0, "cover-at-tip", &state.cover_at_tip,
+			N_("apply cover letter to the tip of the branch")),
 		OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
-- 
2.15.0.169.g3d3eebb67.dirty


