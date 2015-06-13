From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 04/10] add_sought_entry_mem: convert to struct object_id
Date: Sat, 13 Jun 2015 22:16:37 +0000
Message-ID: <1434233803-422442-5-git-send-email-sandals@crustytoothpaste.net>
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
	id 1Z3tjt-0002tS-8l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbbFMWQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:16:59 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42863 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184AbbFMWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B6E028095;
	Sat, 13 Jun 2015 22:16:51 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271595>

Convert this function to use struct object_id.  Express several
hardcoded constants in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 19215b3..cf3019e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,12 +14,14 @@ static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
 				 const char *name, int namelen)
 {
 	struct ref *ref = xcalloc(1, sizeof(*ref) + namelen + 1);
-	unsigned char sha1[20];
+	struct object_id oid;
+	const int chunksz = GIT_SHA1_HEXSZ + 1;
 
-	if (namelen > 41 && name[40] == ' ' && !get_sha1_hex(name, sha1)) {
-		hashcpy(ref->old_oid.hash, sha1);
-		name += 41;
-		namelen -= 41;
+	if (namelen > chunksz && name[chunksz - 1] == ' ' &&
+		!get_oid_hex(name, &oid)) {
+		oidcpy(&ref->old_oid, &oid);
+		name += chunksz;
+		namelen -= chunksz;
 	}
 
 	memcpy(ref->name, name, namelen);
-- 
2.4.0
