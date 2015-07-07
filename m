From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 10/44] builtin-am: refuse to apply patches if index is dirty
Date: Tue,  7 Jul 2015 22:20:28 +0800
Message-ID: <1436278862-2638-11-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlO-0004Wk-GI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630AbbGGOWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:11 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36500 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521AbbGGOVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:46 -0400
Received: by pddu5 with SMTP id u5so39233245pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+04970Bqp5uajTRq6txT9hEVQCGPFZDT5vPeBGBbdY=;
        b=adYIpqEWouBPYIPHQ49vNoklnrl2kGVVhMl70oXv0xVUhG/gQHE386HOPfDzy22Hcy
         dzsB89aKBkkbuuWMxHZaxa/VwHbI4onH3F+2Wfg4rQyZYg4okoeZmoeIb8lNpxjAFRc6
         e9EpqQSmKsLQ9Oe0x1kId5MYbmVpQTj4wCS1nAC4k16AON9JiY4eZNcpa331At4AOQaO
         PV2Roa1+nematLxMKWJvaMr84mBDObrWgyHMNrGyodRo48V9InWsD5F3No/piayK7UQ8
         WREeiFSaoL3htaxZoaZflGy0LYDwFA9D5YLDYarMzUXyg/0bnZnc7rh9Dxz0rGHozKE3
         ke7g==
X-Received: by 10.68.217.2 with SMTP id ou2mr9515823pbc.71.1436278905531;
        Tue, 07 Jul 2015 07:21:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273529>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will refuse to apply patches if the index is dirty. Re-implement this
behavior in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
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
2.5.0.rc1.76.gf60a929
