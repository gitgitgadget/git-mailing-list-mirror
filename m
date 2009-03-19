From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Microoptimize strbuf_cmp
Date: Thu, 19 Mar 2009 22:09:32 +0100
Message-ID: <20090319210931.GB31014@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 22:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPYE-00016V-5L
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760951AbZCSVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759264AbZCSVJn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:09:43 -0400
Received: from mout2.freenet.de ([195.4.92.92]:39798 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760818AbZCSVJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:09:42 -0400
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LkPUe-0006kc-Bl; Thu, 19 Mar 2009 22:09:36 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:49717 helo=tigra.home)
	by 0.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #79)
	id 1LkPUe-0000wc-4o; Thu, 19 Mar 2009 22:09:36 +0100
Received: from blimp.localdomain (ubuntu.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 030F3277D8;
	Thu, 19 Mar 2009 22:09:32 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 7628036D27; Thu, 19 Mar 2009 22:09:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113830>

Make it inline and cleanup a bit. It is definitely less code
including object code, but it is not always measurably faster
(but mostly is).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I have this patch for a long time in my tree and vaguely remember
sending it once.

 strbuf.c |   12 ------------
 strbuf.h |    9 ++++++++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6ed0684..e1f4db7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -137,18 +137,6 @@ void strbuf_list_free(struct strbuf **sbs)
 	free(sbs);
 }
 
-int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
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
index 89bd36e..df95960 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -80,11 +80,18 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
-extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 extern void strbuf_tolower(struct strbuf *);
 
 extern struct strbuf **strbuf_split(const struct strbuf *, int delim);
 extern void strbuf_list_free(struct strbuf **);
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
1.6.2.1.250.ga1458
