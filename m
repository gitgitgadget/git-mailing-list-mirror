From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 07/11] trailer: add interpret-trailers command
Date: Sun, 25 May 2014 07:32:18 +0200
Message-ID: <20140525053223.5329.1794.chriscool@tuxfamily.org>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 07:46:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoRGc-0005Qh-4g
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 07:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaEYFqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 01:46:30 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:55771 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbaEYFqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 01:46:12 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1356B5C;
	Sun, 25 May 2014 07:46:11 +0200 (CEST)
X-git-sha1: 253cf20d0a23dcdea805a83e38ff4d61b0e0b4ea 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250076>

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
1.9.rc0.17.g651113e
