From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 28/44] builtin-am: pass git-apply's options to git-apply
Date: Sun, 28 Jun 2015 22:05:50 +0800
Message-ID: <1435500366-31700-29-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGI-0002jO-Jk
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbF1OIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33966 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbbF1OIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:13 -0400
Received: by pabvl15 with SMTP id vl15so91971173pab.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFkeKwJus1lvEPIO1vwMWbUXDKKWT9nwbBGQ7dyk+Fs=;
        b=0nHc0WOKC6zyYN428F/jo9NZ8Qpq4CSocISTIdCxlvmcO+Qtgq3qTEdNsjFJP37TyN
         /6MaRypVIddMeOQMAkp1/zK69Y/JbXz/bhTtswK7o8Anf6cAqIXHdy5v6V9ozUR6ubXi
         AJfx7NHNluc4ESggShyLW7lyHjWR20Jb/ZwdemUTkqhNszoz/dXM1r/Ci29WZniUFAPJ
         zwCWcLw+CuwRKdgCNrjA1S7rJqGiP+OYYFw0v2ndw8/teKzGcS5cpaHtY9QhnRhKd1q5
         gSMcHinJTT98EkrmfJVnojrghvzha02aJIOPNuM7Z0dcnYA1pQr21fqz5HJRZ2YZklD0
         Lh2A==
X-Received: by 10.66.65.204 with SMTP id z12mr22617845pas.2.1435500493301;
        Sun, 28 Jun 2015 07:08:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272903>

git-am.sh recognizes some of git-apply's options, and would pass them to
git-apply:

* --whitespace, since 8c31cb8 (git-am: --whitespace=x option.,
  2006-02-28)

* -C, since 67dad68 (add -C[NUM] to git-am, 2007-02-08)

* -p, since 2092a1f (Teach git-am to pass -p option down to git-apply,
  2007-02-11)

* --directory, since b47dfe9 (git-am: add --directory=<dir> option,
  2009-01-11)

* --reject, since b80da42 (git-am: implement --reject option passed to
  git-apply, 2009-01-23)

* --ignore-space-change, --ignore-whitespace, since 86c91f9 (git apply:
  option to ignore whitespace differences, 2009-08-04)

* --exclude, since 77e9e49 (am: pass exclude down to apply, 2011-08-03)

* --include, since 58725ef (am: support --include option, 2012-03-28)

* --reject, since b80da42 (git-am: implement --reject option passed to
  git-apply, 2009-01-23)

Re-implement support for these options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 55989e5..5aab627 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -115,6 +115,8 @@ struct am_state {
 	/* one of the enum scissors_type values */
 	int scissors;
 
+	struct argv_array git_apply_opts;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -147,6 +149,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	git_config_get_bool("am.messageid", &state->message_id);
 
 	state->scissors = SCISSORS_UNSET;
+
+	argv_array_init(&state->git_apply_opts);
 }
 
 /**
@@ -168,6 +172,8 @@ static void am_state_release(struct am_state *state)
 
 	if (state->msg)
 		free(state->msg);
+
+	argv_array_clear(&state->git_apply_opts);
 }
 
 /**
@@ -447,6 +453,11 @@ static void am_load(struct am_state *state)
 	else
 		state->scissors = SCISSORS_UNSET;
 
+	read_state_file(&sb, state, "apply-opt", 1);
+	argv_array_clear(&state->git_apply_opts);
+	if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
+		die(_("could not parse %s"), am_path(state, "apply-opt"));
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -621,6 +632,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
+	struct strbuf sb = STRBUF_INIT;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -683,6 +695,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "scissors"), 1, "%s", str);
 
+	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
+	write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -707,6 +722,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
+
+	strbuf_release(&sb);
 }
 
 /**
@@ -1099,6 +1116,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	argv_array_push(&cp.args, "apply");
 
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+
 	if (index_file)
 		argv_array_push(&cp.args, "--cached");
 	else
@@ -1125,6 +1144,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 
 	cp.git_cmd = 1;
 	argv_array_push(&cp.args, "apply");
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
 	argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1616,9 +1636,36 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
+			N_("pass it through git-apply"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
+			N_("pass it through git-apply"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &state.git_apply_opts, NULL,
+			N_("pass it through git-apply"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "directory", &state.git_apply_opts, N_("root"),
+			N_("pass it through git-apply"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "exclude", &state.git_apply_opts, N_("path"),
+			N_("pass it through git-apply"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "include", &state.git_apply_opts, N_("path"),
+			N_("pass it through git-apply"),
+			0),
+		OPT_PASSTHRU_ARGV('C', NULL, &state.git_apply_opts, N_("n"),
+			N_("pass it through git-apply"),
+			0),
+		OPT_PASSTHRU_ARGV('p', NULL, &state.git_apply_opts, N_("num"),
+			N_("pass it through git-apply"),
+			0),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
+		OPT_PASSTHRU_ARGV(0, "reject", &state.git_apply_opts, NULL,
+			N_("pass it through git-apply"),
+			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
 		OPT_CMDMODE(0, "continue", &resume,
-- 
2.5.0.rc0.76.gb2c6e93
