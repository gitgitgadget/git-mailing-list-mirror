Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20F520756
	for <e@80x24.org>; Thu, 12 Jan 2017 07:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdALHXP (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 02:23:15 -0500
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:60246
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdALHXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 02:23:14 -0500
Received: from linuxonhyperv.com ([72.167.245.219])
        by : HOSTING RELAY : with SMTP
        id RZi8cbphYCBxwRZi8cU4Md; Thu, 12 Jan 2017 00:22:13 -0700
x-originating-ip: 72.167.245.219
Received: by linuxonhyperv.com (Postfix, from userid 528)
        id 73ED71900F6; Thu, 12 Jan 2017 01:20:43 -0800 (PST)
From:   Matthew Wilcox <mawilcox@linuxonhyperv.com>
To:     git@vger.kernel.org
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] mailinfo: Add support for keep_cr
Date:   Thu, 12 Jan 2017 01:20:23 -0800
Message-Id: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
X-Mailer: git-send-email 1.7.4.1
X-CMAE-Envelope: MS4wfP3HXfXcY+Pq2zwmNqrQCl7wzfe48mK3fwLt9scxq0nnfwpJNZGetK/skuaiAp5NM9S7C5mtEvT//h/YI+dLcgePAH3oGlNEahn/sHRGh1xJgZLLFbNB
 ZAsvpMUM26L68VyWkDvpemhW3dGlSY02BWnNLC1IgVg75oaHNZEcvzpKJ6PzhWIlsiZKk/rRIxuNhptPkKKofCrn//1Xqmhv+N9UXb1YpudVXG4iTEeb1KuP
 4XHQ8dWtG7DL81g0SadtYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

If you have a base-64 encoded patch with CRLF endings (as produced
by forwarding a patch from Outlook to a Linux machine, for example),
the keep_cr setting is not honoured because keep_cr is only passed
to mailsplit, which does not look through the encoding.  The keep_cr
logic needs to be applied after the base64 decode.  I copied that
logic to handle_filter(), and rather than add a new keep_cr parameter
to handle_filter, I opted to add keep_cr to struct mailinfo; it seemed
appropriate given use_scissors was already there.

Then I needed to initialise keep_cr in the struct mailinfo passed from
git-am, and rather than thread a 'keep_cr' parameter all the way through
to parse_mail(), I decided to add keep_cr to struct am_state, which let
it be removed as a parameter from five other functions.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 builtin/am.c | 49 ++++++++++++++++++++++++-------------------------
 mailinfo.c   |  6 ++++++
 mailinfo.h   |  1 +
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 31fb60578..6cb6e6ca8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -124,6 +124,7 @@ struct am_state {
 	int keep; /* enum keep_type */
 	int message_id;
 	int scissors; /* enum scissors_type */
+	int keep_cr;
 	struct argv_array git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -143,6 +144,7 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	memset(state, 0, sizeof(*state));
 
+	state->keep_cr = -1;
 	assert(dir);
 	state->dir = xstrdup(dir);
 
@@ -697,7 +699,7 @@ static int detect_patch_format(const char **paths)
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
 static int split_mail_mbox(struct am_state *state, const char **paths,
-				int keep_cr, int mboxrd)
+				int mboxrd)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
@@ -707,7 +709,7 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
 	argv_array_pushf(&cp.args, "-d%d", state->prec);
 	argv_array_pushf(&cp.args, "-o%s", state->dir);
 	argv_array_push(&cp.args, "-b");
-	if (keep_cr)
+	if (state->keep_cr)
 		argv_array_push(&cp.args, "--keep-cr");
 	if (mboxrd)
 		argv_array_push(&cp.args, "--mboxrd");
@@ -737,7 +739,7 @@ typedef int (*mail_conv_fn)(FILE *out, FILE *in, int keep_cr);
  * Returns 0 on success, -1 on failure.
  */
 static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
-			const char **paths, int keep_cr)
+			const char **paths)
 {
 	static const char *stdin_only[] = {"-", NULL};
 	int i;
@@ -766,7 +768,7 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
 			return error_errno(_("could not open '%s' for writing"),
 					   mail);
 
-		ret = fn(out, in, keep_cr);
+		ret = fn(out, in, state->keep_cr);
 
 		fclose(out);
 		fclose(in);
@@ -826,8 +828,7 @@ static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
  *
  * Returns 0 on success, -1 on failure.
  */
-static int split_mail_stgit_series(struct am_state *state, const char **paths,
-					int keep_cr)
+static int split_mail_stgit_series(struct am_state *state, const char **paths)
 {
 	const char *series_dir;
 	char *series_dir_buf;
@@ -857,7 +858,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	strbuf_release(&sb);
 	free(series_dir_buf);
 
-	ret = split_mail_conv(stgit_patch_to_mail, state, patches.argv, keep_cr);
+	ret = split_mail_conv(stgit_patch_to_mail, state, patches.argv);
 
 	argv_array_clear(&patches);
 	return ret;
@@ -937,30 +938,27 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
  * state->cur will be set to the index of the first mail, and state->last will
  * be set to the index of the last mail.
  *
- * Set keep_cr to 0 to convert all lines ending with \r\n to end with \n, 1
- * to disable this behavior, -1 to use the default configured setting.
- *
  * Returns 0 on success, -1 on failure.
  */
 static int split_mail(struct am_state *state, enum patch_format patch_format,
-			const char **paths, int keep_cr)
+			const char **paths)
 {
-	if (keep_cr < 0) {
-		keep_cr = 0;
-		git_config_get_bool("am.keepcr", &keep_cr);
+	if (state->keep_cr < 0) {
+		state->keep_cr = 0;
+		git_config_get_bool("am.keepcr", &state->keep_cr);
 	}
 
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
-		return split_mail_mbox(state, paths, keep_cr, 0);
+		return split_mail_mbox(state, paths, 0);
 	case PATCH_FORMAT_STGIT:
-		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
+		return split_mail_conv(stgit_patch_to_mail, state, paths);
 	case PATCH_FORMAT_STGIT_SERIES:
-		return split_mail_stgit_series(state, paths, keep_cr);
+		return split_mail_stgit_series(state, paths);
 	case PATCH_FORMAT_HG:
-		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
+		return split_mail_conv(hg_patch_to_mail, state, paths);
 	case PATCH_FORMAT_MBOXRD:
-		return split_mail_mbox(state, paths, keep_cr, 1);
+		return split_mail_mbox(state, paths, 1);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -971,7 +969,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
  * Setup a new am session for applying patches
  */
 static void am_setup(struct am_state *state, enum patch_format patch_format,
-			const char **paths, int keep_cr)
+			const char **paths)
 {
 	struct object_id curr_head;
 	const char *str;
@@ -988,7 +986,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
-	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
+	if (split_mail(state, patch_format, paths) < 0) {
 		am_destroy(state);
 		die(_("Failed to split patches."));
 	}
@@ -1276,6 +1274,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->scissors");
 	}
 
+	mi.keep_cr = state->keep_cr;
+
 	mi.input = fopen(mail, "r");
 	if (!mi.input)
 		die("could not open input");
@@ -2224,7 +2224,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
 	int binary = -1;
-	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 	int in_progress;
@@ -2254,10 +2253,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_BOOL('m', "message-id", &state.message_id,
 			N_("pass -m flag to git-mailinfo")),
-		{ OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
+		{ OPTION_SET_INT, 0, "keep-cr", &state.keep_cr, NULL,
 		  N_("pass --keep-cr flag to git-mailsplit for mbox format"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
-		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
+		{ OPTION_SET_INT, 0, "no-keep-cr", &state.keep_cr, NULL,
 		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
 		OPT_BOOL('c', "scissors", &state.scissors,
@@ -2392,7 +2391,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		am_setup(&state, patch_format, paths.argv, keep_cr);
+		am_setup(&state, patch_format, paths.argv);
 
 		argv_array_clear(&paths);
 	}
diff --git a/mailinfo.c b/mailinfo.c
index a489d9d0f..2059704a8 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -812,6 +812,12 @@ static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 
 static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 {
+	if (!mi->keep_cr && line->len > 1 &&
+			line->buf[line->len - 1] == '\n' &&
+			line->buf[line->len - 2] == '\r') {
+		strbuf_setlen(line, line->len - 2);
+		strbuf_addch(line, '\n');
+	}
 	switch (mi->filter_stage) {
 	case 0:
 		if (!handle_commit_msg(mi, line))
diff --git a/mailinfo.h b/mailinfo.h
index 04a25351d..9fddcf684 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -12,6 +12,7 @@ struct mailinfo {
 	struct strbuf email;
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
+	int keep_cr;
 	int add_message_id;
 	int use_scissors;
 	int use_inbody_headers;
-- 
2.11.0

