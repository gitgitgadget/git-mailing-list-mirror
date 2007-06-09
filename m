From: Johan Herland <johan@herland.net>
Subject: [PATCH] Use xstrndup() instead of xmalloc() and memcpy(); fix buglet
 with generating default item->keywords.
Date: Sun, 10 Jun 2007 00:36:43 +0200
Message-ID: <200706100036.43894.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090219.37289.johan@herland.net>
 <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 00:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx9aK-0000Ls-6o
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbXFIWi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbXFIWi7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:38:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35098 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbXFIWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:38:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00H0N45J7400@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:36:55 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00J2O458IH50@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:36:44 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE009XG458PH90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:36:44 +0200 (CEST)
In-reply-to: <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49635>

Using xstrndup() yields more compact and readable code than using
xmalloc(), memcpy() and manual NUL termination.
Thanks to Alex Riesen <raa.lkml@gmail.com> for suggesting this.

Also fixes a buglet where item->keywords would always be set to "tag",
even if item->tag was empty.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Saturday 09 June 2007, Alex Riesen wrote:
> ... and what's wrong with strndup?

Nothing. 


...Johan

 tag.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tag.c b/tag.c
index c3a2855..2307ec9 100644
--- a/tag.c
+++ b/tag.c
@@ -219,26 +219,19 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	}
 
 	if (item) { /* Store parsed information into item */
-		if (tag_len) { /* optional tag name was given */
-			item->tag = xmalloc(tag_len + 1);
-			memcpy(item->tag, tag_line, tag_len);
-			item->tag[tag_len] = '\0';
-		}
-		else { /* optional tag name not given */
-			item->tag = xmalloc(1);
-			item->tag[0] = '\0';
-		}
+		if (tag_len) /* optional tag name was given */
+			item->tag = xstrndup(tag_line, tag_len);
+		else /* optional tag name not given */
+			item->tag = xstrndup("", 0);
 
-		if (keywords_len) { /* optional keywords string was given */
-			item->keywords = xmalloc(keywords_len + 1);
-			memcpy(item->keywords, keywords_line, keywords_len);
-			item->keywords[keywords_len] = '\0';
-		}
+		if (keywords_len) /* optional keywords string was given */
+			item->keywords = xstrndup(keywords_line, keywords_len);
 		else { /* optional keywords string not given. Set default */
 			/* if tag name is set, use "tag"; else use "note" */
-			const char *default_kw = item->tag ? "tag" : "note";
-			item->keywords = xmalloc(strlen(default_kw) + 1);
-			memcpy(item->keywords, default_kw, strlen(default_kw) + 1);
+			if (*(item->tag))
+				item->keywords = xstrndup("tag", 3);
+			else
+				item->keywords = xstrndup("note", 4);
 		}
 
 		if (!strcmp(type, blob_type)) {
-- 
1.5.2.1.144.gabc40
