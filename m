From: "Alfred M. Szmidt" <ams@gnu.org>
Subject: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 16:03:03 -0400
Message-ID: <E1MFvux-0001ix-I7@fencepost.gnu.org>
Reply-To: ams@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 22:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvv7-0001pP-84
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 22:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbZFNUDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZFNUDC
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 16:03:02 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:43800 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZFNUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 16:03:01 -0400
Received: from ams by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <ams@gnu.org>)
	id 1MFvux-0001ix-I7
	for git@vger.kernel.org; Sun, 14 Jun 2009 16:03:03 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121560>

This small patch fixes things so that repack, fsck, and other things
work on >2GiB files.  There are still some other problems (cloning
over ssh being one), but this makes it atleast possible to handle such
files.

(not subscribed, please CC)

---
 delta.h       |    2 +-
 patch-delta.c |    2 +-
 sha1_file.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/delta.h b/delta.h
index 40ccf5a..b3acc72 100644
--- a/delta.h
+++ b/delta.h
@@ -95,7 +95,7 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 	int i = 0;
 	do {
 		cmd = *data++;
-		size |= (cmd & ~0x80) << i;
+		size |= (cmd & ~0x80UL) << i;
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
diff --git a/patch-delta.c b/patch-delta.c
index ed9db81..a9ad2bc 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -44,7 +44,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			if (cmd & 0x01) cp_off = *data++;
 			if (cmd & 0x02) cp_off |= (*data++ << 8);
 			if (cmd & 0x04) cp_off |= (*data++ << 16);
-			if (cmd & 0x08) cp_off |= (*data++ << 24);
+			if (cmd & 0x08) cp_off |= ((unsigned long) *data++ << 24);
 			if (cmd & 0x10) cp_size = *data++;
 			if (cmd & 0x20) cp_size |= (*data++ << 8);
 			if (cmd & 0x40) cp_size |= (*data++ << 16);
diff --git a/sha1_file.c b/sha1_file.c
index e73cd4f..4566ea1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1176,7 +1176,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 			return 0;
 		}
 		c = buf[used++];
-		size += (c & 0x7f) << shift;
+		size += (c & 0x7fUL) << shift;
 		shift += 7;
 	}
 	*sizep = size;
-- 
1.6.3.2.225.gb8364.dirty
