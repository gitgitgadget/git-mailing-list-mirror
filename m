From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Thu, 11 Jun 2015 18:21:49 +0800
Message-ID: <1434018125-31804-4-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zd0-0007gk-2P
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbFKKW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33790 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbFKKWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:24 -0400
Received: by padev16 with SMTP id ev16so1888063pad.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooH9dQX4inx9jK/oPd6YV5820shf85a/KTvcwc8JpMM=;
        b=GhRnS96IH55thCIKd7ed3psVWo9zpWxShpvSQlwkjVtMCulR2hktMLUeoWWXSalJ4a
         mh/G5D4m4bB452nV29ujfDptkyq2JAbv52lS4jvLejmX+FvafGkBSEESFy2/Pn49u+Js
         Gk9pn744LY7IQKNcDFzzWg3Kj4pahcUoLtvQY1ylBQ8APgsIcdWfbjfAPzGVuJhSAL3V
         jZ3WgdfSUbA2Rn1G29B2etYoMNSomp374+6xOV0JkHUA6JQkkfPZxv7+9ofBo+/vnHww
         DF6JeNjE5hO96vf7sj1lETJZnnQV4oadJWtIu+RgCBTVOy54CffMc2xBm/ejfhb7eqlH
         gVTg==
X-Received: by 10.70.33.67 with SMTP id p3mr13647928pdi.126.1434018143736;
        Thu, 11 Jun 2015 03:22:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271384>

For the purpose of rewriting git-am.sh into a C builtin, implement a
skeletal builtin/am.c that redirects to $GIT_EXEC_PATH/git-am if the
environment variable _GIT_USE_BUILTIN_AM is not defined. Since in the
Makefile git-am.sh takes precedence over builtin/am.c,
$GIT_EXEC_PATH/git-am will contain the shell script git-am.sh, and thus
this allows us to fall back on the functional git-am.sh when running the
test suite for tests that depend on a working git-am implementation.

This redirection will be removed when all the features of git-am.sh have
been re-implemented in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Declare struct am_state state as static.

 Makefile     |  1 +
 builtin.h    |  1 +
 builtin/am.c | 20 ++++++++++++++++++++
 git.c        |  1 +
 4 files changed, 23 insertions(+)
 create mode 100644 builtin/am.c

diff --git a/Makefile b/Makefile
index 54ec511..b82ba0e 100644
--- a/Makefile
+++ b/Makefile
@@ -812,6 +812,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
diff --git a/builtin.h b/builtin.h
index b87df70..d50c9d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const unsigned char
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
diff --git a/builtin/am.c b/builtin/am.c
new file mode 100644
index 0000000..0ccbe33
--- /dev/null
+++ b/builtin/am.c
@@ -0,0 +1,20 @@
+/*
+ * Builtin "git am"
+ *
+ * Based on git-am.sh by Junio C Hamano.
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+
+int cmd_am(int argc, const char **argv, const char *prefix)
+{
+	if (!getenv("_GIT_USE_BUILTIN_AM")) {
+		const char *path = mkpath("%s/git-am", git_exec_path());
+
+		if (sane_execvp(path, (char**) argv) < 0)
+			die_errno("could not exec %s", path);
+	}
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 44374b1..42328ed 100644
--- a/git.c
+++ b/git.c
@@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive },
-- 
2.1.4
