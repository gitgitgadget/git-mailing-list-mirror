From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 10/12] trailer: execute command from
 'trailer.<name>.command'
Date: Wed, 26 Mar 2014 23:15:28 +0100
Message-ID: <20140326221531.11352.20661.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSw7x-0002F2-CE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbaCZWQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:16:40 -0400
Received: from [194.158.98.15] ([194.158.98.15]:45154 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756348AbaCZWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:16:27 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 39B8644;
	Wed, 26 Mar 2014 23:16:06 +0100 (CET)
X-git-sha1: 3a6618868605d90fdacf1f9048bf2b7cd8da987a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245242>

Let the user specify a command that will give on its standard output
the value to use for the specified trailer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/trailer.c b/trailer.c
index 5bb29ae..eeb2f86 100644
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
@@ -403,6 +414,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 		if (conf->command)
 			warning(_("more than one %s"), conf_key);
 		conf->command = xstrdup(value);
+		conf->command_uses_arg = !!strstr(conf->command, TRAILER_ARG_STRING);
 		break;
 	case TRAILER_WHERE:
 		lowercase_value = xstrdup_tolower(value);
@@ -445,6 +457,44 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
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
 
 static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
 {
@@ -467,6 +517,10 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 		duplicate_conf(&new->conf, &conf_item->conf);
 		new->token = xstrdup(conf_item->conf.key);
 		free(tok);
+		if (conf_item->conf.command_uses_arg || !val) {
+			new->value = apply_command(conf_item->conf.command, val);
+			free(val);
+		}
 	} else
 		new->token = tok;
 
@@ -522,12 +576,21 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
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
1.9.0.164.g3aa33cd.dirty
