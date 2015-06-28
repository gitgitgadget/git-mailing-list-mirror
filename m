From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 27/44] builtin-am: implement --[no-]scissors
Date: Sun, 28 Jun 2015 22:05:49 +0800
Message-ID: <1435500366-31700-28-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGE-0002gE-KA
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbbF1OIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35224 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbF1OIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:11 -0400
Received: by pactm7 with SMTP id tm7so91496405pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGzE71LuKwkpHkL0bI7NmmF9m2U3DDwpJukBFBnOtBo=;
        b=bvGUu8LXmOFj/wa1Pl6WzeeEIviMwXzzY3JNKxOjym/3/EAoPoEcBMMyoXF9arpPVc
         JoY/eK+FAO7KZPvN99Dhz3N+Z00tPHcgit0Hhww/cuoG8HnvjCahR0AQqIu4PoHfjH/4
         9ei9mvaGihVKpbbonW0+VlVcab1F7e328Fe5q753xIPWcXoOV1VQCII2kdWWzqOXuLMk
         qmbv62ukZnRpE7uV1/y6Knepspu9q0r/RISJV6UixkhE5nimQNajllj1P+uyxkZaRUeL
         /HqXuqCa33O1GcNKQZN/pK/kZZn3YUT2VPTqJIfz0GymVw3nQwMaHAefIa9LQZnVYquP
         pE+Q==
X-Received: by 10.66.136.78 with SMTP id py14mr22466745pab.1.1435500490548;
        Sun, 28 Jun 2015 07:08:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272902>

Since 017678b (am/mailinfo: Disable scissors processing by default,
2009-08-26), git-am supported the --[no-]scissors option, passing it to
git-mailinfo.

Re-implement support for this option in builtin/am.c.

Since the default setting of --scissors in git-mailinfo can be
configured with mailinfo.scissors (and perhaps through other settings in
the future), to be safe we make an explicit distinction between
SCISSORS_UNSET, SCISSORS_TRUE and SCISSORS_FALSE.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    There are tests for mailinfo --scissors, but not am --scissors, or
    mailinfo.scissors.

 builtin/am.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 2387726..55989e5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -74,6 +74,12 @@ enum keep_type {
 	KEEP_NON_PATCH  /* pass -b flag to git-mailinfo */
 };
 
+enum scissors_type {
+	SCISSORS_UNSET = -1,
+	SCISSORS_TRUE,  /* pass --scissors to git-mailinfo */
+	SCISSORS_FALSE  /* pass --no-scissors to git-mailinfo */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -106,6 +112,9 @@ struct am_state {
 	/* pass -m flag to git-mailinfo */
 	int message_id;
 
+	/* one of the enum scissors_type values */
+	int scissors;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -136,6 +145,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
+
+	state->scissors = SCISSORS_UNSET;
 }
 
 /**
@@ -428,6 +439,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "messageid", 1);
 	state->message_id = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "scissors", 1);
+	if (!strcmp(sb.buf, "t"))
+		state->scissors = SCISSORS_TRUE;
+	else if (!strcmp(sb.buf, "f"))
+		state->scissors = SCISSORS_FALSE;
+	else
+		state->scissors = SCISSORS_UNSET;
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -648,6 +667,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
 
+	switch (state->scissors) {
+	case SCISSORS_UNSET:
+		str = "";
+		break;
+	case SCISSORS_FALSE:
+		str = "f";
+		break;
+	case SCISSORS_TRUE:
+		str = "t";
+		break;
+	default:
+		die("BUG: invalid value for state->scissors");
+	}
+
+	write_file(am_path(state, "scissors"), 1, "%s", str);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -837,6 +872,19 @@ static int parse_mail(struct am_state *state, const char *mail)
 	if (state->message_id)
 		argv_array_push(&cp.args, "-m");
 
+	switch (state->scissors) {
+	case SCISSORS_UNSET:
+		break;
+	case SCISSORS_FALSE:
+		argv_array_push(&cp.args, "--no-scissors");
+		break;
+	case SCISSORS_TRUE:
+		argv_array_push(&cp.args, "--scissors");
+		break;
+	default:
+		die("BUG: invalid value for state->scissors");
+	}
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1566,6 +1614,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
 		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		OPT_BOOL('c', "scissors", &state.scissors,
+			N_("strip everything before a scissors line")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc0.76.gb2c6e93
