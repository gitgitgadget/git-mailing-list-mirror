From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 2/2] fast-import: use struct hash_table for objects
Date: Thu, 31 Mar 2011 22:59:58 +1100
Message-ID: <1301572798-9973-3-git-send-email-david.barr@cordelta.com>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GYE-0002jn-Th
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab1CaMA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:00:28 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:60863 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438Ab1CaMA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 08:00:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 2E50CC05B;
	Thu, 31 Mar 2011 22:57:20 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTBAg3qFgo47; Thu, 31 Mar 2011 22:57:17 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 60803C059;
	Thu, 31 Mar 2011 22:57:17 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170477>

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 fast-import.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0592b21..8fd8ea9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -313,7 +313,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static struct hash_table object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -555,9 +555,9 @@ static struct object_entry *new_object(unsigned char *sha1)
 
 static struct object_entry *find_object(unsigned char *sha1)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
+	unsigned int h = sha1[0] << 24 | sha1[1] << 16 | sha1[2] << 8 | sha1[3];
 	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
+	for (e = lookup_hash(h, &object_table); e; e = e->next)
 		if (!hashcmp(sha1, e->idx.sha1))
 			return e;
 	return NULL;
@@ -565,8 +565,9 @@ static struct object_entry *find_object(unsigned char *sha1)
 
 static struct object_entry *insert_object(unsigned char *sha1)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
-	struct object_entry *e = object_table[h];
+	unsigned int h = sha1[0] << 24 | sha1[1] << 16 | sha1[2] << 8 | sha1[3];
+	struct object_entry *e = lookup_hash(h, &object_table);
+	void **pos;
 
 	while (e) {
 		if (!hashcmp(sha1, e->idx.sha1))
@@ -575,9 +576,13 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	}
 
 	e = new_object(sha1);
-	e->next = object_table[h];
+	e->next = NULL;
 	e->idx.offset = 0;
-	object_table[h] = e;
+	pos = insert_hash(h, e, &object_table);
+	if (pos) {
+		e->next = *pos;
+		*pos = e;
+	}
 	return e;
 }
 
-- 
1.7.3.2.846.gf4b062
