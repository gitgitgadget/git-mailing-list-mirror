From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 16/45] builtin-am: implement -q/--quiet
Date: Mon, 20 Jul 2015 00:10:08 +0800
Message-ID: <1437322237-29863-17-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBj-0006Gi-CG
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbGSQLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:32 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34318 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbGSQLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:30 -0400
Received: by pacan13 with SMTP id an13so89905030pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyJ3aSqqzY1GhAj6vdDzhs27sGj5s+Qot/hQxZ8mxfY=;
        b=d6XU84Whbha2yAklvTLnW2WNDt2NVWWoypUXURwMPZP371bcqjhrzZcLtVOE7lapN6
         Xai965Op6xVG5wqHk356mSOKGbYC3dg10OSWGFZzklCIAxZ9gdVp2RFa+GFWVAZ9oRhp
         561iWREuVcU3kw5Gmp8+A4THm67YOQFiJORcjoxbzQi6ajcoEX3n+bJrOrwDJsXgosrx
         hew1gzbtLSNKNKV6e7jST8c3xXdOW25HXAmB0qQuya0eVNQKoW8kNlBVtjbJ7/xXllmD
         pmmu+OG/3+F6Etvq8ECNvkHa+AxSApntLXklTdW8mHsEQcR8QeXGTs3LBAJ22Rrm6dbG
         /IEQ==
X-Received: by 10.70.43.72 with SMTP id u8mr49621224pdl.33.1437322289593;
        Sun, 19 Jul 2015 09:11:29 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274239>

Since 0e987a1 (am, rebase: teach quiet option, 2009-06-16), git-am
supported the --quiet option, and when told to be quiet, would only
speak on failure. Re-implement this by introducing the say() function,
which works like fprintf_ln(), but would only write to the stream when
state->quiet is false.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index fa522f5..e0b86d1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -80,6 +80,9 @@ struct am_state {
 
 	/* number of digits in patch filename */
 	int prec;
+
+	/* various operating modes and command line options */
+	int quiet;
 };
 
 /**
@@ -117,6 +120,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
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
@@ -330,6 +349,9 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	read_state_file(&sb, state, "quiet", 1);
+	state->quiet = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -508,6 +530,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -756,7 +780,7 @@ static void do_commit(const struct am_state *state)
 		commit_list_insert(lookup_commit(parent), &parents);
 	} else {
 		ptr = NULL;
-		fprintf_ln(stderr, _("applying to an empty history"));
+		say(state, stderr, _("applying to an empty history"));
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
@@ -833,7 +857,7 @@ static void am_run(struct am_state *state, int resume)
 			write_commit_msg(state);
 		}
 
-		printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		if (run_apply(state) < 0) {
 			int advice_amworkdir = 1;
@@ -869,7 +893,7 @@ static void am_resolve(struct am_state *state)
 {
 	validate_resume_state(state);
 
-	printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
@@ -1104,6 +1128,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
