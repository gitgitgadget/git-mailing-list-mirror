From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 04/19] pull: implement skeletal builtin pull
Date: Wed,  3 Jun 2015 14:48:48 +0800
Message-ID: <1433314143-4478-5-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02V3-0004UJ-NB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbbFCGuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35421 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbbFCGt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:49:57 -0400
Received: by padjw17 with SMTP id jw17so692267pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpJt7kEyeWxC9acH5Js5dG4BBIMVskmY61CuL1ZIJsE=;
        b=oIFYqeZOhWOgo+94YUgUWR76XEoMbqv6c4m/TABTbhzPFDTbIeucj1J9Zb0csEkGaJ
         UDOWlvwiVcS993FAlPwQZlO3piviUkr8sAQY27Swqv4jC0dZgfdnMpXwgjtpN3ksBbVF
         ZlKN0zNfjUamRFSHs9LwJj6jsLlpF4uF95wtybWysZLg3Mq2Z1dOssY1tUGXuHZV0asu
         KU1rBmoHkTjrcVIXnJrnqKGPrXqVX4xN2kqF9OjzJS+ZsxQeBokWjKhojbgnzuTL74wc
         lRtsKf+XjjM4EfvtF37jmWgoMDJCiWzVt8kGy9eLoyjoTB9MpFpA9bZido3/bUq1gDe0
         3cOA==
X-Received: by 10.68.113.194 with SMTP id ja2mr19262658pbb.163.1433314196824;
        Tue, 02 Jun 2015 23:49:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270642>

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
index 0000000..f8b79a2
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
+		if (sane_execvp(path, (char**) argv) < 0)
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
