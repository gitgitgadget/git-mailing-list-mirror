From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/9] trailer: process command line trailer arguments
Date: Tue, 24 Dec 2013 07:37:20 +0100
Message-ID: <20131224063726.19560.28979.chriscool@tuxfamily.org>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLdu-0001ZO-2s
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab3LXGim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:38:42 -0500
Received: from [194.158.98.14] ([194.158.98.14]:50283 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751039Ab3LXGij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C83ED49;
	Tue, 24 Dec 2013 07:38:18 +0100 (CET)
X-git-sha1: 60dcc5a516cef382ac8e8f6adcab3eda7822bd44 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239659>

This patch parses the trailer command line arguments
and put the result into an arg_tok doubly linked
list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/trailer.c b/trailer.c
index 6aba40e..b572c44 100644
--- a/trailer.c
+++ b/trailer.c
@@ -363,3 +363,80 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	}
 	return 0;
 }
+
+static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+{
+	char *end = strchr(trailer, '=');
+	if (!end)
+		end = strchr(trailer, ':');
+	if (end) {
+		strbuf_add(tok, trailer, end - trailer);
+		strbuf_trim(tok);
+		strbuf_addstr(val, end + 1);
+		strbuf_trim(val);
+	} else {
+		strbuf_addstr(tok, trailer);
+		strbuf_trim(tok);
+	}
+}
+
+static struct trailer_item *create_trailer_item(const char *string)
+{
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *new;
+
+	parse_trailer(&tok, &val, string);
+
+	int tok_alnum_len = alnum_len(tok.buf, tok.len);
+
+	/* Lookup if the token matches something in the config */
+	struct trailer_item *item;
+	for (item = first_conf_item; item; item = item->next)
+	{
+		if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
+		    !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
+			new = xcalloc(sizeof(struct trailer_item), 1);
+			new->conf = item->conf;
+			new->token = xstrdup(item->conf->key);
+			new->value = strbuf_detach(&val, NULL);
+			strbuf_release(&tok);
+			return new;
+		}
+	}
+
+	new = xcalloc(sizeof(struct trailer_item), 1);
+	new->conf = xcalloc(sizeof(struct conf_info), 1);
+	new->token = strbuf_detach(&tok, NULL);
+	new->value = strbuf_detach(&val, NULL);
+
+	return new;
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
1.8.4.1.616.g07f5c81
