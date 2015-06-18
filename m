From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 16/31] am: implement quiet option
Date: Thu, 18 Jun 2015 19:25:28 +0800
Message-ID: <1434626743-8552-17-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyU-0005FU-O8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbbFRL1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:09 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34087 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbbFRL04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:56 -0400
Received: by pabvl15 with SMTP id vl15so13421801pab.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EyX+wHKHjSAk9cNaWCviyDIn+QJkN+2m5dPS8dxL++M=;
        b=ysgAMKbJ0Asd0GyGeRCFCHkytiNFNbNN63xDqFuxTfzLBcC9GkxC4MoGUd72mKcTHI
         eMzPDRvOXMbSv+FK9fa5hLKfqXovNysPS8LIOJMZ2Am8XG/Pbjqez17+k8CGbIATbC+f
         MJDD/BPpLDtN5TZNl3E1Pa7Wh41ywbPgC/E0/N/4UZXRcsjXSS/LB0pa2zgoBkpqpD8w
         3WzJ/mj4NKNGxmFtpQXzVqHouN9p9LAmjg6UUU25uztMDv94U97Ym6rPk4sB1oFwWYdC
         UTaT+wC9sjGhg85Rk8rFDu9ZKFEe9kw7OaREu7lDWPYQpIrf4Me30t1TnX1B6BSwSvWu
         3BVA==
X-Received: by 10.68.252.38 with SMTP id zp6mr20435121pbc.159.1434626815377;
        Thu, 18 Jun 2015 04:26:55 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:54 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271981>

Since 0e987a1 (am, rebase: teach quiet option, 2009-06-16), git-am
supported the --quiet option and GIT_QUIET environment variable, and
when told to be quiet, would only speak on failure. Re-implement this by
introducing the say() function, which works like fprintf_ln(), but would
only write to the stream when state->quiet is false.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4adc487..5f38264 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -68,6 +68,8 @@ struct am_state {
 
 	/* number of digits in patch filename */
 	int prec;
+
+	int quiet;
 };
 
 /**
@@ -75,6 +77,8 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state)
 {
+	const char *quiet;
+
 	memset(state, 0, sizeof(*state));
 
 	strbuf_init(&state->dir, 0);
@@ -85,6 +89,10 @@ static void am_state_init(struct am_state *state)
 	strbuf_init(&state->msg, 0);
 
 	state->prec = 4;
+
+	quiet = getenv("GIT_QUIET");
+	if (quiet && *quiet)
+		state->quiet = 1;
 }
 
 /**
@@ -108,6 +116,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
 }
 
 /**
+ * If state->quiet is false, calls fprintf(fp, fmt, ...), and appends a newline
+ * at the end.
+ */
+static void say(const struct am_state *state, FILE *fp, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	if (!state->quiet) {
+		vfprintf(fp, fmt, ap);
+		putc('\n', fp);
+	}
+	va_end(ap);
+}
+
+/**
  * Returns 1 if there is an am session in progress, 0 otherwise.
  */
 static int am_in_progress(const struct am_state *state)
@@ -262,6 +286,9 @@ static void am_load(struct am_state *state)
 
 	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
 
+	read_state_file(&sb, am_path(state, "quiet"), 2, 1);
+	state->quiet = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -445,6 +472,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
 
+	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -654,7 +683,7 @@ static void do_commit(const struct am_state *state)
 		commit_list_insert(lookup_commit(parent), &parents);
 	} else {
 		ptr = NULL;
-		fprintf_ln(stderr, _("applying to an empty history"));
+		say(state, stderr, _("applying to an empty history"));
 	}
 
 	author = fmt_ident(state->author_name.buf, state->author_email.buf,
@@ -705,7 +734,7 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
 
-		printf_ln(_("Applying: %s"), firstline(state->msg.buf));
+		say(state, stdout, _("Applying: %s"), firstline(state->msg.buf));
 
 		if (run_apply(state) < 0) {
 			int value;
@@ -736,7 +765,7 @@ next:
  */
 static void am_resolve(struct am_state *state)
 {
-	printf_ln(_("Applying: %s"), firstline(state->msg.buf));
+	say(state, stdout, _("Applying: %s"), firstline(state->msg.buf));
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
@@ -959,6 +988,7 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_CMDMODE(0, "continue", &opt_resume,
-- 
2.1.4
