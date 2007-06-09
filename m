From: Johan Herland <johan@herland.net>
Subject: [PATCH 16/21] Introduce optional "keywords" on tag objects
Date: Sat, 09 Jun 2007 02:19:37 +0200
Message-ID: <200706090219.37289.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwogC-0004fB-8U
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031594AbXFIATn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031589AbXFIATm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:19:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35610 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030383AbXFIATl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:19:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A05E8S2M00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000SSE8PCP20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:37 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009FZE8PAH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:37 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49543>

This patch introduces a new optional header line to the tag object, called
"keywords". The "keywords" line may contain a comma-separated list of
custom keywords associated with the tag object. There are two "special"
keywords, however: "tag" and "note": When the "keywords" header is
missing, its default value is set to "tag" if a "tag" header is
present; else the default "keywords" value is set to "note". The
"keywords" header is meant to be used by porcelains for classifying
different types of tag objects. This classification may then be used to
filter tag objects in the presentation layer (e.g. by implementing
extra filter options to --decorate, etc.)

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tag.h |    1 +
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index fb678d7..1caec19 100644
--- a/tag.c
+++ b/tag.c
@@ -69,8 +69,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 	unsigned char sha1[20];
 	char type[20];
-	const char   *type_line, *tag_line, *tagger_line;
-	unsigned long type_len,   tag_len,   tagger_len;
+	const char   *type_line, *tag_line, *keywords_line, *tagger_line;
+	unsigned long type_len,   tag_len,   keywords_len,   tagger_len;
 	const char *header_end;
 
 	if (item) {
@@ -103,15 +103,26 @@ int parse_and_verify_tag_buffer(struct tag *item,
 			"Could not find \"\\n\" after \"type\"",
 			type_line - data);
 	if (prefixcmp(tag_line, "tag ")) /* no tag name given */
-		tagger_line = tag_line;
+		keywords_line = tag_line;
 	else {                           /* tag name given */
-		tagger_line = strchr(tag_line, '\n');
-		if (!tagger_line++)
+		keywords_line = strchr(tag_line, '\n');
+		if (!keywords_line++)
 			return error("Tag object (@ char " PD_FMT "): "
 				"Could not find \"\\n\" after \"tag\"",
 				tag_line - data);
 	}
 
+	/* Verify optional keywords line */
+	if (prefixcmp(keywords_line, "keywords ")) /* no keywords given */
+		tagger_line = keywords_line;
+	else {                                     /* keywords given */
+		tagger_line = strchr(keywords_line, '\n');
+		if (!tagger_line++)
+			return error("Tag object (@ char " PD_FMT "): "
+				"Could not find \"\\n\" after \"keywords\"",
+				keywords_line - data);
+	}
+
 	/*
 	 * Verify mandatory tagger line, but only when we're checking
 	 * thoroughly, i.e. on inserting a new tag, and on fsck.
@@ -142,8 +153,11 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	type_len       = tag_line > type_line ?
 			(tag_line - type_line) - 1 : 0;
 	tag_line      += strlen("tag ");
-	tag_len        = tagger_line > tag_line ?
-			(tagger_line - tag_line) - 1 : 0;
+	tag_len        = keywords_line > tag_line ?
+			(keywords_line - tag_line) - 1 : 0;
+	keywords_line += strlen("keywords ");
+	keywords_len   = tagger_line > keywords_line ?
+			(tagger_line - keywords_line) - 1 : 0;
 	tagger_line   += strlen("tagger ");
 	tagger_len     = header_end > tagger_line ?
 			(header_end - tagger_line) - 1 : 0;
@@ -176,6 +190,26 @@ int parse_and_verify_tag_buffer(struct tag *item,
 			}
 		}
 
+		/*
+		 * Verify keywords: disallow control characters, spaces,
+		 * or two subsequent commas
+		 */
+		if (keywords_len) { /* keywords line was given */
+			for (i = 0; i < keywords_len; ++i) {
+				unsigned char c = keywords_line[i];
+				if (c == ',' && keywords_line[i + 1] == ',')
+					/* consecutive commas */
+					return error("Tag object (@ char "
+						PD_FMT "): Found empty keyword",
+						keywords_line + i - data);
+				if (c > ' ' && c != 0x7f)
+					continue;
+				return error("Tag object (@ char " PD_FMT "): "
+					"Could not verify keywords",
+					keywords_line + i - data);
+			}
+		}
+
 		/* Verify tagger line */
 		/* TODO: check for committer/tagger info */
 
@@ -193,6 +227,18 @@ int parse_and_verify_tag_buffer(struct tag *item,
 			item->tag[0] = '\0';
 		}
 
+		if (keywords_len) { /* optional keywords string was given */
+			item->keywords = xmalloc(keywords_len + 1);
+			memcpy(item->keywords, keywords_line, keywords_len);
+			item->keywords[keywords_len] = '\0';
+		}
+		else { /* optional keywords string not given. Set default */
+			/* if tag name is set, use "tag"; else use "note" */
+			const char *default_kw = item->tag ? "tag" : "note";
+			item->keywords = xmalloc(strlen(default_kw) + 1);
+			memcpy(item->keywords, default_kw, strlen(default_kw) + 1);
+		}
+
 		if (!strcmp(type, blob_type)) {
 			item->tagged = &lookup_blob(sha1)->object;
 		} else if (!strcmp(type, tree_type)) {
diff --git a/tag.h b/tag.h
index 2631911..3b0008d 100644
--- a/tag.h
+++ b/tag.h
@@ -9,6 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;       /* optional, may be empty ("") */
+	char *keywords;  /* optional, defaults to tag ? "tag" : "note" */
 	char *signature; /* not actually implemented */
 };
 
-- 
1.5.2
