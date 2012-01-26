From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] config: support parsing config data from buffers
Date: Thu, 26 Jan 2012 02:40:31 -0500
Message-ID: <20120126074031.GC30474@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:40:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqJwl-0007mh-UY
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 08:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2AZHkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 02:40:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45006
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab2AZHkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 02:40:35 -0500
Received: (qmail 24021 invoked by uid 107); 26 Jan 2012 07:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 02:47:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 02:40:31 -0500
Content-Disposition: inline
In-Reply-To: <20120126073547.GA28689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189143>

The only two ways to parse config data are from a file or
from the command-line. Because the command-line format is
totally different from the file format, they don't share any
code. Therefore, to add new sources of file-like config data,
we have to refactor git_parse_file to handle reading from
something besides stdio.

To fix this, our config_file structure now holds either a
"FILE *" pointer or a memory buffer. We intercept calls to
fgetc and ungetc and either pass them along to stdio, or
fake them with our buffer. This leaves the main parsing code
intact and easy to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    1 +
 config.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 21bbb0a..a298897 100644
--- a/cache.h
+++ b/cache.h
@@ -1110,6 +1110,7 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_buffer(config_fn_t fn, void *, const char *, char *, unsigned long );
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index b82f749..49a3d1a 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,9 @@ typedef struct config_file {
 	const char *name;
 	int linenr;
 	int eof;
+	char *buf;
+	unsigned long size;
+	unsigned long cur;
 	struct strbuf value;
 	char var[MAXNAME];
 } config_file;
@@ -101,19 +104,45 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	return nr > 0;
 }
 
+static int get_one_char(void)
+{
+	if (cf->f)
+		return fgetc(cf->f);
+	else if (cf->buf) {
+		if (cf->cur < cf->size)
+			return cf->buf[cf->cur++];
+		return EOF;
+	}
+
+	die("BUG: attempt to read from NULL config_file");
+}
+
+static int unget_one_char(int c)
+{
+	if (cf->f)
+		ungetc(c, cf->f);
+	else if (cf->buf) {
+		if (cf->cur == 0)
+			return EOF;
+		cf->buf[--cf->cur] = c;
+		return c;
+	}
+
+	die("BUG: attempt to ungetc NULL config_file");
+}
+
 static int get_next_char(void)
 {
 	int c;
-	FILE *f;
 
 	c = '\n';
-	if (cf && ((f = cf->f) != NULL)) {
-		c = fgetc(f);
+	if (cf && (cf->f || cf->buf)) {
+		c = get_one_char();
 		if (c == '\r') {
 			/* DOS like systems */
-			c = fgetc(f);
+			c = get_one_char();
 			if (c != '\n') {
-				ungetc(c, f);
+				unget_one_char(c);
 				c = '\r';
 			}
 		}
@@ -833,6 +862,9 @@ static void config_file_push(config_file *top, const char *name)
 	top->name = name;
 	top->linenr = 1;
 	top->eof = 0;
+	top->buf = NULL;
+	top->size = 0;
+	top->cur = 0;
 	strbuf_init(&top->value, 1024);
 	cf = top;
 }
@@ -863,6 +895,22 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
+int git_config_from_buffer(config_fn_t fn, void *data, const char *name,
+			   char *buf, unsigned long size)
+{
+	int ret;
+	config_file top;
+
+	config_file_push(&top, name);
+	top.buf = buf;
+	top.size = size;
+
+	ret = git_parse_file(fn, data);
+
+	config_file_pop(&top);
+	return ret;
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
-- 
1.7.9.rc2.293.gaae2
