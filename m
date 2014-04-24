From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 4/9] patch-id: make it stable against hunk reordering
Date: Thu, 24 Apr 2014 12:31:00 +0300
Message-ID: <1398331809-11309-4-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 11:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGKq-0006QL-T8
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbaDXJwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 05:52:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757AbaDXJwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 05:52:32 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3O9q8Ld032467;
	Thu, 24 Apr 2014 05:52:08 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3O9UFnd012741;
	Thu, 24 Apr 2014 05:30:15 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246957>

Patch id changes if users
1. reorder file diffs that make up a patch
or
2. split a patch up to multiple diffs that touch the same path
(keeping hunks within a single diff ordered to make patch valid).

As the result is functionally equivalent, a different patch id is
surprising to many users.
In particular, reordering files using diff -O is helpful to make patches
more readable (e.g. API header diff before implementation diff).

Add an option to change patch-id behaviour making it stable against
these two kinds of patch change:
1. calculate SHA1 hash for each hunk separately and sum all hashes
(using a symmetrical sum) to get patch id
2. hash the file-level headers together with each hunk (not just the
first hunk)

We use a 20byte sum and not xor - since xor would give 0 output
for patches that have two identical diffs, which isn't all that
unlikely (e.g. append the same line in two places).

The new behaviour is enabled
- when patchid.stable is true
- when --stable flag is present

Using a new flag --unstable or setting patchid.stable to false force
the historical behaviour.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/patch-id.c | 89 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..037cf2f 100644
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
@@ -56,10 +53,31 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
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
+
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
@@ -98,7 +116,19 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		if (before == 0 && after == 0) {
 			if (!memcmp(line, "@@ -", 4)) {
 				/* Parse next hunk, but ignore line numbers.  */
+				if (stable) {
+					/* Hash the file-level headers together with each hunk. */
+					if (hunks) {
+						flush_one_hunk(result, &ctx);
+						/* Prepend saved header ctx for next hunk.  */
+						memcpy(&ctx, &header_ctx, sizeof(ctx));
+					} else {
+						/* Save header ctx for next hunk.  */
+						memcpy(&header_ctx, &ctx, sizeof(ctx));
+					}
+				}
 				scan_hunk_header(line, &before, &after);
+				hunks++;
 				continue;
 			}
 
@@ -107,7 +137,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 				break;
 
 			/* Else we're parsing another header.  */
+			if (stable && hunks)
+				flush_one_hunk(result, &ctx);
 			before = after = -1;
+			hunks = 0;
 		}
 
 		/* If we get here, we're inside a hunk.  */
@@ -119,39 +152,63 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
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
+
+static int git_patch_id_config(const char *var, const char *value, void *cb)
+{
+	int *stable = cb;
+
+	if (!strcmp(var, "patchid.stable")) {
+		*stable = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
 
 int cmd_patch_id(int argc, const char **argv, const char *prefix)
 {
-	if (argc != 1)
+	int stable = -1;
+
+	git_config(git_patch_id_config, &stable);
+
+	/* If nothing is set, default to unstable. */
+	if (stable < 0)
+		stable = 0;
+
+	if (argc == 2 && !strcmp(argv[1], "--stable"))
+		stable = 1;
+	else if (argc == 2 && !strcmp(argv[1], "--unstable"))
+		stable = 0;
+	else if (argc != 1)
 		usage(patch_id_usage);
 
-	generate_id_list();
+	generate_id_list(stable);
 	return 0;
 }
-- 
MST
