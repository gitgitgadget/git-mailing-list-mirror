From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH] use gcrypt instead of libssl for hash
Date: Mon, 18 Apr 2005 05:58:24 +0200
Message-ID: <20050418055824.42d621b8.froese@gmx.de>
References: <87hdi5oet6.dancerj@netfort.gr.jp>
	<Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 05:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNNLc-0007DH-8I
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 05:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDRD6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 23:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVDRD6q
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 23:58:46 -0400
Received: from pop.gmx.de ([213.165.64.20]:4314 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261642AbVDRD6a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 23:58:30 -0400
Received: (qmail invoked by alias); 18 Apr 2005 03:58:28 -0000
Received: from p50904AF5.dip.t-dialin.net (EHLO dialup) [80.144.74.245]
  by mail.gmx.net (mp020) with SMTP; 18 Apr 2005 05:58:28 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> Well, libgcrypt seems to be pretty rare out there - I certainly don't have 
> it installed on my machine.

Well, I don't even have openssl ...

> Or merge the SHA1 code from the kernel, even, and make the project
> entirely self-sufficient.

... so I took the sha1 code from Firefox (it's MPL or GPL - you choose).

Here's the patch.

diff -ruN git-0.04-orig/Makefile git-0.04/Makefile
--- git-0.04-orig/Makefile	Mon Apr 11 05:48:10 2005
+++ git-0.04/Makefile	Mon Apr 18 05:41:49 2005
@@ -9,42 +9,57 @@
 install: $(PROG)
 	install $(PROG) $(HOME)/bin/
 
-LIBS= -lssl -lz
+LIBS= -lz
 
 init-db: init-db.o
 
-update-cache: update-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+update-cache: update-cache.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o sha1.o $(LIBS)
 
-show-diff: show-diff.o read-cache.o
-	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+show-diff: show-diff.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o sha1.o $(LIBS)
 
-write-tree: write-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+write-tree: write-tree.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o sha1.o $(LIBS)
 
-read-tree: read-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+read-tree: read-tree.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o sha1.o $(LIBS)
 
-commit-tree: commit-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+commit-tree: commit-tree.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o sha1.o $(LIBS)
 
-cat-file: cat-file.o read-cache.o
-	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+cat-file: cat-file.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o sha1.o $(LIBS)
 
-fsck-cache: fsck-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+fsck-cache: fsck-cache.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o sha1.o $(LIBS)
 
-checkout-cache: checkout-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+checkout-cache: checkout-cache.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o sha1.o $(LIBS)
 
-diff-tree: diff-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
-
-read-cache.o: cache.h
-show-diff.o: cache.h
+diff-tree: diff-tree.o read-cache.o sha1.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o sha1.o $(LIBS)
 
 clean:
 	rm -f *.o $(PROG) temp_git_file_*
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+depend:
+	makedepend -Y -- -- *.c 2>/dev/null
+
+# DO NOT DELETE
+
+cat-file.o: cache.h sha1.h
+checkout-cache.o: cache.h sha1.h
+commit-tree.o: cache.h sha1.h
+diff-tree.o: cache.h sha1.h
+fsck-cache.o: cache.h sha1.h
+init-db.o: cache.h sha1.h
+read-cache.o: cache.h sha1.h
+read-tree.o: cache.h sha1.h
+sha1.o: sha1.h
+show-diff.o: cache.h sha1.h
+update-cache.o: cache.h sha1.h
+write-tree.o: cache.h sha1.h
diff -ruN git-0.04-orig/cache.h git-0.04/cache.h
--- git-0.04-orig/cache.h	Sun Apr 10 20:19:02 2005
+++ git-0.04/cache.h	Mon Apr 18 05:46:47 2005
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 
-#include <openssl/sha.h>
+#include "sha1.h"
 #include <zlib.h>
 
 /*
diff -ruN git-0.04-orig/sha1.c git-0.04/sha1.c
--- git-0.04-orig/sha1.c	Thu Jan  1 01:00:00 1970
+++ git-0.04/sha1.c	Mon Apr 18 05:40:25 2005
@@ -0,0 +1,152 @@
+/* 
+ * The contents of this file are subject to the Mozilla Public
+ * License Version 1.1 (the "License"); you may not use this file
+ * except in compliance with the License. You may obtain a copy of
+ * the License at http://www.mozilla.org/MPL/
+ * 
+ * Software distributed under the License is distributed on an "AS
+ * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ * implied. See the License for the specific language governing
+ * rights and limitations under the License.
+ * 
+ * The Original Code is SHA 180-1 Reference Implementation (Compact version)
+ * 
+ * The Initial Developer of the Original Code is Paul Kocher of
+ * Cryptography Research.  Portions created by Paul Kocher are 
+ * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
+ * Rights Reserved.
+ * 
+ * Contributor(s):
+ *
+ *     Paul Kocher
+ * 
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License Version 2 or later (the
+ * "GPL"), in which case the provisions of the GPL are applicable 
+ * instead of those above.  If you wish to allow use of your 
+ * version of this file only under the terms of the GPL and not to
+ * allow others to use your version of this file under the MPL,
+ * indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by
+ * the GPL.  If you do not delete the provisions above, a recipient
+ * may use your version of this file under either the MPL or the
+ * GPL.
+ */
+
+#include "sha1.h"
+
+static void shaHashBlock(SHA_CTX *ctx);
+
+void SHA1_Init(SHA_CTX *ctx) {
+  int i;
+
+  ctx->lenW = 0;
+  ctx->sizeHi = ctx->sizeLo = 0;
+
+  /* Initialize H with the magic constants (see FIPS180 for constants)
+   */
+  ctx->H[0] = 0x67452301;
+  ctx->H[1] = 0xefcdab89;
+  ctx->H[2] = 0x98badcfe;
+  ctx->H[3] = 0x10325476;
+  ctx->H[4] = 0xc3d2e1f0;
+
+  for (i = 0; i < 80; i++)
+    ctx->W[i] = 0;
+}
+
+
+void SHA1_Update(SHA_CTX *ctx, void *_dataIn, int len) {
+  unsigned char *dataIn = _dataIn;
+  int i;
+
+  /* Read the data into W and process blocks as they get full
+   */
+  for (i = 0; i < len; i++) {
+    ctx->W[ctx->lenW / 4] <<= 8;
+    ctx->W[ctx->lenW / 4] |= (unsigned int)dataIn[i];
+    if ((++ctx->lenW) % 64 == 0) {
+      shaHashBlock(ctx);
+      ctx->lenW = 0;
+    }
+    ctx->sizeLo += 8;
+    ctx->sizeHi += (ctx->sizeLo < 8);
+  }
+}
+
+
+void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx) {
+  unsigned char pad0x80 = 0x80;
+  unsigned char pad0x00 = 0x00;
+  unsigned char padlen[8];
+  int i;
+
+  /* Pad with a binary 1 (e.g. 0x80), then zeroes, then length
+   */
+  padlen[0] = (unsigned char)((ctx->sizeHi >> 24) & 255);
+  padlen[1] = (unsigned char)((ctx->sizeHi >> 16) & 255);
+  padlen[2] = (unsigned char)((ctx->sizeHi >> 8) & 255);
+  padlen[3] = (unsigned char)((ctx->sizeHi >> 0) & 255);
+  padlen[4] = (unsigned char)((ctx->sizeLo >> 24) & 255);
+  padlen[5] = (unsigned char)((ctx->sizeLo >> 16) & 255);
+  padlen[6] = (unsigned char)((ctx->sizeLo >> 8) & 255);
+  padlen[7] = (unsigned char)((ctx->sizeLo >> 0) & 255);
+  SHA1_Update(ctx, &pad0x80, 1);
+  while (ctx->lenW != 56)
+    SHA1_Update(ctx, &pad0x00, 1);
+  SHA1_Update(ctx, padlen, 8);
+
+  /* Output hash
+   */
+  for (i = 0; i < 20; i++) {
+    hashout[i] = (unsigned char)(ctx->H[i / 4] >> 24);
+    ctx->H[i / 4] <<= 8;
+  }
+
+  /*
+   *  Re-initialize the context (also zeroizes contents)
+   */
+  SHA1_Init(ctx);
+}
+
+
+#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+
+static void shaHashBlock(SHA_CTX *ctx) {
+  int t;
+  unsigned int A,B,C,D,E,TEMP;
+
+  for (t = 16; t <= 79; t++)
+    ctx->W[t] =
+      SHA_ROT(ctx->W[t-3] ^ ctx->W[t-8] ^ ctx->W[t-14] ^ ctx->W[t-16], 1);
+
+  A = ctx->H[0];
+  B = ctx->H[1];
+  C = ctx->H[2];
+  D = ctx->H[3];
+  E = ctx->H[4];
+
+  for (t = 0; t <= 19; t++) {
+    TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + ctx->W[t] + 0x5a827999;
+    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+  }
+  for (t = 20; t <= 39; t++) {
+    TEMP = SHA_ROT(A,5) + (B^C^D)           + E + ctx->W[t] + 0x6ed9eba1;
+    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+  }
+  for (t = 40; t <= 59; t++) {
+    TEMP = SHA_ROT(A,5) + ((B&C)|(D&(B|C))) + E + ctx->W[t] + 0x8f1bbcdc;
+    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+  }
+  for (t = 60; t <= 79; t++) {
+    TEMP = SHA_ROT(A,5) + (B^C^D)           + E + ctx->W[t] + 0xca62c1d6;
+    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+  }
+
+  ctx->H[0] += A;
+  ctx->H[1] += B;
+  ctx->H[2] += C;
+  ctx->H[3] += D;
+  ctx->H[4] += E;
+}
+
diff -ruN git-0.04-orig/sha1.h git-0.04/sha1.h
--- git-0.04-orig/sha1.h	Thu Jan  1 01:00:00 1970
+++ git-0.04/sha1.h	Mon Apr 18 05:40:25 2005
@@ -0,0 +1,45 @@
+/* 
+ * The contents of this file are subject to the Mozilla Public
+ * License Version 1.1 (the "License"); you may not use this file
+ * except in compliance with the License. You may obtain a copy of
+ * the License at http://www.mozilla.org/MPL/
+ * 
+ * Software distributed under the License is distributed on an "AS
+ * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ * implied. See the License for the specific language governing
+ * rights and limitations under the License.
+ * 
+ * The Original Code is SHA 180-1 Header File
+ * 
+ * The Initial Developer of the Original Code is Paul Kocher of
+ * Cryptography Research.  Portions created by Paul Kocher are 
+ * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
+ * Rights Reserved.
+ * 
+ * Contributor(s):
+ *
+ *     Paul Kocher
+ * 
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License Version 2 or later (the
+ * "GPL"), in which case the provisions of the GPL are applicable 
+ * instead of those above.  If you wish to allow use of your 
+ * version of this file only under the terms of the GPL and not to
+ * allow others to use your version of this file under the MPL,
+ * indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by
+ * the GPL.  If you do not delete the provisions above, a recipient
+ * may use your version of this file under either the MPL or the
+ * GPL.
+ */
+
+typedef struct {
+  unsigned int H[5];
+  unsigned int W[80];
+  int lenW;
+  unsigned int sizeHi,sizeLo;
+} SHA_CTX;
+
+void SHA1_Init(SHA_CTX *ctx);
+void SHA1_Update(SHA_CTX *ctx, void *dataIn, int len);
+void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx);


Ciao, ET.
