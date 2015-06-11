From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 10/19] am: refresh the index at start
Date: Thu, 11 Jun 2015 18:21:56 +0800
Message-ID: <1434018125-31804-11-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdL-0007sw-VK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbbFKKWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35999 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbFKKWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:45 -0400
Received: by pabqy3 with SMTP id qy3so1789577pab.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZvBEU6IpYpRYFICaLKu50q5AAIlsxKb3Xvtv4BHTUs=;
        b=XLXEk738gxq3lvwaE3gnO5/lk3hUeLxUL7T/d3WAvPsk7UBCtmrHNfz9Cnv0XRUc6+
         9YsZ1itve6waWPkjW6x72aoZ28f0k8gnvc1Ra/1tnpCxFw9z3PrKu7eNimhIOE5nxwk2
         vpW8OPGfYNLbpHn3t8+ahkG8qFr9k/uPfXYIpzwwkjIT+9DjWstJUdpu0y2EK/kSia78
         jazmGgn+8gMuXFlDDqOco1fpRyfNBYq2PC4JjmokxtlvbfrNTYHalgVNvLD8kZzOUA8f
         2Not9SsJWOu2QHLR4hZyg4/1WP2kxwjVZxRTg8at2LZiDnh6GLuGDkbvAvT9PJKs48k5
         5yjw==
X-Received: by 10.70.133.36 with SMTP id oz4mr13805461pdb.65.1434018165408;
        Thu, 11 Jun 2015 03:22:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271389>

If a file is unchanged but stat-dirty, git-apply may erroneously fail to
apply patches, thinking that they conflict with a dirty working tree.

As such, since 2a6f08a (am: refresh the index at start and --resolved,
2011-08-15), git-am will refresh the index before applying patches.
Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index ecc6d29..417bfde 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -13,6 +13,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "commit.h"
+#include "lockfile.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -457,6 +458,20 @@ static const char *msgnum(const struct am_state *state)
 }
 
 /**
+ * Refresh and write index.
+ */
+static void refresh_and_write_cache(void)
+{
+	static struct lock_file lock_file;
+
+	hold_locked_index(&lock_file, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		die(_("unable to write index file"));
+	rollback_lock_file(&lock_file);
+}
+
+/**
  * Parses `patch` using git-mailinfo. state->msg will be set to the patch
  * message. state->author_name, state->author_email, state->author_date will be
  * set to the patch author's name, email and date respectively. The patch's
@@ -597,6 +612,8 @@ static void do_commit(const struct am_state *state)
  */
 static void am_run(struct am_state *state)
 {
+	refresh_and_write_cache();
+
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
 
@@ -678,6 +695,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
 
+	if (read_index_preload(&the_index, NULL) < 0)
+		die(_("failed to read the index"));
+
 	if (am_in_progress(&state))
 		am_load(&state);
 	else {
-- 
2.1.4
