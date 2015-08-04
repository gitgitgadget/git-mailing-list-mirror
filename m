From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 10/45] builtin-am: refuse to apply patches if index is dirty
Date: Tue,  4 Aug 2015 21:51:31 +0800
Message-ID: <1438696326-19590-11-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcev-0002IR-FH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbbHDNx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33095 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627AbbHDNxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:22 -0400
Received: by pdbnt7 with SMTP id nt7so4812592pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETVUzb7FcJwvHjVTGSYyNtoaUNfxreAnpPhGzk1rel0=;
        b=vOiMZiSUcuqGQKPCfqDlRF/sIsC/05WLC4EA6OqNjgO7/W2F9th+tTwFwdmrtU5Qor
         jUhSe/vxB7wC1teVNtHm1ah8wT4MTqKgclyEOGFBjIik6iHe+rIizv1JKiVXzP8zgwir
         gNaabRBsIqUUDgP7rvs+3yjjVlKp+zR+l79fqk62vc7MecHBkCMNi9LFYSWqPvJj4844
         OlL03aURmvuvidU5Q2hgFDZv6mCD7Jfg7W6E6NVBhXXYH0ky8g8CKbkXcFTwv/YeGXfA
         R15xdmDqwPwJvIiJfhx93Znh1wkWJeDGwLUfNjmhU95fuAV0u5lGumXTTLzM0lu4Bl0J
         lAaw==
X-Received: by 10.70.30.193 with SMTP id u1mr7962577pdh.59.1438696402356;
        Tue, 04 Aug 2015 06:53:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275283>

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
2.5.0.280.gd88bd6e
