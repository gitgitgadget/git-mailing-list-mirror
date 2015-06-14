From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 04/19] pull: implement skeletal builtin pull
Date: Sun, 14 Jun 2015 16:41:51 +0800
Message-ID: <1434271326-11349-5-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43VB-0006Di-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbFNImp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:42:45 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34707 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFNImi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:38 -0400
Received: by pacgb13 with SMTP id gb13so16496767pac.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbwISO09lKIoOb2HmToJLMLbjMmBsDQXdqrXHywOgQE=;
        b=L6bbD1G0eX00XEbzAMr94/aZuTGtvh2jBPhe5ASY4gHybBwbgE2zAL0ppmy20Xw6v4
         qNZi8NFTvGhLTkZvCJKMutspxw9B8g0jncsbIrk3qGJRMdWQAMdK/flFgk3eZu9DAXa9
         /ZoCvhO42ECdQrpigX5TP1E3RWqbGjeI9PWZ+K2v2UElL0JGDeXHtLmY24sc123yNRI1
         +xZN6GM/C4wrhRQLBL5gsuguXtDxIPyUHG9YdIfm6vwIybz0my/wSTftjasSQm/uQK2T
         /EZ5hkuqbNto8dQXO4MhwwGufxc+88c1oOIKJ7m9p8DMENZiaOpcymP85FG3ZAKJQjf8
         XZGA==
X-Received: by 10.68.69.48 with SMTP id b16mr37591470pbu.144.1434271357725;
        Sun, 14 Jun 2015 01:42:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271619>

For the purpose of rewriting git-pull.sh into a C builtin, implement a
skeletal builtin/pull.c that redirects to $GIT_EXEC_PATH/git-pull.sh if
the environment variable _GIT_USE_BUILTIN_PULL is not defined. This
allows us to fall back on the functional git-pull.sh when running the
test suite for tests that depend on a working git-pull implementation.

This redirection should be removed when all the features of git-pull.sh
have been re-implemented in builtin/pull.c.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * style fixes

 Makefile       |  1 +
 builtin.h      |  1 +
 builtin/pull.c | 33 +++++++++++++++++++++++++++++++++
 git.c          |  1 +
 4 files changed, 36 insertions(+)
 create mode 100644 builtin/pull.c

diff --git a/Makefile b/Makefile
index 54ec511..2057a9d 100644
--- a/Makefile
+++ b/Makefile
@@ -877,6 +877,7 @@ BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
+BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
diff --git a/builtin.h b/builtin.h
index b87df70..ea3c834 100644
--- a/builtin.h
+++ b/builtin.h
@@ -98,6 +98,7 @@ extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
+extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pull.c b/builtin/pull.c
new file mode 100644
index 0000000..cabeed4
--- /dev/null
+++ b/builtin/pull.c
@@ -0,0 +1,33 @@
+/*
+ * Builtin "git pull"
+ *
+ * Based on git-pull.sh by Junio C Hamano
+ *
+ * Fetch one or more remote refs and merge it/them into the current HEAD.
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "exec_cmd.h"
+
+static const char * const pull_usage[] = {
+	NULL
+};
+
+static struct option pull_options[] = {
+	OPT_END()
+};
+
+int cmd_pull(int argc, const char **argv, const char *prefix)
+{
+	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
+		const char *path = mkpath("%s/git-pull", git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+	}
+
+	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 44374b1..e7a7713 100644
--- a/git.c
+++ b/git.c
@@ -445,6 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "receive-pack", cmd_receive_pack },
-- 
2.1.4
