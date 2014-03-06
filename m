From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 07/11] trailer: add interpret-trailers command
Date: Thu, 06 Mar 2014 23:14:04 +0100
Message-ID: <20140306221409.29648.33429.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo98-00089r-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaCGGU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:20:28 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:62796 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbaCGGUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:20:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 520F43A;
	Fri,  7 Mar 2014 07:20:24 +0100 (CET)
X-git-sha1: 6750a1f9be085666252dc8b90b859c02e9f3ce90 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243595>

This patch adds the "git interpret-trailers" command.
This command uses the previously added process_trailers()
function in trailer.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                   |  1 +
 Makefile                     |  1 +
 builtin.h                    |  1 +
 builtin/interpret-trailers.c | 33 +++++++++++++++++++++++++++++++++
 git.c                        |  1 +
 5 files changed, 37 insertions(+)
 create mode 100644 builtin/interpret-trailers.c

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
index 0000000..0c8ca72
--- /dev/null
+++ b/builtin/interpret-trailers.c
@@ -0,0 +1,33 @@
+/*
+ * Builtin "git interpret-trailers"
+ *
+ * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
+ *
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "trailer.h"
+
+static const char * const git_interpret_trailers_usage[] = {
+	N_("git interpret-trailers [--trim-empty] [(<token>[(=|:)<value>])...]"),
+	NULL
+};
+
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
+{
+	int trim_empty = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_interpret_trailers_usage, 0);
+
+	process_trailers(trim_empty, argc, argv);
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
-- 
1.8.5.2.204.gcfe299d.dirty
