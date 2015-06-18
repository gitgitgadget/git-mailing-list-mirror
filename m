From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 24/31] am: implement -k/--keep, --keep-non-patch
Date: Thu, 18 Jun 2015 19:25:36 +0800
Message-ID: <1434626743-8552-25-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xz1-0005cI-5M
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbbFRL1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:35 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33303 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbbFRL1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:16 -0400
Received: by pdjn11 with SMTP id n11so64840542pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8DpJdWZTSBo7dn+8UB1i4Uc4klnpMkdrrhZlND1AOps=;
        b=dajBdx+ClvOAZ+CJsV0bCy+8soVZmOHcnGeYXqE3muyyNa5UbkxGyLooxVzDW8Y9mP
         brBpkw/Dr4OAgyM8a/p8BdxZzXsRpM4sM1f4MCli2L0OrTrLEytHwSinKBePI7+GzkSI
         D5rjrAwpGQ2MaI7c/vyfzd8dlnvLbXQ/pcKUdX6WWZ3pnOKWBhbRmQTF1Jp+1NPeeq11
         yJ3IWTIINrkvLBuAI+sLOKOXLzRYsMTSsRqs3OpISPAcB8ziKSyIS3AftkN4uYQUkYFX
         UDbXRvSgy7+rIr2W+azeWMeniTHMqKuHGM4HjbLGIMGOrqYt4So3asxmiZSB/k9zK/pS
         zf9A==
X-Received: by 10.68.215.66 with SMTP id og2mr20200303pbc.20.1434626835654;
        Thu, 18 Jun 2015 04:27:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271986>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -k/--keep option to pass the -k option to
git-mailsplit.

Since f7e5ea1 (am: learn passing -b to mailinfo, 2012-01-16), git-am.sh
supported the --keep-non-patch option to pass the -b option to
git-mailsplit.

Re-implement these two options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index bbef91f..b73549f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -81,6 +81,12 @@ enum patch_format {
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
 	struct strbuf dir;
@@ -104,6 +110,9 @@ struct am_state {
 
 	int sign;
 
+	/* one of the enum keep_type values */
+	int keep;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -333,6 +342,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "sign"), 2, 1);
 	state->sign = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, am_path(state, "keep"), 2, 1);
+	if (!strcmp(sb.buf, "t"))
+		state->keep = KEEP_TRUE;
+	else if (!strcmp(sb.buf, "b"))
+		state->keep = KEEP_NON_PATCH;
+	else
+		state->keep = KEEP_FALSE;
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -497,6 +514,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		struct string_list *paths)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	const char *str;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -527,6 +545,21 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->sign ? "t" : "f");
 
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
+	write_file(am_path(state, "keep"), 1, "%s", str);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -653,6 +686,20 @@ static int parse_patch(struct am_state *state, const char *patch)
 	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
 
 	argv_array_push(&cp.args, "mailinfo");
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
 
@@ -1326,6 +1373,10 @@ static struct option am_options[] = {
 	OPT__QUIET(&state.quiet, N_("be quiet")),
 	OPT_BOOL('s', "signoff", &state.sign,
 		N_("add a Signed-off-by line to the commit message")),
+	OPT_SET_INT('k', "keep", &state.keep,
+		N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
+	OPT_SET_INT(0, "keep-non-patch", &state.keep,
+		N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
-- 
2.1.4
