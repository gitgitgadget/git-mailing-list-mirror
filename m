From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] move encode_in_pack_object_header() to a better place
Date: Tue, 23 Feb 2010 15:02:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002231500210.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Lukashov <michael.lukashov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:02:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk0xx-0006eX-J4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0BWUCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:02:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38718 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab0BWUCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:02:38 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KYB00DYC90D6061@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Feb 2010 15:02:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140827>


Commit 1b22b6c897 made duplicated versions of encode_header() into a
common version called encode_in_pack_object_header(). There is however
a better location that sha1_file.c for such a function though, as
sha1_file.c contains nothing related to the creation of packs, and
it is quite populated already.

Also the comment that was moved to the header file should really remain
near the function as it covers implementation details and provides no
information about the actual function interface.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/cache.h b/cache.h
index c863085..d454b7e 100644
--- a/cache.h
+++ b/cache.h
@@ -911,14 +911,6 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
-/*
- * The per-object header is a pretty dense thing, which is
- *  - first byte: low four bits are "size", then three bits of "type",
- *    and the high bit is "size continues".
- *  - each byte afterwards: low seven bits are size continuation,
- *    with the high bit being "size continues"
- */
-int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/pack-write.c b/pack-write.c
index 9f47cf9..a905ca4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -253,3 +253,30 @@ char *index_pack_lockfile(int ip_out)
 	}
 	return NULL;
 }
+
+/*
+ * The per-object header is a pretty dense thing, which is
+ *  - first byte: low four bits are "size", then three bits of "type",
+ *    and the high bit is "size continues".
+ *  - each byte afterwards: low seven bits are size continuation,
+ *    with the high bit being "size continues"
+ */
+int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr)
+{
+	int n = 1;
+	unsigned char c;
+
+	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
+		die("bad type %d", type);
+
+	c = (type << 4) | (size & 15);
+	size >>= 4;
+	while (size) {
+		*hdr++ = c | 0x80;
+		c = size & 0x7f;
+		size >>= 7;
+		n++;
+	}
+	*hdr = c;
+	return n;
+}
diff --git a/pack.h b/pack.h
index b759a23..d268c01 100644
--- a/pack.h
+++ b/pack.h
@@ -60,6 +60,7 @@ extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off
 extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
+extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
 
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
diff --git a/sha1_file.c b/sha1_file.c
index be6f37e..006321e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1475,26 +1475,6 @@ const char *packed_object_info_detail(struct packed_git *p,
 	}
 }
 
-int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr)
-{
-	int n = 1;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
-		die("bad type %d", type);
-
-	c = (type << 4) | (size & 15);
-	size >>= 4;
-	while (size) {
-		*hdr++ = c | 0x80;
-		c = size & 0x7f;
-		size >>= 7;
-		n++;
-	}
-	*hdr = c;
-	return n;
-}
-
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			      unsigned long *sizep)
 {
