From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 28/45] builtin-am: implement --[no-]scissors
Date: Mon, 20 Jul 2015 00:10:20 +0800
Message-ID: <1437322237-29863-29-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCJ-0006a9-SV
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbbGSQMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:05 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33373 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbGSQL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:58 -0400
Received: by pdbnt7 with SMTP id nt7so18814050pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYmWfC3boyFUIbswLX6XwwP4iAPrplfD9GH9EyYis64=;
        b=lk2AJP3/CuzmYD2AKcOInbwbgIpzoRo3f1YVeScTdBpl8a0irdB2oGtfEi+fBkweZ7
         p8QnL6pxhUWmy+JlL/fYkqsyu25joSrLjVRVbnqNPptjTJs1thu69LUFUicvdEsG15E+
         viubo69rDHGcltXAXo+NdVBLGREelo39OoBIUsk+GVYg0GfldMHt3Fs9qLXVLF34qrbx
         VJnpasP0h1n+Q0Xl1PkAHzwzJGceV1EVpcc2jl259DBd0SYetbVzbg3NFtUZpf5CwuqA
         0Vt2ZNSUS+eqF7CB80PV8jhu7ooTu1Gc79lsXnt+wfxfhJ12SoKQ1y+bMMG4yVMdbzyc
         8q7Q==
X-Received: by 10.70.23.196 with SMTP id o4mr50155166pdf.164.1437322317873;
        Sun, 19 Jul 2015 09:11:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274252>

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
index 80f091e..1f79750 100644
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
@@ -121,6 +128,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
+
+	state->scissors = SCISSORS_UNSET;
 }
 
 /**
@@ -396,6 +405,14 @@ static void am_load(struct am_state *state)
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
@@ -616,6 +633,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
@@ -800,6 +833,19 @@ static int parse_mail(struct am_state *state, const char *mail)
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
 
@@ -1552,6 +1598,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
 		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		OPT_BOOL('c', "scissors", &state.scissors,
+			N_("strip everything before a scissors line")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
