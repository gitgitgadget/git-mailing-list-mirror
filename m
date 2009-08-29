From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] update-server-info: make builtin, use parseopt
Date: Sat, 29 Aug 2009 11:04:52 +0200
Message-ID: <4A98EF34.8050206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 29 11:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhJs7-0006BP-43
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 11:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbZH2JFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 05:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZH2JFC
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 05:05:02 -0400
Received: from india601.server4you.de ([85.25.151.105]:55524 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZH2JFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 05:05:00 -0400
Received: from [10.0.1.101] (p57B7EDE1.dip.t-dialin.net [87.183.237.225])
	by india601.server4you.de (Postfix) with ESMTPSA id 1A79A2F8070;
	Sat, 29 Aug 2009 11:05:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127378>

Convert git update-server-info to a built-in command and use parseopt.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile                     |    2 +-
 builtin-update-server-info.c |   25 +++++++++++++++++++++++++
 builtin.h                    |    1 +
 git.c                        |    1 +
 update-server-info.c         |   28 ----------------------------
 5 files changed, 28 insertions(+), 29 deletions(-)
 create mode 100644 builtin-update-server-info.c
 delete mode 100644 update-server-info.c

diff --git a/Makefile b/Makefile
index d842e52..a614347 100644
--- a/Makefile
+++ b/Makefile
@@ -357,7 +357,6 @@ PROGRAMS += git-patch-id$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
-PROGRAMS += git-update-server-info$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
 
@@ -636,6 +635,7 @@ BUILTIN_OBJS += builtin-tar-tree.o
 BUILTIN_OBJS += builtin-unpack-objects.o
 BUILTIN_OBJS += builtin-update-index.o
 BUILTIN_OBJS += builtin-update-ref.o
+BUILTIN_OBJS += builtin-update-server-info.o
 BUILTIN_OBJS += builtin-upload-archive.o
 BUILTIN_OBJS += builtin-verify-pack.o
 BUILTIN_OBJS += builtin-verify-tag.o
diff --git a/builtin-update-server-info.c b/builtin-update-server-info.c
new file mode 100644
index 0000000..2b3fddc
--- /dev/null
+++ b/builtin-update-server-info.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const update_server_info_usage[] = {
+	"git update-server-info [--force]",
+	NULL
+};
+
+int cmd_update_server_info(int argc, const char **argv, const char *prefix)
+{
+	int force = 0;
+	struct option options[] = {
+		OPT_BOOLEAN('f', "force", &force,
+			"update the info files from scratch"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     update_server_info_usage, 0);
+	if (argc > 0)
+		usage_with_options(update_server_info_usage, options);
+
+	return !!update_server_info(force);
+}
diff --git a/builtin.h b/builtin.h
index 51e4ba7..a2174dc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,6 +102,7 @@ extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
+extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 5da6c65..0b22595 100644
--- a/git.c
+++ b/git.c
@@ -359,6 +359,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
+		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
diff --git a/update-server-info.c b/update-server-info.c
deleted file mode 100644
index 7b38fd8..0000000
--- a/update-server-info.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include "cache.h"
-#include "exec_cmd.h"
-
-static const char update_server_info_usage[] =
-"git update-server-info [--force]";
-
-int main(int ac, char **av)
-{
-	int i;
-	int force = 0;
-	for (i = 1; i < ac; i++) {
-		if (av[i][0] == '-') {
-			if (!strcmp("--force", av[i]) ||
-			    !strcmp("-f", av[i]))
-				force = 1;
-			else
-				usage(update_server_info_usage);
-		}
-	}
-	if (i != ac)
-		usage(update_server_info_usage);
-
-	git_extract_argv0_path(av[0]);
-
-	setup_git_directory();
-
-	return !!update_server_info(force);
-}
-- 
1.6.4.1
