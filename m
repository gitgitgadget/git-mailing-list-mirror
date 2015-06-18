From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 26/31] am: support --keep-cr, am.keepcr
Date: Thu, 18 Jun 2015 19:25:38 +0800
Message-ID: <1434626743-8552-27-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xz3-0005cI-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbbFRL1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:44 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34432 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196AbbFRL1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:21 -0400
Received: by pabvl15 with SMTP id vl15so13428988pab.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sy6Lbrew6juG5n0iSVLwEolGwDIlaYTz1QAu7oe5eEM=;
        b=B0rbL1JRMlPFpSKVrMmkcQFes9s4g7ivgi2+iHzlaT0FnVKvYXe5wcSmvZv1x+1wtZ
         uMrNDK4vlwbTqJXeyCSBh4+P/iIhAWBzDbzJ5siw73mfEoOk1gxnBrC5yKYzz3+VRLvN
         ayH7EJeEP8j55HVowyy+9Q6zY8Am632g1W7BMpn27t8maIfH5f805CL66ISGr18mzZUy
         9V0JYX+jOhY+d3zpiVn4/D5yNv4TQXOa9QWGk6IegkOrnyRppON3L/ykE79NLlXVyz2E
         FUPJnDKtYikxhEaWUjd4cHe7ZQG5ndTXzxcuTYAf3gOwEKygHXlscfDXcw+PTJc5Fs/6
         aR1A==
X-Received: by 10.70.88.98 with SMTP id bf2mr20463893pdb.46.1434626841361;
        Thu, 18 Jun 2015 04:27:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271989>

Since ad2c928 (git-am: Add command line parameter `--keep-cr` passing it
to git-mailsplit, 2010-02-27), git-am.sh supported the --keep-cr option
and would pass it to git-mailsplit.

Since e80d4cb (git-am: Add am.keepcr and --no-keep-cr to override it,
2010-02-27), git-am.sh supported the am.keepcr config setting, which
controls whether --keep-cr is on by default.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4cec380..1991f36 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -469,7 +469,8 @@ done:
  * Splits out individual patches from `paths`, where each path is either a mbox
  * file or a Maildir. Return 0 on success, -1 on failure.
  */
-static int split_patches_mbox(struct am_state *state, struct string_list *paths)
+static int split_patches_mbox(struct am_state *state, struct string_list *paths,
+		int keep_cr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -480,6 +481,8 @@ static int split_patches_mbox(struct am_state *state, struct string_list *paths)
 	argv_array_pushf(&cp.args, "-d%d", state->prec);
 	argv_array_pushf(&cp.args, "-o%s", state->dir.buf);
 	argv_array_push(&cp.args, "-b");
+	if (keep_cr)
+		argv_array_push(&cp.args, "--keep-cr");
 	argv_array_push(&cp.args, "--");
 
 	for_each_string_list_item(item, paths)
@@ -501,14 +504,22 @@ static int split_patches_mbox(struct am_state *state, struct string_list *paths)
  * set to the index of the first patch, and state->last will be set to the
  * index of the last patch.
  *
+ * Set keep_cr to 0 to convert all lines ending with \r\n to end with \n, 1
+ * to disable this behavior, -1 to use the default configured setting.
+ *
  * Returns 0 on success, -1 on failure.
  */
 static int split_patches(struct am_state *state, enum patch_format patch_format,
-		struct string_list *paths)
+		struct string_list *paths, int keep_cr)
 {
+	if (keep_cr < 0) {
+		keep_cr = 0;
+		git_config_get_bool("am.keepcr", &keep_cr);
+	}
+
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
-		return split_patches_mbox(state, paths);
+		return split_patches_mbox(state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -519,7 +530,7 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
  * Setup a new am session for applying patches
  */
 static void am_setup(struct am_state *state, enum patch_format patch_format,
-		struct string_list *paths)
+		struct string_list *paths, int keep_cr)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
@@ -535,7 +546,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir.buf);
 
-	if (split_patches(state, patch_format, paths) < 0) {
+	if (split_patches(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
 		die(_("Failed to split patches."));
 	}
@@ -1371,6 +1382,7 @@ enum resume_mode {
 };
 
 static struct am_state state;
+static int opt_keep_cr = -1;
 static int opt_patch_format;
 static enum resume_mode opt_resume;
 
@@ -1392,6 +1404,12 @@ static struct option am_options[] = {
 		N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 	OPT_BOOL('m', "message-id", &state.message_id,
 		N_("pass -m flag to git-mailinfo")),
+	{ OPTION_SET_INT, 0, "keep-cr", &opt_keep_cr, NULL,
+	  N_("pass --keep-cr flag to git-mailsplit for mbox format"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+	{ OPTION_SET_INT, 0, "no-keep-cr", &opt_keep_cr, NULL,
+	  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
@@ -1486,7 +1504,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				string_list_append(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		am_setup(&state, opt_patch_format, &paths);
+		am_setup(&state, opt_patch_format, &paths, opt_keep_cr);
 
 		string_list_clear(&paths, 0);
 	}
-- 
2.1.4
