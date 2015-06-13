From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 05/10] parse_fetch: convert to use struct object_id
Date: Sat, 13 Jun 2015 22:16:38 +0000
Message-ID: <1434233803-422442-6-git-send-email-sandals@crustytoothpaste.net>
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
	id 1Z3tjx-0002tS-Dm
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbFMWRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:17:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42866 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213AbbFMWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9C05528096;
	Sat, 13 Jun 2015 22:16:51 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271593>

Convert the parse_fetch function to use struct object_id.  Remove the
strlen check as get_oid_hex will fail safely on receiving a too-short
NUL-terminated string.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 80cb4c7..1709346 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -802,19 +802,19 @@ static void parse_fetch(struct strbuf *buf)
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
 			const char *name;
 			struct ref *ref;
-			unsigned char old_sha1[20];
+			struct object_id old_oid;
 
-			if (strlen(p) < 40 || get_sha1_hex(p, old_sha1))
+			if (get_oid_hex(p, &old_oid))
 				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[40] == ' ')
-				name = p + 41;
-			else if (!p[40])
+			if (p[GIT_SHA1_HEXSZ] == ' ')
+				name = p + GIT_SHA1_HEXSZ + 1;
+			else if (!p[GIT_SHA1_HEXSZ])
 				name = "";
 			else
 				die("protocol error: expected sha/ref, got %s'", p);
 
 			ref = alloc_ref(name);
-			hashcpy(ref->old_oid.hash, old_sha1);
+			oidcpy(&ref->old_oid, &old_oid);
 
 			*list = ref;
 			list = &ref->next;
-- 
2.4.0
