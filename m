From: Johan Herland <johan@herland.net>
Subject: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sat, 09 Jun 2007 21:42:05 +0200
Message-ID: <200706092142.05446.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net>
 <200706092028.54459.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 21:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx6pB-0000A9-Cu
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 21:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759032AbXFITmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758229AbXFITmM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 15:42:12 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58078 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758168AbXFITmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 15:42:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00403W2AKR00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 21:42:10 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JXSW26IC10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 21:42:06 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD009CIW25P850@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 21:42:06 +0200 (CEST)
In-reply-to: <200706092028.54459.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49608>

We don't want to print error message on regular parsing of tag objects.

With this patch error messages are only printed when 'thorough_verify'
is set, i.e. when creating new or fscking tag objects.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

On Saturday 09 June 2007, Johan Herland wrote:
> On Saturday 09 June 2007, Junio C Hamano wrote:
> > While I would agree that it makes sense to have the same
> > definition of what is and is not a 100% well formatted tag
> > object for producer side and consumer side, I do not necessarily
> > think it is a good idea to make parse_tag_buffer() chattier on
> > errors.  mktag.c:verify_tag() can afford to be verbose in its
> > diagnosis, because it is used when the user is _creating_ the
> > tag, and it is generally a good idea to be strict when we
> > create.
> > 
> > On the other hand, parse_tag_buffer() is on the side of users
> > who use existing tag objects that were produced by somebody
> > else.  It is generally a good practice to be more lenient when
> > you are consuming.
> > 
> > Also, callers of parse_tag_buffer() know the function is silent
> > on errors (unless there is something seriously wrong with the
> > repository); they do their own error messages when they get an
> > error return.
> 
> Ok. I can make the error messages conditional on 'thorough_verify'.

Is this one ok?

(It goes on top of the patch series as a whole)


...Johan

 tag.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tag.c b/tag.c
index af4356e..c3a2855 100644
--- a/tag.c
+++ b/tag.c
@@ -67,6 +67,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 #define PD_FMT "%td"
 #endif
 
+#define FAIL(...) ( thorough_verify ? error(__VA_ARGS__) : -1 )
+
 	unsigned char sha1[20];
 	char type[20];
 	const char   *type_line, *tag_line, *keywords_line, *tagger_line;
@@ -80,26 +82,26 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	}
 
 	if (size < 65)
-		return error("Tag object failed preliminary size check");
+		return FAIL("Tag object failed preliminary size check");
 
 	/* Verify mandatory object line */
 	if (prefixcmp(data, "object "))
-		return error("Tag object (@ char 0): "
+		return FAIL("Tag object (@ char 0): "
 			"Does not start with \"object \"");
 
 	if (get_sha1_hex(data + 7, sha1))
-		return error("Tag object (@ char 7): Could not get SHA1 hash");
+		return FAIL("Tag object (@ char 7): Could not get SHA1 hash");
 
 	/* Verify mandatory type line */
 	type_line = data + 48;
 	if (prefixcmp(type_line - 1, "\ntype "))
-		return error("Tag object (@ char 47): "
+		return FAIL("Tag object (@ char 47): "
 			"Could not find \"\\ntype \"");
 
 	/* Verify optional tag line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line++)
-		return error("Tag object (@ char " PD_FMT "): "
+		return FAIL("Tag object (@ char " PD_FMT "): "
 			"Could not find \"\\n\" after \"type\"",
 			type_line - data);
 	if (prefixcmp(tag_line, "tag ")) /* no tag name given */
@@ -107,7 +109,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	else {                           /* tag name given */
 		keywords_line = strchr(tag_line, '\n');
 		if (!keywords_line++)
-			return error("Tag object (@ char " PD_FMT "): "
+			return FAIL("Tag object (@ char " PD_FMT "): "
 				"Could not find \"\\n\" after \"tag\"",
 				tag_line - data);
 	}
@@ -118,7 +120,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	else {                                     /* keywords given */
 		tagger_line = strchr(keywords_line, '\n');
 		if (!tagger_line++)
-			return error("Tag object (@ char " PD_FMT "): "
+			return FAIL("Tag object (@ char " PD_FMT "): "
 				"Could not find \"\\n\" after \"keywords\"",
 				keywords_line - data);
 	}
@@ -132,7 +134,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	 */
 	if (prefixcmp(tagger_line, "tagger ")) { /* no tagger given */
 		if (thorough_verify)
-			return error("Tag object (@ char " PD_FMT "): "
+			return FAIL("Tag object (@ char " PD_FMT "): "
 				"Could not find \"tagger \"",
 				tagger_line - data);
 		header_end = tagger_line;
@@ -140,7 +142,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	else {                                   /* tagger given */
 		header_end = strchr(tagger_line, '\n');
 		if (!header_end++)
-			return error("Tag object (@ char " PD_FMT "): "
+			return FAIL("Tag object (@ char " PD_FMT "): "
 				"Could not find \"\\n\" after \"tagger\"",
 				tagger_line - data);
 	}
@@ -164,7 +166,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 	/* Get the actual type */
 	if (type_len >= sizeof(type))
-		return error("Tag object (@ char " PD_FMT "): "
+		return FAIL("Tag object (@ char " PD_FMT "): "
 			"Type too long", type_line - data);
 	memcpy(type, type_line, type_len);
 	type[type_len] = '\0';
@@ -174,7 +176,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 		/* Verify that the object matches */
 		if (verify_object(sha1, type))
-			return error("Tag object (@ char 7): "
+			return FAIL("Tag object (@ char 7): "
 				"Could not verify tagged object %s",
 				sha1_to_hex(sha1));
 
@@ -184,7 +186,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				unsigned char c = tag_line[i];
 				if (c > ' ' && c != 0x7f)
 					continue;
-				return error("Tag object (@ char " PD_FMT "): "
+				return FAIL("Tag object (@ char " PD_FMT "): "
 					"Could not verify tag name",
 					tag_line + i - data);
 			}
@@ -199,12 +201,12 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				unsigned char c = keywords_line[i];
 				if (c == ',' && keywords_line[i + 1] == ',')
 					/* consecutive commas */
-					return error("Tag object (@ char "
+					return FAIL("Tag object (@ char "
 						PD_FMT "): Found empty keyword",
 						keywords_line + i - data);
 				if (c > ' ' && c != 0x7f)
 					continue;
-				return error("Tag object (@ char " PD_FMT "): "
+				return FAIL("Tag object (@ char " PD_FMT "): "
 					"Could not verify keywords",
 					keywords_line + i - data);
 			}
@@ -248,7 +250,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		} else if (!strcmp(type, tag_type)) {
 			item->tagged = &lookup_tag(sha1)->object;
 		} else {
-			error("Tag object (@ char " PD_FMT "): "
+			FAIL("Tag object (@ char " PD_FMT "): "
 				"Unknown type '%s'", type_line - data, type);
 			item->tagged = NULL;
 		}
@@ -262,6 +264,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 	return 0;
 
+#undef FAIL
+
 #undef PD_FMT
 }
 
-- 
1.5.2.1.144.gabc40
