From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 28/31] am: pass git-apply's options to git-apply
Date: Thu, 18 Jun 2015 19:25:40 +0800
Message-ID: <1434626743-8552-29-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XzJ-0005sK-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbbFRL2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:28:00 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36335 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbbFRL10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:26 -0400
Received: by pdjm12 with SMTP id m12so64665026pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GVdk98LI2ScmorqOtS0UMbHfHJgR9EHLNeJn9kyu/fs=;
        b=O2b8bT7l6nUlHSo9zhIhmbB0o3wAfnZmef02P39xPajP5TYvTji7mtdWaOZiz5U1Fa
         4ESYwtzvBKRqtaafWapGey3jucWC2JnajRTedFYjSnPwIicxaSWJ84J48L9FH0d3MO6T
         mXOCH3d/zu3Fu+AgcciWxItSmpUxjYFhqNi+7aj3r0/ZG52feQanf7JWRjmtlPRl0US0
         TuD1SQagLFtBkgaWQKVESPoVG3vgFI4x6z+DtS7YbZH2owxWZFDUNJVcahVw8rXEwVTB
         p8TRaXatp5uBD5VcwpOgbrpJlEKroE8ZduJ+5DYL/74N4Qyqno+F0ZxO2fkcQkGUYooO
         d52Q==
X-Received: by 10.70.47.9 with SMTP id z9mr20506674pdm.69.1434626845952;
        Thu, 18 Jun 2015 04:27:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271995>

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

Re-implement support for these options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 42efce1..3556765 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -125,6 +125,8 @@ struct am_state {
 	/* one of the enum scissors_type values */
 	int scissors;
 
+	struct argv_array git_apply_opts;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -156,6 +158,8 @@ static void am_state_init(struct am_state *state)
 	git_config_get_bool("am.messageid", &state->message_id);
 
 	state->scissors = SCISSORS_UNSET;
+
+	argv_array_init(&state->git_apply_opts);
 }
 
 /**
@@ -168,6 +172,8 @@ static void am_state_release(struct am_state *state)
 	strbuf_release(&state->author_email);
 	strbuf_release(&state->author_date);
 	strbuf_release(&state->msg);
+
+	argv_array_clear(&state->git_apply_opts);
 }
 
 /**
@@ -377,6 +383,11 @@ static void am_load(struct am_state *state)
 	else
 		state->scissors = SCISSORS_UNSET;
 
+	read_state_file(&sb, am_path(state, "apply-opt"), 128, 1);
+	argv_array_clear(&state->git_apply_opts);
+	if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
+		die(_("could not parse %s"), am_path(state, "apply-opt"));
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -553,6 +564,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
+	struct strbuf sb = STRBUF_INIT;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -615,6 +627,10 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_file(am_path(state, "scissors"), 1, "%s", str);
 
+	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
+	write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
+	strbuf_release(&sb);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -977,6 +993,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	argv_array_push(&cp.args, "apply");
 
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+
 	if (index_file)
 		argv_array_push(&cp.args, "--cached");
 	else
@@ -1003,6 +1021,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 
 	cp.git_cmd = 1;
 	argv_array_push(&cp.args, "apply");
+	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
 	argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1459,8 +1478,35 @@ static struct option am_options[] = {
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
 	OPT_BOOL('c', "scissors", &state.scissors,
 		N_("strip everything before a scissors line")),
+	OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
+		N_("pass it through git-apply"),
+		0),
+	OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
+		N_("pass it through git-apply"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &state.git_apply_opts, NULL,
+		N_("pass it through git-apply"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU_ARGV(0, "directory", &state.git_apply_opts, N_("root"),
+		N_("pass it through git-apply"),
+		0),
+	OPT_PASSTHRU_ARGV(0, "exclude", &state.git_apply_opts, N_("path"),
+		N_("pass it through git-apply"),
+		0),
+	OPT_PASSTHRU_ARGV(0, "include", &state.git_apply_opts, N_("path"),
+		N_("pass it through git-apply"),
+		0),
+	OPT_PASSTHRU_ARGV('C', NULL, &state.git_apply_opts, N_("n"),
+		N_("pass it through git-apply"),
+		0),
+	OPT_PASSTHRU_ARGV('p', NULL, &state.git_apply_opts, N_("num"),
+		N_("pass it through git-apply"),
+		0),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
+	OPT_PASSTHRU_ARGV(0, "reject", &state.git_apply_opts, NULL,
+		N_("pass it through git-apply"),
+		PARSE_OPT_NOARG),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 		N_("override error message when patch failure occurs")),
 	OPT_CMDMODE(0, "continue", &opt_resume,
-- 
2.1.4
