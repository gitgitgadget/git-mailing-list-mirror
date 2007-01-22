From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Mon, 22 Jan 2007 21:29:45 +0100
Message-ID: <20070122202945.GA29297@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 22 21:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95uU-0004GO-U1
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbXAVUg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbXAVUg3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:36:29 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:40317 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932440AbXAVUg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:36:28 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 15:36:28 EST
Received: (qmail 29394 invoked by uid 5842); 22 Jan 2007 21:29:45 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37446>

We used to call find_pack_entry() twice from read_sha1_file() in order
to avoid printing an error message, when the object did not exist.  This
is fixed by moving the call to error() to the only place it really
could be called.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 sha1_file.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3025440..43ff402 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1469,21 +1469,20 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
 {
 	struct pack_entry e;
 
-	if (!find_pack_entry(sha1, &e, NULL)) {
-		error("cannot read sha1_file for %s", sha1_to_hex(sha1));
+	if (!find_pack_entry(sha1, &e, NULL))
 		return NULL;
-	}
-	return unpack_entry(e.p, e.offset, type, size);
+	else
+		return unpack_entry(e.p, e.offset, type, size);
 }
 
 void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
-	struct pack_entry e;
 
-	if (find_pack_entry(sha1, &e, NULL))
-		return read_packed_sha1(sha1, type, size);
+	buf = read_packed_sha1(sha1, type, size);
+	if (buf)
+		return buf;
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
@@ -1491,9 +1490,7 @@ void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size
 		return buf;
 	}
 	reprepare_packed_git();
-	if (find_pack_entry(sha1, &e, NULL))
-		return read_packed_sha1(sha1, type, size);
-	return NULL;
+	return read_packed_sha1(sha1, type, size);
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
@@ -1781,6 +1778,8 @@ static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 
 	/* need to unpack and recompress it by itself */
 	unpacked = read_packed_sha1(sha1, type, &len);
+	if (!unpacked)
+		error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 
 	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
 
-- 
1.5.0.rc1.gdf1b-dirty
