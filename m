From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 2/5] Support fetching the memory usage of a delta index
Date: Wed, 11 Jul 2007 22:14:15 -0500
Message-ID: <1184210058269-git-send-email-bdowning@lavos.net>
References: <11842100581060-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 05:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8p8L-0005sZ-D2
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 05:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934525AbXGLDOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 23:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765384AbXGLDOV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 23:14:21 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:62865 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765285AbXGLDOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 23:14:17 -0400
Received: by silvara (Postfix, from userid 1000)
	id 28AEE52136; Wed, 11 Jul 2007 22:14:18 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <11842100581060-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52236>

Delta indexes, at least on 64-bit platforms, tend to be larger than
the actual uncompressed data.  As such, keeping track of this storage
is important if you want to successfully limit the memory size of your
pack window.

Squirrel away the total allocation size inside the delta_index struct,
and add an accessor "sizeof_delta_index" to access it.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 delta.h      |    7 +++++++
 diff-delta.c |   10 ++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/delta.h b/delta.h
index 7b3f86d..40ccf5a 100644
--- a/delta.h
+++ b/delta.h
@@ -24,6 +24,13 @@ create_delta_index(const void *buf, unsigned long bufsize);
 extern void free_delta_index(struct delta_index *index);
 
 /*
+ * sizeof_delta_index: returns memory usage of delta index
+ *
+ * Given pointer must be what create_delta_index() returned, or NULL.
+ */
+extern unsigned long sizeof_delta_index(struct delta_index *index);
+
+/*
  * create_delta: create a delta from given index for the given buffer
  *
  * This function may be called multiple times with different buffers using
diff --git a/diff-delta.c b/diff-delta.c
index faf96e4..3af5835 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -119,6 +119,7 @@ struct index_entry {
 };
 
 struct delta_index {
+	unsigned long memsize;
 	const void *src_buf;
 	unsigned long src_size;
 	unsigned int hash_mask;
@@ -159,6 +160,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	mem = hash + hsize;
 	entry = mem;
 
+	index->memsize = memsize;
 	index->src_buf = buf;
 	index->src_size = bufsize;
 	index->hash_mask = hmask;
@@ -228,6 +230,14 @@ void free_delta_index(struct delta_index *index)
 	free(index);
 }
 
+unsigned long sizeof_delta_index(struct delta_index *index)
+{
+	if (index)
+		return index->memsize;
+	else
+		return 0;
+}
+
 /*
  * The maximum size for any opcode sequence, including the initial header
  * plus Rabin window plus biggest copy.
-- 
1.5.2.GIT
