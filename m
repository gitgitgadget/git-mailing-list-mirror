From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 13/17] trailer: execute command from
 'trailer.<name>.command'
Date: Sun, 26 Jan 2014 18:00:06 +0100
Message-ID: <20140126170011.24291.18469.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TRW-0004P4-8B
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaAZRYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:24:05 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:65146 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbaAZRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:24:03 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 453A855;
	Sun, 26 Jan 2014 18:24:02 +0100 (CET)
X-git-sha1: 01cb5731d73ed727b3530d416229bbb952c97da3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241099>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/trailer.c b/trailer.c
index 6eec3ce..dc81a01 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 /*
  * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -12,11 +13,14 @@ struct conf_info {
 	char *name;
 	char *key;
 	char *command;
+	unsigned command_uses_arg : 1;
 	enum action_where where;
 	enum action_if_exist if_exist;
 	enum action_if_missing if_missing;
 };
 
+#define TRAILER_ARG_STRING "$ARG"
+
 struct trailer_item {
 	struct trailer_item *previous;
 	struct trailer_item *next;
@@ -368,6 +372,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			if (conf->command)
 				warning(_("more than one %s"), orig_conf_key);
 			conf->command = xstrdup(value);
+			conf->command_uses_arg = !!strstr(conf->command, TRAILER_ARG_STRING);
 		} else if (type == TRAILER_WHERE) {
 			if (set_where(conf, value))
 				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
@@ -400,6 +405,45 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tr
 	}
 }
 
+static int read_from_command(struct child_process *cp, struct strbuf *buf)
+{
+	if (run_command(cp))
+		return error("running trailer command '%s' failed", cp->argv[0]);
+	if (strbuf_read(buf, cp->out, 1024) < 1)
+		return error("reading from trailer command '%s' failed", cp->argv[0]);
+	strbuf_trim(buf);
+	return 0;
+}
+
+static const char *apply_command(const char *command, const char *arg)
+{
+	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;
+	const char *argv[] = {NULL, NULL};
+	const char *result = "";
+
+	strbuf_addstr(&cmd, command);
+	if (arg)
+		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+
+	argv[0] = cmd.buf;
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.use_shell = 1;
+
+	if (read_from_command(&cp, &buf))
+		strbuf_release(&buf);
+	else
+		result = strbuf_detach(&buf, NULL);
+
+	strbuf_release(&cmd);
+	return result;
+}
+
 static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 					     const char* tok, const char* val)
 {
@@ -409,6 +453,8 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 	if (conf_item) {
 		new->conf = conf_item->conf;
 		new->token = xstrdup(conf_item->conf->key);
+		if (conf_item->conf->command_uses_arg || !val)
+			new->value = apply_command(conf_item->conf->command, val);
 	} else {
 		new->conf = xcalloc(sizeof(struct conf_info), 1);
 		new->token = tok;
@@ -459,12 +505,22 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 	int i;
 	struct trailer_item *arg_tok_first = NULL;
 	struct trailer_item *arg_tok_last = NULL;
+	struct trailer_item *item;
 
 	for (i = 0; i < argc; i++) {
 		struct trailer_item *new = create_trailer_item(argv[i]);
 		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
 	}
 
+	/* Add conf commands that don't use $ARG */
+	for (item = first_conf_item; item; item = item->next) {
+		if (item->conf->command && !item->conf->command_uses_arg)
+		{
+			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
+			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+		}
+	}
+
 	return arg_tok_first;
 }
 
-- 
1.8.5.2.201.gacc5987
