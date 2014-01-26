From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/17] trailer: add new_trailer_item() function
Date: Sun, 26 Jan 2014 18:00:04 +0100
Message-ID: <20140126170011.24291.94439.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:24:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TRe-0004Tg-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbaAZRYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:24:25 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:43168 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbaAZRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:24:03 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 250B981;
	Sun, 26 Jan 2014 18:24:01 +0100 (CET)
X-git-sha1: c2ba6dff9bb3334af11d7ad75e2e99b5619123dc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241101>

This is a small refactoring to prepare for the next steps.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/trailer.c b/trailer.c
index d581371..6eec3ce 100644
--- a/trailer.c
+++ b/trailer.c
@@ -400,11 +400,27 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tr
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
 
@@ -416,21 +432,12 @@ static struct trailer_item *create_trailer_item(const char *string)
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
