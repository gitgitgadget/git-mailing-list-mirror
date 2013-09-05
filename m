From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 26/38] pack v4: object header decode
Date: Thu, 05 Sep 2013 02:19:49 -0400
Message-ID: <1378362001-1738-27-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwJ-00089M-RL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab3IEGU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab3IEGUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:20 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id C96EF2DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233911>

For this we need the pack version.  However only open_packed_git_1() has
been audited for pack v4 so far, hence the version validation is not
added to pack_version_ok() just yet.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h     |  1 +
 sha1_file.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index c939b60..59d9ba7 100644
--- a/cache.h
+++ b/cache.h
@@ -1025,6 +1025,7 @@ extern struct packed_git {
 	uint32_t num_objects;
 	uint32_t num_bad_objects;
 	unsigned char *bad_object_sha1;
+	int version;
 	int index_version;
 	time_t mtime;
 	int pack_fd;
diff --git a/sha1_file.c b/sha1_file.c
index 5c63781..a298933 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "delta.h"
 #include "pack.h"
+#include "varint.h"
 #include "blob.h"
 #include "commit.h"
 #include "run-command.h"
@@ -845,10 +846,11 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("file %s is far too short to be a packfile", p->pack_name);
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
 		return error("file %s is not a GIT packfile", p->pack_name);
-	if (!pack_version_ok(hdr.hdr_version))
+	if (!pack_version_ok(hdr.hdr_version) && hdr.hdr_version != htonl(4))
 		return error("packfile %s is version %"PRIu32" and not"
 			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
+	p->version = ntohl(hdr.hdr_version);
 
 	/* Verify the pack matches its index. */
 	if (p->num_objects != ntohl(hdr.hdr_entries))
@@ -1725,7 +1727,15 @@ int unpack_object_header(struct packed_git *p,
 	 * insane, so we know won't exceed what we have been given.
 	 */
 	base = use_pack(p, w_curs, *curpos, &left);
-	used = unpack_object_header_buffer(base, left, &type, sizep);
+	if (p->version < 4) {
+		used = unpack_object_header_buffer(base, left, &type, sizep);
+	} else {
+		const unsigned char *cp = base;
+		uintmax_t val = decode_varint(&cp);
+		used = cp - base;
+		type = val & 0xf;
+		*sizep = val >> 4;
+	}
 	if (!used) {
 		type = OBJ_BAD;
 	} else
-- 
1.8.4.38.g317e65b
