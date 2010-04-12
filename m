From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 3/5] tag.c: Refactor parse_tag_buffer to be saner to program
Date: Mon, 12 Apr 2010 16:25:27 -0700
Message-ID: <1271114729-18166-3-git-send-email-spearce@spearce.org>
References: <20100411024008.GC23075@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1TAA-0001PA-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab0DLXfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:35:23 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:55765 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0DLXfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:35:22 -0400
Received: by qyk39 with SMTP id 39so5503046qyk.24
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:35:21 -0700 (PDT)
Received: by 10.229.215.11 with SMTP id hc11mr74748qcb.45.1271114737481;
        Mon, 12 Apr 2010 16:25:37 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id v26sm6718637qce.19.2010.04.12.16.25.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 16:25:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.246.g978a8
In-Reply-To: <20100411024008.GC23075@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144777>

This code was horribly ugly to follow.  The structure of the headers
in an annotated tag object must follow a prescribed order, and most
of these are required.  Simplify the entire parsing logic by going
through the headers in the order they are supposed to appear in,
acting on each header as its identified in the buffer.

This change has the same behavior as the older version, its just
easier to read and maintain.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 tag.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/tag.c b/tag.c
index 52d71bb..ceb8655 100644
--- a/tag.c
+++ b/tag.c
@@ -38,11 +38,11 @@ struct tag *lookup_tag(const unsigned char *sha1)
 
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
-	int typelen, taglen;
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line;
 	char type[20];
-	const char *start = data;
+	const char *bufptr = data;
+	const char *tail = bufptr + size;
+	const char *nl;
 
 	if (item->object.parsed)
 		return 0;
@@ -50,29 +50,19 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 
 	if (size < 64)
 		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
+	if (memcmp("object ", bufptr, 7) || get_sha1_hex(bufptr + 7, sha1) || bufptr[47] != '\n')
 		return -1;
+	bufptr += 48; /* "object " + sha1 + "\n" */
 
-	type_line = (char *) data + 48;
-	if (memcmp("\ntype ", type_line-1, 6))
+	if (prefixcmp(bufptr, "type "))
 		return -1;
-
-	tag_line = memchr(type_line, '\n', size - (type_line - start));
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		return -1;
-
-	sig_line = memchr(tag_line, '\n', size - (tag_line - start));
-	if (!sig_line)
-		return -1;
-	sig_line++;
-
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= 20)
+	bufptr += 5;
+	nl = memchr(bufptr, '\n', tail - bufptr);
+	if (!nl || sizeof(type) <= (nl - bufptr))
 		return -1;
-	memcpy(type, type_line + 5, typelen);
-	type[typelen] = '\0';
-	taglen = sig_line - tag_line - strlen("tag \n");
-	item->tag = xmemdupz(tag_line + 4, taglen);
+	strncpy(type, bufptr, nl - bufptr);
+	type[nl - bufptr] = '\0';
+	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
@@ -87,6 +77,15 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 		item->tagged = NULL;
 	}
 
+	if (prefixcmp(bufptr, "tag "))
+		return -1;
+	bufptr += 4;
+	nl = memchr(bufptr, '\n', tail - bufptr);
+	if (!nl)
+		return -1;
+	item->tag = xmemdupz(bufptr, nl - bufptr);
+	bufptr = nl + 1;
+
 	return 0;
 }
 
-- 
1.7.1.rc1.246.g978a8
