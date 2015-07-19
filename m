From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 10/45] builtin-am: refuse to apply patches if index is dirty
Date: Mon, 20 Jul 2015 00:10:02 +0800
Message-ID: <1437322237-29863-11-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBR-000691-D9
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbGSQLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36549 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbGSQLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:14 -0400
Received: by pachj5 with SMTP id hj5so89278420pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gc9+nyjwdsisoKVCbpNGVG4fs5zVdhPL/gbHv6cg1wU=;
        b=rPIPnQ7xqYtIHD9SN96dnOAP08fGi1H6MPCLe/WiCZqkLJy7JuYInixeRYoGKoh+OB
         YBtvlkmb0awq3oCkKBpr5Lo6YypHu02uweV00VOSMy4f9PoRpomgMNaf0khXGQ7mLsa9
         DDXIxQTq5NIWoFPeFqbVa0jDSEassQXn9hopq7PxaS3bC0v03yrgLBkSl18xGHu9jj2f
         9ZXcKokx+Xk7fKYMsoLF0oMKgdBKxy6GMdhh7/neGuoU9Z/WS1bpa2iRuVFe11x+jrCT
         1XOG4p5mnwCUEp+mMER2GuZ6QNVlLQe1znj87CpoF2GnJhqUb4vmzcJ2TR2Q/d/dRnIJ
         SypQ==
X-Received: by 10.68.224.35 with SMTP id qz3mr49403945pbc.165.1437322273656;
        Sun, 19 Jul 2015 09:11:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274235>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will refuse to apply patches if the index is dirty. Re-implement this
behavior in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index a2811b6..537ad62 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -14,6 +14,8 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -565,6 +567,43 @@ static void refresh_and_write_cache(void)
 }
 
 /**
+ * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
+ * branch, returns 1 if there are entries in the index, 0 otherwise. If an
+ * strbuf is provided, the space-separated list of files that differ will be
+ * appended to it.
+ */
+static int index_has_changes(struct strbuf *sb)
+{
+	unsigned char head[GIT_SHA1_RAWSZ];
+	int i;
+
+	if (!get_sha1_tree("HEAD", head)) {
+		struct diff_options opt;
+
+		diff_setup(&opt);
+		DIFF_OPT_SET(&opt, EXIT_WITH_STATUS);
+		if (!sb)
+			DIFF_OPT_SET(&opt, QUICK);
+		do_diff_cache(head, &opt);
+		diffcore_std(&opt);
+		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
+		}
+		diff_flush(&opt);
+		return DIFF_OPT_TST(&opt, HAS_CHANGES) != 0;
+	} else {
+		for (i = 0; sb && i < active_nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, active_cache[i]->name);
+		}
+		return !!active_nr;
+	}
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -726,9 +765,15 @@ static void do_commit(const struct am_state *state)
 static void am_run(struct am_state *state)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
+	struct strbuf sb = STRBUF_INIT;
 
 	refresh_and_write_cache();
 
+	if (index_has_changes(&sb))
+		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
+
+	strbuf_release(&sb);
+
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 
-- 
2.5.0.rc2.110.gb39b692
