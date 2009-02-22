From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 2/6] tag: parse the date
Date: Sun, 22 Feb 2009 20:06:56 +0200
Message-ID: <e29894ca0902221006k6da2c8adha858c7b61bdbc3ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIl2-00047r-85
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbZBVSG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZBVSG6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:1832 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZBVSG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:57 -0500
Received: by ey-out-2122.google.com with SMTP id 25so358071eya.37
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=J0NcmevQv/W4cZxdgrxY40wLlKzPsGkUirkNbc5lHjI=;
        b=gzj/YzntAaOy581kyNXJ9GE1tk6ODaKWOp7/IlfOjgeZY7TZSxTiMlPlTgSWo7di5y
         P5uh/oplGB8K8iy506ISF5sf26QMkLpt9zlvjQ9KquSGDIcecx3YzhwyIeFNU0era+lV
         6oQfUVh/ngzgoKjuZN0rsN8TBTNsIyv3PxeSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=h6R/cp7MLDz/Y0zctt07iSvp4n5X/2WgpRTg9LWdjuKnLEDDi7id/UJ1iUBAO1V/Z6
         a6DhqAZ7hXiook11jeli8N6lPqb2UdlSSgrtuFHRMTxCNbOwM4IstBfDdyQURHb0sDhq
         Qx0gsiOB8yGQdDuR6F4vT4mVSVtkQsdDAVzpE=
Received: by 10.210.66.1 with SMTP id o1mr432867eba.19.1235326016795; Sun, 22 
	Feb 2009 10:06:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111035>

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 tag.c |    5 ++++-
 tag.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/tag.c b/tag.c
index 42e5b22..eecc636 100644
--- a/tag.c
+++ b/tag.c
@@ -40,7 +40,7 @@ int parse_tag_buffer(struct tag *item, void *data,
unsigned long size)
 {
 	int typelen, taglen, siglen;
 	unsigned char sha1[20];
-	const char *type_line, *tag_line, *sig_line, *msg_line;
+	const char *type_line, *tag_line, *sig_line, *msg_line, *date;
 	char type[20];
 	const char *start = data;

@@ -78,6 +78,9 @@ int parse_tag_buffer(struct tag *item, void *data,
unsigned long size)
 	item->tag = xmemdupz(tag_line + 4, taglen);
 	siglen = msg_line - sig_line - strlen("tagger \n");
 	item->signature = xmemdupz(sig_line + 7, siglen);
+	date = strchr(item->signature, '>');
+	if (date)
+		item->date = strtoul(++date, NULL, 10);

 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
diff --git a/tag.h b/tag.h
index bc2cab3..e6edfcf 100644
--- a/tag.h
+++ b/tag.h
@@ -10,6 +10,7 @@ struct tag {
 	struct object *tagged;
 	char *tag;
 	char *signature;
+	unsigned long date;
 };

 extern struct tag *lookup_tag(const unsigned char *sha1);
-- 
1.6.2.rc1.28.g05ef4.dirty
