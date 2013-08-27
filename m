From: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] config: add _cb suffix to callback functions
Date: Tue, 27 Aug 2013 08:12:16 +0000
Message-ID: <1377591136-10680-1-git-send-email-ncopa@alpinelinux.org>
Cc: Natanael Copa <ncopa@alpinelinux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 10:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEEXN-0001az-EC
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 10:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3H0IWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 04:22:00 -0400
Received: from host74-117-189-115.redmonsters.net ([74.117.189.115]:34971 "EHLO
	dal-a2.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752909Ab3H0IV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 04:21:58 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 04:21:58 EDT
Received: from dev32-edge.nor.wtbts.net (3.203.202.84.customer.cdi.no [84.202.203.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ncopa@tanael.org)
	by dal-a2.localdomain (Postfix) with ESMTPSA id EC036BC2D49;
	Tue, 27 Aug 2013 08:12:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233079>

Commit 4d8dd1494e9f3af2e9738edaca40ada096f7bf10 introduced a build
regression on uClibc which defines fgetc as macro. To work around that
we add a _cb suffix to the callback functions.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 config.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index e13a7b6..aa80078 100644
--- a/config.c
+++ b/config.c
@@ -27,9 +27,9 @@ struct config_source {
 	struct strbuf value;
 	struct strbuf var;
 
-	int (*fgetc)(struct config_source *c);
-	int (*ungetc)(int c, struct config_source *conf);
-	long (*ftell)(struct config_source *c);
+	int (*fgetc_cb)(struct config_source *c);
+	int (*ungetc_cb)(int c, struct config_source *conf);
+	long (*ftell_cb)(struct config_source *c);
 };
 
 static struct config_source *cf;
@@ -217,13 +217,13 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 
 static int get_next_char(void)
 {
-	int c = cf->fgetc(cf);
+	int c = cf->fgetc_cb(cf);
 
 	if (c == '\r') {
 		/* DOS like systems */
-		c = cf->fgetc(cf);
+		c = cf->fgetc_cb(cf);
 		if (c != '\n') {
-			cf->ungetc(c, cf);
+			cf->ungetc_cb(c, cf);
 			c = '\r';
 		}
 	}
@@ -992,9 +992,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		top.u.file = f;
 		top.name = filename;
 		top.die_on_error = 1;
-		top.fgetc = config_file_fgetc;
-		top.ungetc = config_file_ungetc;
-		top.ftell = config_file_ftell;
+		top.fgetc_cb = config_file_fgetc;
+		top.ungetc_cb = config_file_ungetc;
+		top.ftell_cb = config_file_ftell;
 
 		ret = do_config_from(&top, fn, data);
 
@@ -1013,9 +1013,9 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.pos = 0;
 	top.name = name;
 	top.die_on_error = 0;
-	top.fgetc = config_buf_fgetc;
-	top.ungetc = config_buf_ungetc;
-	top.ftell = config_buf_ftell;
+	top.fgetc_cb = config_buf_fgetc;
+	top.ungetc_cb = config_buf_ungetc;
+	top.ftell_cb = config_buf_ftell;
 
 	return do_config_from(&top, fn, data);
 }
@@ -1196,7 +1196,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = cf->ftell(cf);
+			store.offset[store.seen] = cf->ftell_cb(cf);
 			store.seen++;
 		}
 		break;
@@ -1223,19 +1223,19 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		store.offset[store.seen] = cf->ftell(cf);
+		store.offset[store.seen] = cf->ftell_cb(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] = cf->ftell(cf);
+			store.offset[store.seen] = cf->ftell_cb(cf);
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else {
 			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
-					store.offset[store.seen] = cf->ftell(cf);
+					store.offset[store.seen] = cf->ftell_cb(cf);
 			}
 		}
 	}
-- 
1.8.3.4
