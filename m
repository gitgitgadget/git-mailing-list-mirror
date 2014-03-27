From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 11:25:06 +0200
Message-ID: <1395912239-29663-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 10:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT6a9-0002xx-60
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 10:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbaC0J0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 05:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbaC0J0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 05:26:36 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2R9On23025818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Mar 2014 05:24:49 -0400
Received: from redhat.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2R9OkMq016990;
	Thu, 27 Mar 2014 05:24:47 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245268>

Patch id changes if you reorder hunks in a diff.
As the result is functionally equivalent, this is surprising to many
people.
In particular, reordering hunks is helpful to make patches
more readable (e.g. API header diff before implementation diff).

Change patch-id behaviour making it stable against
hunk reodering:
	- prepend header to each hunk (if not there)
	- calculate SHA1 hash for each hunk separately
	- sum all hashes to get patch id

Add a new flag --unstable to get the historical behaviour.

Add --stable which is a nop, for symmetry.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/patch-id.c | 71 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..253ad87 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,17 +1,14 @@
 #include "builtin.h"
 
-static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
+static void flush_current_id(int patchlen, unsigned char *id, unsigned char *result)
 {
-	unsigned char result[20];
 	char name[50];
 
 	if (!patchlen)
 		return;
 
-	git_SHA1_Final(result, c);
 	memcpy(name, sha1_to_hex(id), 41);
 	printf("%s %s\n", sha1_to_hex(result), name);
-	git_SHA1_Init(c);
 }
 
 static int remove_space(char *line)
@@ -56,10 +53,30 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct strbuf *line_buf)
+static void flush_one_hunk(unsigned char *result, git_SHA_CTX *ctx)
 {
-	int patchlen = 0, found_next = 0;
+	unsigned char hash[20];
+	unsigned short carry = 0;
+	int i;
+
+	git_SHA1_Final(hash, ctx);
+	git_SHA1_Init(ctx);
+	/* 20-byte sum, with carry */
+	for (i = 0; i < 20; ++i) {
+		carry += result[i] + hash[i];
+		result[i] = carry;
+		carry >>= 8;
+	}
+}
+static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
+			   struct strbuf *line_buf, int stable)
+{
+	int patchlen = 0, found_next = 0, hunks = 0;
 	int before = -1, after = -1;
+	git_SHA_CTX ctx, header_ctx;
+
+	git_SHA1_Init(&ctx);
+	hashclr(result);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
@@ -99,6 +116,18 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 			if (!memcmp(line, "@@ -", 4)) {
 				/* Parse next hunk, but ignore line numbers.  */
 				scan_hunk_header(line, &before, &after);
+				if (stable) {
+					if (hunks) {
+						flush_one_hunk(result, &ctx);
+						memcpy(&ctx, &header_ctx,
+						       sizeof ctx);
+					} else {
+						/* Save ctx for next hunk.  */
+						memcpy(&header_ctx, &ctx,
+						       sizeof ctx);
+					}
+				}
+				hunks++;
 				continue;
 			}
 
@@ -107,7 +136,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 				break;
 
 			/* Else we're parsing another header.  */
+			if (stable && hunks)
+				flush_one_hunk(result, &ctx);
 			before = after = -1;
+			hunks = 0;
 		}
 
 		/* If we get here, we're inside a hunk.  */
@@ -119,39 +151,46 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
 		patchlen += len;
-		git_SHA1_Update(ctx, line, len);
+		git_SHA1_Update(&ctx, line, len);
 	}
 
 	if (!found_next)
 		hashclr(next_sha1);
 
+	flush_one_hunk(result, &ctx);
+
 	return patchlen;
 }
 
-static void generate_id_list(void)
+static void generate_id_list(int stable)
 {
-	unsigned char sha1[20], n[20];
-	git_SHA_CTX ctx;
+	unsigned char sha1[20], n[20], result[20];
 	int patchlen;
 	struct strbuf line_buf = STRBUF_INIT;
 
-	git_SHA1_Init(&ctx);
 	hashclr(sha1);
 	while (!feof(stdin)) {
-		patchlen = get_one_patchid(n, &ctx, &line_buf);
-		flush_current_id(patchlen, sha1, &ctx);
+		patchlen = get_one_patchid(n, result, &line_buf, stable);
+		flush_current_id(patchlen, sha1, result);
 		hashcpy(sha1, n);
 	}
 	strbuf_release(&line_buf);
 }
 
-static const char patch_id_usage[] = "git patch-id < patch";
+static const char patch_id_usage[] = "git patch-id [--stable | --unstable] < patch";
 
 int cmd_patch_id(int argc, const char **argv, const char *prefix)
 {
-	if (argc != 1)
+	int stable;
+	if (argc == 2 && !strcmp(argv[1], "--stable"))
+		stable = 1;
+	else if (argc == 2 && !strcmp(argv[1], "--unstable"))
+		stable = 0;
+	else if (argc == 1)
+		stable = 1;
+	else
 		usage(patch_id_usage);
 
-	generate_id_list();
+	generate_id_list(stable);
 	return 0;
 }
-- 
MST
