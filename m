From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 13:50:00 +0200
Message-ID: <200706101350.00271.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
 <200706101347.57023.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 13:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxLw2-00045K-46
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 13:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXFJLuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 07:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbXFJLuQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 07:50:16 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52983 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbXFJLuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 07:50:14 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF0080H4VPP600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:50:13 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF009YT4VC1490@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:50:00 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF001PJ4VC13A0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:50:00 +0200 (CEST)
In-reply-to: <200706101347.57023.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49714>

This patch introduces a new optional header line to the tag object, called
"keywords". The "keywords" line may contain a comma-separated list of
custom keywords associated with the tag object. There are two "special"
keywords, however: "tag" and "note": When the "keywords" header is
missing, its default value is set to "tag" if a "tag" header is
present; else the default "keywords" value is set to "note". The
"keywords" header is meant to be used by porcelains for classifying
different types of tag objects. This classification may then be used to
filter tag objects in the presentation layer (e.g. by implementing
extra filter options to --decorate, etc.).

The encoding rules for keywords are identical to those of tag names.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   30 ++++++++++++++++++++++++++----
 tag.c   |   30 +++++++++++++++++++++++++-----
 tag.h   |    1 +
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/mktag.c b/mktag.c
index 5e80d3d..37e10c6 100644
--- a/mktag.c
+++ b/mktag.c
@@ -2,9 +2,10 @@
 #include "tag.h"
 
 /*
- * A signature file has a very simple format: 3-4 lines
+ * A signature file has a very simple format: 3-5 lines
  * of "object <sha1>" + "type <typename>" + "tag <tagname>" (optional) +
- * "tagger <committer>", followed by a blank line, a free-form tag
+ * "keywords <keywords>" (optional) + "tagger <committer>",
+ * followed by a blank line, a free-form tag
  * message and a signature block that git itself doesn't care about,
  * but that can be verified with gpg or similar.
  *
@@ -49,7 +50,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line;
+	const char *object, *type_line, *tag_line, *keywords_line, *tagger_line;
 
 	if (size < 58)
 		return error("wanna fool me ? you obviously got the size wrong !");
@@ -104,8 +105,29 @@ static int verify_tag(char *buffer, unsigned long size)
 		}
 	}
 
+	/* Verify the keywords: disallow ctrl chars, spaces and double commas */
+	keywords_line = tag_line;
+
+	if (!memcmp(tag_line, "keywords ", 9)) {
+		if (tag_line[9] == '\n')
+			return error("char" PD_FMT ": no \"keywords \" found",
+					keywords_line - buffer);
+		keywords_line += 9;
+		for (;;) {
+			unsigned char c = *keywords_line++;
+			if (c == '\n')
+				break;
+			if (c == ',' && *keywords_line == ',')
+				/* double commas. fall through to error() */;
+			else if (c > ' ')
+				continue;
+			return error("char" PD_FMT ": could not verify keywords",
+					keywords_line - buffer);
+		}
+	}
+
 	/* Verify the tagger line */
-	tagger_line = tag_line;
+	tagger_line = keywords_line;
 
 	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
 		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
diff --git a/tag.c b/tag.c
index a7a3454..b74f09f 100644
--- a/tag.c
+++ b/tag.c
@@ -35,9 +35,9 @@ struct tag *lookup_tag(const unsigned char *sha1)
 
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
-	int typelen, taglen;
+	int typelen, taglen, keywordslen;
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line;
+	const char *type_line, *tag_line, *keywords_line, *sig_line;
 	char type[20];
 
         if (item->object.parsed)
@@ -58,25 +58,45 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 		return -1;
 
 	if (!memcmp("tag ", ++tag_line, 4)) {
-		sig_line = strchr(tag_line, '\n');
+		keywords_line = strchr(tag_line, '\n');
+		if (!keywords_line)
+			return -1;
+		keywords_line++;
+	}
+	else
+		keywords_line = tag_line;
+
+	if (!memcmp("keywords ", keywords_line, 9)) {
+		sig_line = strchr(keywords_line, '\n');
 		if (!sig_line)
 			return -1;
 		sig_line++;
 	}
 	else
-		sig_line = tag_line;
+		sig_line = keywords_line;
 
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
 		return -1;
 	memcpy(type, type_line + 5, typelen);
 	type[typelen] = '\0';
-	taglen = sig_line - tag_line - strlen("tag \n");
+	taglen = keywords_line - tag_line - strlen("tag \n");
 	if (taglen < 0) /* missing tag name */
 		taglen = 0;
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
+	keywordslen = sig_line - keywords_line - strlen("keywords \n");
+	if (keywordslen > 0)
+		keywords_line += strlen("keywords ");
+	else { /* missing keywords */
+		if (taglen) /* tag name given */
+			keywords_line = "tag";
+		else
+			keywords_line = "note";
+		keywordslen = strlen(keywords_line);
+	}
+	item->keywords = xstrndup(keywords_line, keywordslen);
 
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
diff --git a/tag.h b/tag.h
index 7e0abbe..6e687b2 100644
--- a/tag.h
+++ b/tag.h
@@ -9,6 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;       /* optional, may be empty ("") */
+	char *keywords;  /* optional, defaults to (tag ? "tag" : "note") */
 	char *signature; /* not actually implemented */
 };
 
-- 
1.5.2.1.144.gabc40
