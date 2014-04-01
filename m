From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 07/11] trailer: add interpret-trailers command
Date: Tue, 01 Apr 2014 21:20:18 +0200
Message-ID: <20140401192023.353.4997.chriscool@tuxfamily.org>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4Jl-0003Fj-3U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbaDATZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:25:43 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:38417 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbaDATZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:25:10 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5D51478;
	Tue,  1 Apr 2014 21:25:09 +0200 (CEST)
X-git-sha1: 0659cd75ba36595b1e98860326517c90adf5f349 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140401191831.353.99271.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245630>

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
index dc600f9..c2a0b19 100644
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
index ec67ae1..94f7e95 100644
--- a/Makefile
+++ b/Makefile
@@ -947,6 +947,7 @@ BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index c47c110..8ca0065 100644
--- a/builtin.h
+++ b/builtin.h
@@ -73,6 +73,7 @@ extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
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
index 7cf2953..63a03eb 100644
--- a/git.c
+++ b/git.c
@@ -380,6 +380,7 @@ static struct cmd_struct commands[] = {
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
+	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-- 
1.9.0.164.g3aa33cd.dirty
