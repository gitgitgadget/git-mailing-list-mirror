From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 1/6] tag: read signature
Date: Sun, 22 Feb 2009 20:06:37 +0200
Message-ID: <e29894ca0902221006y4b0e29e7ucc8a04e8e6e42f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIkJ-0003rP-JM
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZBVSGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZBVSGj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6329 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZBVSGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:38 -0500
Received: by nf-out-0910.google.com with SMTP id d21so367282nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=e4jB50c0g9yE/RV1mgC0crFje60MC/MLPi/dH/XGPgY=;
        b=Nkovkb8VKaRUYwoCftqaWh2dOhIVsQndDyAHYKi/3DLUe3Sg7Gs7xiKqPnmvzLxptS
         dAj6bbPAwhdgkZb9qkVtI0QQ/y8bEI0W9Oy2k/2utizcD8HZ9QBXW3OHEzFO9m3Zcny6
         8qt5p9eCBkrsKV9Wu6HaRIiUMeAI6C+XRfD/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vQVZ5IWa2hI7d6usagRdK3CGNSOzw0WlSoyo90SnH2+jTFsz95KQLrH71VVUqXtBWD
         mPi/lG1/25FCLzP+baJxWA3wEl6FqRGcJ0vQJj95CKOs8wpqjB0wa/j3J5gT1p97fsDN
         mcr2sAZkzK6ANix2EgdrV7+5RRXEr2XiYfjH0=
Received: by 10.210.38.5 with SMTP id l5mr2704629ebl.108.1235325997750; Sun, 
	22 Feb 2009 10:06:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111034>

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 tag.c |   11 ++++++++---
 tag.h |    2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tag.c b/tag.c
index 4470d2b..42e5b22 100644
--- a/tag.c
+++ b/tag.c
@@ -38,9 +38,9 @@ struct tag *lookup_tag(const unsigned char *sha1)

 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
-	int typelen, taglen;
+	int typelen, taglen, siglen;
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line;
+	const char *type_line, *tag_line, *sig_line, *msg_line;
 	char type[20];
 	const char *start = data;

@@ -62,9 +62,12 @@ int parse_tag_buffer(struct tag *item, void *data,
unsigned long size)
 		return -1;

 	sig_line = memchr(tag_line, '\n', size - (tag_line - start));
+	if (!sig_line || memcmp("tagger ", ++sig_line, 7))
+		return -1;
+
+	msg_line = memchr(sig_line, '\n', size - (sig_line - start));
 	if (!sig_line)
 		return -1;
-	sig_line++;

 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
@@ -73,6 +76,8 @@ int parse_tag_buffer(struct tag *item, void *data,
unsigned long size)
 	type[typelen] = '\0';
 	taglen = sig_line - tag_line - strlen("tag \n");
 	item->tag = xmemdupz(tag_line + 4, taglen);
+	siglen = msg_line - sig_line - strlen("tagger \n");
+	item->signature = xmemdupz(sig_line + 7, siglen);

 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
diff --git a/tag.h b/tag.h
index 7a0cb00..bc2cab3 100644
--- a/tag.h
+++ b/tag.h
@@ -9,7 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;
-	char *signature; /* not actually implemented */
+	char *signature;
 };

 extern struct tag *lookup_tag(const unsigned char *sha1);
-- 
1.6.2.rc1.28.g05ef4.dirty
