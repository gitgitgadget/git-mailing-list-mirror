From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 2/6] Support fetching the memory usage of a delta index
Date: Thu, 12 Jul 2007 07:55:48 -0500
Message-ID: <11842449522040-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yD6-0005M9-SP
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763354AbXGLMzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXGLMzx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:55:53 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:56632 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758199AbXGLMzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:50 -0400
Received: by silvara (Postfix, from userid 1000)
	id 8733552135; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52273>

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
