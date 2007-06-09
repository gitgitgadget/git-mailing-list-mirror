From: Johan Herland <johan@herland.net>
Subject: [PATCH 05/21] Make parse_tag_buffer_internal() handle item == NULL
Date: Sat, 09 Jun 2007 02:14:39 +0200
Message-ID: <200706090214.39337.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoba-0003xc-Gd
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbXFIAOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969752AbXFIAOn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:14:43 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47451 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969701AbXFIAOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:14:42 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E0IQB00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:42 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000LGE0FZL30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:39 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FL9E0FRBF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:39 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49532>

This is in preparation for unifying verify_tag() and
parse_tag_buffer_internal().

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   54 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tag.c b/tag.c
index 19c66cd..b134967 100644
--- a/tag.c
+++ b/tag.c
@@ -46,9 +46,11 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 	const char *type_line, *tag_line, *tagger_line;
 	unsigned long type_len, tag_len;
 
-	if (item->object.parsed)
-		return 0;
-	item->object.parsed = 1;
+	if (item) {
+		if (item->object.parsed)
+			return 0;
+		item->object.parsed = 1;
+	}
 
 	if (size < 64)
 		return error("failed preliminary size check");
@@ -85,28 +87,30 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 	memcpy(type, type_line + 5, type_len);
 	type[type_len] = '\0';
 
-	tag_len = tagger_line - tag_line - strlen("tag \n");
-	item->tag = xmalloc(tag_len + 1);
-	memcpy(item->tag, tag_line + 4, tag_len);
-	item->tag[tag_len] = '\0';
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
-	}
-
-	if (item->tagged && track_object_refs) {
-		struct object_refs *refs = alloc_object_refs(1);
-		refs->ref[0] = item->tagged;
-		set_object_refs(&item->object, refs);
+	if (item) {
+		tag_len = tagger_line - tag_line - strlen("tag \n");
+		item->tag = xmalloc(tag_len + 1);
+		memcpy(item->tag, tag_line + 4, tag_len);
+		item->tag[tag_len] = '\0';
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
 	}
 
 	return 0;
-- 
1.5.2
