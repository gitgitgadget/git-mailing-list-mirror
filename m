From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 04/14] trailer: process command line trailer arguments
Date: Thu, 06 Feb 2014 21:19:53 +0100
Message-ID: <20140206202004.325.93876.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:22:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVTP-00052T-2v
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbaBFUWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:22:42 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:64739 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbaBFUVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:21:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8CA1436;
	Thu,  6 Feb 2014 21:21:20 +0100 (CET)
X-git-sha1: b79e0ffcc2d868c18f97f9ea3e2d280e4b73ac98 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140206194123.325.99451.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241740>

This patch parses the trailer command line arguments
and put the result into an arg_tok doubly linked
list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/trailer.c b/trailer.c
index f844f46..3fde21d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -367,3 +367,87 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	}
 	return 0;
 }
+
+static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+{
+	const char *end = strchr(trailer, '=');
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
+static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
+					     const char* tok, const char* val)
+{
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->value = val;
+
+	if (conf_item) {
+		new->conf = conf_item->conf;
+		new->token = xstrdup(conf_item->conf->key);
+	} else {
+		new->conf = xcalloc(sizeof(struct conf_info), 1);
+		new->token = tok;
+	}
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
+		if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
+		    !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
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
1.8.5.2.206.g98f5689.dirty
