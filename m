From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 28/45] builtin-am: implement --[no-]scissors
Date: Tue,  4 Aug 2015 21:51:49 +0800
Message-ID: <1438696326-19590-29-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfi-0002iy-D9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbbHDNyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:15 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36785 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbbHDNyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:11 -0400
Received: by pacgq8 with SMTP id gq8so9181379pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paXQrVRTa2Fi6OX4fSa2LfzLAlXAiQAqR+cR72tWWrg=;
        b=R60EFhyIYMse6Gm8ZJE1X+RoIlIj4qrM9kP1kApHk29/T62+yAHtetGi3dqrZ3DdQg
         vHuEV3wZhCSHT4qGbBmOze9EvR7sk7SINwKmUJCo6wyWbX1tvUuFdBXpkyt5dDwB7eTL
         QnrDHugaO44PTt13drbgZ/C8o2UZs8mrBv4zVJW2N18UlWKPjpOSocJlwHMzU2leDYC/
         72aE4jlUpPYdNhHp7SUVoRg+FgnehjL8PjTsz2TGdtav4MZHHIBrbWKoiK56lnwnt35a
         z9jsp3cMKS5TSvP/MXA8uhOnJVwh8VGN6gvHdnBLX0C+/DFzf7MoB4XuWuSU5rxi4Z/N
         f3WQ==
X-Received: by 10.66.235.104 with SMTP id ul8mr8215383pac.33.1438696451141;
        Tue, 04 Aug 2015 06:54:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275294>

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
 builtin/am.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index e34bc51..727cfb8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -74,6 +74,12 @@ enum keep_type {
 	KEEP_NON_PATCH  /* pass -b flag to git-mailinfo */
 };
 
+enum scissors_type {
+	SCISSORS_UNSET = -1,
+	SCISSORS_FALSE = 0,  /* pass --no-scissors to git-mailinfo */
+	SCISSORS_TRUE        /* pass --scissors to git-mailinfo */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -99,6 +105,7 @@ struct am_state {
 	int utf8;
 	int keep; /* enum keep_type */
 	int message_id;
+	int scissors; /* enum scissors_type */
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -119,6 +126,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
+
+	state->scissors = SCISSORS_UNSET;
 }
 
 /**
@@ -394,6 +403,14 @@ static void am_load(struct am_state *state)
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
@@ -614,6 +631,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
@@ -798,6 +831,19 @@ static int parse_mail(struct am_state *state, const char *mail)
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
 
@@ -1551,6 +1597,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
 		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		OPT_BOOL('c', "scissors", &state.scissors,
+			N_("strip everything before a scissors line")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.280.gd88bd6e
