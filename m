From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 11/17] trailer: add new_trailer_item() function
Date: Thu, 30 Jan 2014 07:49:14 +0100
Message-ID: <20140130064921.7504.42810.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mCy-0005TE-5O
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaA3Hik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:40 -0500
Received: from [194.158.98.45] ([194.158.98.45]:37436 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751107AbaA3HiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:10 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 7AF926F;
	Thu, 30 Jan 2014 08:37:49 +0100 (CET)
X-git-sha1: 9797e0b80e707e686b3b771ca09c33ed94f436e1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241253>

This is a small refactoring to prepare for the next steps.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/trailer.c b/trailer.c
index 73a65e0..430ff39 100644
--- a/trailer.c
+++ b/trailer.c
@@ -399,11 +399,27 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tr
 	}
 }
 
+static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
+					     const char* tok, const char* val)
+{
+	struct trailer_item *new = xcalloc(sizeof(struct trailer_item), 1);
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
 static struct trailer_item *create_trailer_item(const char *string)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	struct trailer_item *new;
 	struct trailer_item *item;
 	int tok_alnum_len;
 
@@ -415,21 +431,12 @@ static struct trailer_item *create_trailer_item(const char *string)
 	for (item = first_conf_item; item; item = item->next) {
 		if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
 		    !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
-			new = xcalloc(sizeof(struct trailer_item), 1);
-			new->conf = item->conf;
-			new->token = xstrdup(item->conf->key);
-			new->value = strbuf_detach(&val, NULL);
 			strbuf_release(&tok);
-			return new;
+			return new_trailer_item(item, NULL, strbuf_detach(&val, NULL));
 		}
 	}
 
-	new = xcalloc(sizeof(struct trailer_item), 1);
-	new->conf = xcalloc(sizeof(struct conf_info), 1);
-	new->token = strbuf_detach(&tok, NULL);
-	new->value = strbuf_detach(&val, NULL);
-
-	return new;
+	return new_trailer_item(NULL, strbuf_detach(&tok, NULL), strbuf_detach(&val, NULL));;
 }
 
 static void add_trailer_item(struct trailer_item **first,
-- 
1.8.5.2.201.gacc5987
