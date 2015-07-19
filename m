From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 25/45] builtin-am: implement -k/--keep, --keep-non-patch
Date: Mon, 20 Jul 2015 00:10:17 +0800
Message-ID: <1437322237-29863-26-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrC5-0006RT-1m
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbbGSQL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:56 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34475 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbGSQLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:51 -0400
Received: by pacan13 with SMTP id an13so89908593pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/voF+Z7jFcZN3e9IhZ6ruSusaAUHC23ahMbeHXOpSII=;
        b=bE3B3QisXoPaZhvqvrUyvzlL3LC5gtMVCYpj9eFKTxdWbrIscvTwx2BNURHIALXWV4
         DVi0PXeGo2WoTjwV7fFOACxLrnQKLGbAwgVVEMnxL1cZiYXmdVPkEgdsGv8lnFjzIJDA
         sME0lpwRREmaLqHjATSQk9MOWa2DU797xYjaq6cQYZbGbFbpZ4hRhFzQQohuat7aZXya
         GPTuS1WIxzFEcJZcIPsk/IGWu/TfsfX7zpb9HKvUlhUEhn46UB9fUPps3z48AvK4fXv6
         +IHyLbk4PmAExmnGa+zCZsExv9NRU+jpkAA8QMwq6tEwLiw9XgsUzrIAp8ujCwMvLYKQ
         CCdw==
X-Received: by 10.70.3.98 with SMTP id b2mr49448400pdb.107.1437322310663;
        Sun, 19 Jul 2015 09:11:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274248>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -k/--keep option to pass the -k option to
git-mailsplit.

Since f7e5ea1 (am: learn passing -b to mailinfo, 2012-01-16), git-am.sh
supported the --keep-non-patch option to pass the -b option to
git-mailsplit.

Re-implement these two options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index a64a859..af08a22 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -68,6 +68,12 @@ enum patch_format {
 	PATCH_FORMAT_MBOX
 };
 
+enum keep_type {
+	KEEP_FALSE = 0,
+	KEEP_TRUE,      /* pass -k flag to git-mailinfo */
+	KEEP_NON_PATCH  /* pass -b flag to git-mailinfo */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -91,6 +97,7 @@ struct am_state {
 	int quiet;
 	int append_signoff;
 	int utf8;
+	int keep; /* enum keep_type */
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -375,6 +382,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "keep", 1);
+	if (!strcmp(sb.buf, "t"))
+		state->keep = KEEP_TRUE;
+	else if (!strcmp(sb.buf, "b"))
+		state->keep = KEEP_NON_PATCH;
+	else
+		state->keep = KEEP_FALSE;
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -538,6 +553,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	const char *str;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -566,6 +582,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
 
+	switch (state->keep) {
+	case KEEP_FALSE:
+		str = "f";
+		break;
+	case KEEP_TRUE:
+		str = "t";
+		break;
+	case KEEP_NON_PATCH:
+		str = "b";
+		break;
+	default:
+		die("BUG: invalid value for state->keep");
+	}
+
+	write_file(am_path(state, "keep"), 1, "%s", str);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -733,6 +765,20 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	argv_array_push(&cp.args, "mailinfo");
 	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
+
+	switch (state->keep) {
+	case KEEP_FALSE:
+		break;
+	case KEEP_TRUE:
+		argv_array_push(&cp.args, "-k");
+		break;
+	case KEEP_NON_PATCH:
+		argv_array_push(&cp.args, "-b");
+		break;
+	default:
+		die("BUG: invalid value for state->keep");
+	}
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1472,6 +1518,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("add a Signed-off-by line to the commit message")),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
+		OPT_SET_INT('k', "keep", &state.keep,
+			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
+		OPT_SET_INT(0, "keep-non-patch", &state.keep,
+			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
