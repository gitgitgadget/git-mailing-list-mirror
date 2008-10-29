From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/9] make packed_object_info() resilient to pack corruptions
Date: Wed, 29 Oct 2008 19:02:47 -0400
Message-ID: <1225321372-6570-5-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6t-0004tU-PV
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbYJ2XDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758157AbYJ2XDa
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150AbYJ2XD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:28 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99426>

In the same spirit as commit 8eca0b47ff, let's try to survive a pack
corruption by making packed_object_info() able to fall back to alternate
packs or loose objects.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7698177..384a430 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1314,8 +1314,10 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
 	inflateEnd(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
-		die("delta data unpack-initial failed");
+	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
+		error("delta data unpack-initial failed");
+		return 0;
+	}
 
 	/* Examine the initial part of the delta to figure out
 	 * the result size.
@@ -1382,15 +1384,29 @@ static int packed_delta_info(struct packed_git *p,
 	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
+	if (!base_offset)
+		return OBJ_BAD;
 	type = packed_object_info(p, base_offset, NULL);
+	if (type <= OBJ_NONE) {
+		struct revindex_entry *revidx = find_pack_revindex(p, base_offset);
+		const unsigned char *base_sha1 =
+					nth_packed_object_sha1(p, revidx->nr);
+		mark_bad_packed_object(p, base_sha1);
+		type = sha1_object_info(base_sha1, NULL);
+		if (type <= OBJ_NONE)
+			return OBJ_BAD;
+	}
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
-	if (sizep)
+	if (sizep) {
 		*sizep = get_size_from_delta(p, w_curs, curpos);
+		if (*sizep == 0)
+			type = OBJ_BAD;
+	}
 
 	return type;
 }
@@ -1500,8 +1516,9 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			*sizep = size;
 		break;
 	default:
-		die("pack %s contains unknown object type %d",
-		    p->pack_name, type);
+		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		      type, (uintmax_t)obj_offset, p->pack_name);
+		type = OBJ_BAD;
 	}
 	unuse_pack(&w_curs);
 	return type;
@@ -1971,7 +1988,14 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 		if (!find_pack_entry(sha1, &e, NULL))
 			return status;
 	}
-	return packed_object_info(e.p, e.offset, sizep);
+
+	status = packed_object_info(e.p, e.offset, sizep);
+	if (status < 0) {
+		mark_bad_packed_object(e.p, sha1);
+		status = sha1_object_info(sha1, sizep);
+	}
+
+	return status;
 }
 
 static void *read_packed_sha1(const unsigned char *sha1,
-- 
1.6.0.3.757.g01be.dirty
