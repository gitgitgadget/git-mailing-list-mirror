From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 33/44] builtin-am: support automatic notes copying
Date: Sun, 28 Jun 2015 22:05:55 +0800
Message-ID: <1435500366-31700-34-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGb-0002vi-2s
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbF1OI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36347 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbbF1OIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:30 -0400
Received: by pdcu2 with SMTP id u2so101486451pdc.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTMZYDjL0QuhSUa8LFQ9/MgJz8IF2hx29I0VD/zlL4w=;
        b=hWlyqm1lWOD4D01GuPHf5d6wuiiUBcMCUMNO60Cmn0ovyEJsTdUjAofeCaUMQqSSzd
         N68s7zQPG3hvcXG4jk6SaPEt+hIYb/l9qtyZwrnYCPUPcf23GvxeZEUGcd6nan3sR1WZ
         iV0eAeL9cqI+reWUJ/XaGcbWA6bOzCS2G/NkjBvcz+J+aZLFPn1SUKVX3aSbuqCX2CsX
         F4HzCu8RE7GNszW/+A7Qfnsrgz77GF1fcTRH+grj6YUhfvC7adT1aRAiUjYotz5/LiQx
         mkPUthPipSAlV8k1C3mbRFrs9rhRTXVS0Sm/2lRTE0055G/vnwKxPWDMgIlmqTyua5Ix
         MmhA==
X-Received: by 10.66.141.48 with SMTP id rl16mr21920873pab.147.1435500508666;
        Sun, 28 Jun 2015 07:08:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272909>

Since eb2151b (rebase: support automatic notes copying, 2010-03-12),
git-am.sh supported automatic notes copying in --rebasing mode by
invoking "git notes copy" once it has finished applying all the patches.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 27b79f7..f618ff1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "notes-utils.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -519,6 +520,64 @@ static int run_post_rewrite_hook(const struct am_state *state)
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
@@ -1424,6 +1483,7 @@ next:
 
 	if (!is_empty_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
+		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
 	}
 
-- 
2.5.0.rc0.76.gb2c6e93
