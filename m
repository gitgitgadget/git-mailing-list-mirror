From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/6] Add strbuf_rtrim and strbuf_insert.
Date: Sun,  9 Sep 2007 02:04:31 +0200
Message-ID: <11892962761617-git-send-email-madcoder@debian.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 11:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOa-00040f-Jb
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:56 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMb-0006Wk-M2
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:21 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMV-0003zs-8G
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbXIIAEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbXIIAEk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:40 -0400
Received: from pan.madism.org ([88.191.52.104]:46627 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbXIIAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9AB021EB1A;
	Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E819A3033; Sun,  9 Sep 2007 02:04:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11892962763548-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.8, required=12.0, autolearn=disabled, AWL=1.250,UIO_VGER=-3)
X-UiO-Scanned: 30F9B3EEED399FFD0F08948EC39CB6B4B5CE1247
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -17 maxlevel 200 minaction 2 bait 0 mail/h: 3 total 517789 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58160>

  * strbuf_rtrim removes trailing spaces.
  * strbuf_insert insert data at a given position.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 strbuf.c |   18 ++++++++++++++++++
 strbuf.h |    6 ++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 7136de1..2643ce1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -28,6 +28,24 @@ void strbuf_grow(struct strbuf *sb, size_t extra) {
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
 
+void strbuf_rtrim(struct strbuf *sb)
+{
+	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
+void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len) {
+	strbuf_grow(sb, len);
+	if (pos >= sb->len) {
+		sb->len = pos;
+	} else {
+		memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
+	}
+	memcpy(sb->buf + pos, data, len);
+	strbuf_setlen(sb, sb->len + len);
+}
+
 void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
 	strbuf_grow(sb, len);
 	memcpy(sb->buf + sb->len, data, len);
diff --git a/strbuf.h b/strbuf.h
index b40dc99..b90cbdf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -68,6 +68,9 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 
 extern void strbuf_grow(struct strbuf *, size_t);
 
+/*----- content related -----*/
+extern void strbuf_rtrim(struct strbuf *);
+
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
 	strbuf_grow(sb, 1);
@@ -75,6 +78,9 @@ static inline void strbuf_addch(struct strbuf *sb, int c) {
 	sb->buf[sb->len] = '\0';
 }
 
+/* inserts after pos, or appends if pos >= sb->len */
+extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
+
 extern void strbuf_add(struct strbuf *, const void *, size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
-- 
1.5.3.1
