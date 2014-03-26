From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 05/12] trailer: process command line trailer arguments
Date: Wed, 26 Mar 2014 23:15:23 +0100
Message-ID: <20140326221531.11352.1208.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 26 23:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSw84-0002Kt-8A
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbaCZWQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:16:55 -0400
Received: from [194.158.98.15] ([194.158.98.15]:45141 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754217AbaCZWQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:16:24 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B124659;
	Wed, 26 Mar 2014 23:16:02 +0100 (CET)
X-git-sha1: dea90248de4e22280d33bddf2b0ee7e9e857f764 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245243>

Parse the trailer command line arguments and put
the result into an arg_tok doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/trailer.c b/trailer.c
index b5a0943..1871843 100644
--- a/trailer.c
+++ b/trailer.c
@@ -398,3 +398,106 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
+static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
+					     char *tok, char *val)
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
+	if (parse_trailer(&tok, &val, string))
+		return NULL;
+
+	tok_alnum_len = alnum_len(tok.buf, tok.len);
+
+	/* Lookup if the token matches something in the config */
+	for (item = first_conf_item; item; item = item->next) {
+		if (!strncasecmp(tok.buf, item->conf.key, tok_alnum_len) ||
+		    !strncasecmp(tok.buf, item->conf.name, tok_alnum_len)) {
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
1.9.0.164.g3aa33cd.dirty
