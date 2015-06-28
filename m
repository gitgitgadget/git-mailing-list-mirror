From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 26/44] builtin-am: support --keep-cr, am.keepcr
Date: Sun, 28 Jun 2015 22:05:48 +0800
Message-ID: <1435500366-31700-27-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGI-0002jO-0Y
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbF1OIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33471 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbF1OII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:08 -0400
Received: by padev16 with SMTP id ev16so91890220pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cBJL9qtRsPRk/9nofTji3zkZzybNpJ+HWFp8eBf65ec=;
        b=STGagCcCdFohq8MqFfRyx//U/1JLgfu8ulMC8pViXwuRWeXytuWZeJOs8+4OSHPcPM
         cC+sqTk3WVei707XsuV2f5tUO092TQhzPhEUUhpmZvT576/6bj6Vr/3CH+XBZSWzj2Tj
         kWLBteayYFVbw0JeCVAB/iU0Q7SAZ/Ap/ahRgNL5LPYgXXW6+TIA/tqThe8C9mUbooWa
         Sp5ySmNXzkjZsGeCI0XyFop/GF5qe1bMeZE1V7c0VTFeNxVWpB1u476+8PD2JrFVq1S0
         JVwPmNstbauW0cd0FMHRNidt8Zg3btxGTZhVgV3zGlIBQIZdvGDr86CElmJBsnyXD/xr
         Z92g==
X-Received: by 10.66.145.74 with SMTP id ss10mr22748133pab.28.1435500488429;
        Sun, 28 Jun 2015 07:08:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272904>

Since ad2c928 (git-am: Add command line parameter `--keep-cr` passing it
to git-mailsplit, 2010-02-27), git-am.sh supported the --keep-cr option
and would pass it to git-mailsplit.

Since e80d4cb (git-am: Add am.keepcr and --no-keep-cr to override it,
2010-02-27), git-am.sh supported the am.keepcr config setting, which
controls whether --keep-cr is on by default.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 52e5b5a..2387726 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -536,7 +536,7 @@ done:
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
-static int split_mail_mbox(struct am_state *state, const char **paths)
+static int split_mail_mbox(struct am_state *state, const char **paths, int keep_cr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
@@ -546,6 +546,8 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
 	argv_array_pushf(&cp.args, "-d%d", state->prec);
 	argv_array_pushf(&cp.args, "-o%s", state->dir);
 	argv_array_push(&cp.args, "-b");
+	if (keep_cr)
+		argv_array_push(&cp.args, "--keep-cr");
 	argv_array_push(&cp.args, "--");
 	argv_array_pushv(&cp.args, paths);
 
@@ -570,14 +572,22 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
  * state->cur will be set to the index of the first mail, and state->last will
  * be set to the index of the last mail.
  *
+ * Set keep_cr to 0 to convert all lines ending with \r\n to end with \n, 1
+ * to disable this behavior, -1 to use the default configured setting.
+ *
  * Returns 0 on success, -1 on failure.
  */
 static int split_mail(struct am_state *state, enum patch_format patch_format,
-			const char **paths)
+			const char **paths, int keep_cr)
 {
+	if (keep_cr < 0) {
+		keep_cr = 0;
+		git_config_get_bool("am.keepcr", &keep_cr);
+	}
+
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
-		return split_mail_mbox(state, paths);
+		return split_mail_mbox(state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -588,7 +598,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
  * Setup a new am session for applying patches
  */
 static void am_setup(struct am_state *state, enum patch_format patch_format,
-			const char **paths)
+			const char **paths, int keep_cr)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
@@ -604,7 +614,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
-	if (split_mail(state, patch_format, paths) < 0) {
+	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
 		die(_("Failed to split patches."));
 	}
@@ -1526,6 +1536,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 
@@ -1549,6 +1560,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_BOOL('m', "message-id", &state.message_id,
 			N_("pass -m flag to git-mailinfo")),
+		{ OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
+		  N_("pass --keep-cr flag to git-mailsplit for mbox format"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
+		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
@@ -1643,7 +1660,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		am_setup(&state, patch_format, paths.argv);
+		am_setup(&state, patch_format, paths.argv, keep_cr);
 
 		argv_array_clear(&paths);
 	}
-- 
2.5.0.rc0.76.gb2c6e93
