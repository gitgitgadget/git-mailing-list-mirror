From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 12:44:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSepF-0002G3-F9
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 20:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbXCQToX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbXCQToX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 15:44:23 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42827 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbXCQToW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 15:44:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HJi7cD008860
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 12:44:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HJi6cG008807;
	Sat, 17 Mar 2007 11:44:06 -0800
In-Reply-To: <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42450>


This trivial 256-entry delta_base cache improves performance for some 
loads by a factor of 2.5 or so.

Instead of always re-generating the delta bases (possibly over and over 
and over again), just cache the last few ones. They often can get re-used.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This should have some other people doing performance testing too, since 
it's fairly core. But *dang*, it's really simple.

diff --git a/sha1_file.c b/sha1_file.c
index f11ca3f..a7e3a2a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1352,16 +1352,57 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
+#define MAX_DELTA_CACHE (256)
+
+static struct delta_base_cache_entry {
+	struct packed_git *p;
+	off_t base_offset;
+	unsigned long size;
+	void *data;
+	enum object_type type;
+} delta_base_cache[MAX_DELTA_CACHE];
+
+static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
+{
+	unsigned long hash;
+
+	hash = (unsigned long)p + (unsigned long)base_offset;
+	hash += (hash >> 8) + (hash >> 16);
+	return hash & 0xff;
+}
+
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type)
 {
+	void *ret;
+	unsigned long hash = pack_entry_hash(p, base_offset);
+	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+
+	ret = ent->data;
+	if (ret && ent->p == p && ent->base_offset == base_offset)
+		goto found_cache_entry;
 	return unpack_entry(p, base_offset, type, base_size);
+
+found_cache_entry:
+	ent->data = NULL;
+	*type = ent->type;
+	*base_size = ent->size;
+	return ret;
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	free(base);
+	unsigned long hash = pack_entry_hash(p, base_offset);
+	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+
+	if (ent->data)
+		free(ent->data);
+	ent->p = p;
+	ent->base_offset = base_offset;
+	ent->type = type;
+	ent->data = base;
+	ent->size = base_size;
 }
 
 static void *unpack_delta_entry(struct packed_git *p,
