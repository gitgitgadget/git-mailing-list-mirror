From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix bug in tag parsing when thorough verification was in effect
Date: Fri, 08 Jun 2007 00:13:50 +0200
Message-ID: <200706080013.50644.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQFv-0002Im-HX
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936780AbXFGWOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936724AbXFGWOu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:14:50 -0400
Received: from [84.208.20.33] ([84.208.20.33]:51570 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S935230AbXFGWOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:14:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00F0JDSIE500@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 00:14:42 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00L57DR3AVC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 00:13:51 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA0016ZDR26NE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 00:13:51 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49393>

The code that was enabled by passing a non-zero 'thorough_verify' argument
to parse_and_verify_tag_buffer() moved the 'tag_line' and 'keywords_line'
pointer variables forward in memory while checking for illegal chars.
These pointers were later used when setting the respective members on
the parsed tag object.

The fix refactors the verification loop so as to use offsets to the
'tag_line' and 'keywords_line' pointers, instead of moving the pointers
directly.

The patch also includes cleanup of the code associated with moving the
various '*_line' pointers past their initial header field identifier.
These operations are now done along with the calculation of their
corresponding '*_len' variables.

The patch also includes minor changes to expected output in associated
testcases.

The bug was discovered by inspection. Currently none of the callers of
parse_and_verify_tag_buffer() that use thorough_verify != 0, also use
the 'tag' and 'keywords' members of the parsed tag object.

Signed-off-by: Johan Herland <johan@herland.net>
---

This goes on top of the existing "Refactor the tag object" patch series.


Have fun!

...Johan

 t/t3800-mktag.sh |    8 ++++----
 tag.c            |   49 ++++++++++++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index f6e3d10..ac9008a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -186,7 +186,7 @@ tagger bar@baz.com
 EOF
 
 cat >expect.pat <<EOF
-^error: char67: could not verify tag name$
+^error: char66: could not verify tag name$
 EOF
 
 check_verify_failure 'verify tag-name check'
@@ -240,7 +240,7 @@ tagger bar@baz.com
 EOF
 
 cat >expect.pat <<EOF
-^error: char83: .*$
+^error: char82: .*$
 EOF
 
 check_verify_failure '"keywords" line check #1'
@@ -258,7 +258,7 @@ tagger bar@baz.com
 EOF
 
 cat >expect.pat <<EOF
-^error: char87: .*$
+^error: char86: .*$
 EOF
 
 check_verify_failure '"keywords" line check #2'
@@ -276,7 +276,7 @@ tagger bar@baz.com
 EOF
 
 cat >expect.pat <<EOF
-^error: char83: .*$
+^error: char82: .*$
 EOF
 
 check_verify_failure '"keywords" line check #3'
diff --git a/tag.c b/tag.c
index 9c95e0b..e371179 100644
--- a/tag.c
+++ b/tag.c
@@ -153,52 +153,55 @@ int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsign
 	if (*header_end != '\n') /* header must end with "\n\n" */
 		return error("char" PD_FMT ": could not find blank line after header section", header_end - data);
 
-	/* Calculate lengths of header fields */
-	type_len      = tag_line      == type_line ? 0 :     /* 0 if not given, > 0 if given */
-			(tag_line      - type_line)     - strlen("type \n");
-	tag_len       = keywords_line == tag_line ? 0 :      /* 0 if not given, > 0 if given */
-			(keywords_line - tag_line)      - strlen("tag \n");
-	keywords_len  = tagger_line   == keywords_line ? 0 : /* 0 if not given, > 0 if given */
-			(tagger_line   - keywords_line) - strlen("keywords \n");
-	tagger_len    = header_end    == tagger_line ? 0 :   /* 0 if not given, > 0 if given */
-			(header_end    - tagger_line)   - strlen("tagger \n");
+	/*
+	 * Advance header field pointers past their initial identifier.
+	 * Calculate lengths of header fields (0 for fields that are not given).
+	 */
+	type_line     += strlen("type ");
+	type_len       =       tag_line >     type_line ? (     tag_line -     type_line) - 1 : 0;
+	tag_line      += strlen("tag ");
+	tag_len        =  keywords_line >      tag_line ? (keywords_line -      tag_line) - 1 : 0;
+	keywords_line += strlen("keywords ");
+	keywords_len   =    tagger_line > keywords_line ? (  tagger_line - keywords_line) - 1 : 0;
+	tagger_line   += strlen("tagger ");
+	tagger_len     =     header_end >   tagger_line ? (   header_end -   tagger_line) - 1 : 0;
 
 	/* Get the actual type */
 	if (type_len >= sizeof(type))
-		return error("char" PD_FMT ": type too long", (type_line + 5) - data);
-	memcpy(type, type_line + 5, type_len);
+		return error("char" PD_FMT ": type too long", (type_line) - data);
+	memcpy(type, type_line, type_len);
 	type[type_len] = '\0';
 
 	if (thorough_verify) {
+		unsigned long i;
+
 		/* Verify that the object matches */
 		if (verify_object(sha1, type))
 			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
 
 		/* Verify the tag name: we don't allow control characters or spaces in it */
 		if (tag_len > 0) { /* tag name was given */
-			tag_line += 4; /* skip past "tag " */
-			for (;;) {
-				unsigned char c = *tag_line++;
+			for (i = 0; i < tag_len; ++i) {
+				unsigned char c = tag_line[i];
 				if (c == '\n')
 					break;
 				if (c > ' ' && c != 0x7f)
 					continue;
-				return error("char" PD_FMT ": could not verify tag name", tag_line - data);
+				return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
 			}
 		}
 
 		/* Verify the keywords line: we don't allow control characters or spaces in it, or two subsequent commas */
 		if (keywords_len > 0) { /* keywords line was given */
-			keywords_line += 9; /* skip past "keywords " */
-			for (;;) {
-				unsigned char c = *keywords_line++;
+			for (i = 0; i < keywords_len; ++i) {
+				unsigned char c = keywords_line[i];
 				if (c == '\n')
 					break;
-				if (c == ',' && *keywords_line == ',')
-					return error("char" PD_FMT ": found empty keyword", keywords_line - data);
+				if (c == ',' && keywords_line[i + 1] == ',') /* consecutive commas */
+					return error("char" PD_FMT ": found empty keyword", keywords_line + i - data);
 				if (c > ' ' && c != 0x7f)
 					continue;
-				return error("char" PD_FMT ": could not verify keywords", keywords_line - data);
+				return error("char" PD_FMT ": could not verify keywords", keywords_line + i - data);
 			}
 		}
 
@@ -211,7 +214,7 @@ int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsign
 	if (item) { /* Store parsed information into item */
 		if (tag_len > 0) { /* optional tag name was given */
 			item->tag = xmalloc(tag_len + 1);
-			memcpy(item->tag, tag_line + 4, tag_len);
+			memcpy(item->tag, tag_line, tag_len);
 			item->tag[tag_len] = '\0';
 		}
 		else { /* optional tag name not given */
@@ -221,7 +224,7 @@ int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsign
 
 		if (keywords_len > 0) { /* optional keywords string was given */
 			item->keywords = xmalloc(keywords_len + 1);
-			memcpy(item->keywords, keywords_line + 9, keywords_len);
+			memcpy(item->keywords, keywords_line, keywords_len);
 			item->keywords[keywords_len] = '\0';
 		}
 		else { /* optional keywords string not given. Set default keywords */
-- 
1.5.2
