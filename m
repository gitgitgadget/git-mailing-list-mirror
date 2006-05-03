From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] tiny optimization to diff-delta
Date: Tue, 02 May 2006 23:46:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605022336551.28543@localhost.localdomain>
References: <Pine.LNX.4.64.0605022226070.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 05:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb8KJ-0005LE-C9
	for gcvg-git@gmane.org; Wed, 03 May 2006 05:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWECDqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 23:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWECDqx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 23:46:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43871 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965055AbWECDqw
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 23:46:52 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYO00DOC7U3CPF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 May 2006 23:46:52 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605022226070.28543@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19453>

This is my assembly freak side looking at generated code again.  And 
since create_delta() is certainly pretty high on the radar every bits 
count.  In this case shorter code is generated if hash_mask is not 
copied to a local variable.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/diff-delta.c b/diff-delta.c
index 26540d8..c618875 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -253,7 +253,7 @@ create_delta(const struct delta_index *i
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, hash_mask, val;
+	unsigned int i, outpos, outsize, val;
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
@@ -289,7 +289,6 @@ create_delta(const struct delta_index *i
 	ref_top = ref_data + index->src_size;
 	data = trg_buf;
 	top = trg_buf + trg_size;
-	hash_mask = index->hash_mask;
 
 	outpos++;
 	val = 0;
@@ -304,7 +303,7 @@ create_delta(const struct delta_index *i
 		struct index_entry *entry;
 		val ^= U[data[-RABIN_WINDOW]];
 		val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
-		i = val & hash_mask;
+		i = val & index->hash_mask;
 		for (entry = index->hash[i]; entry; entry = entry->next) {
 			const unsigned char *ref = entry->ptr;
 			const unsigned char *src = data;
