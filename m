From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc6
Date: Fri, 21 Dec 2007 09:45:16 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712210935130.21557@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org> <alpine.LFD.0.9999.0712202054350.21557@woody.linux-foundation.org> <alpine.LFD.0.9999.0712202110350.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lxQ-0003U5-Gl
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXLURqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbXLURqY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:46:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44080 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264AbXLURqY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 12:46:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBLHjHf4009754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2007 09:45:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBLHjGwl025044;
	Fri, 21 Dec 2007 09:45:17 -0800
In-Reply-To: <alpine.LFD.0.9999.0712202110350.21557@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.711 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69079>



On Thu, 20 Dec 2007, Linus Torvalds wrote:
> 
> Both answers are *correct*, though. The particular choice of "insert at 
> line 489, after line 488" is a bit odd, but is because we don't actually 
> search to exactly the beginning of where the differences started, we 
> search in blocks of 1kB and then we go forward to the next newline.

This slightly more involved diff does a better job at this particular 
issue. Whether the complexity is worth it or not, I dunno, but it changes 
the "remove common lines at the end" to do an exact job, which for this 
particular test-case means that the end result of adding a thousand lines 
of 'y' will look like

	[torvalds@woody ~]$ git diff -U0 a b | grep @@
	@@ -0,0 +1,1000 @@

instead - ie it will say that they were added at the very beginning of the 
file rather than added at some arbitrary point in the middle.

Whether this is really worth it, I dunno.

Also, I'm kind of debating with myself whether it would make most sense to 
only do this kind of optimization when (pick arbitrary cut-off here) 
something like more than half of the file is identical at the end. If we 
don't have a noticeable fraction of the file being the same, it may not 
make sense to really bother with this, since it really is meant for just 
things like ChangeLog files etc that have data added at the beginning.

That would make this whole optimization a lot more targeted to the case 
where it really matters and really helps.

I also do have an incling of a really evil way to make xdiff handle the 
case of having multiple lines of context right too, and basically just 
move all of this logic into xdiff itself rather than have this 
interface-level hack, but I'll have to let that idea brew for a while yet. 

			Linus

---
 xdiff-interface.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 9ee877c..54a53d2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -109,21 +109,43 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
  */
 static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 {
-	const int blk = 1024;
+	int blk = 1024;
 	long trimmed = 0, recovered = 0;
 	char *ap = a->ptr + a->size;
 	char *bp = b->ptr + b->size;
 	long smaller = (a->size < b->size) ? a->size : b->size;
 
-	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
-		trimmed += blk;
-		ap -= blk;
-		bp -= blk;
-	}
+	if (ctx)
+		return;
+
+	do {
+		while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
+			trimmed += blk;
+			ap -= blk;
+			bp -= blk;
+		}
+		blk /= 2;
+	} while (blk);
+
+	/* Did we trim one of them all away? */
+	if (trimmed == smaller) {
+		char *bigger;
+		if (a->size == b->size)
+			return;
+		bigger = a->ptr;
+		if (a->size > b->size)
+			bigger = b->ptr;
+
+		/* Did the other one end in a newline? */
+		if (bigger[trimmed-1] == '\n')
+			goto done;
+	}		
 
-	while (recovered < trimmed && 0 <= ctx)
+	/* Find the next newline */
+	while (recovered < trimmed)
 		if (ap[recovered++] == '\n')
-			ctx--;
+			break;
+done:
 	a->size -= (trimmed - recovered);
 	b->size -= (trimmed - recovered);
 }
