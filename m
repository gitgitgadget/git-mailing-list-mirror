From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix up totally buggered read_or_die()
Date: Thu, 11 Jan 2007 20:37:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701112033490.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jan 12 05:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5EAj-0002OB-Mx
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 05:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbXALEhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 23:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXALEhm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 23:37:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60095 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030483AbXALEhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 23:37:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0C4bdWi018350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 20:37:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0C4bc7O012088;
	Thu, 11 Jan 2007 20:37:39 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.662 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36660>


The "read_or_die()" function would silently NOT die for a partial read, 
and since it was of type "void" it obviously couldn't even return the 
partial number of bytes read.

IOW, it was totally broken. This hopefully fixes it up.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I'm really quite fed up with the "cleanups" that were just too buggy for 
words.

diff --git a/write_or_die.c b/write_or_die.c
index 1224cac..4e8183e 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -4,16 +4,11 @@ int read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
 	ssize_t total = 0;
-	ssize_t loaded = 0;
 
 	while (count > 0) {
-		loaded = xread(fd, p, count);
-		if (loaded <= 0) {
-			if (total)
-				return total;
-			else
-				return loaded;
-		}
+		ssize_t loaded = xread(fd, p, count);
+		if (loaded <= 0)
+			return total ? total : loaded;
 		count -= loaded;
 		p += loaded;
 		total += loaded;
@@ -26,13 +21,12 @@ void read_or_die(int fd, void *buf, size_t count)
 {
 	ssize_t loaded;
 
-	if (!count)
-		return;
 	loaded = read_in_full(fd, buf, count);
-	if (loaded == 0)
-		die("unexpected end of file");
-	else if (loaded < 0)
-		die("read error (%s)", strerror(errno));
+	if (loaded != count) {
+		if (loaded < 0)
+			die("read error (%s)", strerror(errno));
+		die("read error: end of file");
+	}
 }
 
 int write_in_full(int fd, const void *buf, size_t count)
