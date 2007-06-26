From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix zero-object version-2 packs
Date: Tue, 26 Jun 2007 14:34:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261428420.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tjernlund <tjernlund@tjernlund.se>
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Ifw-0006LY-E6
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 23:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXFZVeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXFZVeO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 17:34:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34287 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375AbXFZVeN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 17:34:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QLY8Ff028290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 14:34:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QLY2lN002531;
	Tue, 26 Jun 2007 14:34:02 -0700
X-Spam-Status: No, hits=-2.614 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50978>


A pack-file can get created without any objects in it (to transfer "no 
data" - which can happen if you use a reference git repo, for example, 
or just otherwise just end up transferring only branch head information 
and already have all the objects themselves).

And while we probably should never create an index for such a pack, if we 
do (and we do), the index file size sanity checking was incorrect.

This fixes it.

Reported-and-tested-by: Jocke Tjernlund <tjernlund@tjernlund.se>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Tjernlund <tjernlund@tjernlund.se> wrote:
>
> [SNIP patch]
> 
> Tested your patch and the error went away, many thanks

.. so here's an "official" submission for Junio.

Of course, the simpler thing would be to just remove the "-1". It's really 
pretty pointless. The only reason it exists is that yes, the first object 
obviously cannot have an offset that doesn't fit in 31 bits, so there can 
be at most "n-1" of the extended offsets, but still, I'm not sure that 
particular "clever" sanity test narrowing is worth it.


diff --git a/sha1_file.c b/sha1_file.c
index 7628ee9..f2b1ae0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -510,7 +510,10 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		 * for offsets larger than 2^31.
 		 */
 		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
-		if (idx_size < min_size || idx_size > min_size + (nr - 1)*8) {
+		unsigned long max_size = min_size;
+		if (nr)
+			max_size += (nr - 1)*8;
+		if (idx_size < min_size || idx_size > max_size) {
 			munmap(idx_map, idx_size);
 			return error("wrong index file size in %s", path);
 		}
