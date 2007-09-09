From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/6] Use strbuf_read in builtin-fetch-tool.c.
Date: Sun,  9 Sep 2007 02:04:34 +0200
Message-ID: <11892962771947-git-send-email-madcoder@debian.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
 <11892962761617-git-send-email-madcoder@debian.org>
 <11892962764194-git-send-email-madcoder@debian.org>
 <1189296276114-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 11:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOa-0003oI-JK
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:56 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMh-0006Yp-Ml
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:27 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMb-0003zs-Sl
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbXIIAEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbXIIAEk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:40 -0400
Received: from pan.madism.org ([88.191.52.104]:46631 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbXIIAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B487A1EB1B;
	Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 066B54474; Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1189296276114-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.9, required=12.0, autolearn=disabled, AWL=1.071,UIO_VGER=-3)
X-UiO-Scanned: 5BD91DC48C6984308735A9D65C50F1C99DBB96E0
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -18 maxlevel 200 minaction 2 bait 0 mail/h: 4 total 517790 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58161>

  xrealloc.use --;

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-fetch--tool.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 24c7e6f..0dd742f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -2,27 +2,16 @@
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
-
-#define CHUNK_SIZE 1024
+#include "strbuf.h"
 
 static char *get_stdin(void)
 {
-	size_t offset = 0;
-	char *data = xmalloc(CHUNK_SIZE);
-
-	while (1) {
-		ssize_t cnt = xread(0, data + offset, CHUNK_SIZE);
-		if (cnt < 0)
-			die("error reading standard input: %s",
-			    strerror(errno));
-		if (cnt == 0) {
-			data[offset] = 0;
-			break;
-		}
-		offset += cnt;
-		data = xrealloc(data, offset + CHUNK_SIZE);
+	struct strbuf buf;
+	strbuf_init(&buf);
+	if (strbuf_read(&buf, 0) < 0) {
+		die("error reading standard input: %s", strerror(errno));
 	}
-	return data;
+	return strbuf_detach(&buf);
 }
 
 static void show_new(enum object_type type, unsigned char *sha1_new)
-- 
1.5.3.1
