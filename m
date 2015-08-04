From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 29/45] builtin-am: pass git-apply's options to git-apply
Date: Tue,  4 Aug 2015 21:51:50 +0800
Message-ID: <1438696326-19590-30-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:58:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMck3-0004yv-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934240AbbHDN6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:58:50 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36815 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbbHDNyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:13 -0400
Received: by pacgq8 with SMTP id gq8so9182116pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vsJUFFXb2HNNzFV+QWzIR9evsEXRREUveyW/TO8bflc=;
        b=YvOaegdZbUx0ZuQz5XF9YZXBE5VQwTGjDf9PH47OgtHTQcAuj7ncgmizr6fI3DYwl1
         N8VfCHZZGuAP4W4chZ2Am1573mypVyC5k2W0B3HOL5pV1CMJY9YcWgmpBqOGnSdUsZxV
         heug/flKqG005o/stia50VhlPM95T7T4C75+Vpq5oYXrNiJtuYc93V1hFfEGRZhWT38G
         HEYoq5lqf5kWedy1n+f6MYu2gmLNH1D9GH/chpncravQnTZx8LW9nC9xhc/1SWRKkd/w
         6U2DrSlhhvNzr052jX8Pg9L8SjSJgfLoLox9GyDbp0i9YlW9MQAb9IxxOyz2Ta+0NZ5l
         NLmg==
X-Received: by 10.66.160.1 with SMTP id xg1mr8037149pab.27.1438696453485;
        Tue, 04 Aug 2015 06:54:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275314>

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
 builtin/am.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 727cfb8..f842f69 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -106,6 +106,7 @@ struct am_state {
 	int keep; /* enum keep_type */
 	int message_id;
 	int scissors; /* enum scissors_type */
+	struct argv_array git_apply_opts;
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -128,6 +129,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	git_config_get_bool("am.messageid", &state->message_id);
 
 	state->scissors = SCISSORS_UNSET;
+
+	argv_array_init(&state->git_apply_opts);
 }
 
 /**
@@ -140,6 +143,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_email);
 	free(state->author_date);
 	free(state->msg);
+	argv_array_clear(&state->git_apply_opts);
 }
 
 /**
@@ -411,6 +415,11 @@ static void am_load(struct am_state *state)
 	else
 		state->scissors = SCISSORS_UNSET;
 
+	read_state_file(&sb, state, "apply-opt", 1);
+	argv_array_clear(&state->git_apply_opts);
+	if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
+		die(_("could not parse %s"), am_path(state, "apply-opt"));
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -585,6 +594,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
+	struct strbuf sb = STRBUF_INIT;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -647,6 +657,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "scissors"), 1, "%s", str);
 
+	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
+	write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -671,6 +684,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
+
+	strbuf_release(&sb);
 }
 
 /**
@@ -1058,6 +1073,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	argv_array_push(&cp.args, "apply");
 
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+
 	if (index_file)
 		argv_array_push(&cp.args, "--cached");
 	else
@@ -1084,6 +1101,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 
 	cp.git_cmd = 1;
 	argv_array_push(&cp.args, "apply");
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
 	argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1599,9 +1617,36 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
