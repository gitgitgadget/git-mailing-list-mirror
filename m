From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 10/14] trailer: execute command from
 'trailer.<name>.command'
Date: Thu, 06 Feb 2014 21:19:59 +0100
Message-ID: <20140206202004.325.54178.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVTN-00052T-MO
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbaBFUWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:22:08 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:40512 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbaBFUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:21:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 6A6AE61;
	Thu,  6 Feb 2014 21:21:24 +0100 (CET)
X-git-sha1: 495018e100c92e8f8c212f6c531787009bd6762c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140206194123.325.99451.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241739>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/trailer.c b/trailer.c
index 108e104..98187fc 100644
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
@@ -56,6 +60,13 @@ static inline int contains_only_spaces(const char *str)
 	return !*s;
 }
 
+static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *b)
+{
+	const char *ptr = strstr(sb->buf, a);
+	if (ptr)
+		strbuf_splice(sb, ptr - sb->buf, strlen(a), b, strlen(b));
+}
+
 static void print_tok_val(const char *tok, const char *val)
 {
 	char c = tok[strlen(tok) - 1];
@@ -375,6 +386,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			if (conf->command)
 				warning(_("more than one %s"), orig_conf_key);
 			conf->command = xstrdup(value);
+			conf->command_uses_arg = !!strstr(conf->command, TRAILER_ARG_STRING);
 			break;
 		case TRAILER_WHERE:
 			if (set_where(conf, value))
@@ -411,6 +423,45 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tr
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
@@ -420,6 +471,8 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 	if (conf_item) {
 		new->conf = conf_item->conf;
 		new->token = xstrdup(conf_item->conf->key);
+		if (conf_item->conf->command_uses_arg || !val)
+			new->value = apply_command(conf_item->conf->command, val);
 	} else {
 		new->conf = xcalloc(sizeof(struct conf_info), 1);
 		new->token = tok;
@@ -470,12 +523,22 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
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
1.8.5.2.206.g98f5689.dirty
