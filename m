From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] small cleanup for diff-delta.c
Date: Thu, 15 Dec 2005 11:10:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512151103260.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 17:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emvh5-0004kN-TL
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 17:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVLOQKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 11:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVLOQKg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 11:10:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61480 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750761AbVLOQKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 11:10:35 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IRJ0082CRLK9Q60@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Dec 2005 11:10:32 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13702>

This patch removes unused remnants of the original xdiff source.
No functional change.  Possible tiny speed improvement.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/diff-delta.c b/diff-delta.c
index b2ae7b5..890986e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -84,20 +84,15 @@ typedef struct s_chanode {
 } chanode_t;
 
 typedef struct s_chastore {
-	chanode_t *head, *tail;
 	int isize, nsize;
 	chanode_t *ancur;
-	chanode_t *sncur;
-	int scurr;
 } chastore_t;
 
 static void cha_init(chastore_t *cha, int isize, int icount)
 {
-	cha->head = cha->tail = NULL;
 	cha->isize = isize;
 	cha->nsize = icount * isize;
-	cha->ancur = cha->sncur = NULL;
-	cha->scurr = 0;
+	cha->ancur = NULL;
 }
 
 static void *cha_alloc(chastore_t *cha)
@@ -111,12 +106,7 @@ static void *cha_alloc(chastore_t *cha)
 		if (!ancur)
 			return NULL;
 		ancur->icurr = 0;
-		ancur->next = NULL;
-		if (cha->tail)
-			cha->tail->next = ancur;
-		if (!cha->head)
-			cha->head = ancur;
-		cha->tail = ancur;
+		ancur->next = cha->ancur;
 		cha->ancur = ancur;
 	}
 
@@ -127,7 +117,7 @@ static void *cha_alloc(chastore_t *cha)
 
 static void cha_free(chastore_t *cha)
 {
-	chanode_t *cur = cha->head;
+	chanode_t *cur = cha->ancur;
 	while (cur) {
 		chanode_t *tmp = cur;
 		cur = cur->next;
@@ -142,7 +132,6 @@ typedef struct s_bdrecord {
 } bdrecord_t;
 
 typedef struct s_bdfile {
-	const unsigned char *data, *top;
 	chastore_t cha;
 	unsigned int fphbits;
 	bdrecord_t **fphash;
@@ -152,7 +141,7 @@ static int delta_prepare(const unsigned 
 {
 	unsigned int fphbits;
 	int i, hsize;
-	const unsigned char *base, *data, *top;
+	const unsigned char *data, *top;
 	bdrecord_t *brec;
 	bdrecord_t **fphash;
 
@@ -165,13 +154,12 @@ static int delta_prepare(const unsigned 
 		fphash[i] = NULL;
 	cha_init(&bdf->cha, sizeof(bdrecord_t), hsize / 4 + 1);
 
-	bdf->data = data = base = buf;
-	bdf->top = top = buf + bufsize;
-	data += (bufsize / BLK_SIZE) * BLK_SIZE;
+	top = buf + bufsize;
+	data = buf + (bufsize / BLK_SIZE) * BLK_SIZE;
 	if (data == top)
 		data -= BLK_SIZE;
 
-	for ( ; data >= base; data -= BLK_SIZE) {
+	for ( ; data >= buf; data -= BLK_SIZE) {
 		brec = cha_alloc(&bdf->cha);
 		if (!brec) {
 			cha_free(&bdf->cha);
@@ -208,7 +196,7 @@ void *diff_delta(void *from_buf, unsigne
 {
 	int i, outpos, outsize, inscnt, csize, msize, moff;
 	unsigned int fp;
-	const unsigned char *data, *top, *ptr1, *ptr2;
+	const unsigned char *ref_data, *ref_top, *data, *top, *ptr1, *ptr2;
 	unsigned char *out, *orig;
 	bdrecord_t *brec;
 	bdfile_t bdf;
@@ -224,6 +212,8 @@ void *diff_delta(void *from_buf, unsigne
 		return NULL;
 	}
 
+	ref_data = from_buf;
+	ref_top = from_buf + from_size;
 	data = to_buf;
 	top = to_buf + to_size;
 
@@ -253,7 +243,7 @@ void *diff_delta(void *from_buf, unsigne
 		i = HASH(fp, bdf.fphbits);
 		for (brec = bdf.fphash[i]; brec; brec = brec->next) {
 			if (brec->fp == fp) {
-				csize = bdf.top - brec->ptr;
+				csize = ref_top - brec->ptr;
 				if (csize > top - data)
 					csize = top - data;
 				for (ptr1 = brec->ptr, ptr2 = data; 
@@ -262,7 +252,7 @@ void *diff_delta(void *from_buf, unsigne
 
 				csize = ptr1 - brec->ptr;
 				if (csize > msize) {
-					moff = brec->ptr - bdf.data;
+					moff = brec->ptr - ref_data;
 					msize = csize;
 					if (msize >= 0x10000) {
 						msize = 0x10000;
