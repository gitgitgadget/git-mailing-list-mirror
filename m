From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/7] sha1_file: make "read_object" static
Date: Mon, 12 Jan 2009 18:42:24 +0100
Message-ID: <20090112184224.31342906.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQoc-0007hd-Tq
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbZALRln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZALRln
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:41:43 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:41823 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbZALRlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:41:42 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4A8F78182ED;
	Mon, 12 Jan 2009 18:41:34 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 44D9B818755;
	Mon, 12 Jan 2009 18:41:32 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105360>

This function is only used from "sha1_file.c".

And as we want to add a "replace_object" hook in "read_sha1_file",
we must not let people bypass the hook using something other than
"read_sha1_file".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     |    3 ---
 sha1_file.c |    7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

	Here is a new patch series. This time the hook is in "read_sha1_file".
	There are still many things to do and to check after this, it's just a start.
	But I try to follow the advise we give to GSoC student so I release early
	and often :-)

diff --git a/cache.h b/cache.h
index 231c06d..8e1af26 100644
--- a/cache.h
+++ b/cache.h
@@ -631,9 +631,6 @@ extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsig
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 
-/* just like read_sha1_file(), but non fatal in presence of bad objects */
-extern void *read_object(const unsigned char *sha1, enum object_type *type, unsigned long *size);
-
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
diff --git a/sha1_file.c b/sha1_file.c
index 52d1ead..f08493f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1700,6 +1700,9 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	delta_base_cache_lru.prev = &ent->lru;
 }
 
+static void *read_object(const unsigned char *sha1, enum object_type *type,
+			 unsigned long *size);
+
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
 				off_t curpos,
@@ -2130,8 +2133,8 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
-void *read_object(const unsigned char *sha1, enum object_type *type,
-		  unsigned long *size)
+static void *read_object(const unsigned char *sha1, enum object_type *type,
+			 unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
-- 
1.6.1.83.g16e5
