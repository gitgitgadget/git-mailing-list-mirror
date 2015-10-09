From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 06/13] get_remote_heads: convert to struct object_id
Date: Fri,  9 Oct 2015 01:43:52 +0000
Message-ID: <1444355039-186351-7-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMku-0001vC-1a
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbbJIBps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58070 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755814AbbJIBpL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9BAC02809C;
	Fri,  9 Oct 2015 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355110;
	bh=BXJUvnEu64PmGevpGf4dFwytK/elia9uwS9MhuwxcII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XO2Qag8kNMiNNZu1eFKq/Rr1oeMcWzW9VzKW8/k+kEWdSjRxbvsFpJ3layC5uDdgG
	 AmH2c8g7sbDoDsQvA+7noZXEJ22EXxpxTUAL/puxOEA0WEpP8Erhyc8ZRYoXFvc214
	 YQ4D5NZJGYlNv2cDpFBy8lJrer70EuafL5p1bdnI0dJSbgv3e8NfRb6FfYPZFhAd6m
	 LwxxVIWkswYfbDtHwxaBKSJN+qFcneDmchuJH9R76rW2VlgI5Tiy1mVynn0Yz1tXHX
	 5iyBFfr6EQjqU3fxUeeFrSyShU2B9igkRmXy6pxGfI+WqZWzEvMSIw4Czok7pQCiXK
	 KJGXydWFZVZoJhPbWT690g5JgZLByEQvQS5vLje2vaGH3chZ+2tLsqtdtWQori7tyz
	 ablPm1szzZOw1AeNEPsD1SN6tnWBw3oFXQeGQWtWQbL3fiJFDCDjCghqeSun7rPeQw
	 gwrMoLBNk9ioAujkKErNCFPP1pTExda9HyZ+zDrW0Rp/FhEaJKE
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279291>

Replace an unsigned char array with struct object_id and express several
hard-coded constants in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 45eabcdd..60f9fd07 100644
--- a/connect.c
+++ b/connect.c
@@ -120,7 +120,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
-		unsigned char old_sha1[20];
+		struct object_id old_oid;
 		char *name;
 		int len, name_len;
 		char *buffer = packet_buffer;
@@ -139,34 +139,36 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
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
2.6.1
