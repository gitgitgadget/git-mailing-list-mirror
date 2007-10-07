From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make strbuf_cmp inline, constify its arguments and optimize it a bit
Date: Sun, 7 Oct 2007 16:00:52 +0200
Message-ID: <20071007140052.GA3260@steel.home>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 16:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeWgw-0006EH-Ee
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXJGOA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXJGOA5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:00:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33739 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbXJGOA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:00:56 -0400
Received: from tigra.home (Facde.f.strato-dslnet.de [195.4.172.222])
	by post.webmailer.de (klopstock mo7) (RZmta 13.4)
	with ESMTP id 6033fdj978uKV3 ; Sun, 7 Oct 2007 16:00:53 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DBA8F277AE;
	Sun,  7 Oct 2007 16:00:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7440CC776; Sun,  7 Oct 2007 16:00:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190625904-22808-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9oFqQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60177>

It is definitely less code (also object code). It is not always
measurably faster (but mostly is).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 strbuf.c |   12 ------------
 strbuf.h |    9 ++++++++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f4201e1..215837b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -58,18 +58,6 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-int strbuf_cmp(struct strbuf *a, struct strbuf *b)
-{
-	int cmp;
-	if (a->len < b->len) {
-		cmp = memcmp(a->buf, b->buf, a->len);
-		return cmp ? cmp : -1;
-	} else {
-		cmp = memcmp(a->buf, b->buf, b->len);
-		return cmp ? cmp : a->len != b->len;
-	}
-}
-
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 				   const void *data, size_t dlen)
 {
diff --git a/strbuf.h b/strbuf.h
index 9b9e861..3116387 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -78,7 +78,14 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 
 /*----- content related -----*/
 extern void strbuf_rtrim(struct strbuf *);
-extern int strbuf_cmp(struct strbuf *, struct strbuf *);
+static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
+{
+	int len = a->len < b->len ? a->len: b->len;
+	int cmp = memcmp(a->buf, b->buf, len);
+	if (cmp)
+		return cmp;
+	return a->len < b->len ? -1: a->len != b->len;
+}
 
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
-- 
1.5.3.4.223.g78587
