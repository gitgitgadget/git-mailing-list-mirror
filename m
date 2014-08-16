From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 09/11] trailer: execute command from
 'trailer.<name>.command'
Date: Sat, 16 Aug 2014 18:06:19 +0200
Message-ID: <20140816160622.18221.36846.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:54:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIhFc-0005wB-1O
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaHPQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:54:31 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:59062 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaHPQya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:54:30 -0400
X-ASG-Debug-ID: 1408207993-016a7707b5114eb10002-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id qTP8z1aHeXusRFeC; Sat, 16 Aug 2014 11:53:23 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 7AB0A890DDD;
	Sat, 16 Aug 2014 11:37:49 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 8C139C549B0;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 09/11] trailer: execute command from
 'trailer.<name>.command'
X-git-sha1: f44e2b977e84e42c8423cd86afa295b3e872579d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408208003
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255336>

Let the user specify a command that will give on its standard output
the value to use for the specified trailer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/trailer.c b/trailer.c
index 8e41b8f..baef034 100644
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
@@ -14,6 +16,7 @@ struct conf_info {
 	char *name;
 	char *key;
 	char *command;
+	unsigned command_uses_arg : 1;
 	enum action_where where;
 	enum action_if_exists if_exists;
 	enum action_if_missing if_missing;
@@ -33,6 +36,8 @@ static struct trailer_item *first_conf_item;
 
 static char *separators = ":";
 
+#define TRAILER_ARG_STRING "$ARG"
+
 static int after_or_end(enum action_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
@@ -73,6 +78,13 @@ static inline int contains_only_spaces(const char *str)
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
@@ -478,6 +490,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 		if (conf->command)
 			warning(_("more than one %s"), conf_key);
 		conf->command = xstrdup(value);
+		conf->command_uses_arg = !!strstr(conf->command, TRAILER_ARG_STRING);
 		break;
 	case TRAILER_WHERE:
 		if (set_where(conf, value))
@@ -519,6 +532,46 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
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
+
 static const char *token_from_item(struct trailer_item *item)
 {
 	if (item->conf.key)
@@ -537,6 +590,10 @@ static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
 		duplicate_conf(&new->conf, &conf_item->conf);
 		new->token = xstrdup(token_from_item(conf_item));
 		free(tok);
+		if (conf_item->conf.command_uses_arg || !val) {
+			new->value = apply_command(conf_item->conf.command, val);
+			free(val);
+		}
 	} else {
 		duplicate_conf(&new->conf, &default_conf_info);
 		new->token = tok;
@@ -600,12 +657,21 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 	struct trailer_item *arg_tok_first = NULL;
 	struct trailer_item *arg_tok_last = NULL;
 	struct string_list_item *tr;
+	struct trailer_item *item;
 
 	for_each_string_list_item(tr, trailers) {
 		struct trailer_item *new = create_trailer_item(tr->string);
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
2.0.1.674.ga7f57b7
