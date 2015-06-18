From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 10/31] am: refresh the index at start
Date: Thu, 18 Jun 2015 19:25:22 +0800
Message-ID: <1434626743-8552-11-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xy7-0004tB-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbbFRL0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33737 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbbFRL0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:40 -0400
Received: by padev16 with SMTP id ev16so59556134pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gX/m9qiYv5olpRQwFhm0nKLhaPXcKUW5oll54mhakGE=;
        b=Jl3yuJmWcc9dDw3Lay2eDNJHGkRvMu8kyjuo1VSyoVTOZO03XyNKR0vSfVh1XIcfi1
         F/twabw2OxnwLl1K4dYJ5GcGvlo3j8PfUJiAhT2qC86qPbuZcF08Yx2TWOvdZjGg+Wdc
         IH0YEg9niWIdYq9arG6fv+2Wp0grR/wRPe8XxwHAe4dTbE2zrwzrTMeOJDfw64mE0aBi
         m/mOnUcwN+xEj5YoGqBjuXiO17bSwX/1AkFNRUszJnR7h9N0wy7gZ2LD82H8WNiAFkID
         I/yf9SYivIMEWnjM9EEIDhX/HzEcwBgjhTRCX1meAw+VMGb3V7JOoJ781sM3GJkF41sO
         Decg==
X-Received: by 10.69.26.170 with SMTP id iz10mr20072041pbd.81.1434626799569;
        Thu, 18 Jun 2015 04:26:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271975>

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
index dfb6f7e..a7efe85 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -13,6 +13,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "commit.h"
+#include "lockfile.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -471,6 +472,20 @@ static const char *msgnum(const struct am_state *state)
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
@@ -607,6 +622,8 @@ static void do_commit(const struct am_state *state)
  */
 static void am_run(struct am_state *state)
 {
+	refresh_and_write_cache();
+
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
 
@@ -696,6 +713,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
 
+	if (read_index_preload(&the_index, NULL) < 0)
+		die(_("failed to read the index"));
+
 	if (am_in_progress(&state))
 		am_load(&state);
 	else {
-- 
2.1.4
