From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/5] strbuf API additions and enhancements.
Date: Tue, 18 Sep 2007 19:18:02 +0200
Message-ID: <20070918224119.17650344AB3@madism.org>
References: <20070918223947.GB4535@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXll1-0007bW-60
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXIRWlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbXIRWlV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:41:21 -0400
Received: from pan.madism.org ([88.191.52.104]:54827 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXIRWlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:41:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 60591208A9;
	Wed, 19 Sep 2007 00:41:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 17650344AB3; Wed, 19 Sep 2007 00:41:19 +0200 (CEST)
In-Reply-To: <20070918223947.GB4535@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58648>

Add strbuf_remove, change strbuf_insert:
  As both are special cases of strbuf_splice, implement them as such.
  gcc is able to do the math and generate almost optimal code this way.

Add strbuf_addvf (vsprintf-like)

Add strbuf_swap:
  Exchange the values of its arguments.
  Use it in fast-import.c

Also fix spacing issues in strbuf.h

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 commit.c      |    2 +-
 fast-import.c |    4 +---
 strbuf.c      |   38 ++++++++++++++++++++++++++++----------
 strbuf.h      |   19 +++++++++++++------
 4 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/commit.c b/commit.c
index f86fa77..55b08ec 100644
--- a/commit.c
+++ b/commit.c
@@ -656,7 +656,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	strbuf_attach(&tmp, buf, strlen(buf), strlen(buf) + 1);
 	if (is_encoding_utf8(encoding)) {
 		/* we have re-coded to UTF-8; drop the header */
-		strbuf_splice(&tmp, start, len, NULL, 0);
+		strbuf_remove(&tmp, start, len);
 	} else {
 		/* just replaces XXXX in 'encoding XXXX\n' */
 		strbuf_splice(&tmp, start + strlen("encoding "),
diff --git a/fast-import.c b/fast-import.c
index f990658..eddae22 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1111,9 +1111,7 @@ static int store_object(
 		if (last->no_swap) {
 			last->data = *dat;
 		} else {
-			struct strbuf tmp = *dat;
-			*dat = last->data;
-			last->data = tmp;
+			strbuf_swap(&last->data, dat);
 		}
 		last->offset = e->offset;
 	}
diff --git a/strbuf.c b/strbuf.c
index 59383ac..51aa2de 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -50,16 +50,6 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
-{
-	strbuf_grow(sb, len);
-	if (pos > sb->len)
-		die("`pos' is too far after the end of the buffer");
-	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
-	memcpy(sb->buf + pos, data, len);
-	strbuf_setlen(sb, sb->len + len);
-}
-
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 				   const void *data, size_t dlen)
 {
@@ -79,6 +69,16 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 	strbuf_setlen(sb, sb->len + dlen - len);
 }
 
+void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
+{
+	strbuf_splice(sb, pos, 0, data, len);
+}
+
+void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
+{
+	strbuf_splice(sb, pos, len, NULL, 0);
+}
+
 void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 {
 	strbuf_grow(sb, len);
@@ -109,6 +109,24 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	int len;
+
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	if (len < 0) {
+		len = 0;
+	}
+	if (len > strbuf_avail(sb)) {
+		strbuf_grow(sb, len);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+		if (len > strbuf_avail(sb)) {
+			die("this should not happen, your snprintf is broken");
+		}
+	}
+	strbuf_setlen(sb, sb->len + len);
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index b2cbd97..ac3fb7b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -55,15 +55,20 @@ extern void strbuf_release(struct strbuf *);
 extern void strbuf_reset(struct strbuf *);
 extern char *strbuf_detach(struct strbuf *);
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
+static inline void strbuf_swap(struct strbuf *a, struct strbuf *b) {
+	struct strbuf tmp = *a;
+	*a = *b;
+	*b = tmp;
+}
 
 /*----- strbuf size related -----*/
 static inline size_t strbuf_avail(struct strbuf *sb) {
-    return sb->alloc ? sb->alloc - sb->len - 1 : 0;
+	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
 }
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
-    assert (len < sb->alloc);
-    sb->len = len;
-    sb->buf[len] = '\0';
+	assert (len < sb->alloc);
+	sb->len = len;
+	sb->buf[len] = '\0';
 }
 
 extern void strbuf_grow(struct strbuf *, size_t);
@@ -78,12 +83,12 @@ static inline void strbuf_addch(struct strbuf *sb, int c) {
 	sb->buf[sb->len] = '\0';
 }
 
-/* inserts after pos, or appends if pos >= sb->len */
 extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
+extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
 
 /* splice pos..pos+len with given data */
 extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
-						  const void *, size_t);
+                          const void *, size_t);
 
 extern void strbuf_add(struct strbuf *, const void *, size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
@@ -95,6 +100,8 @@ static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format(printf,2,0)))
+extern void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
-- 
1.5.3.1
