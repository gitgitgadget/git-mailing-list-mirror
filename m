From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 4/5] tag.c: Parse tagger date (if present)
Date: Mon, 12 Apr 2010 16:25:28 -0700
Message-ID: <1271114729-18166-4-git-send-email-spearce@spearce.org>
References: <20100411024008.GC23075@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1T6G-0000X7-Cz
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab0DLXbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:31:22 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:45842 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0DLXbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:31:22 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 19:31:22 EDT
Received: by qyk39 with SMTP id 39so5499384qyk.24
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:31:21 -0700 (PDT)
Received: by 10.229.211.4 with SMTP id gm4mr2778181qcb.13.1271114740098;
        Mon, 12 Apr 2010 16:25:40 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id w30sm6722916qce.10.2010.04.12.16.25.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 16:25:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.246.g978a8
In-Reply-To: <20100411024008.GC23075@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144774>

Just like with committer dates, we parse the tagger date into the
struct tag so its available for further downstream processing.
However since the tagger header was not introduced until Git 0.99.1
we must consider it optional.  For tags missing this header we use
the default date of 0.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 tag.c |   22 ++++++++++++++++++++++
 tag.h |    1 +
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/tag.c b/tag.c
index ceb8655..85607c2 100644
--- a/tag.c
+++ b/tag.c
@@ -36,6 +36,23 @@ struct tag *lookup_tag(const unsigned char *sha1)
         return (struct tag *) obj;
 }
 
+static unsigned long parse_tag_date(const char *buf, const char *tail)
+{
+	const char *dateptr;
+
+	while (buf < tail && *buf++ != '>')
+		/* nada */;
+	if (buf >= tail)
+		return 0;
+	dateptr = buf;
+	while (buf < tail && *buf++ != '\n')
+		/* nada */;
+	if (buf >= tail)
+		return 0;
+	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
+	return strtoul(dateptr, NULL, 10);
+}
+
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
 	unsigned char sha1[20];
@@ -86,6 +103,11 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	item->tag = xmemdupz(bufptr, nl - bufptr);
 	bufptr = nl + 1;
 
+	if (!prefixcmp(bufptr, "tagger "))
+		item->date = parse_tag_date(bufptr, tail);
+	else
+		item->date = 0;
+
 	return 0;
 }
 
diff --git a/tag.h b/tag.h
index c437890..4766272 100644
--- a/tag.h
+++ b/tag.h
@@ -9,6 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;
+	unsigned long date;
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
-- 
1.7.1.rc1.246.g978a8
