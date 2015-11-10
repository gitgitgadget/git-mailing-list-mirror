From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 05/12] get_remote_heads: convert to struct object_id
Date: Tue, 10 Nov 2015 02:22:23 +0000
Message-ID: <1447122150-672570-6-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaQ-0000rb-G8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbbKJCW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:22:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58406 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239AbbKJCWx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:53 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B8D4728099;
	Tue, 10 Nov 2015 02:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122173;
	bh=ypzSoyaYYLmapjCS/Dt9EoLH0ruVjjOwtYkj3cTFLvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyafhwh5Ax/Y2JOjP9kgxTDVzTAdOhR6Ib+wnMLD6QbWPBNrO9SQQOQ3iTRmV3C48
	 fVo2q9sUP25tYhXo9up71HcZTpXQx2LCth2AOFJ+ZTeoTNNprvXK0s/JKy+wqD+W/6
	 s+LvLrIq600L6x4JcJmmHr6dgFdeAty5/5N6/OEiUjBhrWruUuPgKdhjAcbC6d/95k
	 wd0cQDs68N6/hlYKDARvA/0kFmbs+Z521kcuab3Zz39pp5f5S79stNJqERoVf2rnzL
	 gjVYVEYgZWOKfkIo1/vHIva8wnU2VnBZbEI9ZPpyo3Kb286PymLrxdT5hON964a39J
	 nWtyMaNEAIyeQQI3NZTIq2OD2GrRTab+busegpArXhAO9ZaSCwkLimw9ideYKO+x8C
	 lWWJFPBQG/68I7vYM8rRaIjf2RwsiIgC+CTYV4tlnNT88fi1REODO9/p/eT/u6J+9w
	 sg5ugQuRFMylF+UqxNVklgzUo3EHrR29dntuYUzSjBoAVe362+M
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281091>

Replace an unsigned char array with struct object_id and express several
hard-coded constants in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index d13a10a9..fd7ffe18 100644
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
2.6.2.409.gb049f0a
