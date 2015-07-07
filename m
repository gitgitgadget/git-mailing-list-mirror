From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 15/44] builtin-am: implement -q/--quiet
Date: Tue,  7 Jul 2015 22:20:33 +0800
Message-ID: <1436278862-2638-16-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlb-0004dj-IV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbbGGOWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:31 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34992 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbbGGOV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:59 -0400
Received: by pdbci14 with SMTP id ci14so126702282pdb.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KtI5l4rghMFEhOMMy9YdElIEUkZxJ6EBZjROU2tUqpY=;
        b=vGvW172+VLFxeChvn8mrBn8PA3rLsMASJZxsnOceFFHyN8QxkCmU81RG5XWu/XvMAz
         Ar7oZd/B2UoBSwvd4uPWWUNrM3mxWbhGj6Gwh0of1y4V6CxtIrDjZipoVupAcGCWAzSo
         sWHJ5QF57s3KSm1oMmx5KNW0L9etswRVit6ejCYhEAMg7d01aetOAzrVJKPcsL8Hdz1t
         ihZVYo0dZNLHuId/1G6lcTdaNGJgWfnVpJ6YkXHWI9cPSvfkCdaEbgXYeYeXHbuRpz2p
         abuIURehLWYewml2pJNdgZ1lhkdgq6DgYOii6pGeqj3ILrsTsutOmSigmODTt0uRrOXM
         l5YQ==
X-Received: by 10.69.10.196 with SMTP id ec4mr9505043pbd.69.1436278919066;
        Tue, 07 Jul 2015 07:21:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273533>

Since 0e987a1 (am, rebase: teach quiet option, 2009-06-16), git-am
supported the --quiet option, and when told to be quiet, would only
speak on failure. Re-implement this by introducing the say() function,
which works like fprintf_ln(), but would only write to the stream when
state->quiet is false.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v5
    
    * Removed GIT_QUIET environment variable, as it turns out
      git-sh-setup.sh will reset it, which means the user's environment
      cannot affect it.

 builtin/am.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e066a97..61c2ad3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -80,6 +80,8 @@ struct am_state {
 
 	/* number of digits in patch filename */
 	int prec;
+
+	int quiet;
 };
 
 /**
@@ -128,6 +130,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
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
@@ -347,6 +365,9 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	read_state_file(&sb, state, "quiet", 1);
+	state->quiet = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -525,6 +546,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -778,7 +801,7 @@ static void do_commit(const struct am_state *state)
 		commit_list_insert(lookup_commit(parent), &parents);
 	} else {
 		ptr = NULL;
-		fprintf_ln(stderr, _("applying to an empty history"));
+		say(state, stderr, _("applying to an empty history"));
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
@@ -831,7 +854,7 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_commit_msg(state);
 
-		printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		if (run_apply(state) < 0) {
 			int advice_amworkdir = 1;
@@ -873,7 +896,7 @@ static void am_resolve(struct am_state *state)
 		die(_("cannot resume: %s does not exist."),
 			am_path(state, "author-script"));
 
-	printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
@@ -1105,6 +1128,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	};
 
 	struct option options[] = {
+		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
