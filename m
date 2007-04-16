From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 8/9] add get_size_from_delta()
Date: Mon, 16 Apr 2007 12:31:56 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161231370.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU7V-0001EJ-Hr
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030866AbXDPQb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030868AbXDPQb5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:31:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61655 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030866AbXDPQb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:31:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00HEDN9801H0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:31:56 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44673>

... which consists of existing code split out of packed_delta_info()
for other callers to use it as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 cache.h     |    1 +
 sha1_file.c |   73 +++++++++++++++++++++++++++++++---------------------------
 2 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/cache.h b/cache.h
index 4d058c7..b9c2104 100644
--- a/cache.h
+++ b/cache.h
@@ -456,6 +456,7 @@ extern const unsigned char *nth_packed_object_sha1(const struct packed_git *, ui
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
diff --git a/sha1_file.c b/sha1_file.c
index 76e0048..2864ce8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1161,6 +1161,43 @@ static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type
 	return unpack_sha1_rest(&stream, hdr, *size, sha1);
 }
 
+unsigned long get_size_from_delta(struct packed_git *p,
+		        	  struct pack_window **w_curs,
+			          off_t curpos)
+{
+	const unsigned char *data;
+	unsigned char delta_head[20], *in;
+	z_stream stream;
+	int st;
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = delta_head;
+	stream.avail_out = sizeof(delta_head);
+
+	inflateInit(&stream);
+	do {
+		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		stream.next_in = in;
+		st = inflate(&stream, Z_FINISH);
+		curpos += stream.next_in - in;
+	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
+		 stream.total_out < sizeof(delta_head));
+	inflateEnd(&stream);
+	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
+		die("delta data unpack-initial failed");
+
+	/* Examine the initial part of the delta to figure out
+	 * the result size.
+	 */
+	data = delta_head;
+
+	/* ignore base size */
+	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+
+	/* Read the result size */
+	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+}
+
 static off_t get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t *curpos,
@@ -1224,40 +1261,8 @@ static int packed_delta_info(struct packed_git *p,
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
-	if (sizep) {
-		const unsigned char *data;
-		unsigned char delta_head[20], *in;
-		z_stream stream;
-		int st;
-
-		memset(&stream, 0, sizeof(stream));
-		stream.next_out = delta_head;
-		stream.avail_out = sizeof(delta_head);
-
-		inflateInit(&stream);
-		do {
-			in = use_pack(p, w_curs, curpos, &stream.avail_in);
-			stream.next_in = in;
-			st = inflate(&stream, Z_FINISH);
-			curpos += stream.next_in - in;
-		} while ((st == Z_OK || st == Z_BUF_ERROR)
-			&& stream.total_out < sizeof(delta_head));
-		inflateEnd(&stream);
-		if ((st != Z_STREAM_END) &&
-		    stream.total_out != sizeof(delta_head))
-			die("delta data unpack-initial failed");
-
-		/* Examine the initial part of the delta to figure out
-		 * the result size.
-		 */
-		data = delta_head;
-
-		/* ignore base size */
-		get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
-
-		/* Read the result size */
-		*sizep = get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
-	}
+	if (sizep)
+		*sizep = get_size_from_delta(p, w_curs, curpos);
 
 	return type;
 }
-- 
1.5.1.1.781.g65e8
