From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 6/7] Eradicate yet-another-buffer implementation in buitin-rerere.c
Date: Thu,  6 Sep 2007 13:20:10 +0200
Message-ID: <11890776112641-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
 <11890776112292-git-send-email-madcoder@debian.org>
 <11890776111670-git-send-email-madcoder@debian.org>
 <11890776112309-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPn-0008PZ-3n
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbXIFLU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbXIFLU0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:26 -0400
Received: from pan.madism.org ([88.191.52.104]:52614 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbXIFLUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:14 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 702CF1E407;
	Thu,  6 Sep 2007 13:20:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E607E1A3C2; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776112309-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57866>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-rerere.c |   56 +++++++++++++++++------------------------------------
 1 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29d057c..7ebf6f1 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
+#include "strbuf.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
@@ -66,41 +67,20 @@ static int write_rr(struct path_list *rr, int out_fd)
 	return commit_lock_file(&write_lock);
 }
 
-struct buffer {
-	char *ptr;
-	int nr, alloc;
-};
-
-static void append_line(struct buffer *buffer, const char *line)
-{
-	int len = strlen(line);
-
-	if (buffer->nr + len > buffer->alloc) {
-		buffer->alloc = alloc_nr(buffer->nr + len);
-		buffer->ptr = xrealloc(buffer->ptr, buffer->alloc);
-	}
-	memcpy(buffer->ptr + buffer->nr, line, len);
-	buffer->nr += len;
-}
-
-static void clear_buffer(struct buffer *buffer)
-{
-	free(buffer->ptr);
-	buffer->ptr = NULL;
-	buffer->nr = buffer->alloc = 0;
-}
-
 static int handle_file(const char *path,
 	 unsigned char *sha1, const char *output)
 {
 	SHA_CTX ctx;
 	char buf[1024];
 	int hunk = 0, hunk_no = 0;
-	struct buffer minus = { NULL, 0, 0 }, plus = { NULL, 0, 0 };
-	struct buffer *one = &minus, *two = &plus;
+	struct strbuf minus, plus;
+	struct strbuf *one = &minus, *two = &plus;
 	FILE *f = fopen(path, "r");
 	FILE *out;
 
+        strbuf_init(&minus);
+        strbuf_init(&plus);
+
 	if (!f)
 		return error("Could not open %s", path);
 
@@ -122,36 +102,36 @@ static int handle_file(const char *path,
 		else if (!prefixcmp(buf, "======="))
 			hunk = 2;
 		else if (!prefixcmp(buf, ">>>>>>> ")) {
-			int one_is_longer = (one->nr > two->nr);
-			int common_len = one_is_longer ? two->nr : one->nr;
-			int cmp = memcmp(one->ptr, two->ptr, common_len);
+			int one_is_longer = (one->len > two->len);
+			int common_len = one_is_longer ? two->len : one->len;
+			int cmp = memcmp(one->buf, two->buf, common_len);
 
 			hunk_no++;
 			hunk = 0;
 			if ((cmp > 0) || ((cmp == 0) && one_is_longer)) {
-				struct buffer *swap = one;
+				struct strbuf *swap = one;
 				one = two;
 				two = swap;
 			}
 			if (out) {
 				fputs("<<<<<<<\n", out);
-				fwrite(one->ptr, one->nr, 1, out);
+				fwrite(one->buf, one->len, 1, out);
 				fputs("=======\n", out);
-				fwrite(two->ptr, two->nr, 1, out);
+				fwrite(two->buf, two->len, 1, out);
 				fputs(">>>>>>>\n", out);
 			}
 			if (sha1) {
-				SHA1_Update(&ctx, one->ptr, one->nr);
+				SHA1_Update(&ctx, one->buf, one->len);
 				SHA1_Update(&ctx, "\0", 1);
-				SHA1_Update(&ctx, two->ptr, two->nr);
+				SHA1_Update(&ctx, two->buf, two->len);
 				SHA1_Update(&ctx, "\0", 1);
 			}
-			clear_buffer(one);
-			clear_buffer(two);
+			strbuf_release(one);
+			strbuf_release(two);
 		} else if (hunk == 1)
-			append_line(one, buf);
+			strbuf_addstr(one, buf);
 		else if (hunk == 2)
-			append_line(two, buf);
+			strbuf_addstr(two, buf);
 		else if (out)
 			fputs(buf, out);
 	}
-- 
1.5.3.1
