From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 36/38] pack v4: get tree objects
Date: Thu, 05 Sep 2013 02:19:59 -0400
Message-ID: <1378362001-1738-37-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvl-0007oz-9k
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab3IEGUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab3IEGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:22 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G422XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 54A572DA05D6	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233898>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-parse.c | 25 +++++++++++++++++++++++++
 packv4-parse.h |  2 ++
 sha1_file.c    |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 04eab46..4c218d2 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -365,3 +365,28 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 
 	return 0;
 }
+
+void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
+		   off_t offset, unsigned long size)
+{
+	unsigned long avail;
+	unsigned int nb_entries;
+	unsigned char *dst, *dcp;
+	const unsigned char *src, *scp;
+	int ret;
+
+	src = use_pack(p, w_curs, offset, &avail);
+	scp = src;
+	nb_entries = decode_varint(&scp);
+	if (scp == src)
+		return NULL;
+
+	dst = xmallocz(size);
+	dcp = dst;
+	ret = decode_entries(p, w_curs, offset, 0, nb_entries, &dcp, &size, 0);
+	if (ret < 0 || size != 0) {
+		free(dst);
+		return NULL;
+	}
+	return dst;
+}
diff --git a/packv4-parse.h b/packv4-parse.h
index 40aa75a..5f9d809 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -3,5 +3,7 @@
 
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size);
+void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
+		   off_t offset, unsigned long size);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index b57d9f8..79e1293 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2177,7 +2177,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			if (type == OBJ_COMMIT) {
 				data = pv4_get_commit(p, &w_curs, curpos, size);
 			} else {
-				die("no pack v4 tree parsing yet");
+				data = pv4_get_tree(p, &w_curs, curpos, size);
 			}
 			break;
 		}
-- 
1.8.4.38.g317e65b
