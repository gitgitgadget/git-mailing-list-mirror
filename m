From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 3/4] config: make parsing stack struct independent from
 actual data source
Date: Sun, 10 Mar 2013 17:59:40 +0100
Message-ID: <20130310165940.GD1136@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 18:00:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjbU-0006lE-J9
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 18:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab3CJQ7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 12:59:42 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:60045 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3CJQ7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 12:59:42 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjb2-0002wa-N2; Sun, 10 Mar 2013 17:59:41 +0100
Content-Disposition: inline
In-Reply-To: <20130310165642.GA1136@sandbox-ub.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217814>

To simplify adding other sources we extract all functions needed for
parsing into a list of callbacks. We implement those callbacks for the
current file parsing. A new source can implement its own set of callbacks.

Instead of storing the concrete FILE pointer for parsing we store a void
pointer. A new source can use this to store its custom data.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 config.c | 63 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/config.c b/config.c
index f55c43d..fe1c0e5 100644
--- a/config.c
+++ b/config.c
@@ -10,20 +10,42 @@
 #include "strbuf.h"
 #include "quote.h"
 
-typedef struct config_file {
-	struct config_file *prev;
-	FILE *f;
+struct config_source {
+	struct config_source *prev;
+	void *data;
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
+	FILE *f = conf->data;
+	return fgetc(f);
+}
+
+static int config_file_ungetc(int c, struct config_source *conf)
+{
+	FILE *f = conf->data;
+	return ungetc(c, f);
+}
+
+static long config_file_ftell(struct config_source *conf)
+{
+	FILE *f = conf->data;
+	return ftell(f);
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -172,13 +194,12 @@ static int get_next_char(void)
 
 	c = '\n';
 	if (cf) {
-		FILE *f = cf->f;
-		c = fgetc(f);
+		c = cf->fgetc(cf);
 		if (c == '\r') {
 			/* DOS like systems */
-			c = fgetc(f);
+			c = cf->fgetc(cf);
 			if (c != '\n') {
-				ungetc(c, f);
+				cf->ungetc(c, cf);
 				c = '\r';
 			}
 		}
@@ -339,7 +360,7 @@ static int get_base_var(struct strbuf *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn, void *data)
+static int git_parse_source(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -896,7 +917,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
-static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
+static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
 {
 	int ret;
 
@@ -908,7 +929,7 @@ static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_file(fn, data);
+	ret = git_parse_source(fn, data);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -925,12 +946,15 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	ret = -1;
 	if (f) {
-		config_file top;
+		struct config_source top;
 
-		top.f = f;
+		top.data = f;
 		top.name = filename;
+		top.fgetc = config_file_fgetc;
+		top.ungetc = config_file_ungetc;
+		top.ftell = config_file_ftell;
 
-		ret = do_config_from(&top, fn, data);
+		ret = do_config_from_source(&top, fn, data);
 
 		fclose(f);
 	}
@@ -1063,7 +1087,6 @@ static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
-	FILE *f = cf->f;
 
 	switch (store.state) {
 	case KEY_SEEN:
@@ -1075,7 +1098,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(f);
+			store.offset[store.seen] = cf->ftell(cf);
 			store.seen++;
 		}
 		break;
@@ -1102,19 +1125,19 @@ static int store_aux(const char *key, const char *value, void *cb)
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
1.8.2.rc0.26.gf7384c5
