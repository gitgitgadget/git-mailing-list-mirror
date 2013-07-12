From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] sha1_object_info_extended: rename "status" to "type"
Date: Fri, 12 Jul 2013 02:21:22 -0400
Message-ID: <20130712062122.GB15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWjQ-0000Dk-PN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3GLGVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:21:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:36507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3GLGVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:21:24 -0400
Received: (qmail 16566 invoked by uid 102); 12 Jul 2013 06:22:42 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:22:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:21:22 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230172>

The value we get from each low-level object_info function
(e.g., loose, packed) is actually the object type (or -1 for
error). Let's explicitly call it "type", which will make
further refactorings easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4c2365f..e826066 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2394,7 +2394,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
 	struct pack_entry e;
-	int status, rtype;
+	int type, rtype;
 
 	co = find_cached_object(sha1);
 	if (co) {
@@ -2408,23 +2408,23 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		status = sha1_loose_object_info(sha1, oi->sizep, oi->disk_sizep);
-		if (status >= 0) {
+		type = sha1_loose_object_info(sha1, oi->sizep, oi->disk_sizep);
+		if (type >= 0) {
 			oi->whence = OI_LOOSE;
-			return status;
+			return type;
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
 		if (!find_pack_entry(sha1, &e))
-			return status;
+			return type;
 	}
 
-	status = packed_object_info(e.p, e.offset, oi->sizep, &rtype,
-				    oi->disk_sizep);
-	if (status < 0) {
+	type = packed_object_info(e.p, e.offset, oi->sizep, &rtype,
+				  oi->disk_sizep);
+	if (type < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		status = sha1_object_info_extended(sha1, oi);
+		type = sha1_object_info_extended(sha1, oi);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
@@ -2435,7 +2435,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 					 rtype == OBJ_OFS_DELTA);
 	}
 
-	return status;
+	return type;
 }
 
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
-- 
1.8.3.rc3.24.gec82cb9
