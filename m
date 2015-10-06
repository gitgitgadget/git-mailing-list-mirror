From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Tue,  6 Oct 2015 14:15:04 +0200
Message-ID: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 14:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjR9J-0007KI-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 14:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbbJFMPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 08:15:11 -0400
Received: from mail.zhinst.com ([212.126.164.98]:51550 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbbJFMPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 08:15:10 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Tue, 6 Oct 2015 14:15:04 +0200
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279130>

prented_sha1_file() always returns 0 and its only callsite in
builtin/blame.c doesn't use the return value, so change the return type
to void.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 cache.h     | 2 +-
 sha1_file.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 752031e..445853b 100644
--- a/cache.h
+++ b/cache.h
@@ -970,7 +970,7 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+extern void pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index d295a32..d76b723 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2789,14 +2789,14 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	return data;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
+void pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
 	struct cached_object *co;
 
 	hash_sha1_file(buf, len, typename(type), sha1);
 	if (has_sha1_file(sha1) || find_cached_object(sha1))
-		return 0;
+		return;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
@@ -2804,7 +2804,6 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
 	hashcpy(co->sha1, sha1);
-	return 0;
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-- 
2.6.0
