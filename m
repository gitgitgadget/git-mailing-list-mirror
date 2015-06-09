From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/8] add_sought_entry_mem: convert to struct object_id
Date: Tue,  9 Jun 2015 16:28:33 +0000
Message-ID: <1433867316-663554-6-git-send-email-sandals@crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MP8-0001Qc-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbbFIQ31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38343 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753187AbbFIQ3S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:18 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4CD5A28092;
	Tue,  9 Jun 2015 16:29:17 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271198>

Convert this function to use struct object_id.  Use parse_oid_hex to
avoid having to hard-code the number of bytes to be parsed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 19215b3..f3b89a9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,12 +14,14 @@ static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
 				 const char *name, int namelen)
 {
 	struct ref *ref = xcalloc(1, sizeof(*ref) + namelen + 1);
-	unsigned char sha1[20];
+	struct object_id oid;
+	int hexlen;
 
-	if (namelen > 41 && name[40] == ' ' && !get_sha1_hex(name, sha1)) {
-		hashcpy(ref->old_oid.hash, sha1);
-		name += 41;
-		namelen -= 41;
+	if ((hexlen = parse_oid_hex(name, namelen, &oid)) && namelen > hexlen + 1 &&
+		name[hexlen] == ' ') {
+		oidcpy(&ref->old_oid, &oid);
+		name += hexlen + 1;
+		namelen -= hexlen + 1;
 	}
 
 	memcpy(ref->name, name, namelen);
-- 
2.4.0
