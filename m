From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 27/44] builtin-am: implement --[no-]scissors
Date: Tue,  7 Jul 2015 22:20:45 +0800
Message-ID: <1436278862-2638-28-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTly-0004qP-0o
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750AbbGGOWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:52 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34359 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757708AbbGGOWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:31 -0400
Received: by pdbep18 with SMTP id ep18so126728043pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cyXNYmvYs61Ta4i6ElMCnqlvlrInRMPaNuBzh/ulx24=;
        b=otk+vftE/g7Bd/Y26LJ1gBbnfL6oBmdHX6AA0EI0bWTbAF9T53ex6sv1kn+7jESZ2R
         GWHoXPTbpXgmXoD9pwSbR5CG3ZTTr0jCNuKi4iKXhpMIsfL7IH8YWOUWCncRlpC2Gsu1
         UJLaQUr9IFF+RkgmSXmbl563oKE93WpugmEY0zxVV0gmb3LZKyU807Ap8vdSWJ/q+afM
         kcaTTAStZAokE3xX/3pyl0Me7F35af1uBm+ruXrmm8wc7VG6SX0gJDAFHsCTkTq/6cVW
         XtbPd9McZk9aJOwx4hhgg3P998LnucGli6/+6EBzdhXWNvHWp6cYmOaRaomFkv+dQxIq
         MmhQ==
X-Received: by 10.68.191.229 with SMTP id hb5mr9446727pbc.126.1436278951282;
        Tue, 07 Jul 2015 07:22:31 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273537>

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
    v5
    
    * Previously, SCISSORS_FALSE was 1 while SCISSORS_TRUE was 0. This
      should be the other way around.

 builtin/am.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 59a7a2a..2e46a06 100644
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
@@ -106,6 +112,9 @@ struct am_state {
 	/* pass -m flag to git-mailinfo */
 	int message_id;
 
+	/* one of the enum scissors_type values */
+	int scissors;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -130,6 +139,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
+
+	state->scissors = SCISSORS_UNSET;
 }
 
 /**
@@ -422,6 +433,14 @@ static void am_load(struct am_state *state)
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
@@ -642,6 +661,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
@@ -831,6 +866,19 @@ static int parse_mail(struct am_state *state, const char *mail)
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
 
@@ -1560,6 +1608,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
 		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		OPT_BOOL('c', "scissors", &state.scissors,
+			N_("strip everything before a scissors line")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
