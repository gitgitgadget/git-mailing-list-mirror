From: Johan Herland <johan@herland.net>
Subject: [PATCH 7/7] Teach git-mktag to register softrefs for all tag objects
Date: Sat, 09 Jun 2007 20:24:23 +0200
Message-ID: <200706092024.23548.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5bw-0004gq-Tv
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbXFISY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756574AbXFISY1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:24:27 -0400
Received: from smtp.getmail.no ([84.208.20.33]:42490 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571AbXFISY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:24:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00M03SGQ1M00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JNOSGNIH00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:24 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000NNSGNVJ60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:23 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49599>

For each tag object created, we create a corresponding softref from the
tagged object to the tag object itself. This is needed to enable efficient
lookup of which tag objects that point to a given commit/object.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/mktag.c b/mktag.c
index af0cfa6..db8a6b8 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "softrefs.h"
 
 /*
  * Tag object data has the following format: two mandatory lines of
@@ -32,6 +33,7 @@ int main(int argc, char **argv)
 {
 	unsigned long size = 4096;
 	char *buffer = xmalloc(size);
+	struct tag result_tag;
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
@@ -46,7 +48,7 @@ int main(int argc, char **argv)
 	buffer[size] = 0;
 
 	/* Verify tag object data */
-	if (parse_and_verify_tag_buffer(0, buffer, size, 1)) {
+	if (parse_and_verify_tag_buffer(&result_tag, buffer, size, 1)) {
 		free(buffer);
 		die("invalid tag data file");
 	}
@@ -57,6 +59,13 @@ int main(int argc, char **argv)
 	}
 
 	free(buffer);
+
+	/* Create reverse mapping softref */
+	if (add_softref(result_tag.tagged->sha1, result_sha1) < 0) {
+		die("unable to create softref for resulting tag object %s",
+			sha1_to_hex(result_sha1));
+	}
+
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
 }
-- 
1.5.2.1.144.gabc40
