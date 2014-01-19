From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/16] trailer: add interpret-trailers command
Date: Sun, 19 Jan 2014 09:53:46 +0100
Message-ID: <20140119085355.2734.96098.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAN-0008R0-Uh
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbaASIz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:26 -0500
Received: from [194.158.98.14] ([194.158.98.14]:46062 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752012AbaASIyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1E45063;
	Sun, 19 Jan 2014 09:54:30 +0100 (CET)
X-git-sha1: bcac432403d17a9b09ec721f7d2dff4ae869011a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240679>

This patch adds the "git interpret-trailers" command.
This command uses the previously added process_trailers()
function in trailer.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                   |  1 +
 Makefile                     |  1 +
 builtin.h                    |  1 +
 builtin/interpret-trailers.c | 36 ++++++++++++++++++++++++++++++++++++
 git.c                        |  1 +
 trailer.h                    |  6 ++++++
 6 files changed, 46 insertions(+)
 create mode 100644 builtin/interpret-trailers.c
 create mode 100644 trailer.h

diff --git a/.gitignore b/.gitignore
index b5f9def..c870ada 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@
 /git-index-pack
 /git-init
 /git-init-db
+/git-interpret-trailers
 /git-instaweb
 /git-log
 /git-ls-files
diff --git a/Makefile b/Makefile
index ec90feb..a91465e 100644
--- a/Makefile
+++ b/Makefile
@@ -935,6 +935,7 @@ BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index d4afbfe..30f4c30 100644
--- a/builtin.h
+++ b/builtin.h
@@ -71,6 +71,7 @@ extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
+extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
new file mode 100644
index 0000000..f79bffa
--- /dev/null
+++ b/builtin/interpret-trailers.c
@@ -0,0 +1,36 @@
+/*
+ * Builtin "git interpret-trailers"
+ *
+ * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
+ *
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "strbuf.h"
+#include "trailer.h"
+
+static const char * const git_interpret_trailers_usage[] = {
+	N_("git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]"),
+	NULL
+};
+
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
+{
+	const char *infile = NULL;
+	int trim_empty = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_interpret_trailers_usage, 0);
+
+	process_trailers(infile, trim_empty, argc, argv);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 3799514..1420b58 100644
--- a/git.c
+++ b/git.c
@@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
+		{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
 		{ "log", cmd_log, RUN_SETUP },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/trailer.h b/trailer.h
new file mode 100644
index 0000000..9db4459
--- /dev/null
+++ b/trailer.h
@@ -0,0 +1,6 @@
+#ifndef TRAILER_H
+#define TRAILER_H
+
+void process_trailers(const char *infile, int trim_empty, int argc, const char **argv);
+
+#endif /* TRAILER_H */
-- 
1.8.5.2.201.gacc5987
