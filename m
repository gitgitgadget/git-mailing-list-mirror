From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 6/8] parse_fetch: convert to use struct object_id
Date: Tue,  9 Jun 2015 16:28:34 +0000
Message-ID: <1433867316-663554-7-git-send-email-sandals@crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MPL-0001p9-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbbFIQ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38349 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753153AbbFIQ3T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:19 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F29AF28095;
	Tue,  9 Jun 2015 16:29:17 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271199>

Convert the parse_fetch function to use struct object_id.  Switch from
get_sha1_hex to parse_oid_hex to avoid hard-coding constants.  Remove
the strlen check as parse_oid_hex will fail safely on receiving a
too-short NUL-terminated string.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 80cb4c7..46206a0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -802,19 +802,20 @@ static void parse_fetch(struct strbuf *buf)
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
 			const char *name;
 			struct ref *ref;
-			unsigned char old_sha1[20];
+			struct object_id old_oid;
+			int hexlen;
 
-			if (strlen(p) < 40 || get_sha1_hex(p, old_sha1))
+			if (!(hexlen = parse_oid_hex(p, -1, &old_oid)))
 				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[40] == ' ')
-				name = p + 41;
-			else if (!p[40])
+			if (p[hexlen] == ' ')
+				name = p + hexlen + 1;
+			else if (!p[hexlen])
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
