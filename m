From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking
 a directory
Date: Thu, 19 Apr 2007 09:39:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704190932450.9964@woody.linux-foundation.org>
References: <20070418223327.GC2477@steel.home> 
 <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org> 
 <20070418234034.GE2477@steel.home>
 <81b0412b0704190128o7fccbe77h8df3114328d6a0da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 18:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeZfZ-00088M-M5
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 18:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766861AbXDSQjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766862AbXDSQjg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 12:39:36 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:44958 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1766861AbXDSQjf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 12:39:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3JGdQMW004060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2007 09:39:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3JGdOax025174;
	Thu, 19 Apr 2007 09:39:25 -0700
In-Reply-To: <81b0412b0704190128o7fccbe77h8df3114328d6a0da@mail.gmail.com>
X-Spam-Status: No, hits=-5.04 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45028>



On Thu, 19 Apr 2007, Alex Riesen wrote:

> On 4/19/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > >
> > > So here's a suggested and totally untested patch. It makes the code more
> > > readable, and probably fixes *two* bugs in the process. It also simply
> > > doesn't really even care what the error actually was - the important part
> > > was not that it was a directory, but that the unlink didn't succeed!
> > >
> > 
> > Well, it is a bit tested now. I'll repeat the testing tomorrow on that
> > windows box.
> 
> Tested on windows too. Works.

Good. Junio, I'd really suggest applying it. The old code was literally 
wrong, and depended on an error return that seems to be Linux-specific. It 
was also pretty ugly.

Here's the patch again with proper sign-off and a commentary..

As mentioned, maybe this wants expanding in the future, but regardless, 
the patch not only fixes a git problem on windows (and quite possibly 
other unixes too), any extensions will be much easier on top of this.

		Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix working directory errno handling when unlinking a directory

Alex Riesen noticed that the case where a file replaced a directory entry 
in the working tree was broken on cygwin. It turns out that the code made 
some Linux-specific assumptions, and also ignored errors entirely for the 
case where the entry was a symlink rather than a file.

This cleans it up by separating out the common case into a function of its 
own, so that both regular files and symlinks can share it, and by making 
the error handling more obvious (and not depend on any Linux-specific 
behaviour).

Acked-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

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
