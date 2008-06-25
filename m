From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/4] optimize verify-pack a bit
Date: Tue, 24 Jun 2008 23:17:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806242315570.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLWM-0001j3-Pu
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYFYDRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYFYDRO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:17:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22194 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYFYDRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:17:14 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K30002Z314OBQ20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 23:17:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86201>


Using find_pack_entry_one() to get object offsets is rather suboptimal
when nth_packed_object_offset() can be used directly.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 cache.h      |    1 +
 pack-check.c |    4 +---
 sha1_file.c  |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index a68866c..16222a3 100644
--- a/cache.h
+++ b/cache.h
@@ -711,6 +711,7 @@ extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
+extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/pack-check.c b/pack-check.c
index b99a917..d6dbd4b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -67,9 +67,7 @@ static int verify_packfile(struct packed_git *p,
 		entries[i].sha1 = nth_packed_object_sha1(p, i);
 		if (!entries[i].sha1)
 			die("internal error pack-check nth-packed-object");
-		entries[i].offset = find_pack_entry_one(entries[i].sha1, p);
-		if (!entries[i].offset)
-			die("internal error pack-check find-pack-entry-one");
+		entries[i].offset = nth_packed_object_offset(p, i);
 	}
 	qsort(entries, nr_objects, sizeof(*entries), compare_entries);
 
diff --git a/sha1_file.c b/sha1_file.c
index 9330bc4..a92f023 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1708,7 +1708,7 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	}
 }
 
-static off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
+off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
 	index += 4 * 256;
-- 
1.5.6.56.g29b0d
