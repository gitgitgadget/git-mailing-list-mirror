From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 08/44] builtin-am: apply patch with git-apply
Date: Tue,  7 Jul 2015 22:20:26 +0800
Message-ID: <1436278862-2638-9-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTl8-0004Mw-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbbGGOV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:21:57 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33422 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbbGGOVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:41 -0400
Received: by pdbdz6 with SMTP id dz6so31978085pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFxiVSdJeXj3QZ0/LMaH7wDwZ9vD+w++NqYLnvCOacs=;
        b=rzX+tbHhpIN7Z7S7iAIMUteKwRoaWyBj9N++ruFXutKSvi5qgTQeBf19/MoHgV67Ei
         Njj9rKOUYmqAaqp1iiD5i0Z4n7eLJHdjYwaaiTB4BV6ld3eEIaQy/TTRozuUQEkPmXAd
         +XL1I9PlxrlY3W0W/B+4oRRT1FOXzAM27s3zLiv0MGQJbEI8Re9i050OWxIwCXWCUjBG
         i6STtIpmRA4OEx6k3Z+91cQIvfDaGpzRPEZk7Ts20mbF40HJK2ty4LHkRBaoXpUOUe0l
         +nagstr3+2W+Y2trmiG9WprNkqydzJIQSsycakpmbwNcYbUk+YAh9HLXzXTk5nGof851
         4IRA==
X-Received: by 10.70.130.3 with SMTP id oa3mr9477146pdb.51.1436278899844;
        Tue, 07 Jul 2015 07:21:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273528>

Implement applying the patch to the index using git-apply.

If a file is unchanged but stat-dirty, git-apply may erroneously fail to
apply patches, thinking that they conflict with a dirty working tree.

As such, since 2a6f08a (am: refresh the index at start and --resolved,
2011-08-15), git-am will refresh the index before applying patches.
Re-implement this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4897857..9c7a6c8 100644
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
@@ -561,6 +570,20 @@ static const char *msgnum(const struct am_state *state)
 }
 
 /**
+ * Refresh and write index.
+ */
+static void refresh_and_write_cache(void)
+{
+	static struct lock_file lock_file;
+
+	hold_locked_index(&lock_file, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		die(_("unable to write index file"));
+	rollback_lock_file(&lock_file);
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -650,10 +673,35 @@ finish:
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
 
@@ -666,7 +714,27 @@ static void am_run(struct am_state *state)
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
@@ -728,6 +796,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (read_index_preload(&the_index, NULL) < 0)
+		die(_("failed to read the index"));
+
 	if (am_in_progress(&state))
 		am_load(&state);
 	else {
-- 
2.5.0.rc1.76.gf60a929
