From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Consolidate SHA1 object file close
Date: Tue, 10 Jun 2008 18:47:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FRh-0002z0-Mb
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYFKBrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbYFKBrX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:47:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47721 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753076AbYFKBrW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 21:47:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1lJKm027919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 18:47:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1lI6U007391;
	Tue, 10 Jun 2008 18:47:18 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.378 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84574>


This consolidates the common operations for closing the new temporary file 
that we have written, before we move it into place with the final name. 

There's some common code there (make it read-only and check for errors on 
close), but more importantly, this also gives a single place to add an 
fsync_or_die() call if we want to add a safe mode.

This was triggered due to Denis Bueno apparently twice being able to 
corrupt his git repository on OS X due to an unlucky combination of kernel 
crashes and a not-very-robust filesystem.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Junio, this is just the scaffolding, without the actual fsync_or_die call. 

I think it's a worthy place-holder regardless of whether we really want to 
do the fsync (whether conditionally with a config option or not, and 
whether there are more clever options like aio_fsync()).

 sha1_file.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index adcf37c..f311c79 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2105,6 +2105,15 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
+/* Finalize a file on disk, and close it. */
+static void close_sha1_file(int fd)
+{
+	/* For safe-mode, we could fsync_or_die(fd, "sha1 file") here */
+	fchmod(fd, 0444);
+	if (close(fd) != 0)
+		die("unable to write sha1 file");
+}
+
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			      void *buf, unsigned long len, time_t mtime)
 {
@@ -2170,9 +2179,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
-	fchmod(fd, 0444);
-	if (close(fd))
-		die("unable to write sha1 file");
+	close_sha1_file(fd);
 	free(compressed);
 
 	if (mtime) {
@@ -2350,9 +2357,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	} while (1);
 	inflateEnd(&stream);
 
-	fchmod(local, 0444);
-	if (close(local) != 0)
-		die("unable to write sha1 file");
+	close_sha1_file(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
 		unlink(tmpfile);
