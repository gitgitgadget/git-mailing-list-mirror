From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 11/19] am: refuse to apply patches if index is dirty
Date: Thu, 11 Jun 2015 18:21:57 +0800
Message-ID: <1434018125-31804-12-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdR-0007y2-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbbFKKWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:52 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34942 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbbFKKWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:49 -0400
Received: by pdbnf5 with SMTP id nf5so1989280pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0S6f3mYg5H2bNWNrzE/Jdv3Rj3naaxnG23zoz9zvm8w=;
        b=dyIdhXya5spFVGiCMTdXBCTHvQPpoCnRv6KSAPO1nmJ12yYKeoF0hkBtWg9AnQjkqY
         AN0KEsJBZimulCc+DYmTjQX/wjtrdw8pQBLiE1kYut2N5odqXSrknAoNUGRpSp/N/720
         oeda2xg/ATFkhzDsAgu24eK15Mm/NVpXBUc6FDwde+1FPkJLogLoQuD54VPuVKEg3099
         fyCKolvGle1eglrZvpevmugbUckeLa6d5AKAiQE9kmFFKzIwZIoLut2YYNC9VDIcBGvW
         0vmgfmPqM0nufXqb7eOs2lrbrtEaff5P024eUerbkQFKmKukR6S5PkeuXc55ATRjvVi1
         iWYQ==
X-Received: by 10.70.130.77 with SMTP id oc13mr13860603pdb.54.1434018168696;
        Thu, 11 Jun 2015 03:22:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271392>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will refuse to apply patches if the index is dirty. Re-implement this
behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 417bfde..234762c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -14,6 +14,8 @@
 #include "refs.h"
 #include "commit.h"
 #include "lockfile.h"
+#include "diff.h"
+#include "diffcore.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -472,6 +474,43 @@ static void refresh_and_write_cache(void)
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
  * Parses `patch` using git-mailinfo. state->msg will be set to the patch
  * message. state->author_name, state->author_email, state->author_date will be
  * set to the patch author's name, email and date respectively. The patch's
@@ -612,8 +651,15 @@ static void do_commit(const struct am_state *state)
  */
 static void am_run(struct am_state *state)
 {
+	struct strbuf sb = STRBUF_INIT;
+
 	refresh_and_write_cache();
 
+	if (index_has_changes(&sb))
+		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
+
+	strbuf_release(&sb);
+
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
 
-- 
2.1.4
