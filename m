From: drafnel@gmail.com
Subject: [PATCH 4/5] mktag.c: consolidate tag functions by merging mktag.c into builtin-tag.c
Date: Thu,  8 May 2008 21:19:48 -0500
Message-ID: <2582798.1210299536197.JavaMail.teamon@b301.teamon.com>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <1210299589-10448-3-git-send-email-drafnel@example.com>
 <1210299589-10448-4-git-send-email-drafnel@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIRB-00059u-UX
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbYEICdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYEICdY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:24 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755459AbYEICdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:20 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492IuG10573;
	Fri, 9 May 2008 02:18:56 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210299589-10448-4-git-send-email-drafnel@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81592>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile      |    1 -
 builtin-tag.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mktag.c       |  183 ---------------------------------------------------------
 3 files changed, 181 insertions(+), 184 deletions(-)
 delete mode 100644 mktag.c

diff --git a/Makefile b/Makefile
index 1128cef..572459f 100644
--- a/Makefile
+++ b/Makefile
@@ -423,7 +423,6 @@ LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
-LIB_OBJS += mktag.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-revindex.o
diff --git a/builtin-tag.c b/builtin-tag.c
index 129ff57..85ec2f3 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -296,6 +296,161 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 	free(buf);
 }
 
+/*
+ * We refuse to tag something we can't verify. Just because.
+ */
+static int verify_object(unsigned char *sha1, const char *expected_type)
+{
+	int ret = -1;
+	enum object_type type;
+	unsigned long size;
+	void *buffer = read_sha1_file(sha1, &type, &size);
+
+	if (buffer) {
+		if (type == type_from_string(expected_type))
+			ret = check_sha1_signature(sha1, buffer, size, expected_type);
+		free(buffer);
+	}
+	return ret;
+}
+
+#ifdef NO_C99_FORMAT
+#define PD_FMT "%d"
+#else
+#define PD_FMT "%td"
+#endif
+
+/*
+ * A signature file has a very simple fixed format: four lines
+ * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * "tagger <committer>", followed by a blank line, a free-form tag
+ * message and a signature block that git itself doesn't care about,
+ * but that can be verified with gpg or similar.
+ *
+ * The first four lines are guaranteed to be at least 83 bytes:
+ * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
+ * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
+ * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
+ * the shortest possible tagger-line.
+ */
+
+static int verify_tag_buffer(const char *buffer, size_t size)
+{
+	int typelen;
+	char type[20];
+	unsigned char sha1[20];
+	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
+	size_t len;
+
+	if (size < 84)
+		return error("wanna fool me ? you obviously got the size wrong !");
+
+	/* Verify object line */
+	object = buffer;
+	if (memcmp(object, "object ", 7))
+		return error("char%d: does not start with \"object \"", 0);
+
+	if (get_sha1_hex(object + 7, sha1))
+		return error("char%d: could not get SHA1 hash", 7);
+
+	/* Verify type line */
+	type_line = object + 48;
+	if (memcmp(type_line - 1, "\ntype ", 6))
+		return error("char%d: could not find \"\\ntype \"", 47);
+
+	/* Verify tag-line */
+	tag_line = strchr(type_line, '\n');
+	if (!tag_line)
+		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
+	tag_line++;
+	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
+
+	/* Get the actual type */
+	typelen = tag_line - type_line - strlen("type \n");
+	if (typelen >= sizeof(type))
+		return error("char" PD_FMT ": type too long", type_line+5 - buffer);
+
+	memcpy(type, type_line+5, typelen);
+	type[typelen] = 0;
+
+	/* Verify that the object matches */
+	if (verify_object(sha1, type))
+		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+
+	/* Verify the tag-name: we don't allow control characters or spaces in it */
+	tag_line += 4;
+	for (;;) {
+		unsigned char c = *tag_line++;
+		if (c == '\n')
+			break;
+		if (c > ' ')
+			continue;
+		return error("char" PD_FMT ": could not verify tag name", tag_line - buffer);
+	}
+
+	/* Verify the tagger line */
+	tagger_line = tag_line;
+
+	if (memcmp(tagger_line, "tagger ", 7))
+		return error("char" PD_FMT ": could not find \"tagger \"",
+			tagger_line - buffer);
+
+	/*
+	 * Check for correct form for name and email
+	 * i.e. " <" followed by "> " on _this_ line
+	 * No angle brackets within the name or email address fields.
+	 * No spaces within the email address field.
+	 */
+	tagger_line += 7;
+	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
+		strpbrk(tagger_line, "<>\n") != lb+1 ||
+		strpbrk(lb+2, "><\n ") != rb)
+		return error("char" PD_FMT ": malformed tagger field",
+			tagger_line - buffer);
+
+	/* Check for author name, at least one character, space is acceptable */
+	if (lb == tagger_line)
+		return error("char" PD_FMT ": missing tagger name",
+			tagger_line - buffer);
+
+	/* timestamp, 1 or more digits followed by space */
+	tagger_line = rb + 2;
+	if (!(len = strspn(tagger_line, "0123456789")))
+		return error("char" PD_FMT ": missing tag timestamp",
+			tagger_line - buffer);
+	tagger_line += len;
+	if (*tagger_line != ' ')
+		return error("char" PD_FMT ": malformed tag timestamp",
+			tagger_line - buffer);
+	tagger_line++;
+
+	/* timezone, 5 digits [+-]hhmm, max. 1400 */
+	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
+	      strspn(tagger_line+1, "0123456789") == 4 &&
+	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
+		return error("char" PD_FMT ": malformed tag timezone",
+			tagger_line - buffer);
+	tagger_line += 6;
+
+	/* Verify the blank line separating the header from the body */
+	if (*tagger_line != '\n')
+		return error("char" PD_FMT ": trailing garbage in tag header",
+			tagger_line - buffer);
+
+	/*
+	 * Make sure we haven't advanced past what the caller said the
+	 * buffer size was.
+	 */
+	if (tagger_line - buffer >= size)
+		return error("char" PD_FMT ": tag truncated", size);
+
+	/* The actual stuff afterwards we don't care about.. */
+	return 0;
+}
+
+#undef PD_FMT
+
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
 		       unsigned char *prev, unsigned char *result)
@@ -482,3 +637,29 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&buf);
 	return 0;
 }
+
+int cmd_mktag(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf buf;
+	unsigned char result_sha1[20];
+
+	if (argc != 1)
+		usage("git-mktag < signaturefile");
+
+	strbuf_init(&buf, 0);
+	if (strbuf_read(&buf, 0, 4096) < 0) {
+		die("could not read from stdin");
+	}
+
+	/* Verify it for some basic sanity: it needs to start with
+	   "object <sha1>\ntype\ntagger " */
+	if (verify_tag_buffer(buf.buf, buf.len) < 0)
+		die("invalid tag signature file");
+
+	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
+		die("unable to write tag file");
+
+	strbuf_release(&buf);
+	printf("%s\n", sha1_to_hex(result_sha1));
+	return 0;
+}
diff --git a/mktag.c b/mktag.c
deleted file mode 100644
index 6204001..0000000
--- a/mktag.c
+++ /dev/null
@@ -1,183 +0,0 @@
-#include "cache.h"
-#include "tag.h"
-
-/*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
- * "tagger <committer>", followed by a blank line, a free-form tag
- * message and a signature block that git itself doesn't care about,
- * but that can be verified with gpg or similar.
- *
- * The first four lines are guaranteed to be at least 83 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
- * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
- * the shortest possible tagger-line.
- */
-
-/*
- * We refuse to tag something we can't verify. Just because.
- */
-static int verify_object(unsigned char *sha1, const char *expected_type)
-{
-	int ret = -1;
-	enum object_type type;
-	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
-
-	if (buffer) {
-		if (type == type_from_string(expected_type))
-			ret = check_sha1_signature(sha1, buffer, size, expected_type);
-		free(buffer);
-	}
-	return ret;
-}
-
-#ifdef NO_C99_FORMAT
-#define PD_FMT "%d"
-#else
-#define PD_FMT "%td"
-#endif
-
-static int verify_tag_buffer(const char *buffer, size_t size)
-{
-	int typelen;
-	char type[20];
-	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
-	size_t len;
-
-	if (size < 84)
-		return error("wanna fool me ? you obviously got the size wrong !");
-
-	/* Verify object line */
-	object = buffer;
-	if (memcmp(object, "object ", 7))
-		return error("char%d: does not start with \"object \"", 0);
-
-	if (get_sha1_hex(object + 7, sha1))
-		return error("char%d: could not get SHA1 hash", 7);
-
-	/* Verify type line */
-	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"", 47);
-
-	/* Verify tag-line */
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
-	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
-
-	/* Get the actual type */
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line+5 - buffer);
-
-	memcpy(type, type_line+5, typelen);
-	type[typelen] = 0;
-
-	/* Verify that the object matches */
-	if (verify_object(sha1, type))
-		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
-
-	/* Verify the tag-name: we don't allow control characters or spaces in it */
-	tag_line += 4;
-	for (;;) {
-		unsigned char c = *tag_line++;
-		if (c == '\n')
-			break;
-		if (c > ' ')
-			continue;
-		return error("char" PD_FMT ": could not verify tag name", tag_line - buffer);
-	}
-
-	/* Verify the tagger line */
-	tagger_line = tag_line;
-
-	if (memcmp(tagger_line, "tagger ", 7))
-		return error("char" PD_FMT ": could not find \"tagger \"",
-			tagger_line - buffer);
-
-	/*
-	 * Check for correct form for name and email
-	 * i.e. " <" followed by "> " on _this_ line
-	 * No angle brackets within the name or email address fields.
-	 * No spaces within the email address field.
-	 */
-	tagger_line += 7;
-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strpbrk(tagger_line, "<>\n") != lb+1 ||
-		strpbrk(lb+2, "><\n ") != rb)
-		return error("char" PD_FMT ": malformed tagger field",
-			tagger_line - buffer);
-
-	/* Check for author name, at least one character, space is acceptable */
-	if (lb == tagger_line)
-		return error("char" PD_FMT ": missing tagger name",
-			tagger_line - buffer);
-
-	/* timestamp, 1 or more digits followed by space */
-	tagger_line = rb + 2;
-	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char" PD_FMT ": missing tag timestamp",
-			tagger_line - buffer);
-	tagger_line += len;
-	if (*tagger_line != ' ')
-		return error("char" PD_FMT ": malformed tag timestamp",
-			tagger_line - buffer);
-	tagger_line++;
-
-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      strspn(tagger_line+1, "0123456789") == 4 &&
-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char" PD_FMT ": malformed tag timezone",
-			tagger_line - buffer);
-	tagger_line += 6;
-
-	/* Verify the blank line separating the header from the body */
-	if (*tagger_line != '\n')
-		return error("char" PD_FMT ": trailing garbage in tag header",
-			tagger_line - buffer);
-
-	/*
-	 * Make sure we haven't advanced past what the caller said the
-	 * buffer size was.
-	 */
-	if (tagger_line - buffer >= size)
-		return error("char" PD_FMT ": tag truncated", size);
-
-	/* The actual stuff afterwards we don't care about.. */
-	return 0;
-}
-
-#undef PD_FMT
-
-int cmd_mktag(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf buf;
-	unsigned char result_sha1[20];
-
-	if (argc != 1)
-		usage("git-mktag < signaturefile");
-
-	strbuf_init(&buf, 0);
-	if (strbuf_read(&buf, 0, 4096) < 0) {
-		die("could not read from stdin");
-	}
-
-	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag_buffer(buf.buf, buf.len) < 0)
-		die("invalid tag signature file");
-
-	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
-		die("unable to write tag file");
-
-	strbuf_release(&buf);
-	printf("%s\n", sha1_to_hex(result_sha1));
-	return 0;
-}
-- 
1.5.5.67.g9a49
