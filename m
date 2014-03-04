From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 04/11] trailer: process command line trailer arguments
Date: Tue, 04 Mar 2014 20:48:02 +0100
Message-ID: <20140304194810.14249.51930.chriscool@tuxfamily.org>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKvLh-0000BT-6C
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbaCDTtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:49:31 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:63953 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbaCDTta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:49:30 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 8A3B974;
	Tue,  4 Mar 2014 20:49:29 +0100 (CET)
X-git-sha1: 427b15831c062f129b35ac3d2bab1fbb265ed653 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140304193250.14249.56949.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243381>

Parse the trailer command line arguments and put
the result into an arg_tok doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/trailer.c b/trailer.c
index 5b8e28b..5d69c00 100644
--- a/trailer.c
+++ b/trailer.c
@@ -378,3 +378,96 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	}
 	return 0;
 }
+
+static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+{
+	size_t len = strcspn(trailer, "=:");
+	if (len < strlen(trailer)) {
+		strbuf_add(tok, trailer, len);
+		strbuf_trim(tok);
+		strbuf_addstr(val, trailer + len + 1);
+		strbuf_trim(val);
+	} else {
+		strbuf_addstr(tok, trailer);
+		strbuf_trim(tok);
+	}
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
+static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
+					     char* tok, char* val)
+{
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->value = val;
+
+	if (conf_item) {
+		duplicate_conf(&new->conf, &conf_item->conf);
+		new->token = xstrdup(conf_item->conf.key);
+		free(tok);
+	} else
+		new->token = tok;
+
+	return new;
+}
+
+static struct trailer_item *create_trailer_item(const char *string)
+{
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *item;
+	int tok_alnum_len;
+
+	parse_trailer(&tok, &val, string);
+
+	tok_alnum_len = alnum_len(tok.buf, tok.len);
+
+	/* Lookup if the token matches something in the config */
+	for (item = first_conf_item; item; item = item->next) {
+		if (!strncasecmp(tok.buf, item->conf.key, tok_alnum_len) ||
+		    !strncasecmp(tok.buf, item->conf.name, tok_alnum_len)) {
+			strbuf_release(&tok);
+			return new_trailer_item(item, NULL, strbuf_detach(&val, NULL));
+		}
+	}
+
+	return new_trailer_item(NULL, strbuf_detach(&tok, NULL), strbuf_detach(&val, NULL));;
+}
+
+static void add_trailer_item(struct trailer_item **first,
+			     struct trailer_item **last,
+			     struct trailer_item *new)
+{
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
+static struct trailer_item *process_command_line_args(int argc, const char **argv)
+{
+	int i;
+	struct trailer_item *arg_tok_first = NULL;
+	struct trailer_item *arg_tok_last = NULL;
+
+	for (i = 0; i < argc; i++) {
+		struct trailer_item *new = create_trailer_item(argv[i]);
+		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+	}
+
+	return arg_tok_first;
+}
-- 
1.8.5.2.204.gcfe299d.dirty
