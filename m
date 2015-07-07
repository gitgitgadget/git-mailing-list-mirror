From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 33/44] builtin-am: support automatic notes copying
Date: Tue,  7 Jul 2015 22:20:51 +0800
Message-ID: <1436278862-2638-34-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmW-0005EC-1f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832AbbGGOX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:26 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36805 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730AbbGGOWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:45 -0400
Received: by pacgz10 with SMTP id gz10so40450518pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADLmIjt32g6NlrSjGWrFSHsREKaYlUb5bDYoo9ciYtg=;
        b=w4LTW4RJbMLIYdRbvmFAWdrH97fHHiz+MGjw7tjEdeb1BVMrV0VqJT0f6BizTVqFeI
         n2FB4ZrlW6xz4H1QTm2A/fNUlEnNcjrBusm+j/em9F0Jl9MON5JZXFl2j/jbHk1ZboZG
         cfz3qu9D9k/2NANYteo77iE+EMl6cMX6BX3062YFbcTFbeAxGyjAHmNbH8Kbp7/8GJTh
         yYd2RGVQtE+F2nEIoRSyNQKFtIoFIy1Qd7xzy7a2QVjK2SuFGRHlBg030H9sPkg0sBU0
         ukfvP6fVMyzdGHR7xu/8yLWYwfxCpnpYnUw5uA7MTVO+Y86vfRHSLxsMoI4XTjoxtl8G
         J0sw==
X-Received: by 10.68.239.70 with SMTP id vq6mr9400859pbc.157.1436278965137;
        Tue, 07 Jul 2015 07:22:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273548>

Since eb2151b (rebase: support automatic notes copying, 2010-03-12),
git-am.sh supported automatic notes copying in --rebasing mode by
invoking "git notes copy" once it has finished applying all the patches.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index c234ee9..2255a1e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "notes-utils.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -514,6 +515,64 @@ static int run_post_rewrite_hook(const struct am_state *state)
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
@@ -1419,6 +1478,7 @@ next:
 
 	if (!is_empty_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
+		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
 	}
 
-- 
2.5.0.rc1.76.gf60a929
