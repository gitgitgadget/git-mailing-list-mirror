From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v15 04/11] trailer: process command line trailer arguments
Date: Sat, 20 Sep 2014 15:45:07 +0200
Message-ID: <20140920134515.18999.32085.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Sep 20 15:48:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVL1y-0006m9-Qz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 15:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbaITNsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 09:48:51 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:33633 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbaITNsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 09:48:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 9C8D47E;
	Sat, 20 Sep 2014 15:48:35 +0200 (CEST)
X-git-sha1: d8ae60e3851aa750aeb393236c46d78b64236f00 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257314>

Parse the trailer command line arguments and put
the result into an arg_tok doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/trailer.c b/trailer.c
index 668dc33..bf58980 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -462,3 +463,127 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	}
 	return 0;
 }
+
+static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+{
+	size_t len;
+	struct strbuf seps = STRBUF_INIT;
+	strbuf_addstr(&seps, separators);
+	strbuf_addch(&seps, '=');
+	len = strcspn(trailer, seps.buf);
+	strbuf_release(&seps);
+	if (len == 0)
+		return error(_("empty trailer token in trailer '%s'"), trailer);
+	if (len < strlen(trailer)) {
+		strbuf_add(tok, trailer, len);
+		strbuf_trim(tok);
+		strbuf_addstr(val, trailer + len + 1);
+		strbuf_trim(val);
+	} else {
+		strbuf_addstr(tok, trailer);
+		strbuf_trim(tok);
+	}
+	return 0;
+}
+
+
+static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
+{
+	*dst = *src;
+	if (src->name)
+		dst->name = xstrdup(src->name);
+	if (src->key)
+		dst->key = xstrdup(src->key);
+	if (src->command)
+		dst->command = xstrdup(src->command);
+}
+
+static const char *token_from_item(struct trailer_item *item)
+{
+	if (item->conf.key)
+		return item->conf.key;
+
+	return item->conf.name;
+}
+
+static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
+					     char *tok, char *val)
+{
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->value = val;
+
+	if (conf_item) {
+		duplicate_conf(&new->conf, &conf_item->conf);
+		new->token = xstrdup(token_from_item(conf_item));
+		free(tok);
+	} else {
+		duplicate_conf(&new->conf, &default_conf_info);
+		new->token = tok;
+	}
+
+	return new;
+}
+
+static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
+{
+	if (!strncasecmp(tok, item->conf.name, tok_len))
+		return 1;
+	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
+}
+
+static struct trailer_item *create_trailer_item(const char *string)
+{
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *item;
+	int tok_len;
+
+	if (parse_trailer(&tok, &val, string))
+		return NULL;
+
+	tok_len = token_len_without_separator(tok.buf, tok.len);
+
+	/* Lookup if the token matches something in the config */
+	for (item = first_conf_item; item; item = item->next) {
+		if (token_matches_item(tok.buf, item, tok_len)) {
+			strbuf_release(&tok);
+			return new_trailer_item(item,
+						NULL,
+						strbuf_detach(&val, NULL));
+		}
+	}
+
+	return new_trailer_item(NULL,
+				strbuf_detach(&tok, NULL),
+				strbuf_detach(&val, NULL));
+}
+
+static void add_trailer_item(struct trailer_item **first,
+			     struct trailer_item **last,
+			     struct trailer_item *new)
+{
+	if (!new)
+		return;
+	if (!*last) {
+		*first = new;
+		*last = new;
+	} else {
+		(*last)->next = new;
+		new->previous = *last;
+		*last = new;
+	}
+}
+
+static struct trailer_item *process_command_line_args(struct string_list *trailers)
+{
+	struct trailer_item *arg_tok_first = NULL;
+	struct trailer_item *arg_tok_last = NULL;
+	struct string_list_item *tr;
+
+	for_each_string_list_item(tr, trailers) {
+		struct trailer_item *new = create_trailer_item(tr->string);
+		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+	}
+
+	return arg_tok_first;
+}
-- 
2.0.3.960.g41c6e4c
