From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 11/16] trailer: add new_trailer_item() function
Date: Sun, 19 Jan 2014 09:53:49 +0100
Message-ID: <20140119085355.2734.76444.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAP-0008R0-4E
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbaASIza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:30 -0500
Received: from [194.158.98.14] ([194.158.98.14]:46091 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752019AbaASIyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:53 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0E91D65;
	Sun, 19 Jan 2014 09:54:32 +0100 (CET)
X-git-sha1: 2bb5521ef863f331803bb94e4238a55591adefc7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240690>

This is a small refactoring to prepare for the next steps.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/trailer.c b/trailer.c
index 9026337..43a3735 100644
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
 
 	parse_trailer(&tok, &val, string);
 
@@ -416,21 +432,12 @@ static struct trailer_item *create_trailer_item(const char *string)
 	{
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
