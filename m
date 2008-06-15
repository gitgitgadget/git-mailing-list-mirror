From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Sun, 15 Jun 2008 11:08:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org>
References: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 20:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wfD-00006O-Tb
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 20:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914AbYFOSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758929AbYFOSIV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 14:08:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758856AbYFOSIU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2008 14:08:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5FI8BWs025603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jun 2008 11:08:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5FI8AhO019592;
	Sun, 15 Jun 2008 11:08:11 -0700
In-Reply-To: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.858 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85106>



On Sat, 14 Jun 2008, Junio C Hamano wrote:
>
> Other than that I had to stop for a few seconds to think at the magic 
> "20 bytes longer", they look scary-but-correct ;-).

Actually, thinking about it, the +20 was not just fairly arbitrary and 
would have been better off with a comment, it was also not a very good 
number to begin with - it just was the old tempfile pattern rounded up to 
the next "even" number.

The _correct_ number to use is +39, with a better tempfile pattern.

That needs a few comments, though. So I added those too.

This patch is totally unimportant, but it does mean that a really 
traditional filesystem can now do the final rename in-place, because the 
temporary file is not just in the same directory as the final one, but ti 
also has the same length, so old-style filesystems can literally just edit 
the name in place and mark the buffer dirty.

And more modern filesystems will generally end up doing more complex 
things regardless of what we do, but at least this won't _hurt_ either.

There is one more funny (or sad) detail to this: the old temporary 
filename was an interesting size: 14 characters. That happens to be the 
traditional path component limit on really old UNIX filesystems, so if you 
were to try to use such a filesystem, you'd always be able to create the 
temporary file, but then you'd never actually be able to do the final link 
or rename due to the final name being too long.

So take this or leave it as you want - it's really not very important, I 
just wrote this because I was thinking about what really goes on at a very 
low level when we do that final atomic rename to create the actual 
directory entry. This makes it theoretically just a tiny bit more atomic 
on old-fashioned filesystems.

		Linus

---
 sha1_file.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 37bcc54..f9ec069 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2110,17 +2110,31 @@ static inline int directory_size(const char *filename)
  *
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
+ *
+ * In order to make the final rename as simple as possible to do
+ * in-place for traditional filesystems, we make the temporary
+ * filename have the same size as the final one - 38 characters
+ * (19 bytes of SHA1 info - the first byte is used for the sub-
+ * directory fan-out).
+ *
+ * The temporary filename pattern is
+ *  - 8 characters of "tmp_obj_"
+ *  - 23 characters of the object filename
+ *  - 7 characters of "_XXXXXX" for mkstemp().
  */
 static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
-	if (dirlen + 20 > bufsiz) {
+	if (dirlen + 39 > bufsiz) {
 		errno = ENAMETOOLONG;
 		return -1;
 	}
 	memcpy(buffer, filename, dirlen);
-	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
+	memcpy(buffer + dirlen, "tmp_obj_", 8);
+	memcpy(buffer + dirlen + 8, filename + dirlen, 23);
+	memcpy(buffer + dirlen + 31, "_XXXXXX", 8);
+	
 	fd = mkstemp(buffer);
 	if (fd < 0 && dirlen) {
 		/* Make sure the directory exists */
@@ -2129,7 +2143,8 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 			return -1;
 
 		/* Try again */
-		strcpy(buffer + dirlen - 1, "/tmp_obj_XXXXXX");
+		buffer[dirlen-1] = '/';
+		memcpy(buffer + dirlen + 32, "XXXXXX", 6);
 		fd = mkstemp(buffer);
 	}
 	return fd;
