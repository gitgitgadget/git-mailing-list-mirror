From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Mon, 19 Mar 2007 08:20:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703190804350.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <200702281754.42383.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
 <200703191932.26856.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 16:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTJfC-0001U9-82
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 16:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965881AbXCSPU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 11:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbXCSPU2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 11:20:28 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37636 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965881AbXCSPU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 11:20:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JFKOcD027772
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 08:20:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JFKNCH009499;
	Mon, 19 Mar 2007 07:20:23 -0800
In-Reply-To: <200703191932.26856.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.478 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42627>



On Mon, 19 Mar 2007, Alexander Litvinov wrote:
> 
> It is pity but my repo was corrupted again. I have WinXP + cygwin + 
> git-1.5.0-572-ge86d552. I was doing 
> git-apply/git-am/git-reset/git-cvsexportcommit and broke repo somehow. I have 
> two broken blobs that should be done by my recent patches.

Ok, can you send me just the two broken blobs? I assume that they are 
loose objects, so when fsck complaines about a corrupt object xyzzy..., 
just take those objects from

	.git/objects/xy/zzy..

and tar the two broken ones up, and send it to me by email. I'll keep it 
private if need be, but if you don't care about that, it would be even 
better if you can send them to the list publicly so that others can see 
what the corruption looks like.

> Is there any way to catch and solve the problem ?

I'd like to see the objects to look at what the corruption looks like, but 
I suspect that it's cygwin and/or WinXP. I'm not at all convinced that 
Windows is all that safe in general when it comes to data consistency, and 
I suspect cygwin makes it much worse by making operations that *should* be 
atomic be non-atomic.

Here's a patch that is probably a good idea to try. It disables the 
hardlinking code for CYGWIN, and it also checks for errors from "close()". 
Those are the two most obvious issues that I could imagine causing 
problems..

		Linus
---
 sha1_file.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 372af60..d829dc7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1760,6 +1760,14 @@ static void write_sha1_file_prepare(void *buf, unsigned long len,
 	SHA1_Final(sha1, &c);
 }
 
+#ifdef __CYGWIN__
+static int link(const char *old, const char *new)
+{
+	errno = ENOSYS;
+	return -1;
+}
+#endif
+
 /*
  * Link the tempfile to the final place, possibly creating the
  * last directory level as you do so.
@@ -1951,7 +1959,8 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
 	fchmod(fd, 0444);
-	close(fd);
+	if (close(fd))
+		die("error closing sha1 file (%s)", strerror(errno));
 	free(compressed);
 
 	return move_temp_to_file(tmpfile, filename);
