From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 34/45] builtin-am: support automatic notes copying
Date: Tue,  4 Aug 2015 21:51:55 +0800
Message-ID: <1438696326-19590-35-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfy-0002r5-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbbHDNy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35267 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940AbbHDNyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:25 -0400
Received: by pasy3 with SMTP id y3so9209214pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7B2BdEchDKelo6QwolAYfqBE1UD/JMPGuqMiUnYgHJ0=;
        b=HbVQ2/ylEPCeaE15qrqSFd6bQsWVCxGPbRh2rsxPpmukHv4w8+wzqJwjI4J/4LI1xx
         mW4mKMw25L3uejHzi6cX0M0N00gRh6Ibo5VKjNliFOD5pvJr9JGUVbWYZ+pnsja3SLig
         0HehBLee/TYZwCWaF3HXr7lVbZOIsWGuwO26DvVGkyZzAoR4nMEVTBsMf+kKcD+SJAZL
         9Y9RaKcqNGqJbZQ8Fjixi35XnoJ4HRc9eBkcI0QQpA9pqmawaoDZRuySojDj4ZdP3QKL
         zCRd0hYpkK5Tj+4h3V+OCJc4wl0W3li85+3OJTbYSRYcVpxzuIA9rZRd07rKbLFrD0xQ
         yS3g==
X-Received: by 10.67.14.163 with SMTP id fh3mr8202415pad.155.1438696464991;
        Tue, 04 Aug 2015 06:54:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275306>

Since eb2151b (rebase: support automatic notes copying, 2010-03-12),
git-am.sh supported automatic notes copying in --rebasing mode by
invoking "git notes copy" once it has finished applying all the patches.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index dbec9fc..7d7f91d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "notes-utils.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -479,6 +480,64 @@ static int run_post_rewrite_hook(const struct am_state *state)
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
@@ -1405,6 +1464,7 @@ next:
 
 	if (!is_empty_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
+		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
 	}
 
-- 
2.5.0.280.gd88bd6e
