From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 07/17] rebase-common: implement refresh_and_write_cache()
Date: Sat, 12 Mar 2016 18:46:27 +0800
Message-ID: <1457779597-6918-8-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4x-0005u9-WE
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbcCLKrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:25 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34162 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbcCLKrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:17 -0500
Received: by mail-pa0-f42.google.com with SMTP id fe3so103223303pab.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voVfNRlTjYNXnrHVtcbut4jVU3tBeXpBr5UhlRAUr2M=;
        b=zgEukKscH9QhBjxVgw2WFuPA9Dl1vra8KC9tEZGu0H0zB9ovVgu+JeJlHqg80om1Mp
         VYAqVd0oG2TL8mG7iptvZ8U+6uWvq4C9h82HY8jP/okjRmzfwgCs/ioBzjsXGQiXbqZy
         4Q322DPgN00lWgaMnBphWvHgw/1GbR40DQNKrCYwBQO/xYv4i1ejiaTy1gyVeROXTP4Z
         G2JCpIgkAIQeINunW2E6yV21plQbZ4I7cYe1diPKUKyCg8FiE3/mfeZqbkor1raDiiSM
         3aVlB6DZNztkrGiKwH3cz/c58PbYklezUIQsIKx5Vrok9TvN+0uGCd/cECFVUQig4c03
         t+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voVfNRlTjYNXnrHVtcbut4jVU3tBeXpBr5UhlRAUr2M=;
        b=IczUEaodpGiFiy9RSbYRy1046wmobbjRjQ+iB2y2FGuzfgNAHA9UdJS6M5NBONloRK
         7y4Ae4RQ92HinxrCtWG7QkRcEgNCegdxTdDyITzGnzf+ABlQj8G+0L9ehjwbY0MptWb+
         L+QeKyEF/d4UqVCI7kjX1ztNQVExZyV4hBjxaRsr+nBSoPpCZr2SDtIzSBUmMs0EjDL7
         ZXmwTfyvV/HsmkXMWM1ZsDmMHorL0w0iDbQGbL3VjydekjsbzChYoNr1LgNlVug3kjNQ
         osz1CCISWH+UBhhs+m9JVx6r8ZImfs2I7t0rJkCYo+xE8hcjZxlSisBydTZMrlo8WfzX
         /CCw==
X-Gm-Message-State: AD7BkJKQTo/MhNnrTXntCLNJipSFTpODzT3i9DickbLFuA6P7IEvHwyXobEyfdOJ0PpasQ==
X-Received: by 10.66.97.8 with SMTP id dw8mr22929828pab.28.1457779636917;
        Sat, 12 Mar 2016 02:47:16 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:15 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288738>

In the upcoming git-rebase to C rewrite, it is a common operation to
refresh the index and write the resulting index.

builtin/am.c already implements refresh_and_write_cache(), which is what
we want. Move it to rebase-common.c, so that it can be shared with all
the rebase backends, including git-am.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c    | 14 +-------------
 rebase-common.c | 11 +++++++++++
 rebase-common.h |  5 +++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d003939..504b604 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "rebase-common.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1125,19 +1126,6 @@ static const char *msgnum(const struct am_state *state)
 }
 
 /**
- * Refresh and write index.
- */
-static void refresh_and_write_cache(void)
-{
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
-
-	hold_locked_index(lock_file, 1);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write index file"));
-}
-
-/**
  * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
  * branch, returns 1 if there are entries in the index, 0 otherwise. If an
  * strbuf is provided, the space-separated list of files that differ will be
diff --git a/rebase-common.c b/rebase-common.c
index 8169fb6..b07e1f1 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -3,6 +3,17 @@
 #include "dir.h"
 #include "run-command.h"
 #include "refs.h"
+#include "lockfile.h"
+
+void refresh_and_write_cache(void)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+
+	hold_locked_index(lock_file, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write index file"));
+}
 
 void rebase_options_init(struct rebase_options *opts)
 {
diff --git a/rebase-common.h b/rebase-common.h
index 067ad0b..8620e8c 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -1,6 +1,11 @@
 #ifndef REBASE_COMMON_H
 #define REBASE_COMMON_H
 
+/**
+ * Refresh and write index.
+ */
+void refresh_and_write_cache(void);
+
 /* common rebase backend options */
 struct rebase_options {
 	struct object_id onto;
-- 
2.7.0
