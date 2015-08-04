From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 16/45] builtin-am: implement -q/--quiet
Date: Tue,  4 Aug 2015 21:51:37 +0800
Message-ID: <1438696326-19590-17-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfN-0002W9-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbbHDNxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:41 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33027 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964870AbbHDNxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:37 -0400
Received: by padck2 with SMTP id ck2so9383909pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FrY5NDaiTfPHfxfTldRCZKjzY5Zo8CeITiMGqZ2rqjk=;
        b=UPR0Afk/74d/SVZ6fl05OOcZGWM4W0eDaM7Qqz2qadfw+Ty4XBpm8kqe6CGv9vUJP3
         CNXTwUuWEvrjAJB7JdZm1z4VZ5LINqb2pgbfwraG9HFkOkzF3Ir2KYmZm5a2q1MGDQhQ
         f04LSySbL4DFzTMStg1YCJfNvbRKJnPSU2QK/E8/glEowvQwsPTF2SkAQYGXW05py+0b
         KlQO7s3cp8Fj5VmJZlMTuChTDp0dLlV1T74p5pEEg4aN1RZbWbfdgdWpfWvq6ZJfruYM
         3bLkba4Wun2i/Ql1Htr18lN/Yp8NuevMcRUg8rRndUj0rjexPY+3NMrIqxok28r+NgQj
         aArQ==
X-Received: by 10.68.168.161 with SMTP id zx1mr8157738pbb.35.1438696417533;
        Tue, 04 Aug 2015 06:53:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275292>

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
index d4b4b86..0875e69 100644
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
@@ -1105,6 +1129,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.280.gd88bd6e
