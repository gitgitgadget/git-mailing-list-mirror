From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 09/12] trailer: execute command from
 'trailer.<name>.command'
Date: Sun, 06 Apr 2014 19:02:00 +0200
Message-ID: <20140406170204.15116.67057.chriscool@tuxfamily.org>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 07 20:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEX4-0003gs-05
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbaDGSoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:24 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:50984 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013AbaDGSoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:44:05 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 7A7F858;
	Mon,  7 Apr 2014 20:44:03 +0200 (CEST)
X-git-sha1: 9ef3fc2d8e1b8ad8ebb0c41ba65a2c6473425103 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245879>

Let the user specify a command that will give on its standard output
the value to use for the specified trailer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/trailer.c b/trailer.c
index 16465e5..09db2c2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 #include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
@@ -13,11 +14,14 @@ struct conf_info {
 	char *name;
 	char *key;
 	char *command;
+	unsigned command_uses_arg : 1;
 	enum action_where where;
 	enum action_if_exists if_exists;
 	enum action_if_missing if_missing;
 };
 
+#define TRAILER_ARG_STRING "$ARG"
+
 struct trailer_item {
 	struct trailer_item *previous;
 	struct trailer_item *next;
@@ -59,6 +63,13 @@ static inline int contains_only_spaces(const char *str)
 	return !*s;
 }
 
+static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *b)
+{
+	const char *ptr = strstr(sb->buf, a);
+	if (ptr)
+		strbuf_splice(sb, ptr - sb->buf, strlen(a), b, strlen(b));
+}
+
 static void free_trailer_item(struct trailer_item *item)
 {
 	free(item->conf.name);
@@ -402,6 +413,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 		if (conf->command)
 			warning(_("more than one %s"), conf_key);
 		conf->command = xstrdup(value);
+		conf->command_uses_arg = !!strstr(conf->command, TRAILER_ARG_STRING);
 		break;
 	case TRAILER_WHERE:
 		if (set_where(conf, value))
@@ -438,6 +450,45 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 	return 0;
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
+	const char *result;
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
+	if (read_from_command(&cp, &buf)) {
+		strbuf_release(&buf);
+		result = xstrdup("");
+	} else
+		result = strbuf_detach(&buf, NULL);
+
+	strbuf_release(&cmd);
+	return result;
+}
 
 static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
 {
@@ -468,6 +519,10 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 		duplicate_conf(&new->conf, &conf_item->conf);
 		new->token = xstrdup(token_from_item(conf_item));
 		free(tok);
+		if (conf_item->conf.command_uses_arg || !val) {
+			new->value = apply_command(conf_item->conf.command, val);
+			free(val);
+		}
 	} else
 		new->token = tok;
 
@@ -529,12 +584,21 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
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
+		if (item->conf.command && !item->conf.command_uses_arg) {
+			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
+			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+		}
+	}
+
 	return arg_tok_first;
 }
 
-- 
1.9.0.163.g8ca203c
