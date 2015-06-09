From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/8] Add a utility function to make parsing hex values easier.
Date: Tue,  9 Jun 2015 16:28:32 +0000
Message-ID: <1433867316-663554-5-git-send-email-sandals@crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MP8-0001Qc-4j
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbbFIQ3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:25 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38341 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649AbbFIQ3R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:17 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 860E828093;
	Tue,  9 Jun 2015 16:29:16 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271194>

get_oid_hex is already available for parsing hex object IDs into struct
object_id, but parsing code still must hard-code the number of bytes
read.  Introduce parse_oid_hex, which accepts an optional length, and
also returns the number of bytes parsed on success, or 0 on failure.
This makes it easier for code not to assume fixed values when parsing,
and to move to larger hash functions in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 9 +++++++++
 hex.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index fa1f067..f3b829f 100644
--- a/cache.h
+++ b/cache.h
@@ -1012,6 +1012,15 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
+/*
+ * Like get_oid_hex, but accepts an optional length argument, which may be -1
+ * if the string is terminated by a non-hex character.  As with get_oid_hex,
+ * reading stops if a NUL is encountered.  Returns the number of characters
+ * read (40) on success and 0 on failure.  This is designed to be easier to
+ * use for parsing data than get_oid_hex.
+ */
+extern int parse_oid_hex(const char *hex, int len, struct object_id *oid);
+
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 extern int read_ref_full(const char *refname, int resolve_flags,
diff --git a/hex.c b/hex.c
index 899b74a..ba196d7 100644
--- a/hex.c
+++ b/hex.c
@@ -61,6 +61,13 @@ int get_oid_hex(const char *hex, struct object_id *oid)
 	return get_sha1_hex(hex, oid->hash);
 }
 
+int parse_oid_hex(const char *hex, int len, struct object_id *oid)
+{
+	if (len != -1 && len < GIT_SHA1_HEXSZ)
+		return 0;
+	return get_sha1_hex(hex, oid->hash) ? GIT_SHA1_HEXSZ : 0;
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-- 
2.4.0
