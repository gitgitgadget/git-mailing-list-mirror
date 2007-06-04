From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/6] Refactor git tag objects; make "tag" header optional;
 introduce new optional "keywords" header
Date: Mon, 04 Jun 2007 02:52:54 +0200
Message-ID: <200706040252.55152.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0ok-0001uq-Oh
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXFDAxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbXFDAxB
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:53:01 -0400
Received: from smtp.getmail.no ([84.208.20.33]:32816 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXFDAxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:53:00 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300J016GB1000@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:52:59 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EA66G7JV20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:52:55 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JNP6G7Q010@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:52:55 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49054>


In order to support ref-less tag objects (aka. 'notes'), we want to do
some changes to the tag object structure. The new structure implemented
in this patch is backward-compatible in the way that all existing tag
objects (valid in the old implementation) will remain valid in the new
implementation. The following changes are done:

1. Make the "tag" header optional. The "tag" header contains the tag name,
   which is optional for 'notes'. The new semantics for the "tag" header
   are as follows: The tag header _must_ be given for signed tags (this
   is already enforced by git-tag.sh). When the tag header is not given,
   its value defaults to the empty string.

2. Introduce a new optional "keywords" header. The "keywords" header is a
   comma-separated list of free-form values. However, two certain value
   have special meaning: "tag" and "note": When the "keywords" header is
   missing, its default value is set to "tag" if a "tag" header is
   present; else the default "keywords" value is set to "note". The
   "keywords" header is meant to be used by porcelains for classifying
   different types of tag objects. This classification may then be used to
   filter tag objects in the presentation layer (e.g. by implementing
   extra filter options to --decorate, etc.)

3. Make the "tagger" header mandatory. This header has already for a long
   time been "de facto" mandatory, in that it is automatically generated
   by git-tag.sh. This patch verifies the existence of the header when
   creating tag objects. However, since there exists old tags without
   the "tagger" header, the verification should not be done when parsing
   tag objects.

4. Consolidate the parsing and verification of tag objects. Currently
   parsing is done in tag.c:parse_tag_buffer(), and verification is done
   with a very similar piece of code in mktag.c:verify_tag(). This patch
   unifies the parsing and verification of tag objects in a new function
   parse_and_verify_tag_buffer() which is then called from the other
   places.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |  148 ++++++++---------------------------
 tag.c   |  266 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 tag.h   |    4 +-
 3 files changed, 251 insertions(+), 167 deletions(-)

diff --git a/mktag.c b/mktag.c
index 9310111..cde6036 100644
--- a/mktag.c
+++ b/mktag.c
@@ -2,128 +2,42 @@
 #include "tag.h"
 
 /*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * Tag object data has the following format: two mandatory lines of
+ * "object <sha1>" + "type <typename>", plus two optional lines of
+ * "tag <tagname>" + "keywords <keywords>", plus a mandatory line of
  * "tagger <committer>", followed by a blank line, a free-form tag
- * message and a signature block that git itself doesn't care about,
- * but that can be verified with gpg or similar.
+ * message and an optional signature block that git itself doesn't
+ * care about, but that can be verified with gpg or similar.
  *
- * The first three lines are guaranteed to be at least 63 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, and "tag .\n" at 6 bytes is the
- * shortest single-character-tag line. 
+ * <sha1> represents the object pointed to by this tag, <typename> is
+ * the type of the object pointed to ("tag", "blob", "tree" or "commit"),
+ * <tagname> is the name of this tag object (and must correspond to the
+ * name of the corresponding ref (if any) in '.git/refs/'). <keywords> is
+ * a comma-separated list of keywords associated with this tag object, and
+ * <committer> holds the "name <email>" of the tag creator and timestamp
+ * of when the tag object was created (analogous to "committer" in commit
+ * objects).
  *
- * We also artificially limit the size of the full object to 8kB.
- * Just because I'm a lazy bastard, and if you can't fit a signature
- * in that size, you're doing something wrong.
- */
-
-/* Some random size */
-#define MAXSIZE (8192)
-
-/*
- * We refuse to tag something we can't verify. Just because.
+ * The first two lines are guaranteed to be at least 57 bytes:
+ * "object <sha1>\n" is 48 bytes, and "type tag\n" at 9 bytes is
+ * the shortest possible "type" line. The tagger line is at least
+ * "tagger \n" (8 bytes), and a blank line is also needed (1 byte).
+ * Therefore a tag object _must_ have >= 66 bytes.
+ *
+ * If "tag <tagname>" is omitted, <tagname> defaults to the empty string.
+ * If "keywords <keywords>" is omitted, <keywords> defaults to "tag" if
+ * a <tagname> was given, "note" otherwise.
  */
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
-static int verify_tag(char *buffer, unsigned long size)
-{
-	int typelen;
-	char type[20];
-	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line;
-
-	if (size < 64)
-		return error("wanna fool me ? you obviously got the size wrong !");
-
-	buffer[size] = 0;
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
-	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
-
-	/* TODO: check for committer info + blank line? */
-	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
-
-	/* The actual stuff afterwards we don't care about.. */
-	return 0;
-}
-
-#undef PD_FMT
 
 int main(int argc, char **argv)
 {
 	unsigned long size = 4096;
 	char *buffer = xmalloc(size);
+	struct tag result_tag;
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git-mktag < signaturefile");
+		usage("git-mktag < tag_data_file");
 
 	setup_git_directory();
 
@@ -132,16 +46,18 @@ int main(int argc, char **argv)
 		die("could not read from stdin");
 	}
 
-	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buffer, size) < 0)
-		die("invalid tag signature file");
+	/* Verify tag object data */
+	if (parse_and_verify_tag_buffer(&result_tag, buffer, size, 1)) {
+		free(buffer);
+		die("invalid tag data file");
+	}
 
-	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
+	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0) {
+		free(buffer);
 		die("unable to write tag file");
+	}
 
 	free(buffer);
-
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
 }
diff --git a/tag.c b/tag.c
index bbacd59..9c95e0b 100644
--- a/tag.c
+++ b/tag.c
@@ -33,65 +33,231 @@ struct tag *lookup_tag(const unsigned char *sha1)
         return (struct tag *) obj;
 }
 
-int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
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
+/*
+ * Perform parsing and verification of tag object data.
+ *
+ * The 'item' parameter may be set to NULL if only verification is desired.
+ */
+int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsigned long size, int thorough_verify)
 {
-	int typelen, taglen;
+#ifdef NO_C99_FORMAT
+#define PD_FMT "%d"
+#else
+#define PD_FMT "%td"
+#endif
+
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line;
 	char type[20];
+	const char   *type_line, *tag_line, *keywords_line, *tagger_line;
+	unsigned long type_len,   tag_len,   keywords_len,   tagger_len;
+	const char *header_end, *end = data + size;
 
-        if (item->object.parsed)
-                return 0;
-        item->object.parsed = 1;
-
-	if (size < 64)
-		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
-		return -1;
-
-	type_line = (char *) data + 48;
-	if (memcmp("\ntype ", type_line-1, 6))
-		return -1;
-
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		return -1;
-
-	sig_line = strchr(tag_line, '\n');
-	if (!sig_line)
-		return -1;
-	sig_line++;
-
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= 20)
-		return -1;
-	memcpy(type, type_line + 5, typelen);
-	type[typelen] = '\0';
-	taglen = sig_line - tag_line - strlen("tag \n");
-	item->tag = xmalloc(taglen + 1);
-	memcpy(item->tag, tag_line + 4, taglen);
-	item->tag[taglen] = '\0';
-
-	if (!strcmp(type, blob_type)) {
-		item->tagged = &lookup_blob(sha1)->object;
-	} else if (!strcmp(type, tree_type)) {
-		item->tagged = &lookup_tree(sha1)->object;
-	} else if (!strcmp(type, commit_type)) {
-		item->tagged = &lookup_commit(sha1)->object;
-	} else if (!strcmp(type, tag_type)) {
-		item->tagged = &lookup_tag(sha1)->object;
-	} else {
-		error("Unknown type %s", type);
-		item->tagged = NULL;
+	if (item) {
+		if (item->object.parsed)
+			return 0;
+		item->object.parsed = 1;
 	}
 
-	if (item->tagged && track_object_refs) {
-		struct object_refs *refs = alloc_object_refs(1);
-		refs->ref[0] = item->tagged;
-		set_object_refs(&item->object, refs);
+	if (size < 66)
+		return error("failed preliminary size check");
+
+	/* Verify mandatory object line */
+	if (memcmp(data, "object ", 7))
+		return error("char%d: does not start with \"object \"", 0);
+
+	if (get_sha1_hex(data + 7, sha1))
+		return error("char%d: could not get SHA1 hash", 7);
+
+	/* Verify mandatory type line */
+	type_line = data + 48;
+	if (memcmp(type_line - 1, "\ntype ", 6))
+		return error("char%d: could not find \"\\ntype \"", 47);
+
+	/* Verify optional tag line */
+	tag_line = memchr(type_line, '\n', end - type_line);
+	if (!tag_line++)
+		return error("char" PD_FMT ": could not find \"\\n\" after \"type\"", type_line - data);
+	if (end - tag_line < 4)
+		return error("char" PD_FMT ": premature end of data", tag_line - data);
+	if (memcmp("tag ", tag_line, 4))
+		keywords_line = tag_line; /* no tag name given */
+	else {                            /* tag name given */
+		keywords_line = memchr(tag_line, '\n', end - tag_line);
+		if (!keywords_line++)
+			return error("char" PD_FMT ": could not find \"\\n\" after \"tag\"", tag_line - data);
+	}
+
+	/* Verify optional keywords line */
+	if (end - keywords_line < 9)
+		return error("char" PD_FMT ": premature end of data", keywords_line - data);
+	if (memcmp("keywords ", keywords_line, 9))
+		tagger_line = keywords_line; /* no keywords given */
+	else {                               /* keywords given */
+		tagger_line = memchr(keywords_line, '\n', end - keywords_line);
+		if (!tagger_line++)
+			return error("char" PD_FMT ": could not find \"\\n\" after \"keywords\"", keywords_line - data);
+	}
+
+	if (thorough_verify) {
+		/*
+		 * Verify mandatory tagger line, but only when we're checking
+		 * thoroughly, i.e. on inserting a new tag, and on fsck.
+		 * There are existing tag objects without a tagger line (most
+		 * notably the "v0.99" tag in the main git repo), and we don't
+		 * want to fail parsing on these.
+		 */
+		if (end - tagger_line < 7)
+			return error("char" PD_FMT ": premature end of data", tagger_line - data);
+		if (memcmp("tagger ", tagger_line, 7))
+			return error("char" PD_FMT ": could not find \"tagger \"", tagger_line - data);
+		header_end = memchr(tagger_line, '\n', end - tagger_line);
+		if (!header_end++)
+			return error("char" PD_FMT ": could not find \"\\n\" after \"tagger\"", tagger_line - data);
+		if (end - header_end < 1)
+			return error("char" PD_FMT ": premature end of data", header_end - data);
+		if (*header_end != '\n') /* header must end with "\n\n" */
+			return error("char" PD_FMT ": could not find blank line after header section", header_end - data);
+	}
+	else {
+		/* Treat tagger line as optional */
+		if (end - tagger_line >= 7 && !memcmp("tagger ", tagger_line, 7)) {
+			/* Found tagger line */
+			header_end = memchr(tagger_line, '\n', end - tagger_line);
+			if (!header_end++)
+				return error("char" PD_FMT ": could not find \"\\n\" after \"tagger\"", tagger_line - data);
+		}
+		else /* No tagger line */
+			header_end = tagger_line;
 	}
 
+	if (end - header_end < 1)
+		return error("char" PD_FMT ": premature end of data", header_end - data);
+	if (*header_end != '\n') /* header must end with "\n\n" */
+		return error("char" PD_FMT ": could not find blank line after header section", header_end - data);
+
+	/* Calculate lengths of header fields */
+	type_len      = tag_line      == type_line ? 0 :     /* 0 if not given, > 0 if given */
+			(tag_line      - type_line)     - strlen("type \n");
+	tag_len       = keywords_line == tag_line ? 0 :      /* 0 if not given, > 0 if given */
+			(keywords_line - tag_line)      - strlen("tag \n");
+	keywords_len  = tagger_line   == keywords_line ? 0 : /* 0 if not given, > 0 if given */
+			(tagger_line   - keywords_line) - strlen("keywords \n");
+	tagger_len    = header_end    == tagger_line ? 0 :   /* 0 if not given, > 0 if given */
+			(header_end    - tagger_line)   - strlen("tagger \n");
+
+	/* Get the actual type */
+	if (type_len >= sizeof(type))
+		return error("char" PD_FMT ": type too long", (type_line + 5) - data);
+	memcpy(type, type_line + 5, type_len);
+	type[type_len] = '\0';
+
+	if (thorough_verify) {
+		/* Verify that the object matches */
+		if (verify_object(sha1, type))
+			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+
+		/* Verify the tag name: we don't allow control characters or spaces in it */
+		if (tag_len > 0) { /* tag name was given */
+			tag_line += 4; /* skip past "tag " */
+			for (;;) {
+				unsigned char c = *tag_line++;
+				if (c == '\n')
+					break;
+				if (c > ' ' && c != 0x7f)
+					continue;
+				return error("char" PD_FMT ": could not verify tag name", tag_line - data);
+			}
+		}
+
+		/* Verify the keywords line: we don't allow control characters or spaces in it, or two subsequent commas */
+		if (keywords_len > 0) { /* keywords line was given */
+			keywords_line += 9; /* skip past "keywords " */
+			for (;;) {
+				unsigned char c = *keywords_line++;
+				if (c == '\n')
+					break;
+				if (c == ',' && *keywords_line == ',')
+					return error("char" PD_FMT ": found empty keyword", keywords_line - data);
+				if (c > ' ' && c != 0x7f)
+					continue;
+				return error("char" PD_FMT ": could not verify keywords", keywords_line - data);
+			}
+		}
+
+		/* Verify the tagger line */
+		/* TODO: check for committer/tagger info */
+
+		/* The actual stuff afterwards we don't care about.. */
+	}
+
+	if (item) { /* Store parsed information into item */
+		if (tag_len > 0) { /* optional tag name was given */
+			item->tag = xmalloc(tag_len + 1);
+			memcpy(item->tag, tag_line + 4, tag_len);
+			item->tag[tag_len] = '\0';
+		}
+		else { /* optional tag name not given */
+			item->tag = xmalloc(1);
+			item->tag[0] = '\0';
+		}
+
+		if (keywords_len > 0) { /* optional keywords string was given */
+			item->keywords = xmalloc(keywords_len + 1);
+			memcpy(item->keywords, keywords_line + 9, keywords_len);
+			item->keywords[keywords_len] = '\0';
+		}
+		else { /* optional keywords string not given. Set default keywords */
+			/* if tag name is set, use "tag"; otherwise use "note" */
+			const char *default_kw = item->tag ? "tag" : "note";
+			item->keywords = xmalloc(strlen(default_kw) + 1);
+			memcpy(item->keywords, default_kw, strlen(default_kw) + 1);
+		}
+
+		if (!strcmp(type, blob_type)) {
+			item->tagged = &lookup_blob(sha1)->object;
+		} else if (!strcmp(type, tree_type)) {
+			item->tagged = &lookup_tree(sha1)->object;
+		} else if (!strcmp(type, commit_type)) {
+			item->tagged = &lookup_commit(sha1)->object;
+		} else if (!strcmp(type, tag_type)) {
+			item->tagged = &lookup_tag(sha1)->object;
+		} else {
+			error("Unknown type %s", type);
+			item->tagged = NULL;
+		}
+
+		if (item->tagged && track_object_refs) {
+			struct object_refs *refs = alloc_object_refs(1);
+			refs->ref[0] = item->tagged;
+			set_object_refs(&item->object, refs);
+		}
+	}
 	return 0;
+
+#undef PD_FMT
+}
+
+int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
+{
+	return parse_and_verify_tag_buffer(item, (const char *) data, size, 0);
 }
 
 int parse_tag(struct tag *item)
diff --git a/tag.h b/tag.h
index 7a0cb00..6853594 100644
--- a/tag.h
+++ b/tag.h
@@ -8,11 +8,13 @@ extern const char *tag_type;
 struct tag {
 	struct object object;
 	struct object *tagged;
-	char *tag;
+	char *tag;       /* optional, may be empty ("") */
+	char *keywords;  /* optional, defaults to tag ? "tag" : "note" */
 	char *signature; /* not actually implemented */
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
+extern int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsigned long size, int thorough_verify);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
1.5.2
