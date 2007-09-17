From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] Export matches_pack_name() and fix its return value
Date: Mon, 17 Sep 2007 01:27:06 -0700
Message-ID: <11900176341874-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD85-0006oP-Sq
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbXIQJmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXIQJmz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:42:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbXIQJmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:42:54 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082714.SWLF20651.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:14 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTE1X0061gtr5g0000000; Mon, 17 Sep 2007 04:27:14 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58412>

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
