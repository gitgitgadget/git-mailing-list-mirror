From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 27/31] am: implement --[no-]scissors
Date: Thu, 18 Jun 2015 19:25:39 +0800
Message-ID: <1434626743-8552-28-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xz7-0005oK-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbbFRL1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:47 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34626 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbFRL1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:23 -0400
Received: by pdbki1 with SMTP id ki1so64759961pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/zjnRUJpj4TcT1CJRend7/0eW6SlL0ktizYKAx7i0SI=;
        b=Qg198xd5/JOzmGprIUQJbCqmysdl3cLXAyc6F1z5ZkAcOM3o/3uUH1d0hbCp8nlRCp
         OI18tP/PCNknHrkSA1Zflz8HV93juAVvrN/BZHTvyxVcrQgWaEHOG6sKR09P2fAt6z7R
         BA49aMx9uE9NmS+MKBHQ9X+nme/fMgTJYfS0NrDM4DJbbYcIT7N0J+eWjA56qpNbLZQg
         7ENi9eTKLWdVPsyXMAZMiHRUEWbKe5UGc5cWDX8Iks9d3Oltv6PKZ7GM2PpN8IoRYrCj
         3EpK6MxlLjcI+X5qwPK+KWvpfGVu42aKbkhLvmx7Pcxci+rPCoJcG2zyMA0pYTKnvfyJ
         FpNg==
X-Received: by 10.70.38.170 with SMTP id h10mr20229164pdk.20.1434626843459;
        Thu, 18 Jun 2015 04:27:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271992>

Since 017678b (am/mailinfo: Disable scissors processing by default,
2009-08-26), git-am supported the --[no-]scissors option, passing it to
git-mailinfo.

Re-implement support for this option.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    There are tests for mailinfo --scissors, but not am --scissors, or
    mailinfo.scissors.

 builtin/am.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 1991f36..42efce1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum keep_type {
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
 	struct strbuf dir;
@@ -116,6 +122,9 @@ struct am_state {
 	/* pass -m flag to git-mailinfo */
 	int message_id;
 
+	/* one of the enum scissors_type values */
+	int scissors;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -145,6 +154,8 @@ static void am_state_init(struct am_state *state)
 		state->quiet = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
+
+	state->scissors = SCISSORS_UNSET;
 }
 
 /**
@@ -358,6 +369,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "messageid"), 2, 1);
 	state->message_id = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, am_path(state, "scissors"), 2, 1);
+	if (!strcmp(sb.buf, "t"))
+		state->scissors = SCISSORS_TRUE;
+	else if (!strcmp(sb.buf, "f"))
+		state->scissors = SCISSORS_FALSE;
+	else
+		state->scissors = SCISSORS_UNSET;
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -581,6 +600,21 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
+	write_file(am_path(state, "scissors"), 1, "%s", str);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -724,6 +758,19 @@ static int parse_patch(struct am_state *state, const char *patch)
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
 
@@ -1410,6 +1457,8 @@ static struct option am_options[] = {
 	{ OPTION_SET_INT, 0, "no-keep-cr", &opt_keep_cr, NULL,
 	  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+	OPT_BOOL('c', "scissors", &state.scissors,
+		N_("strip everything before a scissors line")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
-- 
2.1.4
