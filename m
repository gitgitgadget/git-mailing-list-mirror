From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 02/10] make overflow test on delta base offset work regardless
 of variable size
Date: Mon, 09 Apr 2007 01:06:29 -0400
Message-ID: <11760951993458-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5u-00038I-On
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbXDIFGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbXDIFGv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXDIFGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:40 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:39 -0400 (EDT)
In-reply-to: <11760951973319-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44037>

This patch introduces the MSB() macro to obtain the desired number of
most significant bits from a given variable independently of the variable
type.

It is then used to better implement the overflow test on the OBJ_OFS_DELTA
base offset variable with the property of always working correctly
regardless of the type/size of that variable.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |    2 +-
 builtin-unpack-objects.c |    2 +-
 git-compat-util.h        |    8 ++++++++
 index-pack.c             |    2 +-
 sha1_file.c              |    2 +-
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6bff17b..ee607a0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1014,7 +1014,7 @@ static void check_object(struct object_entry *entry)
 				ofs = c & 127;
 				while (c & 128) {
 					ofs += 1;
-					if (!ofs || ofs & ~(~0UL >> 7))
+					if (!ofs || MSB(ofs, 7))
 						die("delta base offset overflow in pack for %s",
 						    sha1_to_hex(entry->sha1));
 					c = buf[used_0++];
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 3956c56..63f7db6 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -209,7 +209,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || MSB(base_offset, 7))
 				die("offset value overflow for delta base object");
 			pack = fill(1);
 			c = *pack;
diff --git a/git-compat-util.h b/git-compat-util.h
index 139fc19..bcfcb35 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -13,6 +13,14 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifdef __GNUC__
+#define TYPEOF(x) (__typeof__(x))
+#else
+#define TYPEOF(x)
+#endif
+
+#define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (sizeof(x) * 8 - (bits))))
+
 #if !defined(__APPLE__) && !defined(__FreeBSD__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
diff --git a/index-pack.c b/index-pack.c
index 3c768fb..0e54aa6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -249,7 +249,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || MSB(base_offset, 7))
 				bad_object(obj->offset, "offset value overflow for delta base object");
 			p = fill(1);
 			c = *p;
diff --git a/sha1_file.c b/sha1_file.c
index d9ca69a..ebdd497 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1150,7 +1150,7 @@ static off_t get_delta_base(struct packed_git *p,
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || MSB(base_offset, 7))
 				die("offset value overflow for delta base object");
 			c = base_info[used++];
 			base_offset = (base_offset << 7) + (c & 127);
-- 
1.5.1.696.g6d352-dirty
