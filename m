From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] Export matches_pack_name() and fix its return value
Date: Mon, 17 Sep 2007 01:44:47 -0700
Message-ID: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCEP-00089U-5t
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbXIQIpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbXIQIo7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:44:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702AbXIQIo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:44:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A91E21368AD;
	Mon, 17 Sep 2007 04:45:17 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58396>

The function sounds boolean; make it behave as one, not "0 for
success, non-zero for failure".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 +
 sha1_file.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 70abbd5..3fa5b8e 100644
--- a/cache.h
+++ b/cache.h
@@ -529,6 +529,7 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern int matches_pack_name(struct packed_git *p, const char *name);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 9978a58..5801c3e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1684,22 +1684,22 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-static int matches_pack_name(struct packed_git *p, const char *ig)
+int matches_pack_name(struct packed_git *p, const char *name)
 {
 	const char *last_c, *c;
 
-	if (!strcmp(p->pack_name, ig))
-		return 0;
+	if (!strcmp(p->pack_name, name))
+		return 1;
 
 	for (c = p->pack_name, last_c = c; *c;)
 		if (*c == '/')
 			last_c = ++c;
 		else
 			++c;
-	if (!strcmp(last_c, ig))
-		return 0;
+	if (!strcmp(last_c, name))
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
@@ -1717,7 +1717,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 		if (ignore_packed) {
 			const char **ig;
 			for (ig = ignore_packed; *ig; ig++)
-				if (!matches_pack_name(p, *ig))
+				if (matches_pack_name(p, *ig))
 					break;
 			if (*ig)
 				goto next;
-- 
1.5.3.1.967.g6bb01
