From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 09/10] patch-id: convert to use struct object_id
Date: Fri, 13 Mar 2015 23:39:35 +0000
Message-ID: <1426289976-568060-10-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBx-00007q-5l
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbbCMXk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50132 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754948AbbCMXkO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:14 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6CEEC28094;
	Fri, 13 Mar 2015 23:40:13 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265428>

Convert some magic numbers to the new GIT_SHA1 constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/patch-id.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 77db873..ba34dac 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,14 +1,14 @@
 #include "builtin.h"
 
-static void flush_current_id(int patchlen, unsigned char *id, unsigned char *result)
+static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
 {
 	char name[50];
 
 	if (!patchlen)
 		return;
 
-	memcpy(name, sha1_to_hex(id), 41);
-	printf("%s %s\n", sha1_to_hex(result), name);
+	memcpy(name, oid_to_hex(id), GIT_SHA1_HEXSZ + 1);
+	printf("%s %s\n", oid_to_hex(result), name);
 }
 
 static int remove_space(char *line)
@@ -53,23 +53,23 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static void flush_one_hunk(unsigned char *result, git_SHA_CTX *ctx)
+static void flush_one_hunk(struct object_id *result, git_SHA_CTX *ctx)
 {
-	unsigned char hash[20];
+	unsigned char hash[GIT_SHA1_RAWSZ];
 	unsigned short carry = 0;
 	int i;
 
 	git_SHA1_Final(hash, ctx);
 	git_SHA1_Init(ctx);
 	/* 20-byte sum, with carry */
-	for (i = 0; i < 20; ++i) {
-		carry += result[i] + hash[i];
-		result[i] = carry;
+	for (i = 0; i < GIT_SHA1_RAWSZ; ++i) {
+		carry += result->hash[i] + hash[i];
+		result->hash[i] = carry;
 		carry >>= 8;
 	}
 }
 
-static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
+static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 			   struct strbuf *line_buf, int stable)
 {
 	int patchlen = 0, found_next = 0;
@@ -77,7 +77,7 @@ static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
 	git_SHA_CTX ctx;
 
 	git_SHA1_Init(&ctx);
-	hashclr(result);
+	oidclr(result);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
@@ -93,7 +93,7 @@ static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
 		else if (!memcmp(line, "\\ ", 2) && 12 < strlen(line))
 			continue;
 
-		if (!get_sha1_hex(p, next_sha1)) {
+		if (!get_oid_hex(p, next_oid)) {
 			found_next = 1;
 			break;
 		}
@@ -143,7 +143,7 @@ static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
 	}
 
 	if (!found_next)
-		hashclr(next_sha1);
+		oidclr(next_oid);
 
 	flush_one_hunk(result, &ctx);
 
@@ -152,15 +152,15 @@ static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
 
 static void generate_id_list(int stable)
 {
-	unsigned char sha1[20], n[20], result[20];
+	struct object_id oid, n, result;
 	int patchlen;
 	struct strbuf line_buf = STRBUF_INIT;
 
-	hashclr(sha1);
+	oidclr(&oid);
 	while (!feof(stdin)) {
-		patchlen = get_one_patchid(n, result, &line_buf, stable);
-		flush_current_id(patchlen, sha1, result);
-		hashcpy(sha1, n);
+		patchlen = get_one_patchid(&n, &result, &line_buf, stable);
+		flush_current_id(patchlen, &oid, &result);
+		oidcpy(&oid, &n);
 	}
 	strbuf_release(&line_buf);
 }
-- 
2.2.1.209.g41e5f3a
