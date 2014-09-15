From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 07/11] trailer: add interpret-trailers command
Date: Mon, 15 Sep 2014 07:31:37 +0200
Message-ID: <20140915053142.26573.41071.chriscool@tuxfamily.org>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 07:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTP79-0001MG-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 07:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbaIOFqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 01:46:05 -0400
Received: from delay-5y.bbox.fr ([194.158.98.76]:41109 "EHLO delay-5y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbaIOFqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 01:46:03 -0400
Received: from mail-1y.bbox.fr (bt8sssom.cs.dolmen.bouyguestelecom.fr [172.24.208.144])
	by delay-5y.bbox.fr (Postfix) with ESMTP id DE01662728
	for <git@vger.kernel.org>; Mon, 15 Sep 2014 07:36:29 +0200 (CEST)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 319493A;
	Mon, 15 Sep 2014 07:34:08 +0200 (CEST)
X-git-sha1: 5f1db0358a76f5f7838aebd82fa43747402352ca 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140915052330.26573.34823.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257036>

This patch adds the "git interpret-trailers" command.
This command uses the previously added process_trailers()
function in trailer.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                   |  1 +
 Makefile                     |  1 +
 builtin.h                    |  1 +
 builtin/interpret-trailers.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 git.c                        |  1 +
 5 files changed, 48 insertions(+)
 create mode 100644 builtin/interpret-trailers.c

diff --git a/.gitignore b/.gitignore
index cf0d191..85593de 100644
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
index ef82972..0b06ae0 100644
--- a/Makefile
+++ b/Makefile
@@ -953,6 +953,7 @@ BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index 5d91f31..b87df70 100644
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
index 0000000..46838d2
--- /dev/null
+++ b/builtin/interpret-trailers.c
@@ -0,0 +1,44 @@
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
+#include "string-list.h"
+#include "trailer.h"
+
+static const char * const git_interpret_trailers_usage[] = {
+	N_("git interpret-trailers [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
+	NULL
+};
+
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
+{
+	int trim_empty = 0;
+	struct string_list trailers = STRING_LIST_INIT_DUP;
+
+	struct option options[] = {
+		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
+				N_("trailer(s) to add")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_interpret_trailers_usage, 0);
+
+	if (argc) {
+		int i;
+		for (i = 0; i < argc; i++)
+			process_trailers(argv[i], trim_empty, &trailers);
+	} else
+		process_trailers(NULL, trim_empty, &trailers);
+
+	string_list_clear(&trailers, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 5ebb32f..e327a90 100644
--- a/git.c
+++ b/git.c
@@ -417,6 +417,7 @@ static struct cmd_struct commands[] = {
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
+	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-- 
2.0.3.960.g41c6e4c
