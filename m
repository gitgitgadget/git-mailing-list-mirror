From: Linus Torvalds <torvalds@osdl.org>
Subject: Clean up write_in_full() users
Date: Thu, 11 Jan 2007 20:23:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701112014050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jan 12 05:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Dx4-0007eZ-Bk
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 05:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbXALEXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 23:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbXALEXS
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 23:23:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59198 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbXALEXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0C4N1Wi017977
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 20:23:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0C4N0Mt011696;
	Thu, 11 Jan 2007 20:23:00 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36658>


With the new-and-improved write_in_full() semantics, where a partial write 
simply always returns a real error (and always sets 'errno' when that 
happens, including for the disk full case), a lot of the callers of 
write_in_full() were just unnecessarily complex.

In particular, there's no reason to ever check for a zero length or 
return: if the length was zero, we'll return zero, otherwise, if a disk 
full resulted in the actual write() system call returning zero the 
write_in_full() logic would have correctly turned that into a negative 
return value, with 'errno' set to ENOSPC.

I really wish every "write_in_full()" user would just check against "<0" 
now, but this fixes the nasty and stupid ones.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I actually think "read_in_full()" should get the same loving tender care 
too, for all the same reasons. I think "read_or_die()" is totally broken. 
Anybody who uses "read_or_die()" is buggy by definition, since it will do 
a partial read AND NOT RETURN ANY INDICATION THAT IT WAS PARTIAL!

Can I please ask people who do these idiotic cleanups to get their act 
together?

I'll send a patch for that next, but I looked at "write_in_full()" first, 
for historical reasons.

diff --git a/sha1_file.c b/sha1_file.c
index 18dd89b..2a5be53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1618,14 +1618,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 
 static int write_buffer(int fd, const void *buf, size_t len)
 {
-	ssize_t size;
-
-	if (!len)
-		return 0;
-	size = write_in_full(fd, buf, len);
-	if (!size)
-		return error("file write: disk full");
-	if (size < 0)
+	if (write_in_full(fd, buf, len) < 0)
 		return error("file write error (%s)", strerror(errno));
 	return 0;
 }
diff --git a/write_or_die.c b/write_or_die.c
index 488de72..1224cac 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -58,14 +58,7 @@ int write_in_full(int fd, const void *buf, size_t count)
 
 void write_or_die(int fd, const void *buf, size_t count)
 {
-	ssize_t written;
-
-	if (!count)
-		return;
-	written = write_in_full(fd, buf, count);
-	if (written == 0)
-		die("disk full?");
-	else if (written < 0) {
+	if (write_in_full(fd, buf, count) < 0) {
 		if (errno == EPIPE)
 			exit(0);
 		die("write error (%s)", strerror(errno));
@@ -74,16 +67,7 @@ void write_or_die(int fd, const void *buf, size_t count)
 
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
-	ssize_t written;
-
-	if (!count)
-		return 1;
-	written = write_in_full(fd, buf, count);
-	if (written == 0) {
-		fprintf(stderr, "%s: disk full?\n", msg);
-		return 0;
-	}
-	else if (written < 0) {
+	if (write_in_full(fd, buf, count) < 0) {
 		if (errno == EPIPE)
 			exit(0);
 		fprintf(stderr, "%s: write error (%s)\n",
@@ -96,16 +80,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 
 int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
-	ssize_t written;
-
-	if (!count)
-		return 1;
-	written = write_in_full(fd, buf, count);
-	if (written == 0) {
-		fprintf(stderr, "%s: disk full?\n", msg);
-		return 0;
-	}
-	else if (written < 0) {
+	if (write_in_full(fd, buf, count) < 0) {
 		fprintf(stderr, "%s: write error (%s)\n",
 			msg, strerror(errno));
 		return 0;
