From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 15/16] trailer: set author and committer env variables
Date: Sun, 19 Jan 2014 09:53:53 +0100
Message-ID: <20140119085355.2734.55181.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAR-0008R0-DH
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaASIzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:38 -0500
Received: from [194.158.98.15] ([194.158.98.15]:50036 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752030AbaASIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:55:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 737BA5F;
	Sun, 19 Jan 2014 09:54:34 +0100 (CET)
X-git-sha1: ae2c68f8773d845591b850f5268a3f3923e9ff8f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240685>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 549d381..3b21f57 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "argv-array.h"
 /*
  * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -415,14 +416,40 @@ static int read_from_command(struct child_process *cp, struct strbuf *buf)
 	return 0;
 }
 
+static void setup_ac_env(struct argv_array *env, const char *ac_name, const char *ac_mail, const char *(*read)(int))
+{
+	if (!getenv(ac_name) || !getenv(ac_mail)) {
+		struct ident_split ident;
+		const char *namebuf, *mailbuf;
+		int namelen, maillen;
+		const char *ac_info = read(IDENT_NO_DATE);
+
+		if (split_ident_line(&ident, ac_info, strlen(ac_info)))
+			return;
+
+		namelen = ident.name_end - ident.name_begin;
+		namebuf = ident.name_begin;
+
+		maillen = ident.mail_end - ident.mail_begin;
+		mailbuf = ident.mail_begin;
+
+		argv_array_pushf(env, "%s=%.*s", ac_name, namelen, namebuf);
+		argv_array_pushf(env, "%s=%.*s", ac_mail, maillen, mailbuf);
+	}
+}
+
 static const char *apply_command(const char *command, const char *arg)
 {
+	struct argv_array env = ARGV_ARRAY_INIT;
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp;
 	const char *argv[] = {NULL, NULL};
 	const char *result = "";
 
+	setup_ac_env(&env, "GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL", git_author_info);
+	setup_ac_env(&env, "GIT_COMMITTER_NAME", "GIT_COMMITTER_EMAIL", git_committer_info);
+
 	strbuf_addstr(&cmd, command);
 	if (arg)
 		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
@@ -430,7 +457,7 @@ static const char *apply_command(const char *command, const char *arg)
 	argv[0] = cmd.buf;
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
-	cp.env = local_repo_env;
+	cp.env = env.argv;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.use_shell = 1;
@@ -441,6 +468,7 @@ static const char *apply_command(const char *command, const char *arg)
 		result = strbuf_detach(&buf, NULL);
 
 	strbuf_release(&cmd);
+	argv_array_clear(&env);
 	return result;
 }
 
-- 
1.8.5.2.201.gacc5987
