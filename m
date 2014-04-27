From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 1/5] patch-id: make it stable against hunk reordering
Date: Sun, 27 Apr 2014 21:15:44 +0300
Message-ID: <1398622524-26207-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTcQ-0000HU-AL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbaD0SPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:15:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbaD0SPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:15:07 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIEuwt025286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:14:57 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIEsc6017540;
	Sun, 27 Apr 2014 14:14:54 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247212>

Patch id changes if users reorder file diffs that make up a patch.

As the result is functionally equivalent, a different patch id is
surprising to many users.
In particular, reordering files using diff -O is helpful to make patches
more readable (e.g. API header diff before implementation diff).

Add an option to change patch-id behaviour making it stable against
these kinds of patch change:
calculate SHA1 hash for each hunk separately and sum all hashes
(using a symmetrical sum) to get patch id

We use a 20byte sum and not xor - since xor would give 0 output
for patches that have two identical diffs, which isn't all that
unlikely (e.g. append the same line in two places).

The new behaviour is enabled
- when patchid.stable is true
- when --stable flag is present

Using a new flag --unstable or setting patchid.stable to false force
the historical behaviour.

In the documentation, clarify that patch ID can now be a sum of hashes,
not a hash.
Document how command line and config options affect the
behaviour.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/patch-id.c             | 74 +++++++++++++++++++++++++++++++++---------
 Documentation/git-patch-id.txt | 37 ++++++++++++++++++---
 2 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..77db873 100644
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
+{
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
 {
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
+	git_SHA_CTX ctx;
+
+	git_SHA1_Init(&ctx);
+	hashclr(result);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
@@ -107,6 +125,8 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 				break;
 
 			/* Else we're parsing another header.  */
+			if (stable)
+				flush_one_hunk(result, &ctx);
 			before = after = -1;
 		}
 
@@ -119,39 +139,63 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
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
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 312c3b1..fa562d3 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,14 +8,14 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' < <patch>
+'git patch-id' [--stable | --unstable] < <patch>
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
-whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
-the same time also reasonably unique, i.e., two patches that have the same "patch
-ID" are almost guaranteed to be the same thing.
+A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
+patch, with whitespace and line numbers ignored.  As such, it's "reasonably
+stable", but at the same time also reasonably unique, i.e., two patches that
+have the same "patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
@@ -27,6 +27,33 @@ This can be used to make a mapping from patch ID to commit ID.
 
 OPTIONS
 -------
+
+--stable::
+	Use a "stable" sum of hashes as the patch ID. With this option:
+	 - Reordering file diffs that make up a patch does not affect the ID.
+	   In particular, two patches produced by comparing the same two trees
+	   with two different settings for "-O<orderfile>" result in the same
+	   patch ID signature, thereby allowing the computed result to be used
+	   as a key to index some meta-information about the change between
+	   the two trees;
+	 
+	 - Result is different from the value produced by git 1.9 and older
+	   or produced when an "unstable" hash (see --unstable below) is
+	   configured - even when used on a diff output taken without any use
+	   of "-O<orderfile>", thereby making existing databases storing such
+	   "unstable" or historical patch-ids unusable.
+
+	This is the default if patchid.stable is set to true.
+
+--unstable::
+	Use an "unstable" hash as the patch ID. With this option,
+	the result produced is compatible with the patch-id value produced
+	by git 1.9 and older.  Users with pre-existing databases storing
+	patch-ids produced by git 1.9 and older (who do not deal with reordered
+	patches) may want to use this option.
+
+	This is the default.
+
 <patch>::
 	The diff to create the ID of.
 
-- 
MST
