From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/6] Use strbufs to in read_message (imap-send.c), custom buffer--.
Date: Sun,  9 Sep 2007 02:04:35 +0200
Message-ID: <11892962771756-git-send-email-madcoder@debian.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
 <11892962761617-git-send-email-madcoder@debian.org>
 <11892962764194-git-send-email-madcoder@debian.org>
 <1189296276114-git-send-email-madcoder@debian.org>
 <11892962771947-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOa-0003oI-DS
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:56 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMs-0006at-6D
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:38 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMo-0003zs-4w
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbXIIAEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbXIIAEn
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:43 -0400
Received: from pan.madism.org ([88.191.52.104]:46635 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbXIIAEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:39 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2D0031EB1D;
	Sun,  9 Sep 2007 02:04:38 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0C5CD4EF4; Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11892962771947-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.2, required=12.0, autolearn=disabled, AWL=0.833,UIO_VGER=-3)
X-UiO-Scanned: EE051DF095C86DF14DBEC3D1C28754962F02FFD8
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -21 maxlevel 200 minaction 2 bait 0 mail/h: 6 total 517792 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58153>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 imap-send.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a5a0696..d3dc5dd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,7 @@
  */
 
 #include "cache.h"
+#include "strbuf.h"
 
 typedef struct store_conf {
 	char *name;
@@ -1160,28 +1161,18 @@ imap_store_msg( store_t *gctx, msg_data_t *data, int *uid )
 static int
 read_message( FILE *f, msg_data_t *msg )
 {
-	int len, r;
+	struct strbuf buf;
 
-	memset( msg, 0, sizeof *msg );
-	len = CHUNKSIZE;
-	msg->data = xmalloc( len+1 );
-	msg->data[0] = 0;
-
-	while(!feof( f )) {
-		if (msg->len >= len) {
-			void *p;
-			len += CHUNKSIZE;
-			p = xrealloc(msg->data, len+1);
-			if (!p)
-				break;
-			msg->data = p;
-		}
-		r = fread( &msg->data[msg->len], 1, len - msg->len, f );
-		if (r <= 0)
+	memset(msg, 0, sizeof(*msg));
+	strbuf_init(&buf);
+
+	do {
+		if (strbuf_fread(&buf, CHUNKSIZE, f) <= 0)
 			break;
-		msg->len += r;
-	}
-	msg->data[msg->len] = 0;
+	} while (!feof(f));
+
+	msg->len  = buf.len;
+	msg->data = strbuf_detach(&buf);
 	return msg->len;
 }
 
-- 
1.5.3.1
