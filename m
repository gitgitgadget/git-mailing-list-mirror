From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] New strbuf APIs: splice and attach.
Date: Sat, 15 Sep 2007 15:56:50 +0200
Message-ID: <20070916172233.8B8AD1835F@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxpQ-0007yF-0B
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbXIPRWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbXIPRWf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:35 -0400
Received: from pan.madism.org ([88.191.52.104]:35172 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbXIPRWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:34 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D3B4A2029B;
	Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8B8AD1835F; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58328>

* strbuf_splice replace a portion of the buffer with another.
* strbuf_attach replace a strbuf buffer with the given one, that should be
  malloc'ed. Then it enforces strbuf's invariants. If alloc > len, then this
  function has negligible cost, else it will perform a realloc, possibly
  with a cost.

Also some style issues are fixed now.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 strbuf.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 strbuf.h |    5 ++++
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index d919047..ff551ac 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,30 +1,45 @@
 #include "cache.h"
 #include "strbuf.h"
 
-void strbuf_init(struct strbuf *sb, size_t hint) {
+void strbuf_init(struct strbuf *sb, size_t hint)
+{
 	memset(sb, 0, sizeof(*sb));
 	if (hint)
 		strbuf_grow(sb, hint);
 }
 
-void strbuf_release(struct strbuf *sb) {
+void strbuf_release(struct strbuf *sb)
+{
 	free(sb->buf);
 	memset(sb, 0, sizeof(*sb));
 }
 
-void strbuf_reset(struct strbuf *sb) {
+void strbuf_reset(struct strbuf *sb)
+{
 	if (sb->len)
 		strbuf_setlen(sb, 0);
 	sb->eof = 0;
 }
 
-char *strbuf_detach(struct strbuf *sb) {
+char *strbuf_detach(struct strbuf *sb)
+{
 	char *res = sb->buf;
 	strbuf_init(sb, 0);
 	return res;
 }
 
-void strbuf_grow(struct strbuf *sb, size_t extra) {
+void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
+{
+	strbuf_release(sb);
+	sb->buf   = buf;
+	sb->len   = len;
+	sb->alloc = alloc;
+	strbuf_grow(sb, 0);
+	sb->buf[sb->len] = '\0';
+}
+
+void strbuf_grow(struct strbuf *sb, size_t extra)
+{
 	if (sb->len + extra + 1 <= sb->len)
 		die("you want to use way too much memory");
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
@@ -37,24 +52,44 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len) {
+void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
+{
 	strbuf_grow(sb, len);
-	if (pos >= sb->len) {
-		pos = sb->len;
-	} else {
-		memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
-	}
+	if (pos > sb->len)
+		die("`pos' is too far after the end of the buffer");
+	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
 	memcpy(sb->buf + pos, data, len);
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
+void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
+				   const void *data, size_t dlen)
+{
+	if (pos + len < pos)
+		die("you want to use way too much memory");
+	if (pos > sb->len)
+		die("`pos' is too far after the end of the buffer");
+	if (pos + len > sb->len)
+		die("`pos + len' is too far after the end of the buffer");
+
+	if (dlen >= len)
+		strbuf_grow(sb, dlen - len);
+	memmove(sb->buf + pos + dlen,
+			sb->buf + pos + len,
+			sb->len - pos - len);
+	memcpy(sb->buf + pos, data, dlen);
+	strbuf_setlen(sb, sb->len + dlen - len);
+}
+
+void strbuf_add(struct strbuf *sb, const void *data, size_t len)
+{
 	strbuf_grow(sb, len);
 	memcpy(sb->buf + sb->len, data, len);
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_addf(struct strbuf *sb, const char *fmt, ...) {
+void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
+{
 	int len;
 	va_list ap;
 
@@ -76,7 +111,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...) {
 	strbuf_setlen(sb, sb->len + len);
 }
 
-size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f) {
+size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
+{
 	size_t res;
 
 	strbuf_grow(sb, size);
@@ -110,7 +146,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
-void read_line(struct strbuf *sb, FILE *fp, int term) {
+void read_line(struct strbuf *sb, FILE *fp, int term)
+{
 	int ch;
 	if (feof(fp)) {
 		strbuf_release(sb);
diff --git a/strbuf.h b/strbuf.h
index 21fc111..f163c63 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -55,6 +55,7 @@ extern void strbuf_init(struct strbuf *, size_t);
 extern void strbuf_release(struct strbuf *);
 extern void strbuf_reset(struct strbuf *);
 extern char *strbuf_detach(struct strbuf *);
+extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
 
 /*----- strbuf size related -----*/
 static inline size_t strbuf_avail(struct strbuf *sb) {
@@ -81,6 +82,10 @@ static inline void strbuf_addch(struct strbuf *sb, int c) {
 /* inserts after pos, or appends if pos >= sb->len */
 extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
 
+/* splice pos..pos+len with given data */
+extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
+						  const void *, size_t);
+
 extern void strbuf_add(struct strbuf *, const void *, size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
-- 
1.5.3.1
