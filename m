From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 3/5] config: make parsing stack struct independent from
 actual data source
Date: Thu, 9 May 2013 18:19:32 +0200
Message-ID: <20130509161932.GE3526@book-mint>
References: <20130509154020.GA26423@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:24:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTeA-0001eJ-1I
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab3EIQYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:24:42 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:53680 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3EIQYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:24:41 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTZA-0005pV-Vz; Thu, 09 May 2013 18:19:37 +0200
Content-Disposition: inline
In-Reply-To: <20130509154020.GA26423@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223742>

To simplify adding other sources we extract all functions needed for
parsing into a list of callbacks. We implement those callbacks for the
current file parsing. A new source can implement its own set of callbacks.

Instead of storing the concrete FILE pointer for parsing we store a void
pointer. A new source can use this to store its custom data.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 66 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/config.c b/config.c
index 046642b..2390458 100644
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
+	};
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
+	return fgetc(conf->file);
+}
+
+static int config_file_ungetc(int c, struct config_source *conf)
+{
+	return ungetc(c, conf->file);
+}
+
+static long config_file_ftell(struct config_source *conf)
+{
+	return ftell(conf->file);
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
@@ -894,10 +913,11 @@ int git_default_config(const char *var, const char *value, void *dummy)
 }
 
 /*
- * The fields f and name of top need to be initialized before calling
+ * All source specific fields in the union, name and the callbacks
+ * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
+static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
 {
 	int ret;
 
@@ -909,7 +929,7 @@ static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_file(fn, data);
+	ret = git_parse_source(fn, data);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -926,12 +946,15 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	ret = -1;
 	if (f) {
-		config_file top;
+		struct config_source top;
 
-		top.f = f;
+		top.file = f;
 		top.name = filename;
+		top.fgetc = config_file_fgetc;
+		top.ungetc = config_file_ungetc;
+		top.ftell = config_file_ftell;
 
-		ret = do_config_from(&top, fn, data);
+		ret = do_config_from_source(&top, fn, data);
 
 		fclose(f);
 	}
@@ -1064,7 +1087,6 @@ static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
-	FILE *f = cf->f;
 
 	switch (store.state) {
 	case KEY_SEEN:
@@ -1076,7 +1098,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = cf->ftell(cf);
 			store.seen++;
 		}
 		break;
@@ -1103,19 +1125,19 @@ static int store_aux(const char *key, const char *value, void *cb)
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
1.8.3.rc1.40.gba374ae
