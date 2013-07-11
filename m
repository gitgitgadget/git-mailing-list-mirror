From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 3/5] config: make parsing stack struct independent from
 actual data source
Date: Fri, 12 Jul 2013 00:44:39 +0200
Message-ID: <20130711224439.GD26477@book-mint>
References: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPbW-0001oh-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab3GKWor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:44:47 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:44664 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391Ab3GKWoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:44:46 -0400
Received: from [85.16.23.209] (helo=book-mint)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UxPbM-0006XS-OF; Fri, 12 Jul 2013 00:44:41 +0200
Content-Disposition: inline
In-Reply-To: <20130711223614.GA26477@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230146>

To simplify adding other sources we extract all functions needed for
parsing into a list of callbacks. We implement those callbacks for the
current file parsing. A new source can implement its own set of callbacks.

Instead of storing the concrete FILE pointer for parsing we store a void
pointer. A new source can use this to store its custom data.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 64 +++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/config.c b/config.c
index 1ec73ad..71da389 100644
--- a/config.c
+++ b/config.c
@@ -10,20 +10,41 @@
 #include "strbuf.h"
 #include "quote.h"
 
-typedef struct config_file {
-	struct config_file *prev;
-	FILE *f;
+struct config_source {
+	struct config_source *prev;
+	union {
+		FILE *file;
+	} u;
 	const char *name;
 	int linenr;
 	int eof;
 	struct strbuf value;
 	struct strbuf var;
-} config_file;
 
-static config_file *cf;
+	int (*fgetc)(struct config_source *c);
+	int (*ungetc)(int c, struct config_source *conf);
+	long (*ftell)(struct config_source *c);
+};
+
+static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+static int config_file_fgetc(struct config_source *conf)
+{
+	return fgetc(conf->u.file);
+}
+
+static int config_file_ungetc(int c, struct config_source *conf)
+{
+	return ungetc(c, conf->u.file);
+}
+
+static long config_file_ftell(struct config_source *conf)
+{
+	return ftell(conf->u.file);
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -168,15 +189,13 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 
 static int get_next_char(void)
 {
-	int c;
-	FILE *f = cf->f;
+	int c = cf->fgetc(cf);
 
-	c = fgetc(f);
 	if (c == '\r') {
 		/* DOS like systems */
-		c = fgetc(f);
+		c = cf->fgetc(cf);
 		if (c != '\n') {
-			ungetc(c, f);
+			cf->ungetc(c, cf);
 			c = '\r';
 		}
 	}
@@ -336,7 +355,7 @@ static int get_base_var(struct strbuf *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn, void *data)
+static int git_parse_source(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -904,10 +923,11 @@ int git_default_config(const char *var, const char *value, void *dummy)
 }
 
 /*
- * The fields f and name of top need to be initialized before calling
+ * All source specific fields in the union, name and the callbacks
+ * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
+static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 {
 	int ret;
 
@@ -919,7 +939,7 @@ static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_file(fn, data);
+	ret = git_parse_source(fn, data);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -936,10 +956,13 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	ret = -1;
 	if (f) {
-		config_file top;
+		struct config_source top;
 
-		top.f = f;
+		top.u.file = f;
 		top.name = filename;
+		top.fgetc = config_file_fgetc;
+		top.ungetc = config_file_ungetc;
+		top.ftell = config_file_ftell;
 
 		ret = do_config_from(&top, fn, data);
 
@@ -1074,7 +1097,6 @@ static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
-	FILE *f = cf->f;
 
 	switch (store.state) {
 	case KEY_SEEN:
@@ -1086,7 +1108,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = cf->ftell(cf);
 			store.seen++;
 		}
 		break;
@@ -1113,19 +1135,19 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		store.offset[store.seen] = ftell(f);
+		store.offset[store.seen] = cf->ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = cf->ftell(cf);
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else {
 			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
-					store.offset[store.seen] = ftell(f);
+					store.offset[store.seen] = cf->ftell(cf);
 			}
 		}
 	}
-- 
1.8.3.2.773.gcfaae5b
