From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking
 a directory
Date: Wed, 18 Apr 2007 16:04:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org>
References: <20070418223327.GC2477@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 01:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeJMs-00046v-Cx
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992974AbXDRXPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992970AbXDRXPL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:15:11 -0400
Received: from smtp1.osdl.org ([65.172.181.25]:53631 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992984AbXDRXPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 19:15:09 -0400
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2007 19:15:08 EDT
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3IN47lJ026415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Apr 2007 16:04:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IN46lL005354;
	Wed, 18 Apr 2007 16:04:06 -0700
In-Reply-To: <20070418223327.GC2477@steel.home>
X-Spam-Status: No, hits=-5.04 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44962>



On Thu, 19 Apr 2007, Alex Riesen wrote:
>
> +				struct stat st;
> +				int err = errno;
> +				if (err == EISDIR ||
> +				    (err == EPERM && !lstat(path, &st) && S_ISDIR(st.st_mode))) {

Can I ask people to please *not* write things like this?

Here's an important rule from Linus:

	Rule#1 when fixing bugs: there's a reason for the bug. And 
	_usually_ the reason was that the source code was hard to think 
	about or read.

	So you should always make the source code more readable when you 
	fix a bug. If you don't, the bug will just reappear or is just 
	more subtly hidden! A bugfix that just makes the same code even
	*harder* to read is not a fix at all!

(Side note: EPERM is actually apparently the POSIXLY correct error!)

Comlex conditionals are really just asking for bugs - either because they 
are buggy themselves, or because people don't understand what they really 
test for, and introduce bugs later.

That whole sequence should probably be a function of its own. But I'd also 
like to note that for some strange and inexplicable reason, the regular 
file handling and the symlink handling uses totally different setup, and 
the symlink handling does *not* do any of the error checks that the file 
case does.

So that function should be *common* to the two cases, and do the mkdir_p 
_and_ the unlink. As it is, I suspect we have some test-case for regular 
files that caused us to be careful with them, but we lack a test-case for 
symlinks, so we never bothered to make the code work either!

So here's a suggested and totally untested patch. It makes the code more 
readable, and probably fixes *two* bugs in the process. It also simply 
doesn't really even care what the error actually was - the important part 
was not that it was a directory, but that the unlink didn't succeed!

But even if somebody wants to re-introduce more errno value testing, I 
think you should apply this patch *first*, because source code readability 
really is very important!

Functions should be small and not have indentation of more than two 
levels.

[ And yes, I realize I don't always follow my own rules, but I try. I 
  often don't write a hell of a lot of comments when I write the first 
  version of the code - I tend to add them later when some piece of code 
  has been shown to need them - but I try very hard to make functions 
  small and simple and do *one* thing, and not have lots of levels of 
  indentation. And if you see me write bad code, please flame me too! ]

		Linus

---
 merge-recursive.c |   54 ++++++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 595b022..cea6c87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -574,6 +574,31 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 	}
 }
 
+static int make_room_for_path(const char *path)
+{
+	int status;
+	const char *msg = "failed to create path '%s'%s";
+
+	status = mkdir_p(path, 0777);
+	if (status) {
+		if (status == -3) {
+			/* something else exists */
+			error(msg, path, ": perhaps a D/F conflict?");
+			return -1;
+		}
+		die(msg, path, "");
+	}
+
+	/* Successful unlink is good.. */
+	if (!unlink(path))
+		return 0;
+	/* .. and so is no existing file */
+	if (errno == ENOENT)
+		return 0;
+	/* .. but not some other error (who really cares what?) */
+	return error(msg, path, ": perhaps a D/F conflict?");
+}
+
 static void update_file_flags(const unsigned char *sha,
 			      unsigned mode,
 			      const char *path,
@@ -594,33 +619,12 @@ static void update_file_flags(const unsigned char *sha,
 		if (type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 
+		if (make_room_for_path(path) < 0) {
+			update_wd = 0;
+			goto update_index;
+		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
-			int status;
-			const char *msg = "failed to create path '%s'%s";
-
-			status = mkdir_p(path, 0777);
-			if (status) {
-				if (status == -3) {
-					/* something else exists */
-					error(msg, path, ": perhaps a D/F conflict?");
-					update_wd = 0;
-					goto update_index;
-				}
-				die(msg, path, "");
-			}
-			if (unlink(path)) {
-				if (errno == EISDIR) {
-					/* something else exists */
-					error(msg, path, ": perhaps a D/F conflict?");
-					update_wd = 0;
-					goto update_index;
-				}
-				if (errno != ENOENT)
-					die("failed to unlink %s "
-					    "in preparation to update: %s",
-					    path, strerror(errno));
-			}
 			if (mode & 0100)
 				mode = 0777;
 			else
