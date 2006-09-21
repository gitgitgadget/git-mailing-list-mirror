From: Nicolas Pitre <nico@cam.org>
Subject: (unknown)
Date: Thu, 21 Sep 2006 00:04:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609202349580.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:05:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFoK-0006Sg-RU
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWIUEEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIUEEy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:04:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64226 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751201AbWIUEEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:04:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007O9CO3T700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:04:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27443>

[PATCH 1/6] move pack creation to version 3

It's been quite a while now that GIT is able to read version 3 packs.
Let's create them at last.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/diff-delta.c b/diff-delta.c
index fa16d06..51df460 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -308,8 +308,8 @@ create_delta(const struct delta_index *i
 				continue;
 			if (ref_size > top - src)
 				ref_size = top - src;
-			if (ref_size > 0x10000)
-				ref_size = 0x10000;
+			if (ref_size > 0xffffff)
+				ref_size = 0xffffff;
 			if (ref_size <= msize)
 				break;
 			while (ref_size-- && *src++ == *ref)
@@ -318,6 +318,8 @@ create_delta(const struct delta_index *i
 				/* this is our best match so far */
 				msize = ref - entry->ptr;
 				moff = entry->ptr - ref_data;
+				if (msize >= 0x10000)
+					break;  /* this is good enough */
 			}
 		}
 
@@ -381,6 +383,8 @@ create_delta(const struct delta_index *i
 			if (msize & 0xff) { out[outpos++] = msize; i |= 0x10; }
 			msize >>= 8;
 			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
+			msize >>= 8;
+			if (msize & 0xff) { out[outpos++] = msize; i |= 0x40; }
 
 			*op = i;
 		}
diff --git a/pack.h b/pack.h
index eb07b03..05557da 100644
--- a/pack.h
+++ b/pack.h
@@ -7,7 +7,7 @@ #include "object.h"
  * Packed object header
  */
 #define PACK_SIGNATURE 0x5041434b	/* "PACK" */
-#define PACK_VERSION 2
+#define PACK_VERSION 3
 #define pack_version_ok(v) ((v) == htonl(2) || (v) == htonl(3))
 struct pack_header {
 	unsigned int hdr_signature;
