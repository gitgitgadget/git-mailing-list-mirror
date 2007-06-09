From: Johan Herland <johan@herland.net>
Subject: [PATCH 03/21] Refactoring to make verify_tag() and parse_tag_buffer()
 more similar
Date: Sat, 09 Jun 2007 02:13:40 +0200
Message-ID: <200706090213.40785.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwoaT-0003nG-U5
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970217AbXFIANs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970068AbXFIANs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:13:48 -0400
Received: from smtp.getmail.no ([84.208.20.33]:65101 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969752AbXFIANq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:13:46 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903DYXJG00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:45 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000KADYTCO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:41 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FD7DYSRBF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:41 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49529>

A fair amount of refactoring is included in this patch, none of which
should affect the actual behaviour of the code in any way.

Here are the changes done:

- Refactor out all the (char *) casting in parse_tag_buffer(). Create a
  wrapper function (parse_tag_buffer()) that casts _once_ and then calls
  parse_tag_buffer_internal() which does the real work

- Variable renaming in parse_tag_buffer_internal():
  - sig_line -> tagger_line
  - typelen  -> type_len
  - taglen   -> tag_len

- Variable renaming in verify_tag():
  - buffer  -> data
  - typelen -> type_len

- Remove unnecessary variable 'object' from verify_tag(). It has always
  the same value as 'data', so use 'data' directly instead

- Fix type of length variables (int -> unsigned long)

- Move null-termination of tag buffer out of verify_tag() and into main().

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   41 +++++++++++++++++++----------------------
 tag.c   |   50 +++++++++++++++++++++++++++-----------------------
 2 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/mktag.c b/mktag.c
index b82e377..0bc20c8 100644
--- a/mktag.c
+++ b/mktag.c
@@ -32,52 +32,48 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
 	return ret;
 }
 
+static int verify_tag(char *data, unsigned long size)
+{
 #ifdef NO_C99_FORMAT
 #define PD_FMT "%d"
 #else
 #define PD_FMT "%td"
 #endif
 
-static int verify_tag(char *buffer, unsigned long size)
-{
-	int typelen;
-	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line;
+	char type[20];
+	const char *type_line, *tag_line, *tagger_line;
+	unsigned long type_len;
 
 	if (size < 64)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
-	buffer[size] = 0;
-
 	/* Verify object line */
-	object = buffer;
-	if (memcmp(object, "object ", 7))
+	if (memcmp(data, "object ", 7))
 		return error("char%d: does not start with \"object \"", 0);
 
-	if (get_sha1_hex(object + 7, sha1))
+	if (get_sha1_hex(data + 7, sha1))
 		return error("char%d: could not get SHA1 hash", 7);
 
 	/* Verify type line */
-	type_line = object + 48;
+	type_line = data + 48;
 	if (memcmp(type_line - 1, "\ntype ", 6))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
+		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
+		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
 
 	/* Get the actual type */
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line+5 - buffer);
-
-	memcpy(type, type_line+5, typelen);
-	type[typelen] = 0;
+	type_len = tag_line - type_line - strlen("type \n");
+	if (type_len >= sizeof(type))
+		return error("char" PD_FMT ": type too long", type_line + 5 - data);
+	memcpy(type, type_line + 5, type_len);
+	type[type_len] = '\0';
 
 	/* Verify that the object matches */
 	if (verify_object(sha1, type))
@@ -91,23 +87,23 @@ static int verify_tag(char *buffer, unsigned long size)
 			break;
 		if (c > ' ')
 			continue;
-		return error("char" PD_FMT ": could not verify tag name", tag_line - buffer);
+		return error("char" PD_FMT ": could not verify tag name", tag_line - data);
 	}
 
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
 	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
+		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
 
 	/* TODO: check for committer info + blank line? */
 	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
 
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
-}
 
 #undef PD_FMT
+}
 
 int main(int argc, char **argv)
 {
@@ -124,6 +120,7 @@ int main(int argc, char **argv)
 		free(buffer);
 		die("could not read from stdin");
 	}
+	buffer[size] = 0;
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
diff --git a/tag.c b/tag.c
index 954ed8a..8d31603 100644
--- a/tag.c
+++ b/tag.c
@@ -33,7 +33,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
         return (struct tag *) obj;
 }
 
-int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
+static int parse_tag_buffer_internal(struct tag *item, const char *data, const unsigned long size)
 {
 #ifdef NO_C99_FORMAT
 #define PD_FMT "%d"
@@ -41,14 +41,14 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 #define PD_FMT "%td"
 #endif
 
-	int typelen, taglen;
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line;
 	char type[20];
+	const char *type_line, *tag_line, *tagger_line;
+	unsigned long type_len, tag_len;
 
-        if (item->object.parsed)
-                return 0;
-        item->object.parsed = 1;
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
 
 	if (size < 64)
 		return error("failed preliminary size check");
@@ -57,39 +57,38 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	if (memcmp(data, "object ", 7))
 		return error("char%d: does not start with \"object \"", 0);
 
-	if (get_sha1_hex((char *) data + 7, sha1))
+	if (get_sha1_hex(data + 7, sha1))
 		return error("char%d: could not get SHA1 hash", 7);
 
 	/* Verify type line */
-	type_line = (char *) data + 48;
+	type_line = data + 48;
 	if (memcmp(type_line - 1, "\ntype ", 6))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - (char *) data);
+		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - (char *) data);
+		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
 
-	sig_line = strchr(tag_line, '\n');
-	if (!sig_line)
+	tagger_line = strchr(tag_line, '\n');
+	if (!tagger_line)
 		return -1;
-	sig_line++;
+	tagger_line++;
 
 	/* Get the actual type */
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line+5 - (char *) data);
-
-	memcpy(type, type_line + 5, typelen);
-	type[typelen] = '\0';
+	type_len = tag_line - type_line - strlen("type \n");
+	if (type_len >= sizeof(type))
+		return error("char" PD_FMT ": type too long", type_line + 5 - data);
+	memcpy(type, type_line + 5, type_len);
+	type[type_len] = '\0';
 
-	taglen = sig_line - tag_line - strlen("tag \n");
-	item->tag = xmalloc(taglen + 1);
-	memcpy(item->tag, tag_line + 4, taglen);
-	item->tag[taglen] = '\0';
+	tag_len = tagger_line - tag_line - strlen("tag \n");
+	item->tag = xmalloc(tag_len + 1);
+	memcpy(item->tag, tag_line + 4, tag_len);
+	item->tag[tag_len] = '\0';
 
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
@@ -115,6 +114,11 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 #undef PD_FMT
 }
 
+int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
+{
+	return parse_tag_buffer_internal(item, (const char *) data, size);
+}
+
 int parse_tag(struct tag *item)
 {
 	enum object_type type;
-- 
1.5.2
