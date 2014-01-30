From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/17] trailer: process command line trailer arguments
Date: Thu, 30 Jan 2014 07:49:07 +0100
Message-ID: <20140130064921.7504.55916.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mD9-0005Zm-VD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbaA3HiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:07 -0500
Received: from [194.158.98.14] ([194.158.98.14]:38370 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752569AbaA3HiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:06 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 214F837;
	Thu, 30 Jan 2014 08:37:45 +0100 (CET)
X-git-sha1: 8e23fad458a83696ea3f316f12cb0e4b49900dad 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241256>

This patch parses the trailer command line arguments
and put the result into an arg_tok doubly linked
list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/trailer.c b/trailer.c
index d979a0f..f48fd94 100644
--- a/trailer.c
+++ b/trailer.c
@@ -362,3 +362,80 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
1.8.5.2.201.gacc5987
