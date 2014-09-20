From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v15 09/11] trailer: execute command from
 'trailer.<name>.command'
Date: Sat, 20 Sep 2014 15:45:12 +0200
Message-ID: <20140920134515.18999.38603.chriscool@tuxfamily.org>
References: <20140920134048.18999.79434.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Sep 20 15:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVL2C-0006ro-Go
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 15:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbaITNs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 09:48:56 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:33694 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbaITNsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 09:48:41 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 94D8157;
	Sat, 20 Sep 2014 15:48:39 +0200 (CEST)
X-git-sha1: 835583f91394be7964f4f861c3caaa6ce63f346e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257319>

Let the user specify a command that will give on its standard output
the value to use for the specified trailer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 094c6e8..50f9547 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "string-list.h"
+#include "run-command.h"
+#include "string-list.h"
 #include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
@@ -33,6 +35,8 @@ static struct trailer_item *first_conf_item;
 
 static char *separators = ":";
 
+#define TRAILER_ARG_STRING "$ARG"
+
 static int after_or_end(enum action_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
@@ -78,6 +82,13 @@ static inline int contains_only_spaces(const char *str)
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
@@ -203,6 +214,63 @@ static struct trailer_item *remove_first(struct trailer_item **first)
 	return item;
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
+
+static void apply_item_command(struct trailer_item *in_tok, struct trailer_item *arg_tok)
+{
+	if (arg_tok->conf.command) {
+		const char *arg;
+		if (arg_tok->value && arg_tok->value[0]) {
+			arg = arg_tok->value;
+		} else {
+			if (in_tok && in_tok->value)
+				arg = xstrdup(in_tok->value);
+			else
+				arg = xstrdup("");
+		}
+		arg_tok->value = apply_command(arg_tok->conf.command, arg);
+		free((char *)arg);
+	}
+}
+
 static void apply_arg_if_exists(struct trailer_item *in_tok,
 				struct trailer_item *arg_tok,
 				struct trailer_item *on_tok,
@@ -214,16 +282,19 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		free_trailer_item(arg_tok);
 		break;
 	case EXISTS_REPLACE:
+		apply_item_command(in_tok, arg_tok);
 		add_arg_to_input_list(on_tok, arg_tok,
 				      in_tok_first, in_tok_last);
 		remove_from_list(in_tok, in_tok_first, in_tok_last);
 		free_trailer_item(in_tok);
 		break;
 	case EXISTS_ADD:
+		apply_item_command(in_tok, arg_tok);
 		add_arg_to_input_list(on_tok, arg_tok,
 				      in_tok_first, in_tok_last);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT:
+		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(in_tok, arg_tok, 1))
 			add_arg_to_input_list(on_tok, arg_tok,
 					      in_tok_first, in_tok_last);
@@ -231,6 +302,7 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 			free_trailer_item(arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
+		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(on_tok, arg_tok, 0))
 			add_arg_to_input_list(on_tok, arg_tok,
 					      in_tok_first, in_tok_last);
@@ -254,6 +326,7 @@ static void apply_arg_if_missing(struct trailer_item **in_tok_first,
 	case MISSING_ADD:
 		where = arg_tok->conf.where;
 		in_tok = after_or_end(where) ? in_tok_last : in_tok_first;
+		apply_item_command(NULL, arg_tok);
 		if (*in_tok) {
 			add_arg_to_input_list(*in_tok, arg_tok,
 					      in_tok_first, in_tok_last);
@@ -536,7 +609,7 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 					     char *tok, char *val)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->value = val;
+	new->value = val ? val : xstrdup("");
 
 	if (conf_item) {
 		duplicate_conf(&new->conf, &conf_item->conf);
@@ -605,7 +678,17 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 	struct trailer_item *arg_tok_first = NULL;
 	struct trailer_item *arg_tok_last = NULL;
 	struct string_list_item *tr;
+	struct trailer_item *item;
+
+	/* Add a trailer item for each configured trailer with a command */
+	for (item = first_conf_item; item; item = item->next) {
+		if (item->conf.command) {
+			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
+			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+		}
+	}
 
+	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
 		struct trailer_item *new = create_trailer_item(tr->string);
 		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
-- 
2.0.3.960.g41c6e4c
