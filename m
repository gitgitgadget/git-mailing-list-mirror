From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 08/45] builtin-am: apply patch with git-apply
Date: Mon, 20 Jul 2015 00:10:00 +0800
Message-ID: <1437322237-29863-9-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBM-00066m-HA
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbbGSQLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36510 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbbGSQLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:09 -0400
Received: by pachj5 with SMTP id hj5so89277532pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8iFWwahATMsSylxF3d7s3fKIuGxGo30nk03akKSOVUM=;
        b=N/fveF0Qd5t/mBb2I9QDgHcDhR4yqS+DefnIOSqFddo+o+2iRE/BFgKM1EkZOAgkTo
         1pM8O0JTOZz+6qHe5szakSsbJfow/rgjwWoXtzEGmFlGaYQcRM+UVqGfLKT9w+AuUI7+
         yyaBGDMnZdrOQ1+oFgT1qljB0B+l+nRTgV18zHheAirn4IEJ/jd0En3LCv78CflFheEz
         0b/oDsf0RJe8tpkgaReznyAaFFsbEupRFzc1wGZMFu5qM/rGNgkg1IzsO7dzHeKTKBYj
         bhdX/XJ/zFWkDDEQufbXXae4+0nKedlzkPIXFCSVExh+n+mLZZIv/vINTTDCiZbOEKYI
         j0sg==
X-Received: by 10.66.147.68 with SMTP id ti4mr49675062pab.90.1437322268789;
        Sun, 19 Jul 2015 09:11:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274233>

Implement applying the patch to the index using git-apply.

If a file is unchanged but stat-dirty, git-apply may erroneously fail to
apply patches, thinking that they conflict with a dirty working tree.

As such, since 2a6f08a (am: refresh the index at start and --resolved,
2011-08-15), git-am will refresh the index before applying patches.
Re-implement this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v6
    
    * refresh_and_write_cache(): use a heap-allocated lock_file instead of a
      static-allocated one to allow the function to be reentrant.
    
    * refresh_and_write_cache(): remove the rollback_lock_file() -- since we
      ensure that the write_locked_index() succeeds there is no need to call
      it.

 builtin/am.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 63f0fa4..1f198e4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "run-command.h"
 #include "quote.h"
+#include "lockfile.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -42,6 +43,14 @@ static int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
 	return 0;
 }
 
+/**
+ * Returns the length of the first line of msg.
+ */
+static int linelen(const char *msg)
+{
+	return strchrnul(msg, '\n') - msg;
+}
+
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX
@@ -540,6 +549,19 @@ static const char *msgnum(const struct am_state *state)
 }
 
 /**
+ * Refresh and write index.
+ */
+static void refresh_and_write_cache(void)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+
+	hold_locked_index(lock_file, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write index file"));
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -629,10 +651,35 @@ finish:
 }
 
 /**
+ * Applies current patch with git-apply. Returns 0 on success, -1 otherwise.
+ */
+static int run_apply(const struct am_state *state)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+
+	argv_array_push(&cp.args, "apply");
+	argv_array_push(&cp.args, "--index");
+	argv_array_push(&cp.args, am_path(state, "patch"));
+
+	if (run_command(&cp))
+		return -1;
+
+	/* Reload index as git-apply will have modified it. */
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+/**
  * Applies all queued mail.
  */
 static void am_run(struct am_state *state)
 {
+	refresh_and_write_cache();
+
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 
@@ -645,7 +692,27 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_commit_msg(state);
 
-		/* NEEDSWORK: Patch application not implemented yet */
+		printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
+
+		if (run_apply(state) < 0) {
+			int advice_amworkdir = 1;
+
+			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
+				linelen(state->msg), state->msg);
+
+			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
+
+			if (advice_amworkdir)
+				printf_ln(_("The copy of the patch that failed is found in: %s"),
+						am_path(state, "patch"));
+
+			exit(128);
+		}
+
+		/*
+		 * NEEDSWORK: After the patch has been applied to the index
+		 * with git-apply, we need to make commit as well.
+		 */
 
 next:
 		am_next(state);
@@ -707,6 +774,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (read_index_preload(&the_index, NULL) < 0)
+		die(_("failed to read the index"));
+
 	if (am_in_progress(&state))
 		am_load(&state);
 	else {
-- 
2.5.0.rc2.110.gb39b692
