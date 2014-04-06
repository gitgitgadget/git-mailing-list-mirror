From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 04/12] trailer: process command line trailer arguments
Date: Sun, 06 Apr 2014 19:01:55 +0200
Message-ID: <20140406170204.15116.3903.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 07 20:44:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEXM-0003uc-MH
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbaDGSoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:46 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:50940 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755987AbaDGSoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:44:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id C955463;
	Mon,  7 Apr 2014 20:43:59 +0200 (CEST)
X-git-sha1: 33cf41fd854b309acd6fd1a56bfa2a8357e03646 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245882>

Parse the trailer command line arguments and put
the result into an arg_tok doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/trailer.c b/trailer.c
index c7c0f54..89ebff1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -391,3 +391,120 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
1.9.0.163.g8ca203c
