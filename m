From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 15/19] am: implement quiet option
Date: Thu, 11 Jun 2015 18:22:01 +0800
Message-ID: <1434018125-31804-16-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdi-00088k-DC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbbFKKXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:23:08 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35081 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbFKKW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:59 -0400
Received: by pdbnf5 with SMTP id nf5so1992115pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyRqcotE8W7vk64fj4/zsXW0KIh/+/3bQoJmOruvLt0=;
        b=ubHHwcXjYs2pEffq4n1DPRBr+QEad5SktxREbPcx8MnguBZxskijoQ3wwhTuZAKoKT
         B3d3LcJwjuu9E9iJYuTkjQySKTs/sLiXmBaaq6FlZjl1sYxYFh8ToslawN4CDFtgsMFu
         HHJ0K/pL9Vi/4eQnoDN5LjNqWdesGNueNIbaBv7UJsuuQXZAe+2PyisnUEsX0nZzF88k
         pTXXAD0c8qTghbTIrvg2PvNVptABTyyUiP9FRrngvRcH8U4hg13ttTJZUMXXLuy0z2+X
         eZGWPCezb3cehlEtd57cTjPMz8/erwPm9wsyuKsJHznd4Z3p/wM80tUVC5Qk+8E6DObh
         E6mQ==
X-Received: by 10.66.120.161 with SMTP id ld1mr13516948pab.73.1434018179273;
        Thu, 11 Jun 2015 03:22:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271396>

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
index cdc07ab..795b672 100644
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
@@ -83,6 +87,10 @@ static void am_state_init(struct am_state *state)
 	strbuf_init(&state->author_date, 0);
 	strbuf_init(&state->msg, 0);
 	state->prec = 4;
+
+	quiet = getenv("GIT_QUIET");
+	if (quiet && *quiet)
+		state->quiet = 1;
 }
 
 /**
@@ -106,6 +114,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
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
@@ -250,6 +274,9 @@ static void am_load(struct am_state *state)
 
 	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
 
+	read_state_file(&sb, am_path(state, "quiet"), 2, 1);
+	state->quiet = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -431,6 +458,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
 
+	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -644,7 +673,7 @@ static void do_commit(const struct am_state *state)
 		commit_list_insert(lookup_commit(parent), &parents);
 	} else {
 		ptr = NULL;
-		fprintf_ln(stderr, _("applying to an empty history"));
+		say(state, stderr, _("applying to an empty history"));
 	}
 
 	author = fmt_ident(state->author_name.buf, state->author_email.buf,
@@ -695,7 +724,7 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
 
-		printf_ln(_("Applying: %s"), firstline(state->msg.buf));
+		say(state, stdout, _("Applying: %s"), firstline(state->msg.buf));
 
 		if (run_apply(state) < 0) {
 			int value;
@@ -726,7 +755,7 @@ next:
  */
 static void am_resolve(struct am_state *state)
 {
-	printf_ln(_("Applying: %s"), firstline(state->msg.buf));
+	say(state, stdout, _("Applying: %s"), firstline(state->msg.buf));
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
@@ -949,6 +978,7 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_CMDMODE(0, "continue", &opt_resume,
-- 
2.1.4
