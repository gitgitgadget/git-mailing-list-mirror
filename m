From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Eradicate yet-another-buffer implementation in buitin-rerere.c
Date: Wed,  5 Sep 2007 21:18:42 +0200
Message-ID: <1189019923662-git-send-email-madcoder@debian.org>
References: <20070905085720.GD31750@artemis.corp>
 <11890199232110-git-send-email-madcoder@debian.org>
 <11890199232128-git-send-email-madcoder@debian.org>
 <11890199232646-git-send-email-madcoder@debian.org>
 <1189019923740-git-send-email-madcoder@debian.org>
 <11890199233357-git-send-email-madcoder@debian.org>
 <1189019923943-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0PN-00046W-9k
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXIETS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbXIETSz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:18:55 -0400
Received: from pan.madism.org ([88.191.52.104]:46562 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690AbXIETSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:18:49 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B8CA71E1D9;
	Wed,  5 Sep 2007 21:18:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DF7133244D2; Wed,  5 Sep 2007 21:18:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <1189019923943-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57749>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-rerere.c |   53 +++++++++++++++--------------------------------------
 1 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29d057c..2025004 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
+#include "strbuf.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
@@ -66,38 +67,14 @@ static int write_rr(struct path_list *rr, int out_fd)
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
+	struct strbuf minus = STRBUF_INIT, plus = STRBUF_INIT;
+	struct strbuf *one = &minus, *two = &plus;
 	FILE *f = fopen(path, "r");
 	FILE *out;
 
@@ -122,36 +99,36 @@ static int handle_file(const char *path,
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
1.5.3
