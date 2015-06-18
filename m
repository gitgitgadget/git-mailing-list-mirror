From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 11/31] am: refuse to apply patches if index is dirty
Date: Thu, 18 Jun 2015 19:25:23 +0800
Message-ID: <1434626743-8552-12-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyP-00055J-H0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbbFRL06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:58 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35266 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbbFRL0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:43 -0400
Received: by pdbci14 with SMTP id ci14so6231050pdb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2F7J0apdIMwnudbkn1q2biy7IfI3YmvxQvLMEo0Rqfg=;
        b=HOZtwUFGyu+AmZ8CXyGgAYU7m6C/IqqNJ7PUfcHofg5Gjx43uQ0MnWUKNQh20B0hQN
         SCg67mH5Q8xj9p8g438Ef0ib3k4HKc4Hi1ezZhXEAzxibHNjtQadUm/R2TnAz0agpbBb
         Heat5765+7fJH/UHVZbjYiuW3ghUPb3WGHmQA5YrHKhKuGdzFB+wUkLQk25CGvD53We3
         MX03Q0kCz8HIxVn0jVYphCnFbEzpNrjqmBlcRMYx5D9454LlKVImvRNHBC6rBpchMLVq
         h462453KAFzMbXnw4Uyt4LG45KJFKeIJECtM7uupJQwNgt4XBzQtF6Ik4Udj6JIp6qxO
         /rjQ==
X-Received: by 10.70.136.67 with SMTP id py3mr20448762pdb.112.1434626802644;
        Thu, 18 Jun 2015 04:26:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271983>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will refuse to apply patches if the index is dirty. Re-implement this
behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    Note: no tests for this

 builtin/am.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index a7efe85..9d6ab2a 100644
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
@@ -486,6 +488,43 @@ static void refresh_and_write_cache(void)
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
@@ -622,8 +661,15 @@ static void do_commit(const struct am_state *state)
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
