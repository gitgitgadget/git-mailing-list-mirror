From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 27/45] builtin-am: support --keep-cr, am.keepcr
Date: Tue,  4 Aug 2015 21:51:48 +0800
Message-ID: <1438696326-19590-28-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfh-0002iy-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbbHDNyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34313 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbbHDNyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:09 -0400
Received: by pawu10 with SMTP id u10so9251887paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Yb5o6wH0Rd74KzuLaHPM2QAHkXbKOh3c3nNWUthUWY=;
        b=aQv5wjNVh+AthwO+m99B2s3W9zub3d7Km+2tTjLA2MaCVClEqY3FcvMOTA3Vynz2UP
         La5C7E73JPo8LjZLQ9kuadTLYag0nBTP8233I90mIGcQsWm/HWZdUXZhhJpUgky02i8d
         QktvjeSaPzv/Ke4/2Z6VjvTq/L8GnNUNxIbF6Y0gCE49/5FbD40jUimmcZnzt5KJtHvo
         2umgAsp+39amd1RBe31DKnkFZS0xUtvy4Yt/CqpzNB13nwGqRQ4gpbinyu174se/4GFw
         R+cilPQmGfrFXB71pKybAh4mTQTAKqWUAa9laRR1oh6OBhWt05cADCnfH8WQX8VKGTO+
         In5A==
X-Received: by 10.68.202.72 with SMTP id kg8mr8130496pbc.42.1438696448859;
        Tue, 04 Aug 2015 06:54:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275293>

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
index 8e97839..e34bc51 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -502,7 +502,7 @@ done:
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
-static int split_mail_mbox(struct am_state *state, const char **paths)
+static int split_mail_mbox(struct am_state *state, const char **paths, int keep_cr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
@@ -512,6 +512,8 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
 	argv_array_pushf(&cp.args, "-d%d", state->prec);
 	argv_array_pushf(&cp.args, "-o%s", state->dir);
 	argv_array_push(&cp.args, "-b");
+	if (keep_cr)
+		argv_array_push(&cp.args, "--keep-cr");
 	argv_array_push(&cp.args, "--");
 	argv_array_pushv(&cp.args, paths);
 
@@ -536,14 +538,22 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
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
@@ -554,7 +564,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
  * Setup a new am session for applying patches
  */
 static void am_setup(struct am_state *state, enum patch_format patch_format,
-			const char **paths)
+			const char **paths, int keep_cr)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
@@ -570,7 +580,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
-	if (split_mail(state, patch_format, paths) < 0) {
+	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
 		die(_("Failed to split patches."));
 	}
@@ -1511,6 +1521,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 
@@ -1534,6 +1545,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
@@ -1631,7 +1648,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		am_setup(&state, patch_format, paths.argv);
+		am_setup(&state, patch_format, paths.argv, keep_cr);
 
 		argv_array_clear(&paths);
 	}
-- 
2.5.0.280.gd88bd6e
