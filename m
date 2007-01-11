From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 11:19:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
 <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 20:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H55T3-0005Jp-4s
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 20:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbXAKTUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 14:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXAKTUB
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 14:20:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56133 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbXAKTUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 14:20:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BJJbWi002164
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 11:19:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BJJak3000642;
	Thu, 11 Jan 2007 11:19:37 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
X-Spam-Status: No, hits=-0.664 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36603>



On Thu, 11 Jan 2007, Linus Torvalds wrote:
> 
> That said, clearly something didn't check the error return of a write() 
> call. Some of that got fixed up recently, so it might even be fixed in 
> current git already.

I'm not convinced.

The "write_in_full()" logic is supposed to help people avoid problems, but 
it *still* returns a success for a partial write.

Example of extreme breakage:

	static int write_buffer(int fd, const void *buf, size_t len)
	{
	        ssize_t size;
	
	        size = write_in_full(fd, buf, len);
	        if (!size)
	                return error("file write: disk full");
	        if (size < 0)
	                return error("file write error (%s)", strerror(errno));
	        return 0;
	}

which is TOTAL GARBAGE, because the disk-full event might have happened in 
the middle of the write, so "write_in_full()" might have returned 4096, 
for example, even though the buffer length was much bigger.

I personally think write_in_full() is totally mis-designed. If you are 
ready to handle partial writes, you should use "xwrite()". If you're not 
ready to handle partial writes, you should either use "write_or_die()", 
_or_ you should expect a partial write to at least return an error code 
(which is how "write_buffer()" works).

But that's not how write_in_full() actually works. Write-in-full does not 
return an error for a partial write, it returns the partial size.

Which is idiotic. It makes the function pointless. Just use xwrite() for 
that.

I would suggest perhaps a patch like this..  And then you _really_ can 
just do

	if (write_in_full(fd, buf, len) < 0)
		die("Not going to work: %s", strerror(errno));

and be happy.

		Linus

---
diff --git a/write_or_die.c b/write_or_die.c
index a119e1d..f95299a 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -37,15 +37,14 @@ int write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
 	ssize_t total = 0;
-	ssize_t written = 0;
 
 	while (count > 0) {
-		written = xwrite(fd, p, count);
-		if (written <= 0) {
-			if (total)
-				return total;
-			else
-				return written;
+		size_t written = xwrite(fd, p, count);
+		if (written < 0)
+			return -1;
+		if (!written) {
+			errno = ENOSPC;
+			return -1
 		}
 		count -= written;
 		p += written;
