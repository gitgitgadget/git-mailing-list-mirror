From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] restore legacy behavior for read_sha1_file()
Date: Mon, 14 Jul 2008 21:46:48 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142134450.12484@xanadu.home>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
 <7vod50dote.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141937180.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZdz-0006xG-26
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbYGOBqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbYGOBqy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:46:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43052 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYGOBqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:46:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000KICYA2WI30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 21:46:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0807141937180.12484@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88496>

Since commit 8eca0b47ff1598a6d163df9358c0e0c9bd92d4c8, it is possible
for read_sha1_file() to return NULL even with existing objects when they
are corrupted.  Previously a corrupted object would have terminated the
program immediately, effectively making read_sha1_file() return NULL 
only when specified object is not found.

Let's restore this behavior for all users of read_sha1_file() and 
provide a separate function with the ability to not terminate when
bad objects are encountered.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Mon, 14 Jul 2008, Nicolas Pitre wrote:

> Well, I have a different solution which should restore the original 
> "behavior" in the presence of existing but non-readable objects.  Patch 
> will follow later.

So here it is.

diff --git a/sha1_file.c b/sha1_file.c
index 2df78b5..e281c14 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1006,6 +1006,18 @@ static void mark_bad_packed_object(struct packed_git *p,
 	p->num_bad_objects++;
 }
 
+static int has_packed_and_bad(const unsigned char *sha1)
+{
+	struct packed_git *p;
+	unsigned i;
+
+	for (p = packed_git; p; p = p->next)
+		for (i = 0; i < p->num_bad_objects; i++)
+			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+				return 1;
+	return 0;
+}
+
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	unsigned char real_sha1[20];
@@ -1647,7 +1659,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 		      sha1_to_hex(base_sha1), (uintmax_t)base_offset,
 		      p->pack_name);
 		mark_bad_packed_object(p, base_sha1);
-		base = read_sha1_file(base_sha1, type, &base_size);
+		base = read_object(base_sha1, type, &base_size);
 		if (!base)
 			return NULL;
 	}
@@ -1945,7 +1957,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 		error("failed to read object %s at offset %"PRIuMAX" from %s",
 		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
 		mark_bad_packed_object(e.p, sha1);
-		data = read_sha1_file(sha1, type, size);
+		data = read_object(sha1, type, size);
 	}
 	return data;
 }
@@ -2010,8 +2022,8 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
-void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
-		     unsigned long *size)
+void *read_object(const unsigned char *sha1, enum object_type *type,
+		  unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
@@ -2037,6 +2049,16 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 	return read_packed_sha1(sha1, type, size);
 }
 
+void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
+		     unsigned long *size)
+{
+	void *data = read_object(sha1, type, size);
+	/* legacy behavior is to die on corrupted objects */
+	if (!data && (has_loose_object(sha1) || has_packed_and_bad(sha1)))
+		die("object %s is corrupted", sha1_to_hex(sha1));
+	return data;
+}
+
 void *read_object_with_reference(const unsigned char *sha1,
 				 const char *required_type_name,
 				 unsigned long *size,
