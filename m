From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 21:31:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 21:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOtq-0003Aw-PO
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760225AbXKNUbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXKNUbU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:31:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42027 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753243AbXKNUbT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 15:31:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 411B047274
	for <git@vger.kernel.org>; Wed, 14 Nov 2007 15:31:18 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Nov 2007 15:31:18 -0500
X-Sasl-enc: QScOkjyWvZawGmUqXFPYoJtQVzWO8zTML3V+QNA9piYl 1195072277
Received: from [192.168.2.101] (p549A183B.dip0.t-ipconnect.de [84.154.24.59])
	by mail.messagingengine.com (Postfix) with ESMTP id 83A3F2A23F
	for <git@vger.kernel.org>; Wed, 14 Nov 2007 15:31:17 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65010>

Hello,

please find below a patch that solves an error when compiling with the 
original Sun Solaris Compiler. When compiling out of the box, the 
following happens:

     CC diff-delta.o
"diff-delta.c", line 314: identifier redeclared: create_delta
 	current : function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void
 	previous: function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void : "delta.h", line 44
cc: acomp failed for diff-delta.c
make: *** [diff-delta.o] Error 2

This is because 'struct delta_index' is declared with no size in delta.h 
and with size in diff-delta.c which does not fit.

When the struct definition is done in the header file as one would 
normally expect, everything compiles ok with exception of a 
mkdtemp()-issue which somebody else already took care of on this list.

Best regards

Guido


diff --git a/delta.h b/delta.h
index 40ccf5a..06af9a7 100644
--- a/delta.h
+++ b/delta.h
@@ -1,8 +1,23 @@
  #ifndef DELTA_H
  #define DELTA_H

-/* opaque object for delta index */
-struct delta_index;
+struct index_entry {
+    const unsigned char *ptr;
+    unsigned int val;
+};
+
+struct unpacked_index_entry {
+    struct index_entry entry;
+    struct unpacked_index_entry *next;
+};
+
+struct delta_index {
+    unsigned long memsize;
+    const void *src_buf;
+    unsigned long src_size;
+    unsigned int hash_mask;
+    struct index_entry *hash[FLEX_ARRAY];
+};

  /*
   * create_delta_index: compute index data from given buffer
diff --git a/diff-delta.c b/diff-delta.c
index 9e440a9..2023e40 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -112,24 +112,6 @@ static const unsigned int U[256] = {
  	0x133eb0ac, 0x6d8b90a1, 0x450d4467, 0x3bb8646a
  };

-struct index_entry {
-	const unsigned char *ptr;
-	unsigned int val;
-};
-
-struct unpacked_index_entry {
-	struct index_entry entry;
-	struct unpacked_index_entry *next;
-};
-
-struct delta_index {
-	unsigned long memsize;
-	const void *src_buf;
-	unsigned long src_size;
-	unsigned int hash_mask;
-	struct index_entry *hash[FLEX_ARRAY];
-};
-
  struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
  {
  	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
