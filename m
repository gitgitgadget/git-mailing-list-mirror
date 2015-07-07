From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 26/44] builtin-am: support --keep-cr, am.keepcr
Date: Tue,  7 Jul 2015 22:20:44 +0800
Message-ID: <1436278862-2638-27-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmC-00051M-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbbGGOW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35198 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699AbbGGOW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:29 -0400
Received: by pactm7 with SMTP id tm7so114131786pac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Fo1eUAN1ncM42TlnkL6/tjWenh9kLedkBdMaZk015g=;
        b=f6IEYsu3SKP69qW+y0rLwE5yCaCBassoJCz61iSITNUCQK3rr4982hDrNW+W5YPnl7
         6AFI17P2v30+srVjJM8YoDpXtEz1oZ1InUppCeZpEGq/rT6patSO/KT20YALnUCESQOs
         Y+KNtv09t8+6B6Yt+AaMHXDbvrrmGLaL3wU0hqHSV4E8KFY4KqeyHdkVPNuDp6qIiYoa
         ksKhNkeTXfcWLKxN1DSjdMXNiIlXNeJ2yxN00wypV/irFqkwxbDzQsqjbcbz2agC/aM8
         SJOzn5jVctEI0Eh5lGEga6hVAiaZgQa5RnO9wkAz8AgB2haadYn7M/nL6RuLSBj9eDh+
         1u4Q==
X-Received: by 10.68.69.11 with SMTP id a11mr9395993pbu.169.1436278948979;
        Tue, 07 Jul 2015 07:22:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273544>

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
index 099c6ed..59a7a2a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -530,7 +530,7 @@ done:
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
-static int split_mail_mbox(struct am_state *state, const char **paths)
+static int split_mail_mbox(struct am_state *state, const char **paths, int keep_cr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
@@ -540,6 +540,8 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
 	argv_array_pushf(&cp.args, "-d%d", state->prec);
 	argv_array_pushf(&cp.args, "-o%s", state->dir);
 	argv_array_push(&cp.args, "-b");
+	if (keep_cr)
+		argv_array_push(&cp.args, "--keep-cr");
 	argv_array_push(&cp.args, "--");
 	argv_array_pushv(&cp.args, paths);
 
@@ -564,14 +566,22 @@ static int split_mail_mbox(struct am_state *state, const char **paths)
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
@@ -582,7 +592,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
  * Setup a new am session for applying patches
  */
 static void am_setup(struct am_state *state, enum patch_format patch_format,
-			const char **paths)
+			const char **paths, int keep_cr)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
@@ -598,7 +608,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
-	if (split_mail(state, patch_format, paths) < 0) {
+	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
 		die(_("Failed to split patches."));
 	}
@@ -1520,6 +1530,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 
@@ -1543,6 +1554,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
@@ -1637,7 +1654,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		am_setup(&state, patch_format, paths.argv);
+		am_setup(&state, patch_format, paths.argv, keep_cr);
 
 		argv_array_clear(&paths);
 	}
-- 
2.5.0.rc1.76.gf60a929
