From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 34/45] builtin-am: support automatic notes copying
Date: Mon, 20 Jul 2015 00:10:26 +0800
Message-ID: <1437322237-29863-35-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCT-0006cj-2f
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbbGSQMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:14 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33647 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbGSQMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:12 -0400
Received: by padck2 with SMTP id ck2so88793953pad.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E9DQpJreuj+SZydbdMsrU8PcDB8WFaQYuBXuLCrd31U=;
        b=p8+xkDLrbl0+NfSC77p6zwaMxqV2PFQQ0wOeVZAI9DZ2TjonurgQzEqxYYyELf0uas
         jWVcsdYge5P9hWvEmnr+G4dyUTHU6FFbIpXkfaZQ3e6a4mggxIVEUK/WpeMvr34Vtn2h
         UiP65s4+ji6rvUC4kolR9rEABvKLReHvKzXU2EcawhxcPYI9nJaunENPpk5oSoQSKDVk
         1oN3/0l4grdd8AscfyUQAzcy1njqCGAxPavcfSJoW97PCTLJuIYzp2t1+JFTmsLGayUZ
         BAbhtzEIst9vu14UcVBi0EJTX41jCLtBFzR7GVx9/2Ygfunz3r49wcjC6p/QxKCg51jM
         5gCg==
X-Received: by 10.68.88.33 with SMTP id bd1mr50246971pbb.124.1437322332490;
        Sun, 19 Jul 2015 09:12:12 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274254>

Since eb2151b (rebase: support automatic notes copying, 2010-03-12),
git-am.sh supported automatic notes copying in --rebasing mode by
invoking "git notes copy" once it has finished applying all the patches.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index e99e1ec..64b467f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "notes-utils.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -481,6 +482,64 @@ static int run_post_rewrite_hook(const struct am_state *state)
 }
 
 /**
+ * Reads the state directory's "rewritten" file, and copies notes from the old
+ * commits listed in the file to their rewritten commits.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int copy_notes_for_rebase(const struct am_state *state)
+{
+	struct notes_rewrite_cfg *c;
+	struct strbuf sb = STRBUF_INIT;
+	const char *invalid_line = _("Malformed input line: '%s'.");
+	const char *msg = "Notes added by 'git rebase'";
+	FILE *fp;
+	int ret = 0;
+
+	assert(state->rebasing);
+
+	c = init_copy_notes_for_rewrite("rebase");
+	if (!c)
+		return 0;
+
+	fp = xfopen(am_path(state, "rewritten"), "r");
+
+	while (!strbuf_getline(&sb, fp, '\n')) {
+		unsigned char from_obj[GIT_SHA1_RAWSZ], to_obj[GIT_SHA1_RAWSZ];
+
+		if (sb.len != GIT_SHA1_HEXSZ * 2 + 1) {
+			ret = error(invalid_line, sb.buf);
+			goto finish;
+		}
+
+		if (get_sha1_hex(sb.buf, from_obj)) {
+			ret = error(invalid_line, sb.buf);
+			goto finish;
+		}
+
+		if (sb.buf[GIT_SHA1_HEXSZ] != ' ') {
+			ret = error(invalid_line, sb.buf);
+			goto finish;
+		}
+
+		if (get_sha1_hex(sb.buf + GIT_SHA1_HEXSZ + 1, to_obj)) {
+			ret = error(invalid_line, sb.buf);
+			goto finish;
+		}
+
+		if (copy_note_for_rewrite(c, from_obj, to_obj))
+			ret = error(_("Failed to copy notes from '%s' to '%s'"),
+					sha1_to_hex(from_obj), sha1_to_hex(to_obj));
+	}
+
+finish:
+	finish_copy_notes_for_rewrite(c, msg);
+	fclose(fp);
+	strbuf_release(&sb);
+	return ret;
+}
+
+/**
  * Determines if the file looks like a piece of RFC2822 mail by grabbing all
  * non-indented lines and checking if they look like they begin with valid
  * header field names.
@@ -1407,6 +1466,7 @@ next:
 
 	if (!is_empty_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
+		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
 	}
 
-- 
2.5.0.rc2.110.gb39b692
