From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 10/44] builtin-am: refuse to apply patches if index is dirty
Date: Sun, 28 Jun 2015 22:05:32 +0800
Message-ID: <1435500366-31700-11-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFJ-00023Q-PS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbbF1OHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34794 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbF1OHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:22 -0400
Received: by pabvl15 with SMTP id vl15so91965666pab.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vf2DTLrZ/oLIucxo1L1R0mJk62xfmEXOdBkOWbTGo/c=;
        b=wKSyuXLtfYl2A4+bXzikrvAmPRSFSgP4GTtrSOvbdmfgiKiQwoETitoLFeHGnw4kyM
         k/Zdb1OoTOoS56xlLCHy8NrU3K+psyYVv9GrRDZoa0DsVAX1WnMLnb5FKkBo+DpIOeBO
         STbqehxOxvv4oPwRqyvF6uWY5Qvfwk2AXwTmhsFavWyUqE2o/1a2QM8VWehfykxI+d7X
         TtL7kpMx4cm3l8T0SAVD1TB8I+h0fWow+qLOZa6vFD+sC1YAYXERZxOFqm5dcUl/eW+H
         2auFNi+jqABtSuo9Y9PjgMElbCsOpqyjKpLcPQirfPxpaz3lzxuMH2yJRdQQUZskz832
         XVPQ==
X-Received: by 10.70.102.226 with SMTP id fr2mr22798284pdb.26.1435500442144;
        Sun, 28 Jun 2015 07:07:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272886>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will refuse to apply patches if the index is dirty. Re-implement this
behavior in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    Note: no tests for this

 builtin/am.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index bbb540c..f9a641a 100644
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
@@ -587,6 +589,43 @@ static void refresh_and_write_cache(void)
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
@@ -748,9 +787,15 @@ static void do_commit(const struct am_state *state)
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
2.5.0.rc0.76.gb2c6e93
