From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 33/38] pack v4: we can read commit objects now
Date: Thu, 05 Sep 2013 02:19:56 -0400
Message-ID: <1378362001-1738-34-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvz-0007xc-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab3IEGUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab3IEGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:22 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANT2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 38B272DA05F2	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233905>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 Makefile       |  1 +
 packv4-parse.c |  1 +
 packv4-parse.h |  7 +++++++
 sha1_file.c    | 10 ++++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 packv4-parse.h

diff --git a/Makefile b/Makefile
index ba6cafc..22fc276 100644
--- a/Makefile
+++ b/Makefile
@@ -702,6 +702,7 @@ LIB_H += notes.h
 LIB_H += object.h
 LIB_H += pack-revindex.h
 LIB_H += pack.h
+LIB_H += packv4-parse.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pathspec.h
diff --git a/packv4-parse.c b/packv4-parse.c
index bca1a97..431f47e 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -9,6 +9,7 @@
  */
 
 #include "cache.h"
+#include "packv4-parse.h"
 #include "varint.h"
 
 const unsigned char *get_sha1ref(struct packed_git *p,
diff --git a/packv4-parse.h b/packv4-parse.h
new file mode 100644
index 0000000..40aa75a
--- /dev/null
+++ b/packv4-parse.h
@@ -0,0 +1,7 @@
+#ifndef PACKV4_PARSE_H
+#define PACKV4_PARSE_H
+
+void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
+		     off_t offset, unsigned long size);
+
+#endif
diff --git a/sha1_file.c b/sha1_file.c
index f3bfa28..b57d9f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -19,6 +19,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "pack-revindex.h"
+#include "packv4-parse.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "streaming.h"
@@ -2172,6 +2173,15 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
+		if (p->version >= 4 && !base_from_cache) {
+			if (type == OBJ_COMMIT) {
+				data = pv4_get_commit(p, &w_curs, curpos, size);
+			} else {
+				die("no pack v4 tree parsing yet");
+			}
+			break;
+		}
+		/* fall through */
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		if (!base_from_cache)
-- 
1.8.4.38.g317e65b
