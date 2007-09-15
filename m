From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] New strbuf APIs: splice and embed.
Date: Sat, 15 Sep 2007 15:56:50 +0200
Message-ID: <20070915141335.ECB4B4C152@madism.org>
References: <20070915141210.GA27494@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYP2-0000FP-45
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbXIOONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbXIOONh
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:13:37 -0400
Received: from pan.madism.org ([88.191.52.104]:33916 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbXIOONg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:13:36 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3F0C178B;
	Sat, 15 Sep 2007 16:13:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id ECB4B4C152; Sat, 15 Sep 2007 16:13:35 +0200 (CEST)
In-Reply-To: <20070915141210.GA27494@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58246>

* strbuf_splice replace a portion of the buffer with another.
* strbuf_embed replace a strbuf buffer with the given one, that should be
  malloc'ed. Then it enforces strbuf's invariants. If alloc > len, then this
  function has negligible cost, else it will perform a realloc, possibly
  with a cost.
---
 strbuf.c |   31 +++++++++++++++++++++++++++++--
 strbuf.h |    5 +++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index d919047..ad82eaf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -24,14 +24,22 @@ char *strbuf_detach(struct strbuf *sb) {
 	return res;
 }
 
+void strbuf_embed(struct strbuf *sb, void *buf, size_t len, size_t alloc) {
+	strbuf_release(sb);
+	sb->buf   = buf;
+	sb->len   = len;
+	sb->alloc = alloc;
+	strbuf_grow(sb, 0);
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_grow(struct strbuf *sb, size_t extra) {
 	if (sb->len + extra + 1 <= sb->len)
 		die("you want to use way too much memory");
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
 
-void strbuf_rtrim(struct strbuf *sb)
-{
+void strbuf_rtrim(struct strbuf *sb) {
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] = '\0';
@@ -48,6 +56,25 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
+				   const void *data, size_t dlen)
+{
+	if (pos + len < pos)
+		die("you want to splice outside from the buffer");
+	if (pos > sb->len)
+		pos = sb->len;
+	if (pos + len > sb->len)
+		len = sb->len - pos;
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
 void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
 	strbuf_grow(sb, len);
 	memcpy(sb->buf + sb->len, data, len);
diff --git a/strbuf.h b/strbuf.h
index 21fc111..7e009d1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -55,6 +55,7 @@ extern void strbuf_init(struct strbuf *, size_t);
 extern void strbuf_release(struct strbuf *);
 extern void strbuf_reset(struct strbuf *);
 extern char *strbuf_detach(struct strbuf *);
+extern void strbuf_embed(struct strbuf *, void *, size_t, size_t);
 
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
