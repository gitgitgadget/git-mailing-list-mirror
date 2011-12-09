From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 3/5] sha1_file_name_buf(): sha1_file_name in caller's buffer
Date: Fri, 9 Dec 2011 09:39:35 +0100
Message-ID: <bdaa6fad1f9ca46e9e1059bc1d6167732a1e9896.1323419666.git.trast@student.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:39:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzi-0005RO-5D
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab1LIIjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1LIIjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:45 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:39 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323419666.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186617>

sha1_file_name is non-reentrant because of its use of a static buffer.
Split it into just the buffer writing (which can be called even from
threads as long as the buffer is stack'd) and a small wrapper that
uses the static buffer as before.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 sha1_file.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c3595b3..18648c3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -153,18 +153,11 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 }
 
 /*
- * NOTE! This returns a statically allocated buffer, so you have to be
- * careful about using it. Do an "xstrdup()" if you need to save the
- * filename.
- *
- * Also note that this returns the location for creating.  Reading
- * SHA1 file can happen from any alternate directory listed in the
- * DB_ENVIRONMENT environment variable if it is not found in
- * the primary object database.
+ * Similar to sha1_file_name but you provide a buffer of size at least
+ * PATH_MAX.
  */
-char *sha1_file_name(const unsigned char *sha1)
+void sha1_file_name_buf(char *buf, const unsigned char *sha1)
 {
-	static char buf[PATH_MAX];
 	const char *objdir;
 	int len;
 
@@ -179,6 +172,22 @@ char *sha1_file_name(const unsigned char *sha1)
 	buf[len+3] = '/';
 	buf[len+42] = '\0';
 	fill_sha1_path(buf + len + 1, sha1);
+}
+
+/*
+ * NOTE! This returns a statically allocated buffer, so you have to be
+ * careful about using it. Do an "xstrdup()" if you need to save the
+ * filename.
+ *
+ * Also note that this returns the location for creating.  Reading
+ * SHA1 file can happen from any alternate directory listed in the
+ * DB_ENVIRONMENT environment variable if it is not found in
+ * the primary object database.
+ */
+char *sha1_file_name(const unsigned char *sha1)
+{
+	static char buf[PATH_MAX];
+	sha1_file_name_buf(buf, sha1);
 	return buf;
 }
 
-- 
1.7.8.431.g2abf2
