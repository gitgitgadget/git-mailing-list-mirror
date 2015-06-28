From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 15/44] builtin-am: implement -q/--quiet, GIT_QUIET
Date: Sun, 28 Jun 2015 22:05:37 +0800
Message-ID: <1435500366-31700-16-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFd-0002FP-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbbF1OH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:58 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33416 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbbF1OHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:36 -0400
Received: by pdjn11 with SMTP id n11so101602087pdj.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FcVayDzapgwHJrJBnIcLt3t6ZMV7f3fHh1r7aRg7ElI=;
        b=VWVS9d8ZBB2096vMlZP24Gk93w29/hSyYoPt74zvZySNo+7RZCQZp/uB/Tem/D6w7j
         LKKVyae4IGNgqXGZdP7q43xSz7+iBHRoHzvlhsq/aXCD3NUaitjWjRXN35OzygKIPPS7
         Qlu65fy5ccULvEIdalRkREX5XU56YuuWd6U6GsGebfgQEP3ZVVgH7AznD40ipjFUYgz4
         nU0I1vJY43Y3kvy1tTAt92TUerRSKXUGTBZ/zJewg9/stxO/W+Sdyqjw7FZwQ+s0p7s+
         aIOQx5dT9yrRJlY7cjfZl73fM2rNV8Kjnv3tBUIdeDQhkTc8l/ixHIa6DQrMjXXSQ0qT
         SwQA==
X-Received: by 10.70.129.5 with SMTP id ns5mr22776935pdb.134.1435500455713;
        Sun, 28 Jun 2015 07:07:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272891>

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
index e066a97..2643b04 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -80,6 +80,8 @@ struct am_state {
 
 	/* number of digits in patch filename */
 	int prec;
+
+	int quiet;
 };
 
 /**
@@ -88,12 +90,18 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state, const char *dir)
 {
+	const char *quiet;
+
 	memset(state, 0, sizeof(*state));
 
 	assert(dir);
 	state->dir = xstrdup(dir);
 
 	state->prec = 4;
+
+	quiet = getenv("GIT_QUIET");
+	if (quiet && *quiet)
+		state->quiet = 1;
 }
 
 /**
@@ -128,6 +136,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
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
@@ -347,6 +371,9 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	read_state_file(&sb, state, "quiet", 1);
+	state->quiet = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -525,6 +552,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -778,7 +807,7 @@ static void do_commit(const struct am_state *state)
 		commit_list_insert(lookup_commit(parent), &parents);
 	} else {
 		ptr = NULL;
-		fprintf_ln(stderr, _("applying to an empty history"));
+		say(state, stderr, _("applying to an empty history"));
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
@@ -831,7 +860,7 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_commit_msg(state);
 
-		printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		if (run_apply(state) < 0) {
 			int advice_amworkdir = 1;
@@ -873,7 +902,7 @@ static void am_resolve(struct am_state *state)
 		die(_("cannot resume: %s does not exist."),
 			am_path(state, "author-script"));
 
-	printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
@@ -1105,6 +1134,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc0.76.gb2c6e93
