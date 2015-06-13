From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 06/10] get_remote_heads: convert to struct object_id
Date: Sat, 13 Jun 2015 22:16:39 +0000
Message-ID: <1434233803-422442-7-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjv-0002tS-CW
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbbFMWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:17:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42869 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751228AbbFMWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BE39528097;
	Sat, 13 Jun 2015 22:16:51 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271597>

Replace an unsigned char array with struct object_id and express several
hard-coded constants in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index f8b10eb..7f005a7 100644
--- a/connect.c
+++ b/connect.c
@@ -119,7 +119,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
-		unsigned char old_sha1[20];
+		struct object_id old_oid;
 		char *name;
 		int len, name_len;
 		char *buffer = packet_buffer;
@@ -138,34 +138,36 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
 			die("remote error: %s", arg);
 
-		if (len == 48 && skip_prefix(buffer, "shallow ", &arg)) {
-			if (get_sha1_hex(arg, old_sha1))
+		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
+			skip_prefix(buffer, "shallow ", &arg)) {
+			if (get_oid_hex(arg, &old_oid))
 				die("protocol error: expected shallow sha-1, got '%s'", arg);
 			if (!shallow_points)
 				die("repository on the other end cannot be shallow");
-			sha1_array_append(shallow_points, old_sha1);
+			sha1_array_append(shallow_points, old_oid.hash);
 			continue;
 		}
 
-		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
+		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
+			buffer[GIT_SHA1_HEXSZ] != ' ')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
-		name = buffer + 41;
+		name = buffer + GIT_SHA1_HEXSZ + 1;
 
 		name_len = strlen(name);
-		if (len != name_len + 41) {
+		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
 			free(server_capabilities);
 			server_capabilities = xstrdup(name + name_len + 1);
 		}
 
 		if (extra_have && !strcmp(name, ".have")) {
-			sha1_array_append(extra_have, old_sha1);
+			sha1_array_append(extra_have, old_oid.hash);
 			continue;
 		}
 
 		if (!check_ref(name, flags))
 			continue;
-		ref = alloc_ref(buffer + 41);
-		hashcpy(ref->old_oid.hash, old_sha1);
+		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
+		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
 		list = &ref->next;
 		got_at_least_one_head = 1;
-- 
2.4.0
