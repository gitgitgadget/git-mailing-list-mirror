From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 04/11] trailer: process command line trailer arguments
Date: Fri, 25 Apr 2014 21:06:55 +0200
Message-ID: <20140425190703.28550.72683.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Apr 25 21:08:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlTs-0003tp-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbaDYTH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:07:56 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:43433 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590AbaDYTHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id BBBBA74;
	Fri, 25 Apr 2014 21:07:44 +0200 (CEST)
X-git-sha1: 383bc719f5d2ac34932ad815a5434ff3d775e9c0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247097>

Parse the trailer command line arguments and put
the result into an arg_tok doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/trailer.c b/trailer.c
index f376be5..f79a369 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -391,3 +392,120 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	}
 	return 0;
 }
+
+static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+{
+	size_t len = strcspn(trailer, "=:");
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
+	} else
+		new->token = tok;
+
+	return new;
+}
+
+static int token_matches_item(const char *tok, struct trailer_item *item, int alnum_len)
+{
+	if (!strncasecmp(tok, item->conf.name, alnum_len))
+		return 1;
+	return item->conf.key ? !strncasecmp(tok, item->conf.key, alnum_len) : 0;
+}
+
+static struct trailer_item *create_trailer_item(const char *string)
+{
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *item;
+	int tok_alnum_len;
+
+	if (parse_trailer(&tok, &val, string))
+		return NULL;
+
+	tok_alnum_len = alnum_len(tok.buf, tok.len);
+
+	/* Lookup if the token matches something in the config */
+	for (item = first_conf_item; item; item = item->next) {
+		if (token_matches_item(tok.buf, item, tok_alnum_len)) {
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
1.9.1.636.g20d5f34
